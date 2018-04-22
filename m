Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+RxzOKKRi4pnUuWnsI0CE/G2VXXont9yH7VFUMHMp6uor7oGp9/zLTscP+T5s36ynXmfkG
ARC-Seal: i=1; a=rsa-sha256; t=1524406846; cv=none;
        d=google.com; s=arc-20160816;
        b=eqw0zdc/oMdeFT3haOZia1Qkic0kheDIisa+Ew0wS5+6TDOhuIGIsiJ32Ipy2goUsN
         hkIngs5vjHoDdA5kVOuebhY/mti0T9S+l6GU3o+jldGBfVJLAAkAZ9J/OOsHngEpA3m4
         5gk013PMBTzbr5F5YX9XAqVl8KaTPdPQRadQF5HH1Mri5wR5gfK9P9H186oWtKWVg6Xz
         DXhAm0rQeYS3Rmmk9cVYY9C/6fnGedcnqIexklo0uWav6UuLiVgCYTpV5dCorR+ORUpZ
         ptMCOiuHYuvEwCFmPLSlYkYv4L3rpW/c0X6y6C5N4nCiakPNoD7kS6yJHlOsGwBlQr/7
         8ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7wqedEjkYCrrG+V02z37RdSpxjm9JHmnK3VsOTXZ5Qc=;
        b=xhEMnNd82tPDt/sYVNau1jBpNckGtFgHuE+RZYrrypnP1ZKCaBxMQHcwRWH6OoVMBA
         IGZkmPIGQ/MWUMEpNOpOQbPNj4xddl/irUJzHuuMjzQcvpg0RDQYoVtduIJKkCYZ0qA3
         LrrPkIx6DVKy7LH00CgfQlhX0QSCg/bcmRV6iZumKnt4uHinET1axv0tIo5nZ7XlM2Re
         SceR7gJFJK1/bM1TpeI6h9mi7Gn6BLzEhMXeh0AjInk+BHtLrY/LI0e3dx8vRsise3Oj
         9i8/GA/pAcarOiFBcXrE+EU4sKux5sB+0zivEraA5Ls6EwyTMW2rY3lTVzAUAutsxG2S
         4y1A==
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
Subject: [PATCH 3.18 09/52] ubi: Reject MLC NAND
Date: Sun, 22 Apr 2018 15:53:42 +0200
Message-Id: <20180422135315.675774120@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454837068211980?=
X-GMAIL-MSGID: =?utf-8?q?1598456433062355882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -905,6 +905,17 @@ int ubi_attach_mtd_dev(struct mtd_info *
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
