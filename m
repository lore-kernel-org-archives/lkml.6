Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221825-2-7131660045944797056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221825; b=rOxqS4E8A/Ux29UH6mva4BLH1U3wdGwAuMmKvtPUQ9PIHHU
    AwOjq7i1OYTziYnppAAvEB8lmaZCW/BYC4w5ISAY3xsM2vxKkrdLXQh9eSY456dx
    +D8eiME5d4boLLPrn6uZTKjWD9SRZBLhuQZ9cu4/nS3PNlbe2uHUedotXcNXDM9z
    eCfLFCfT+biEWvbG6CfNpX3uKhIUZnZngJ1AeZhOd3BBUGgjDOh+freDTJ96xWis
    ri94RQUq0lljltm2wFSvcNqLe3/NoA0cZkBCWW8y0+eaifxRJr7xP2w5Po7NueFC
    thz6IzNYbCZ0QiL41T7DYt2JXCa5XjUzW0f4B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221825; bh=f9wT/iGJlvyWe30rQDk7fp/fN+
    Kg9j36eLd0vws+Acs=; b=fffLZzuxrsJW1isIZzZlDsrG9iStCvBCe2JKBOwNnf
    /B38EXvf7fTInyX97+/T5h54sTeYO2lAO5w7AtH2G6DFAaEuggdDxaXc5D1ca9Iq
    ORIZ2z0xb/54QOod2ponpllCtIY3WmdsnbO+FT0yQ02DUQ4pY4UoDFJnUAtWCuU/
    kE1vqWXZqxR5Cd/i/MXToMhMKoGg77KeBPAKQlrs6DddqhvqtQO9Sdcloiqof9t6
    gkPCbFCLGm/QpqsUe0+Xo+mtjegKCoJN8d1G97IfEHy432R8e2qWxtcsYbdB1HAP
    olUHL0rike5hO1gCS41Ejf9IpwV1ugIfRRI8AffGKFHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCPP0e (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932450AbeCPP0b (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clay McClure <clay@daemons.net>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3.18 13/25] ubi: Fix race condition between ubi volume creation and udev
Date: Fri, 16 Mar 2018 16:23:00 +0100
Message-Id: <20180316152233.293335705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -308,6 +308,12 @@ int ubi_create_volume(struct ubi_device
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
@@ -350,11 +356,6 @@ int ubi_create_volume(struct ubi_device
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
@@ -374,6 +375,10 @@ out_sysfs:
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
