Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELskvvTr+WxrG8E35FPIvqAwwisDLg7ywe12YbUAODnSuJEMexMODA+Jjan9PDgh73WKuCyW
ARC-Seal: i=1; a=rsa-sha256; t=1521214357; cv=none;
        d=google.com; s=arc-20160816;
        b=ICESu0TutBfs05ULSvoPpLQwqjS3F94GJwI15YTxTAfVJeIluGZHG8GK2AR9XU3Pav
         62vNLmHJoIEaWrCYJnX9MKzIuv9/v2l/PYu8bYrjL7W0LAXI/jzQa8mgR2Kdew4GYn3g
         /NMFroUz6TS1RyAmYVgFqo/xPCag+FqUL+durPmLaG9L4+p16NAZ5qACRFiDNLMD9mK6
         uPaPILUcF+xane+lChCkb8L+lYyYnTqUhkZDqg1JcwlSdaNsLtxi9O881utbPh0v2Ja7
         32LLpY2JJGWxt+tD4hiy3TOOfxUHpG6PIlC/w4/hc7IJSoPMMAupsfGfU3HKhxyXXiuZ
         D8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rwCx8kmwCbVmKkL/BS45rv3v4rKX0KvmZljrsixpB0c=;
        b=oH3TJHfvGdetH7908S89l/BtmJkvEE2ubGfarrYqtVWbZ3zoJWaoZq7fhPXwBt065M
         CYifFwkxdgg/jrGUvRmuQfx9TKAfIPe7sQdbbOW7pITId9dSVbWWVXAbIMvU95bDTSlA
         YT6v9Z9I56okqSpzmEiTmJQahPHvYz2JGv0lZQKBm5byL15lt7Op/zK1dmTHc6K44UX2
         fFGiiyTeyhC7dMe7XOTL3eole7wsN31hyRptIobAn4q4ndkPOCaqmsYVTXQlDgyqf4uT
         sXpWwkISMykuDbM1gfqfB4Ozo+DDdiHLX+loD6yTFjJvep350K3pscpql42JAziFDIZx
         gzAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clay McClure <clay@daemons.net>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 65/86] ubi: Fix race condition between ubi volume creation and udev
Date: Fri, 16 Mar 2018 16:23:28 +0100
Message-Id: <20180316152321.777135868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108481339588180?=
X-GMAIL-MSGID: =?utf-8?q?1595108865892026995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clay McClure <clay@daemons.net>

commit a51a0c8d213594bc094cb8e54aad0cb6d7f7b9a6 upstream.

Similar to commit 714fb87e8bc0 ("ubi: Fix race condition between ubi
device creation and udev"), we should make the volume active before
registering it.

Signed-off-by: Clay McClure <clay@daemons.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/vmt.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -265,6 +265,12 @@ int ubi_create_volume(struct ubi_device
 			vol->last_eb_bytes = vol->usable_leb_size;
 	}
 
+	/* Make volume "available" before it becomes accessible via sysfs */
+	spin_lock(&ubi->volumes_lock);
+	ubi->volumes[vol_id] = vol;
+	ubi->vol_count += 1;
+	spin_unlock(&ubi->volumes_lock);
+
 	/* Register character device for the volume */
 	cdev_init(&vol->cdev, &ubi_vol_cdev_operations);
 	vol->cdev.owner = THIS_MODULE;
@@ -304,11 +310,6 @@ int ubi_create_volume(struct ubi_device
 	if (err)
 		goto out_sysfs;
 
-	spin_lock(&ubi->volumes_lock);
-	ubi->volumes[vol_id] = vol;
-	ubi->vol_count += 1;
-	spin_unlock(&ubi->volumes_lock);
-
 	ubi_volume_notify(ubi, vol, UBI_VOLUME_ADDED);
 	self_check_volumes(ubi);
 	return err;
@@ -328,6 +329,10 @@ out_sysfs:
 out_cdev:
 	cdev_del(&vol->cdev);
 out_mapping:
+	spin_lock(&ubi->volumes_lock);
+	ubi->volumes[vol_id] = NULL;
+	ubi->vol_count -= 1;
+	spin_unlock(&ubi->volumes_lock);
 	if (do_free)
 		ubi_eba_destroy_table(eba_tbl);
 out_acc:
