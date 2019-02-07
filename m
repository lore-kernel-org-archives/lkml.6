Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA68C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6DF2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhV9uZ9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBGSJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:09:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56281 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:09:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so830283wmh.5;
        Thu, 07 Feb 2019 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QUqafu5ey3MC3GU/mS/kAxgTE6eFfVBe/RhdMdih610=;
        b=LhV9uZ9fZ4wucABOqEDhJKKYjOmhoDWltS+c+T/VNQlnGlVc7C1FNUGi6p51nS3YQ5
         rymkj+bGbC/7Wl8PiSDtP/uNeRbgANTt4SxZfgYfj57Tp/tmXh1mB9qJcY26GvA4v8eT
         sL0jZtTLkffeMsQHFxBAu1ttb9MCO5bGdVPqAAAPHU7vkecIyIT8fAxv/fF0/P6yM/v6
         mKtTJCMtyVcqKeMjiefTjB+wwMKGddPR2AcsHocI1+aXOWRH2tSkGQXYxnudpS0to/Qm
         gtW4BYrTPw+nksPeh8988UPltfzIkrX7cJ9RhkdoclamKWA4df+5eX6c+lzygJho0VyZ
         X3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QUqafu5ey3MC3GU/mS/kAxgTE6eFfVBe/RhdMdih610=;
        b=Qto0fsxl6EuGs2PydY1/WY3R0z1hYD533RGppXJ1r74VSGJYwLh5anmepKOLf/sWXj
         hb/GHd6y21V+/lfD63Hs6UxwJy1xTdFAlX0lCBxpUaY0n8wA1vPjbgH+W+A4bTveNF60
         rq5QdM7MOAHqMP8xrgc+2JbjjeLXkBIFBAKf2Bo9GxldlzEykqjSsZRczIftpBkAU6Xg
         AxFDbUa7aIvjE3jAmqrCCKyAfpzVMjMtW/kqO42dTpNA5YMGtHhUM7SLF00F+iG3Yb+x
         G2s4lqz2aElQgI81/4EUnI7/NjKiSV4aazv/Ut1b54+7iDToeLzLb3rPZKCQtPmdM82M
         1ePA==
X-Gm-Message-State: AHQUAua3ruRIcWzwgBab8VxPaYIpTOmSEhqXB70LvEPLAYB9ZKHgQRaJ
        cZPI+VXGvSltJFBlHm7SNcbOFb4e
X-Google-Smtp-Source: AHgI3IYNC1Fw/+iZj2Hx/N1g1mdnGyHPdJxPQMGDgRkEBIWL7znbjXEVwNwYhqb8IHFc+mvGylWhiA==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr8219356wme.54.1549562946874;
        Thu, 07 Feb 2019 10:09:06 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m4sm7321218wrq.6.2019.02.07.10.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:09:06 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, stable@kernel.org
Subject: [PATCH] kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
Date:   Thu,  7 Feb 2019 19:09:03 +0100
Message-Id: <1549562945-5503-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

kvm_ioctl_create_device() does the following:

1. creates a device that holds a reference to the VM object (with a borrowed
   reference, the VM's refcount has not been bumped yet)
2. initializes the device
3. transfers the reference to the device to the caller's file descriptor table
4. calls kvm_get_kvm() to turn the borrowed reference to the VM into a real
   reference

The ownership transfer in step 3 must not happen before the reference to the VM
becomes a proper, non-borrowed reference, which only happens in step 4.
After step 3, an attacker can close the file descriptor and drop the borrowed
reference, which can cause the refcount of the kvm object to drop to zero.

This means that we need to grab a reference for the device before
anon_inode_getfd(), otherwise the VM can disappear from under us.

Fixes: 852b6d57dc7f ("kvm: add device control API")
Cc: stable@kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5ecea812cb6a..585845203db8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3000,8 +3000,10 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	if (ops->init)
 		ops->init(dev);
 
+	kvm_get_kvm(kvm);
 	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
 	if (ret < 0) {
+		kvm_put_kvm(kvm);
 		mutex_lock(&kvm->lock);
 		list_del(&dev->vm_node);
 		mutex_unlock(&kvm->lock);
@@ -3009,7 +3011,6 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 		return ret;
 	}
 
-	kvm_get_kvm(kvm);
 	cd->fd = ret;
 	return 0;
 }
-- 
1.8.3.1

