Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9681DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFE7217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170721;
	bh=+Gw5Py3D9XQs8Ad17vsIs+lR1N1P7z9GugjQVKKDSTg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VmqitfI6KwjzZpiwEQ6iU/rsyn3w6yXRZc9k446kTmWv0b78mJJPf+/lUlciRr5Af
	 XN6U5GMElnHOd0haHVj7v1AWWy4Y09lNDITrW58IKVmIWAXFjPv3XjLmfeZ6zszuax
	 G3SzkwII1x5YK7iiNvyZvBJoUHX8stVQoMcHJh2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfAVPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfAVPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9FA20879;
        Tue, 22 Jan 2019 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170636;
        bh=+Gw5Py3D9XQs8Ad17vsIs+lR1N1P7z9GugjQVKKDSTg=;
        h=From:To:Cc:Subject:Date:From;
        b=xxrzN+9+nDOcbe8ee8IOiZ2frIs7aVUnP21euVtoFXI52ZIm4PNbst1G6uqxf8n4T
         l0sVusO4QxuwUdedZPTGQsQ8sLrAN4AGvlcG8INEu+d5YYjbY48YnvQeMGEFaaZlbE
         gpxRTqvmLS3WtIaAScy+S01huJELTIuQEE8LYWjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: [PATCH] kvm: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:50 +0100
Message-Id: <20190122152151.16139-51-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5ecea812cb6a..4f96450ecdfc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2528,9 +2528,7 @@ static int kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 
 	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
 	vcpu->debugfs_dentry = debugfs_create_dir(dir_name,
-								vcpu->kvm->debugfs_dentry);
-	if (!vcpu->debugfs_dentry)
-		return -ENOMEM;
+						  vcpu->kvm->debugfs_dentry);
 
 	ret = kvm_arch_create_vcpu_debugfs(vcpu);
 	if (ret < 0) {
-- 
2.20.1

