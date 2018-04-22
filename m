Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KcZ3vTl9HmKbY61eo+UcdZbl1SpWgBa7UjkYhJbMjaNn/Q/uGb9G+QAT6myDT9nwA12Pe
ARC-Seal: i=1; a=rsa-sha256; t=1524405884; cv=none;
        d=google.com; s=arc-20160816;
        b=tZuU5WXU1uMPgVAvn3s0DT4GeQRBWrh6zrGmWKPawdS0w4k2DocZ/Ym4nb/50w83MT
         QoKNZVB0z0CRXUXFQqR6pmIzbS7xTPoxnbeFJ8xpHcnvn6zTKVR/92gBzTGPzfct/rUI
         0Kdk+svlS6hRfpOj/6if9uQlu/D4XYsD4nnkk0dJTDICiDpObBYRBbcE0Ifg0DxIM+t2
         XoxUvlnH2/SInQJ5iY3GkO6Pbj2mEKcQKyO3UZ/zsYFh2jfB2ei/316PMgeXrgsHrnYu
         GM7kGBjIbxya1f36Ghnb+zvz6Y4Ju5nfu6zYhcOBt+8jdhaMFc45NtZ/HSlivFuMt0TZ
         XVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DTwvLH0VZLaj8c/6jiDqb8n4Dz4jCS+wQvIQxJJsDpo=;
        b=R+/BaIn7P1aPRbflRl4hol4tluzfvcLSpg7kyIWFIgwFzoCChZ4QjDRwnl8wIMzSBM
         ogyhVFz2KklA1OkyY6Cn3RvP07VykPaMsfZx3UJWpQS63IGzjurCwo3Lv7XXZOTLIvlv
         FU7/OnHXEGklnjxYW9ut3kIw4DaDsefqGh0KTmmZB1qWHb8wW8Y6ED2/iY6lKrEHu1N6
         oX8c9cHNn+H7Tj0jNPUQzjWaofBpmMVLxKWXaFAFXPVP63mUX31GbPcsryFDTT+6J7d+
         PtjZJDqLzd9KS3RJYQxPLyQofEH5xgrjq9Rw0KcY9UudC4+VzvoJ3td7EXkOysW1IU8P
         ksAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 4.14 006/164] ubi: Reject MLC NAND
Date: Sun, 22 Apr 2018 15:51:13 +0200
Message-Id: <20180422135135.662676031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454837068211980?=
X-GMAIL-MSGID: =?utf-8?q?1598455424500920486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit b5094b7f135be34630e3ea8a98fa215715d0f29d upstream.

While UBI and UBIFS seem to work at first sight with MLC NAND, you will
most likely lose all your data upon a power-cut or due to read/write
disturb.
In order to protect users from bad surprises, refuse to attach to MLC
NAND.

Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/build.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -845,6 +845,17 @@ int ubi_attach_mtd_dev(struct mtd_info *
 		return -EINVAL;
 	}
 
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type == MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
