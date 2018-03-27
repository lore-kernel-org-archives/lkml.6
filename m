Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3kulHGnC6nUMgdY4rvXuSLLE12IEcrVddo/NNZiLRGQPqwTLMbOgUNDwd2ZXAjNbD2JGL
ARC-Seal: i=1; a=rsa-sha256; t=1522168509; cv=none;
        d=google.com; s=arc-20160816;
        b=PuGaXYrUphoJJucakz0XvgGo6Eksnje8cORTgSOXOWrJi7OiQKeJa3sTf7b0CayRt+
         Shi8FJ+Y9PsSWYg8p99WoJN6HZ5KIvD14JGB5yKhpj/PkbPFWWlaJDPhZMUKi3zmc18S
         +I+REQGdNzI5ajAZRTv5U8J/vdmKeykn+14q9DBhwi58AIJl0lmhUAUTnF07/U/oxYI+
         8YeChmFs6rcvBdjq43QhQ1jteESlM/LqFOZnMv/PLlbW6pDdt6TSN3T1jLAOHWS18NN6
         4t3fZc8f62QjqxFmHiO34G3ZPpD9BxTTYd/2zd7VWSE+elP3npKN/IZcp0EjVLx6nBXC
         waKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZrxYz/gUm33Gv7DZB7Jnw+cvqXPZGIDjK5tudDYeUnE=;
        b=I2MHyVhxmcbRHF8HS0jfc//+GAKq3s9+Iq5JuvbJ2usWm/9G7f1ooD1ABtFImHwTGF
         r8C9u5TkBz2QSKCeV5B6iZdZnrBm2ul//u2QDOqnb5/wQ4GA7KyAkmEvzRR3N69RQg6z
         aX0FRw6H7QTx1Smc9gIWqtXPmQAzc756lJ2p3Gby7GkqUCy7vnufDxO5HG5fgiejlbYL
         R/As+vTlFKf4B67zvuqgj7JdCyi2T/lh5QWYbFRZbR8mIE/TkGBiraQk56jsdCIGc796
         zWx+AQEy5/GPeqS2dZXN2i67kkmUhCqwP1kEefBiPYOV2CtBLhIPEm+i4CkmMw+Wj6uj
         xyIw==
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
Subject: [PATCH 4.14 036/101] libata: dont try to pass through NCQ commands to non-NCQ devices
Date: Tue, 27 Mar 2018 18:27:08 +0200
Message-Id: <20180327162752.221720085@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109179007553871?=
X-GMAIL-MSGID: =?utf-8?q?1596109367399634547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3315,6 +3315,12 @@ static unsigned int ata_scsi_pass_thru(s
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
