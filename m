Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zlb/bSjpa5d58R3DbgJ0OkZpc4pSK44k1dDqocg1VyFSzzafxCz3fMTDVgtQO62t4bwwo
ARC-Seal: i=1; a=rsa-sha256; t=1522168205; cv=none;
        d=google.com; s=arc-20160816;
        b=MGDMiJ9cspvIlud1WK+eAECNZXRLTuHNck6qWHUQU5Bqd39GRgWaJgDbquyiOJhojC
         CNeJXuM+xlbmXhoRHezrGbn6vDOZvDWrssOoJaW+Ek+8cbqLcYtY4q/To1WJHwHB6Hmp
         vseKcnAV+rOk1pj11spJ5CsE/mfxEjXZFeZANx3cqNDDUFkzMis9yJQTRGdB4w5PRJkx
         nAvzfhOk8RZNvQCaZ049cYG7LLf8ntcWOf2T/N1GQigtQvIsLBQRBTXCenO7P7XWcnfz
         gWIx4G5LIc76jXum5M9agMHqmPlQGeA9ZQ0yC4ihPWHeykIOODay9KmRQuy3eYEqMOvH
         PQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f3HvRodcle/4p6ugWV8k/x/PWziHxgRobXOz24bPIh4=;
        b=Mvjq05yS1ImJddXafMo9q8FtyWamGKP6arXoO94+J5ylOCih4ctvI7c9W5x3WqjXdt
         1YEDwQwuz18v0GoDPqhUcKmUVuAHz6QN0rdFqN9upd2dt+d6iBlEHkZWX0/SfnZOkSHz
         4rpb0Owf8c3SVDnZLzOBFBe0TRPrwQYiwuN3g/4dxsaD4Q8bGvl47FPeSP6KmVP5NPLg
         UrFkYBYPMjhqG+rw2ZkGrod95KG6IwPU/jFiLG89BwpFa1rfmti+3gJIvF5qtSN5WgOd
         ydTsieyPGzmURKg2j0RZb7Yu3sGMzgQfFSwiQo2TBOUTe3tBJ9QBZGySJRK+ZZfyCrpj
         G1Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 13/43] libata: remove WARN() for DMA or PIO command without data
Date: Tue, 27 Mar 2018 18:27:17 +0200
Message-Id: <20180327162717.131571418@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109047910699948?=
X-GMAIL-MSGID: =?utf-8?q?1596109047910699948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 9173e5e80729c8434b8d27531527c5245f4a5594 upstream.

syzkaller hit a WARN() in ata_qc_issue() when writing to /dev/sg0.  This
happened because it issued a READ_6 command with no data buffer.

Just remove the WARN(), as it doesn't appear indicate a kernel bug.  The
expected behavior is to fail the command, which the code does.

Here's a reproducer that works in QEMU when /dev/sg0 refers to a disk of
the default type ("82371SB PIIX3 IDE"):

    #include <fcntl.h>
    #include <unistd.h>

    int main()
    {
            char buf[42] = { [36] = 0x8 /* READ_6 */ };

            write(open("/dev/sg0", O_RDWR), buf, sizeof(buf));
    }

Fixes: f92a26365a72 ("libata: change ATA_QCFLAG_DMAMAP semantics")
Reported-by: syzbot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v2.6.25+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5077,8 +5077,7 @@ void ata_qc_issue(struct ata_queued_cmd
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
