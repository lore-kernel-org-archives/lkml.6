Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt0o2J7qpPy/PCWPTMsJV0rUoZIjUwCAWMkWpD3Dd2LVHqIbA3vcw4fBfvvRpP4ggYNh8is
ARC-Seal: i=1; a=rsa-sha256; t=1521214180; cv=none;
        d=google.com; s=arc-20160816;
        b=cWmEgchZI8ZAh4F3A2y95sp6xGyIpO5XxElHTIHuMDRRiEULeLGkskxRHdW0KzaE1F
         x6weLEvAgSdjKKT5CNdm209e8J1Vkug0eMIaewmjNjYqft/s3cg+DrvjF4oLkeB4uS6k
         WFxbtyd+S8lX0WiNKcNnDsKoOYkulUdh4kyvN7btQKq91h+XR7PucnC6R6ZHTrWeGPhu
         9XuYpXNL98dMnWMcW9WJ1g8TnQfqvmJVTi6FxzV54nS56PhIXSqkZID+ZjhbJuv/z/4i
         Od59uf4nXODXpzaeKhLLlcrW1q+6IdhQfx7qBvWK3xslNbTqLEkq/aejuJ0ifLVIg/nb
         +O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eqZkltvilYGdRB2eLYoCGn0drk7e69aIY6YqSjOpjdY=;
        b=LXStQNoe8TxAIDCaOPues8fAurxyr5FBtrI4KqS8Wtztk34K2mpBuewRxCdss1hJ3o
         30HPs2bX8miVmHM82DaLOcMTRlVP79eA0Gw5tbW74eIZSwmDiqsWo95+lmZJBMPwZ964
         cOhPuawBOtDHRlFw2ABMss8TWO6WmV1qLjoXvMLeD1TNLzMOyfCznwBcJ+I0wB2vFMV5
         aSCp85io3w9gV2uJL1VzrnRfOy9xDgePo1RFmpxPLnOt+E78DhBOqanzvtbujyUEsjGT
         go6UPK9cDYnW4eojqSb+H3EqEU3/lioJezZ65d6dzRn7e7y5JFLVh4FIK03a/hA1Jck1
         t6Wg==
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
Subject: [PATCH 4.4 46/63] ubi: Fix race condition between ubi volume creation and udev
Date: Fri, 16 Mar 2018 16:23:18 +0100
Message-Id: <20180316152304.810109748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108481339588180?=
X-GMAIL-MSGID: =?utf-8?q?1595108680544880415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 		kfree(vol->eba_tbl);
 out_acc:
