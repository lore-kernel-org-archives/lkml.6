Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804508-2-6846101868286703858
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
    t=1521804507; b=CxEbtIyJs9811RODPFxvNDHxdGsWRPl1/z0HuuNM3Qdr8CK
    HGRfo9bLj6LEFvhvfpAe5VpceMVSbAKsWAv3MyrvyQaqFEq5siIY3HnzKTWETW6h
    6WDnG193GF7oUF6Z5wuTr3WIXtsZnKiuVNLBtYQg/NauCSgqhsg0x2/xNi012akM
    y4AGCrRlSWk0aykRmFwZe2ZexGBOBTDL/mEeZDrfV9BAjcgnzAxjjhG1p+rAYEfd
    yEE94gy5+fhROQl/o0I14tzG5M9PstRgKbZQNvnuxZMsoHFsrlZCxQ+7vTz/73+b
    5EEFu2FkPuFhTB2HtsDIAv95d00k8PyI0o2JBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804507; bh=vx9tslYIgTBqwxAdy3vwc5Hox0
    iZb0+kRAefRnpcs3A=; b=W3J/FFHh7ymX8QLc+E6jQ+IWizUomQQd0DZfK3gqrS
    XkIF3rAz3R4INEUW/jkyTcuf/Srrii3fMyYsKuy7weHygLc0xj6LJqyAYVLxf1T9
    EQBWNo7i2/W9BijEq/++gvoZeVsh+nK7Ck20lV4iNKpNHf5OMTEYwlbQTf56JOgG
    fveglOeiJTj3lFGhwSEsL+ejhVOO7DkriBX5yec7EBbuxekIAACpsxrOEcQWJl3I
    ih70C9h1Xdb279PhdPG4FZLnmoxRLpb6ENjPO6XSAaEANWmxmZzKV08/1UEfDesg
    HwOgCNTlGfNxqJDDdCeRFI4UEK1Qubaje0mVwg9FtZtA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbeCWKGx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeCWKGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 049/177] IB/mlx5: Take write semaphore when changing the vma struct
Date: Fri, 23 Mar 2018 10:52:57 +0100
Message-Id: <20180323094207.497408437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maor Gottlieb <maorg@mellanox.com>


[ Upstream commit ecc7d83be3243835c9396a1a2fb8ce95f205207b ]

When the driver disassociate user context, it changes the vma to
anonymous by setting the vm_ops to null and zap the vma ptes.

In order to avoid race in the kernel, we need to take write lock
before we change the vma entries.

Fixes: 7c2344c3bbf97 ('IB/mlx5: Implements disassociate_ucontext API')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1313,7 +1313,7 @@ static void mlx5_ib_disassociate_ucontex
 	/* need to protect from a race on closing the vma as part of
 	 * mlx5_ib_vma_close.
 	 */
-	down_read(&owning_mm->mmap_sem);
+	down_write(&owning_mm->mmap_sem);
 	list_for_each_entry_safe(vma_private, n, &context->vma_private_list,
 				 list) {
 		vma = vma_private->vma;
@@ -1327,7 +1327,7 @@ static void mlx5_ib_disassociate_ucontex
 		list_del(&vma_private->list);
 		kfree(vma_private);
 	}
-	up_read(&owning_mm->mmap_sem);
+	up_write(&owning_mm->mmap_sem);
 	mmput(owning_mm);
 	put_task_struct(owning_process);
 }
