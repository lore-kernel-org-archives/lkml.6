Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4842VfzzGpLkbPG+qKetjE35FiKnKSLcIySOnM/3x/iyxUZ36c8YS1Q6mmGLaR08zfSVVeL
ARC-Seal: i=1; a=rsa-sha256; t=1522168747; cv=none;
        d=google.com; s=arc-20160816;
        b=vOmZJNLgRJbtvG/l1+n0nnMZFoo8apB6SAxgQFU4ybleN8WXU4CBsftbDz2HnG0hR/
         Ts/yqUI4KoskYwRskWU9LgllexbP74jWNolZIowDHucvvoABZ3mZPAxdqcGw8HXURvy8
         3sOKQ2bKJJ7b6bfETJ50mr7+B1bgY92UW7sR+m9ZVhyYlEEZag5vJ3BAuNEe6rZFcIhV
         a5brn4Nqlss8K6JknhIIhURNZuuyS9bJbKxrwPucSBej9HrQ6qBiwqcfI1ez/eozsa8/
         trG3yMjM8+tsXlO8nz3BToUmL+y5gGoEDyrTi48/PwsW3/OE5tYQmeRk9D/l3jZSUqQL
         6Q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jWcXO8t3Yk6wBva7XOn4pZWt2tkBZdxE4n2rPvm2baU=;
        b=CpF3lJME1budAGcCJrSAbwzkiP/RnHwUrZxcSfZXXl59HBQQ8vZz82r74PkiJLguIv
         v7jMBg3fJkNr74PaWm7JEO6Mdqrdrl4qPcWAqgf0+Zehp21pvQfAdB3YJsnuFKU1CKQF
         5uetxr+U10unoW97vQKlnoq+IlU0LeCycAV6jGfrz6HdBJJJuHhSR3wA1h95O7G+gAHu
         E0dXHqDNrUZ/SfEez461jDxxxenHvKki7yqL4OxCwpab88njSSzXIBRHINlGFGcumfSD
         LuFLSNlSrt6M5icHHxY8P/aMSF+jTkCF8p5kWpvsAO/NiEzchXifkqfXsnyCxXWQXTRZ
         tK6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bastian Stender <bst@pengutronix.de>,
	Jan Luebbe <jlu@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 018/105] mmc: block: fix updating ext_csd caches on ioctl call
Date: Tue, 27 Mar 2018 18:26:58 +0200
Message-Id: <20180327162758.604371066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109309398745231?=
X-GMAIL-MSGID: =?utf-8?q?1596109616715776570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastian Stender <bst@pengutronix.de>

commit e74ef2194b41ba5e511fab29fe5ff00e72d2f42a upstream.

PARTITION_CONFIG is cached in mmc_card->ext_csd.part_config and the
currently active partition in mmc_blk_data->part_curr. These caches do
not always reflect changes if the ioctl call modifies the
PARTITION_CONFIG registers, e.g. by changing BOOT_PARTITION_ENABLE.

Write the PARTITION_CONFIG value extracted from the ioctl call to the
cache and update the currently active partition accordingly. This
ensures that the user space cannot change the values behind the
kernel's back. The next call to mmc_blk_part_switch() will operate on
the data set by the ioctl and reflect the changes appropriately.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -66,6 +66,7 @@ MODULE_ALIAS("mmc:block");
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
@@ -580,6 +581,24 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	}
 
 	/*
+	 * Make sure the cache of the PARTITION_CONFIG register and
+	 * PARTITION_ACCESS bits is updated in case the ioctl ext_csd write
+	 * changed it successfully.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		/*
+		 * Update cache so the next mmc_blk_part_switch call operates
+		 * on up-to-date data.
+		 */
+		card->ext_csd.part_config = value;
+		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
+	}
+
+	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
 	 */
