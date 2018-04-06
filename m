Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zfqwytcrs43lWo7cvxoOXk0WBaNTsfFWwya1WyhCZ03n9Bn8ebKOmZNujwI1N+aTBkewl
ARC-Seal: i=1; a=rsa-sha256; t=1523021121; cv=none;
        d=google.com; s=arc-20160816;
        b=bm/Rch3K9ZXbNseKW50KGHORCxKd8jKeQaeyAm+5VBvmXXOSmVNa4gFDYyqLJwyVVP
         1LN4Eqy+QFQuiYZbKlpyDHdKCMvDwl3NQxZhp1trGEVBU1CsXRBQsvJ3QQJhTlKmIGIN
         2N+ocljFKAKBSGGoxmhicL7OTHwOvc4JmorugBrWs8lt/FmtH+ae/z2F80ufSHEGwHmO
         bvwiVExcm8HOKYQBz5JMu+kRxh4Y7xRDmkD7FmnZLSGZtZ9u8DpvuYAecJCB2iATnVsH
         tWQdVWeQcbliG01c4p4wGja/xNVbkflAcPpB4uDUu9APQRHb6NUCfxK41v87VZgcjhza
         yekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BNrshF+onKoLabZWZM3KqjbLDzswJzuYDJO5MdvkURY=;
        b=rBQXJ33nwYlDe1OtxUOEm4SmHp/rfeU3s20rBOaC/UaVLi4OL7LyVWCCJJAnnpmPgN
         rp+ZqhiWnEN04oajMrTxlm0NyOxyOhRiSSsv9YdDBCOM639ErKVAQgoTxH/pDZnJSt3Y
         GfKMTtHwM3SC+UB9pz05myYIKuWZcvOYPA+cRvB56Jo6G+ZE+SBBT9HJ3RODZ6xN9hCL
         RnIUJ/z3d2PYofsmLeE7VDvYOccx/Ii1DEbugbBLWuUYTXMigA6HJ6qWUu1DF7vG23ET
         mDelU4bs3Y3+BEE0/nWbdSY7s+zMCT/8U2Npbv5S2EZkeK8EnQ2ZhsMNnbkEuEfmL0rJ
         KPAQ==
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
Subject: [PATCH 3.18 05/93] libata: remove WARN() for DMA or PIO command without data
Date: Fri,  6 Apr 2018 15:22:34 +0200
Message-Id: <20180406084225.201399322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003395399266736?=
X-GMAIL-MSGID: =?utf-8?q?1597003395399266736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5109,8 +5109,7 @@ void ata_qc_issue(struct ata_queued_cmd
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
