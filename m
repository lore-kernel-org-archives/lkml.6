Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D646C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00B82084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759861;
	bh=l93Evb8YqM0Tkmz6yNRBZOhB4d6bmHgDT8WwYma9qDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8hNjzxrjbo8iVwhG1noNbnwIle+tZsGJHSKTTQG6PllH5m+SMDFV6MXZ0wHKpetj
	 e0bwoibSuMmoqG2DX4N51uy7IepUqXpn/VJei/aM1aojX3lX3klE7/8oojfU/2wUhi
	 uU2QMAeeDmWNHPtjTG3pYgJBLdYaOI6/vY7zMZZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfBUOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfBUOhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B517E2084D;
        Thu, 21 Feb 2019 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759857;
        bh=l93Evb8YqM0Tkmz6yNRBZOhB4d6bmHgDT8WwYma9qDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/4eGZd4QS9FZQ7mVUiahCeQHRBp60HwuYmiknC2f03mk1IzWgeL9nWSLWG5OYruj
         aqDASB58DX5hIYKlrRG6vbu7B4lXS4BYwxRqA3/r0U/B9W2agIEtMlMWWPt0KcRSLY
         UaX72JledjHzbeIvi+8PxisOEgcppwWps/dxoPug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 14/20] kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
Date:   Thu, 21 Feb 2019 15:35:44 +0100
Message-Id: <20190221141947.179218556@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2711,14 +2711,15 @@ static int kvm_ioctl_create_device(struc
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


