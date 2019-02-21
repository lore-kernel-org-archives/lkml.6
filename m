Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D289AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19FB20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759805;
	bh=26ClJN1DQp2RlucG+ba1Rj/fWhTZZc4evasXUnpqvaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IOxsw8YETiemvvU3RbJ9ZLy5YvX7DZv3g9Jp0tlmUcd69zvBo3p5QOu0DahHUtUb2
	 5zf3K/x4SOn3pB7pW3Hga32I/RAWpUR9QC8P60g+pekGTLdUIT6jDQQNN3JZCUmDD6
	 0pU7B5iiGs4nCfA5/DnhwCFj6FZ2qStteLAq4+4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfBUOgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:36:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5AF2084D;
        Thu, 21 Feb 2019 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759801;
        bh=26ClJN1DQp2RlucG+ba1Rj/fWhTZZc4evasXUnpqvaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdT6l23BYzJCObcS2CKAHzbI6NafUsQnTGkL6zNSoC3SLoxVzENUksC6/ZHGKGcLW
         Bui0wKR33rFbASxb54d3ykwH+t8QrSmJufu2LdRR3VVFBMHYDOIxh/vLcc85i7uXgU
         wklMw45NNmbTPhzrmxRY4HFtUMH+l79HhC89rdb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3.18 10/13] kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
Date:   Thu, 21 Feb 2019 15:35:41 +0100
Message-Id: <20190221125241.305422019@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2398,14 +2398,15 @@ static int kvm_ioctl_create_device(struc
 		return ret;
 	}
 
+	kvm_get_kvm(kvm);
 	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
 	if (ret < 0) {
+		kvm_put_kvm(kvm);
 		ops->destroy(dev);
 		return ret;
 	}
 
 	list_add(&dev->vm_node, &kvm->devices);
-	kvm_get_kvm(kvm);
 	cd->fd = ret;
 	return 0;
 }


