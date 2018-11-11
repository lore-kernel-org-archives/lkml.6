Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6012175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mriCmGJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6012175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeKLIUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388608AbeKLIUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:21 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E413223D8;
        Sun, 11 Nov 2018 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975425;
        bh=COLl5J+OImek4e+EgNhWIDvx/f9jezt5+thDeUpuWoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mriCmGJGlbfmHQPG2HrpVGBf7QQCZ4uOQZRANunOBBVCwsEj0AZ4pVbmull65jzMC
         47yaZbNlSfUhjtUndKACcNVrb3iM0iY+fG8tn97WvDQdIXqL5RRIO9XQrgC3FkCJDD
         1zXL1F6B47lvN1Cg0Uq8C5aahHYmIoIQfrjGsHFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Adit Ranadive <aditr@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 156/350] VMCI: Resource wildcard match fixed
Date:   Sun, 11 Nov 2018 14:20:20 -0800
Message-Id: <20181111221714.587682648@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorgen Hansen <jhansen@vmware.com>

[ Upstream commit 11924ba5e671d6caef1516923e2bd8c72929a3fe ]

When adding a VMCI resource, the check for an existing entry
would ignore that the new entry could be a wildcard. This could
result in multiple resource entries that would match a given
handle. One disastrous outcome of this is that the
refcounting used to ensure that delayed callbacks for VMCI
datagrams have run before the datagram is destroyed can be
wrong, since the refcount could be increased on the duplicate
entry. This in turn leads to a use after free bug. This issue
was discovered by Hangbin Liu using KASAN and syzkaller.

Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_driver.c   |    2 +-
 drivers/misc/vmw_vmci/vmci_resource.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.5.0-k");
+MODULE_VERSION("1.1.6.0-k");
 MODULE_LICENSE("GPL v2");
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -57,7 +57,8 @@ static struct vmci_resource *vmci_resour
 
 		if (r->type == type &&
 		    rid == handle.resource &&
-		    (cid == handle.context || cid == VMCI_INVALID_ID)) {
+		    (cid == handle.context || cid == VMCI_INVALID_ID ||
+		     handle.context == VMCI_INVALID_ID)) {
 			resource = r;
 			break;
 		}


