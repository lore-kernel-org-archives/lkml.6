Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227wrtgWI3EnehovIxTUe9tOtF6EG8XLKiYwqUTLNTK4wNY+uIhHyKhPm2oETIgmdl7cjyMl
ARC-Seal: i=1; a=rsa-sha256; t=1518708837; cv=none;
        d=google.com; s=arc-20160816;
        b=kCKJWnbeF0fnRsIRL4nOer+3KHuqnw50Scs9LH3ayLVBfBvk+t+ozeH/7xqZivpv8R
         V+Iuuic+Gwm6OWmIdyHHgDIgqabgz01up0nxCfupjLWHd0PBinXbf02kwzLctE7S0fEi
         NB9i/MXhHvqwjTHSYLXX1Vvd6R8tltqpgFigBySuotHeZJ9uARzldT/bqRCEupCQDjd5
         xeWjK/UOYW6A1AZ9f9r2/BX2vhgMZHRiawmyH5CgnRJDNo1zecohs/TuBKOuFMB1xEu2
         u8Bi/av/gnslcERsWAJiAtyZ+26J4/THWZLf6z7i5q4+ZfWIpJNzXA6hi181usk6PIZ8
         z63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d5JwATqItvZ90NwbCdTJ8i8LbuxbbrBwDNSzjUS+h9Y=;
        b=TZXeAh+mOCaXxBCovtW7GVaSGsFfn/rFRMW11eWZ4+Hp6gqYJczuiM3N6pI1fXWJ/f
         EfiCwESXQqqQw6mig7rfvxOIfohSfVuRWstXJmOFCuzmQ3gSgp1cH1tEYCi3ENih6cNu
         q3h38sPWv30MAUOioK027AIZXgaCCFr/+6kIAhi0q3MPIkDXQYp/ApAuXyl3lB5h+3Ak
         jl5wzxFKVYN05KGhb93i73/bS7kp2dHAcOyz+YLDwPbeLne9k2K79wkuzHv1GLOhUWc0
         VoMUJtRvL2ZivbC3YvaiPWy2Z6b7AasrZHKUyBoCt48yzvdYVlQfd7VTyjjerwJ2MYSc
         dknQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clay McClure <clay@daemons.net>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 099/195] ubi: Fix race condition between ubi volume creation and udev
Date: Thu, 15 Feb 2018 16:16:30 +0100
Message-Id: <20180215151710.642247933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481637537037246?=
X-GMAIL-MSGID: =?utf-8?q?1592481637537037246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clay McClure <clay@daemons.net>

commit a51a0c8d213594bc094cb8e54aad0cb6d7f7b9a6 upstream.

Similar to commit 714fb87e8bc0 ("ubi: Fix race condition between ubi
device creation and udev"), we should make the volume active before
registering it.

Signed-off-by: Clay McClure <clay@daemons.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/vmt.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -270,6 +270,12 @@ int ubi_create_volume(struct ubi_device
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
@@ -298,11 +304,6 @@ int ubi_create_volume(struct ubi_device
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
@@ -315,6 +316,10 @@ out_sysfs:
 	 */
 	cdev_device_del(&vol->cdev, &vol->dev);
 out_mapping:
+	spin_lock(&ubi->volumes_lock);
+	ubi->volumes[vol_id] = NULL;
+	ubi->vol_count -= 1;
+	spin_unlock(&ubi->volumes_lock);
 	ubi_eba_destroy_table(eba_tbl);
 out_acc:
 	spin_lock(&ubi->volumes_lock);
