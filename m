Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15E2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BBF214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789450;
	bh=geDBmwratt/yH06PqXA2E4c54bW5rEC+qkPRKE9GjTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zt2VPgY00KaTJXKl6GAFXTYMKHkmejmkUVyCutvee6dQsmOYZOaZ3DM18ypQovQ1K
	 Q2ywsoGAWjXmJk8rQhMJ7tg9C053PbEZ/IRaliMcNJlfjFSKIwk3ckc80MOHlAIASz
	 isGmLpWvBaQx+TLiXAlWi4vFeYWygMojDiB4X/tQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BBF214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbeLNMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731656AbeLNMKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33B92147D;
        Fri, 14 Dec 2018 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789446;
        bh=geDBmwratt/yH06PqXA2E4c54bW5rEC+qkPRKE9GjTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/Tz+YmDBXRJFM9InvMZ1ZgrfsRLV6hlbFqM3pO+jCtJHGPhY9NHZU3K5Q7G6075v
         w7EwMvu4emv8+3OnA+Aozfn67DHHJJcYStoriIMVIDgfG8sh2Dox894F56MCWG61F1
         d75+LpnW5x2kwcqRClc87JG2JhEV/nAdeRZYoIls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 85/89] flexfiles: enforce per-mirror stateid only for v4 DSes
Date:   Fri, 14 Dec 2018 13:00:38 +0100
Message-Id: <20181214115733.891046906@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>

commit 320f35b7bf8cccf1997ca3126843535e1b95e9c4 upstream.

Since commit bb21ce0ad227 we always enforce per-mirror stateid.
However, this makes sense only for v4+ servers.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/flexfilelayout/flexfilelayout.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1725,7 +1725,8 @@ ff_layout_read_pagelist(struct nfs_pgio_
 	if (fh)
 		hdr->args.fh = fh;
 
-	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
+	if (vers == 4 &&
+		!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
 		goto out_failed;
 
 	/*
@@ -1790,7 +1791,8 @@ ff_layout_write_pagelist(struct nfs_pgio
 	if (fh)
 		hdr->args.fh = fh;
 
-	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
+	if (vers == 4 &&
+		!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
 		goto out_failed;
 
 	/*


