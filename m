Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5576C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3221B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898594;
	bh=0PQXRgnZf2J5HVkB0d/pTRumzsfj+AI4/IQL6UeKebM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drHDlAiAN1v5LXDd8djK/NcR2ZU8qwEyx1Q6/8+oh1HieefVkcTXZ1eIhD/rFjac0
	 tvh5fZ+QSk0u1OHQLEMJry2ZJxPzFlTYNvM8Lf4iKBcWQEaGs7A9a+j/uuUfQlo1cA
	 9qELfCbuW355PMXonhAbhS7H9zCZrnBMIKKQ2yZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390917AbfBKPXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390085AbfBKPD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930E5222B5;
        Mon, 11 Feb 2019 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897407;
        bh=0PQXRgnZf2J5HVkB0d/pTRumzsfj+AI4/IQL6UeKebM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1pq6P/8/Ll0xNdZdypTWHaq6dJPkN7ALlP1/3mRXJakTFjd8v3Eu7sUogSTG7PIl
         gKBGbKKkDiPvTluzRiXcYnGW35xB2QwoIWONN5+3Nr9ImqehzIiKfxpSyVFB4mT0mH
         X2HPiyqfyoeOFFW6aV5IOmsb+Prr/txhI0XaJ03s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 193/205] kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
Date:   Mon, 11 Feb 2019 15:19:51 +0100
Message-Id: <20190211141841.033392607@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit cfa39381173d5f969daf43582c95ad679189cbc9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/kvm_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2912,8 +2912,10 @@ static int kvm_ioctl_create_device(struc
 	if (ops->init)
 		ops->init(dev);
 
+	kvm_get_kvm(kvm);
 	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
 	if (ret < 0) {
+		kvm_put_kvm(kvm);
 		mutex_lock(&kvm->lock);
 		list_del(&dev->vm_node);
 		mutex_unlock(&kvm->lock);
@@ -2921,7 +2923,6 @@ static int kvm_ioctl_create_device(struc
 		return ret;
 	}
 
-	kvm_get_kvm(kvm);
 	cd->fd = ret;
 	return 0;
 }


