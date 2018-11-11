Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B6C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858C820872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUFoFz1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858C820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391131AbeKLItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390788AbeKLIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD1221780;
        Sun, 11 Nov 2018 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975561;
        bh=Y7cjABgHQ6iwsddHuD3fNSfOKSo2j75SBGG2JfEZS94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUFoFz1SfVfTgMJ66lpS+yGEJv+4UxIG0mEaaVgRb4Rg5iY5LhKYtakzMwejYhkek
         2mCXyE1RgLVTvpdMiCIT0m0L+ZdOPFnEju3vkFMH7TUUfMMS0A2poyUC0RI3CHEl3x
         PQsjm18Lj8ziz0b+iEadEMkC53lqIwY5Xd/vkAjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.14 123/222] xen/pvh: dont try to unplug emulated devices
Date:   Sun, 11 Nov 2018 14:23:40 -0800
Message-Id: <20181111221658.698598209@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit e6111161c0a02d58919d776eec94b313bb57911f upstream.

A Xen PVH guest has no associated qemu device model, so trying to
unplug any emulated devices is making no sense at all.

Bail out early from xen_unplug_emulated_devices() when running as PVH
guest. This will avoid issuing the boot message:

[    0.000000] Xen Platform PCI: unrecognised magic value

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/platform-pci-unplug.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -146,6 +146,10 @@ void xen_unplug_emulated_devices(void)
 {
 	int r;
 
+	/* PVH guests don't have emulated devices. */
+	if (xen_pvh_domain())
+		return;
+
 	/* user explicitly requested no unplug */
 	if (xen_emul_unplug & XEN_UNPLUG_NEVER)
 		return;


