Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C745C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3221581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D3221581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeHXMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:04:37 -0400
Received: from www.osadl.org ([62.245.132.105]:47884 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeHXMEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:04:37 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w7O8Sl5E012215;
        Fri, 24 Aug 2018 10:28:47 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     David Airlie <airlied@linux.ie>, Andrew F Davis <afd@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] drm: omapdrm: do not allow kmalloc to fail
Date:   Fri, 24 Aug 2018 10:27:23 +0200
Message-Id: <1535099243-29679-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 As this is during init this allocation should not fail and given that the
code is in this state now for 4 years+ this seems to have worked.
kmalloc should be checked though or forced not to fail - Not really sure
but this case seems suitable for __GFP_NOFAIL (relatively small
allocation early in the boot process where it should not fail). The
alternative would probably be a BUG_ON(!new_compat); here.

Issue was introduced by
  commit f2dd36ac9974 ("OMAPDSS: move 'compatible' converter to omapdss driver")

and there is the identical issue in:
  ./drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:113:

Pleas let me know if that fix (use of __GFP_NOFAIL) is suitable for this
situation.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: f2dd36ac9974 ("OMAPDSS: move 'compatible' converter to omapdss driver")
---

Issue located with an experimental coccinelle script

Patch was compile tested with: omap2plus_defconfig (implies OMAP2_DSS_INIT=y)

Patch is against 4.18 (localversion-next is next-20180824)


 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
index 3bfb95d..1e07c07 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
@@ -110,7 +110,7 @@ static void __init omapdss_omapify_node(struct device_node *node)
 	num_strs = omapdss_count_strings(prop);
 
 	new_len = prop->length + strlen(prefix) * num_strs;
-	new_compat = kmalloc(new_len, GFP_KERNEL);
+	new_compat = kmalloc(new_len, GFP_KERNEL | __GFP_NOFAIL);
 
 	omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
 
-- 
2.1.4

