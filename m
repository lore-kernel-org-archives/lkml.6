Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5827206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864651;
	bh=2Q/+0lqhtxYQc3wHqqIcMWT1zF/sDPcBsDC9AP1fVqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SyG696cZd5cBoxZivpCxT+dCDmYgXlS+gNIYuqgXRU6Tj3AshbS8dX3I+gnvuzdWz
	 mtW5/p0bOzCEAYYD8cA+VZ07ojScqhJSITDEks3+oIZyXh8xXiGvBd0S6/aEoVSCRr
	 KSmtbr5HCaSa9c9zHj3Dd11QohX0f2Ugb7frCUxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfAGMha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfAGMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A3F206BB;
        Mon,  7 Jan 2019 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864645;
        bh=2Q/+0lqhtxYQc3wHqqIcMWT1zF/sDPcBsDC9AP1fVqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srtJQWKzWQkogq8t4IbAofUX4sbhgCFEtm1tic2GXGlk9hQtvsKRMCjluUYD/y9o0
         HATig2vA7EMwdXU9l0xJRoCLwmdLvdyJX31Lo3rt3gElMhLdlB9vRiVDSFgVV8zG/w
         vLYAHILZneDlTl1qI4P9HS22VtwHC7SQ2eT8m/mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.20 061/145] drm/v3d: Skip debugfs dumping GCA on platforms without GCA.
Date:   Mon,  7 Jan 2019 13:31:38 +0100
Message-Id: <20190107104445.246016861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

commit 2f20fa8d12e859a03f68bdd81d75830141bc9ac9 upstream.

Fixes an oops reading this debugfs entry on BCM7278.

Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180928232126.4332-4-eric@anholt.net
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Cc: <stable@vger.kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/v3d/v3d_debugfs.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -71,10 +71,13 @@ static int v3d_v3d_debugfs_regs(struct s
 			   V3D_READ(v3d_hub_reg_defs[i].reg));
 	}
 
-	for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   v3d_gca_reg_defs[i].name, v3d_gca_reg_defs[i].reg,
-			   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
+	if (v3d->ver < 41) {
+		for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
+			seq_printf(m, "%s (0x%04x): 0x%08x\n",
+				   v3d_gca_reg_defs[i].name,
+				   v3d_gca_reg_defs[i].reg,
+				   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
+		}
 	}
 
 	for (core = 0; core < v3d->cores; core++) {


