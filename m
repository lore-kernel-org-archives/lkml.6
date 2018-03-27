Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+pyqEr9wFcLlN67Ki1Il2QwIO8fCqeMQaYi3vgBxgGk+VP/rs+T+Dt7XjQ5UjLDQIcH1va
ARC-Seal: i=1; a=rsa-sha256; t=1522168330; cv=none;
        d=google.com; s=arc-20160816;
        b=TSPZ8IG91/KF3AnS86AW06wYvDlrkCPA8sKl4O4/AXZr+Xn/StxvKyhtiZOwNWLFps
         2HEZHhiALOjkwqpOv0m6gE+9HijZr6HqB6E1kh2Ye0aamBfPdDd9IwvEp2OeFIBRnRYz
         LSOTbS0jFHxJS28Tscfmw/PD2IvD1YGmrDetPd+8bDmxWPILwCYSldoata6Cisd2JCyG
         T6+uTMbgYB8PFgMt0SnIap5LMQT8F6rsRKHXNTPZXzQjWDvClD/xS55cnqxhAxdVXIpm
         FLZpgioinJVQEXfuMQZP2Me5mXCg0y605mwb0Rb+M5akMV/c72+Cfq+O6VO0UdxwxGFF
         9zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hTx3fDKlmeMj+SxvwqfynxLFUrqCJ1CLk2Id39UX9xM=;
        b=t6eL2CWQKTUQQYSCsEnC8G2cPxte4hpEaXuaymuTSr1dJoHDorLPBD/ZEUvvUAPt+d
         YF1tx3j88igco5DCgj7qAvWLRJMI513uMyUI5BO+WnaPteL+/dpas9edyFlbzD9AGwep
         vsu+ydR0bVVzQvOW33saNk2JbfX+zFMGRRgKY3AVsI5ciae8M8HzKNWhP1teFgHSdZUx
         5qKFWYSCbV7/WMqxmA/CefJalts6ea8iZb7F2uKcV78foiJFX7gXRHmmJiLR1fC+dzEM
         ibzNnfgd9eFvTnfHg+lNLiY/bg8Cf7lwQive1R7aidNgMa6cHOFlbFLjtde2SCBe+idC
         Is/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+2f69ca28df61bdfc77cd36af2e789850355a221e@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 16/67] libata: dont try to pass through NCQ commands to non-NCQ devices
Date: Tue, 27 Mar 2018 18:27:08 +0200
Message-Id: <20180327162727.589082775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109179007553871?=
X-GMAIL-MSGID: =?utf-8?q?1596109179007553871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 2c1ec6fda2d07044cda922ee25337cf5d4b429b3 upstream.

syzkaller hit a WARN() in ata_bmdma_qc_issue() when writing to /dev/sg0.
This happened because it issued an ATA pass-through command (ATA_16)
where the protocol field indicated that NCQ should be used -- but the
device did not support NCQ.

We could just remove the WARN() from libata-sff.c, but the real problem
seems to be that the SCSI -> ATA translation code passes through NCQ
commands without verifying that the device actually supports NCQ.

Fix this by adding the appropriate check to ata_scsi_pass_thru().

Here's reproducer that works in QEMU when /dev/sg0 refers to a disk of
the default type ("82371SB PIIX3 IDE"):

    #include <fcntl.h>
    #include <unistd.h>

    int main()
    {
            char buf[53] = { 0 };

	    buf[36] = 0x85;		/* ATA_16 */
	    buf[37] = (12 << 1);	/* FPDMA */
	    buf[38] = 0x1;		/* Has data */
	    buf[51] = 0xC8;		/* ATA_CMD_READ */
            write(open("/dev/sg0", O_RDWR), buf, sizeof(buf));
    }

Fixes: ee7fb331c3ac ("libata: add support for NCQ commands for SG interface")
Reported-by: syzbot+2f69ca28df61bdfc77cd36af2e789850355a221e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3226,6 +3226,12 @@ static unsigned int ata_scsi_pass_thru(s
 		goto invalid_fld;
 	}
 
+	/* We may not issue NCQ commands to devices not supporting NCQ */
+	if (ata_is_ncq(tf->protocol) && !ata_ncq_enabled(dev)) {
+		fp = 1;
+		goto invalid_fld;
+	}
+
 	/* sanity check for pio multi commands */
 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
 		fp = 1;
