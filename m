Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D1AC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C7A20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9poGWsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C7A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeKIHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbeKIHde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:34 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA962089F;
        Thu,  8 Nov 2018 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714166;
        bh=R8LdLibVwVPjiUhIJobKphAG/4ZZxsXmMdZdnmZcKos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9poGWsDymP0bkar+Pzpve8ILRRdsVzi2PJx3EXaXbGBASlEU+TsCaPdH2XAF0ubC
         iRjgE2lqmnkfH8Su5aY7jl8UzsDB6Uvc/xm6aSDxLo0H3XaZEnp8ArxskM9PgxwJw9
         pIEKsdAM5c4w4l8f3IKbreMCQOxdW3EvCikWp2rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 086/144] of/pci: Remove duplicate kfree in of_pci_get_host_bridge_resources()
Date:   Thu,  8 Nov 2018 13:50:57 -0800
Message-Id: <20181108215101.625526125@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit feb28979c137ba3f649ad36fc27c85c64c111f78 ]

Commit d2be00c0fb5a ("of/pci: Free resources on failure in
of_pci_get_host_bridge_resources()") fixed the error path so it frees
everything on the "resources" list.  That list includes the bus_range, so
we should not free it again.

Remove the superfluous free of bus_range.

[bhelgaas: changelog]
Fixes: d2be00c0fb5a ("of/pci: Free resources on failure in of_pci_get_host_bridge_resources()")
Reported-by: Jiang Liu <jiang.liu@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index ecc5fa5640d2..8a74b1d399a1 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -229,7 +229,6 @@ parse_failed:
 	list_for_each_entry(window, resources, list)
 		kfree(window->res);
 	pci_free_resource_list(resources);
-	kfree(bus_range);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.17.1



