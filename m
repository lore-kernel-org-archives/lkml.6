Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4819iXvBP8YB9tlJmEKDoEzq3f3K613K7/qb1gquVfvTM5Dl7fCNn5/bLDMEO8wH/vU3qoD
ARC-Seal: i=1; a=rsa-sha256; t=1522168327; cv=none;
        d=google.com; s=arc-20160816;
        b=usKxIeCkCvc+Bu4kHB1sXqLYLSHSoYctAWBZzNcZn6yioSyWpXFAoLats17DpLQOlF
         4htjQGkgU5VjUboe++VQATDDbBo44rUOu7IE2Ih9AP9FRTtRR337TX8pNPCXTa8k7hw/
         fZN1LN1Gkp8jlKS/w8GrU0UiPZZPuHKGimnv1qXG2u/KMk9oHSimudV/ntpU5toUsEhB
         Em5RhQrbQHhaMSOKKs+YpDy32BBN/YaIlI1gEvgxyh/VJ9eBi45S5hlDKBvlq/qpdiVk
         VHCZJfRTz6Pc36q/kwB56K+DKBknWGz20IWJqhsq1wDpBmrmzn0yMOUBNlpAz9K0ci5h
         Kpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MrcwzNrH0t0b3HVt8KAy8avsQUxmv0SAGmNhz2uRWxI=;
        b=crKoF754woRulkB5cXzqe3+J6CCx8AURMA4TzG83ar9aRuZM6jrQ/r0sftTySMYglM
         qPKD6PBgbjFu37TKh+R3+oflfQhshzSjbgQhZWHAJavduHqtLu8+FHyjb97jzESgz2vB
         1a9ve4Z/cmdh1B2CYG8V5DsT1lQWUFQmZ18DljZXkW01DFGn9HHZx2mTwm1OEbP8LvtT
         W+whem5BjX56WQkKNGc9uqg43679yXZAys0GAVBM+w+ldvlgMt/qidj/7SfCsM9zOmzj
         UGnqH+RlsFIgWskJ+g5COkQMWjatBMdhkc3oY0ZAruYJ7dfwCgM8UPB239gnjwzGWfuz
         fhNA==
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
Subject: [PATCH 4.9 15/67] libata: remove WARN() for DMA or PIO command without data
Date: Tue, 27 Mar 2018 18:27:07 +0200
Message-Id: <20180327162727.528611617@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109047910699948?=
X-GMAIL-MSGID: =?utf-8?q?1596109176107074348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5265,8 +5265,7 @@ void ata_qc_issue(struct ata_queued_cmd
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
