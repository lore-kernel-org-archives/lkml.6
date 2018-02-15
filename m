Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711372-2-15368216789156093261
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711371; b=VdvdHVXq8IQ9QcOZA2OtBz2Isez0xizDU7mga+xwAdsT4c8
    swVt6FgKkzAmzhTc9FWvu6/o/MemiICDDUR9ungByA+njyqVsmGD+QYp8nIFE6jZ
    jM6O9LdyOAKZsIMCxo+e0yPiQa/0LfzrDG970Vi+NGNDSYjRD8ZTAGes5ilJ6qfs
    bwU7/2owSWQPj3yxqgYM4cgcur7o07RAy6l4sx6BNfecdg1AxngBCrt9/ZN313Wb
    hZ/iw5BXKo3sEtbeYajJ4kvYU4Qm0uJsxUWQZpZT2xc4hXGEjTB0sF/ljac8kHpD
    9ecwtpmyJdwkz7vU1pyNm/Lz+CvtMfrvrZTB5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711371; bh=C5LdO8t+Pw5kG2LJl2MT4MT0cK
    C06h0/kgpjBSvAveY=; b=CLMNMXKZQHpFSg8o4xG+wTQeankuwmaaHlkja0noKq
    uTWNiSo+FYJwEScnUSqQT75HKw0SdtHaOvia3tCQFcyjNJ1u8GuU1yi81ms9OK2Y
    KVF7n2nHHqZygKwa9R73BiJaP2yhBEvM/Ghq82EX+OSC+gojacMtomamx/Uea1T0
    9MCCK85nRcyl5ZWUQlWB2WEhqBXiaTkQJ9W5ttQHMxmJmmdofphTCZXlT3C3Zy8A
    DS/6B1KcNQFpDrkNeqFyEAG8yZShD+Qu5O7m++ENepAmn6abjoEa0QJskKMFRH+5
    xYfL2FKdMOrwYjM41WsAj6PhQvJ9Z8PxpkrSZZb+fVoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165490AbeBOPoc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165417AbeBOPoa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clay McClure <clay@daemons.net>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.15 092/202] ubi: Fix race condition between ubi volume creation and udev
Date: Thu, 15 Feb 2018 16:16:32 +0100
Message-Id: <20180215151718.219945743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
