Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+s2rogd/603Uqgenoxkl/ZhtGJ9c5PVclsMgz9LL+UgpABHOjk55rXrGIXWW7OCgqMtVDx
ARC-Seal: i=1; a=rsa-sha256; t=1522168506; cv=none;
        d=google.com; s=arc-20160816;
        b=R0UcC+UkDdwoICz+LciEBfV6V+ffKs4Hd5EglivIQY47ZrZBkw1Ercl9bojPm3Dl6c
         EH23T9y0Bl+bkRI7vsZVv/xYJ+ixAUfp/59OQttVnmmhJr1f9t6FdJr5XOoDp5aScFS5
         wls+Q9EEo7QbE/0N+PWn2DihIcURvoJnrXIOGQolIJdxPnw+CTUDbw3KniTxUF+lkkHZ
         C6UvH9fZoMezMr1ThVcBuAGiFB7G92bEzNQGu9QSWGIBA6piO0CjCxNdhMzBPRkfL2AR
         4/LGUB+qu8sJOBcQlGhUwEd1oZ3mqfWXlakvqp6rBWIgdqTplCvAZDZYP04WoL/2t+6O
         QOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8akEMqmx1c7TUBq2lcFHdguNtfb6XFkQTjBVckdrDnI=;
        b=DyM8gBABdRZRjhPoevrZ1stM0SNkJi1ZiT+Zs54IBkllcjxEoFcj1cDkX93j6melhs
         ULLWgpfayoOUW1yaDqDn2PfKGOHuCZslnaSdZvijRQbRUY4gqfX1q8lQfLih/e2spbEe
         dF1P2Kvd7e1DAc91KEHCB6ke7GzFDGb6Occ9ffNKYRHibYYdsAA4MsLErtL4mlR68AV3
         rTd1Qz+ZNwTxBG2He6xIZzev6Z2N5JGBEyPMMx6iDZy0lKKPp+PkhizR/ucnbiBk+zNF
         6gxt4+SvqgQ0qlvOOhvPJ1elLdczVNzraXFp4aBlXaJ7E5hzP5vQUYWI0KCopqPacoAv
         IGfg==
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
Subject: [PATCH 4.14 035/101] libata: remove WARN() for DMA or PIO command without data
Date: Tue, 27 Mar 2018 18:27:07 +0200
Message-Id: <20180327162752.149396434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109047910699948?=
X-GMAIL-MSGID: =?utf-8?q?1596109363999411516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5391,8 +5391,7 @@ void ata_qc_issue(struct ata_queued_cmd
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
