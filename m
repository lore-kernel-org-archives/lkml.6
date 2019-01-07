Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A19720651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865578;
	bh=LIPy5yR/yeUTrprN4EsOUKON1W6KU8Z69f3HG+yuafQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXBKXHW8C55fIDe4y/J1GNfplGTmwzqhRfnm1nEAzYgmxVameHvPC9erKhL/ZpNFo
	 8UvZbEwhOpCjilbRs9IIOoknx+J/clz/E4qodrpf7wyLgypu5tC5y/adMbPlRCCEmb
	 tQh/GQ2S+/meIsAmTxDVBOnvh7vQxIMJL9Kw/nQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfAGMw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfAGMwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D904320651;
        Mon,  7 Jan 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865574;
        bh=LIPy5yR/yeUTrprN4EsOUKON1W6KU8Z69f3HG+yuafQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmqhRoH0Bgerh5NyKO4oBtZ5mD5yCoJ7q+1brquhNRMXAh2KvHHUx7Wg12SCUQJut
         TrHrlork1S6HpbGORm966J9Nh4QAYLY4Jvrvm9PqcWr1q0XBJn0VezWvdievKSzp6Z
         nxbxGW+nyc0fKCojFlZygL+2c9EKaDh4FpFfwGj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 096/170] drm/v3d: Skip debugfs dumping GCA on platforms without GCA.
Date:   Mon,  7 Jan 2019 13:32:03 +0100
Message-Id: <20190107104504.381090175@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


