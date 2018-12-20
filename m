Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8BC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3E1217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297953;
	bh=Ll82O8ayxpFEcIP0kbQ4roWK9/YT8S7vXOg0BxPCTkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OP39G70/rMWjnYlI3D3pLgBgyNtJYWVpJv2L1R6x7JhQa1xruadr4NrCw2079qLwh
	 svKixQ7ZqKa9OdSkhUsslNnJ1vBFOaMbPZ/z7lpAR1AMQehuzMxipAM34zCtqSBGHM
	 uVqckYszUleAYz8KOY2AiRyGZ4LvPyK25igtQ6R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeLTJZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbeLTJZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA08217D7;
        Thu, 20 Dec 2018 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297947;
        bh=Ll82O8ayxpFEcIP0kbQ4roWK9/YT8S7vXOg0BxPCTkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oxu8Pis514W8ehY90NDKUmsOANaplsW+kkzyktmhwf8hYQK8AnYMAhbtcRR7WSiPN
         kW4XsjLdxlSev6E+O5ZjXs4kyQy0qwWmjU/EeFmdL6kIWgzVJLwDg+BGQ1T3Ji5ZBX
         IsjViHsTGbIw09oVsVr7wTZHBwycdct7coFun05Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 15/72] drm/nouveau/kms: Fix memory leak in nv50_mstm_del()
Date:   Thu, 20 Dec 2018 10:18:14 +0100
Message-Id: <20181220085922.932740035@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 24199c5436f267399afed0c4f1f57663c0408f57 upstream.

Noticed this while working on redoing the reference counting scheme in
the DP MST helpers. Nouveau doesn't attempt to call
drm_dp_mst_topology_mgr_destroy() at all, which leaves it leaking all of
the resources for drm_dp_mst_topology_mgr and it's children mstbs+ports.

Fixes: f479c0ba4a17 ("drm/nouveau/kms/nv50: initial support for DP 1.2 multi-stream")
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nv50_display.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -3378,6 +3378,7 @@ nv50_mstm_del(struct nv50_mstm **pmstm)
 {
 	struct nv50_mstm *mstm = *pmstm;
 	if (mstm) {
+		drm_dp_mst_topology_mgr_destroy(&mstm->mgr);
 		kfree(*pmstm);
 		*pmstm = NULL;
 	}


