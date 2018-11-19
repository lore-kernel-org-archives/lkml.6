Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F1214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N25rpwmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650F1214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbeKTDKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbeKTDKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29193214C4;
        Mon, 19 Nov 2018 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646002;
        bh=bv2jD/nkNyvNIulj7UDqbDyulOzjy3RgpS8lSEWtzaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N25rpwmELHzxZ1beIX1QGNnfJjCBOD52IHXYoxmpciwwsQ+aCnGgvL4z1BIQRstnA
         3c9fT03kNh0KMIWCkpJSJLi2eyyhDCoQ/Psg0WQFbaCmHk7gYgrswODq2kaVNhXAc1
         uVMfgY/ohy8XYRcbZ/d8Zg7Dc4iUMZoPZKSk4dBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Juergen Gross <jgross@suse.com>, Jeff.Kubascik@dornerworks.com,
        Jarvis.Roach@dornerworks.com, Nathan.Studer@dornerworks.com,
        vkuznets@redhat.com, boris.ostrovsky@oracle.com,
        julien.grall@arm.com
Subject: [PATCH 4.18 171/171] CONFIG_XEN_PV breaks xen_create_contiguous_region on ARM
Date:   Mon, 19 Nov 2018 17:29:27 +0100
Message-Id: <20181119162641.376268738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Stefano Stabellini <stefanos@xilinx.com>

commit f9005571701920551bcf54a500973fb61f2e1eda upstream.

xen_create_contiguous_region has now only an implementation if
CONFIG_XEN_PV is defined. However, on ARM we never set CONFIG_XEN_PV but
we do have an implementation of xen_create_contiguous_region which is
required for swiotlb-xen to work correctly (although it just sets
*dma_handle).

[backport: remove change to xen_remap_pfn]

Cc: <stable@vger.kernel.org> # 4.12
Fixes: 16624390816c ("xen: create xen_create/destroy_contiguous_region() stubs for PVHVM only builds")
Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
CC: Jeff.Kubascik@dornerworks.com
CC: Jarvis.Roach@dornerworks.com
CC: Nathan.Studer@dornerworks.com
CC: vkuznets@redhat.com
CC: boris.ostrovsky@oracle.com
CC: jgross@suse.com
CC: julien.grall@arm.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/xen/xen-ops.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -41,7 +41,7 @@ int xen_setup_shutdown_event(void);
 
 extern unsigned long *xen_contiguous_bitmap;
 
-#ifdef CONFIG_XEN_PV
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				unsigned int address_bits,
 				dma_addr_t *dma_handle);


