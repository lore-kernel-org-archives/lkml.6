Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3C0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CDA23FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CDA23FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGFFr7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932603AbeGFFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:47:58 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 430CB86A;
        Fri,  6 Jul 2018 05:47:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-ia64@vger.kernel.org,
        Oliver OHalloran <oohall@gmail.com>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: [PATCH 4.17 22/46] drm/sti: Depend on OF rather than selecting it
Date:   Fri,  6 Jul 2018 07:46:43 +0200
Message-Id: <20180706054525.666782487@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver O'Halloran <oohall@gmail.com>

commit c9fea6f4379c72b7c59e1efceab09a35bc7eac43 upstream.

Commit cc6b741c6f63 ("drm: sti: remove useless fields from vtg
structure") reworked some code inside of this driver and made it select
CONFIG_OF. This results in the entire OF layer being enabled when
building an allmodconfig on ia64. OF on ia64 is completely unsupported
so this isn't a great state of affairs.

The 0day robot noticed a link-time failure on ia64 caused by
using of_node_to_nid() in an otherwise unrelated driver. The
generic fallback for of_node_to_nid() only exists when:

	defined(CONFIG_OF) && defined(CONFIG_NUMA) == false

Since CONFIG_NUMA is usually selected for IA64 we get the link failure.
Fix this by making the driver depend on OF rather than selecting it,
odds are that was the original intent.

Link: https://lists.01.org/pipermail/kbuild-all/2018-March/045172.html
Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-ia64@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180403053401.30045-1-oohall@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/sti/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -1,6 +1,6 @@
 config DRM_STI
 	tristate "DRM Support for STMicroelectronics SoC stiH4xx Series"
-	depends on DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
+	depends on OF && DRM && (ARCH_STI || ARCH_MULTIPLATFORM)
 	select RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -8,6 +8,5 @@ config DRM_STI
 	select DRM_PANEL
 	select FW_LOADER
 	select SND_SOC_HDMI_CODEC if SND_SOC
-	select OF
 	help
 	  Choose this option to enable DRM on STM stiH4xx chipset


