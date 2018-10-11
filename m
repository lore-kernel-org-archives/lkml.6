Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F085C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BDC21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+VNSK33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BDC21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeJKXPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8C621480;
        Thu, 11 Oct 2018 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272835;
        bh=BqcrMYK1ZR91GHO10OKlk7DbV0NiJM40d7EHXceB8LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+VNSK33S0+pnv4E0H1e9gkMiOEjSe07ftJ9fzqcI1Q2l44ZX08HhfDLvUXfyYnzp
         srFRWHneDpesTKEljSwDLd0zlSWx5W+ZY04EyeHO4IKI+MIcCdIbBBSIS/Z454zKH8
         ZSDGzNCA2VWeZ739hYpycPO0VMvtFHdXqPi6/rcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Wilhelm <fwilhelm@google.com>,
        Jan Beulich <jbeulich@suse.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 11/44] xen-netback: fix input validation in xenvif_set_hash_mapping()
Date:   Thu, 11 Oct 2018 17:39:49 +0200
Message-Id: <20181011152452.999951115@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

From: Jan Beulich <JBeulich@suse.com>

commit 780e83c259fc33e8959fed8dfdad17e378d72b62 upstream.

Both len and off are frontend specified values, so we need to make
sure there's no overflow when adding the two for the bounds check. We
also want to avoid undefined behavior and hence use off to index into
->hash.mapping[] only after bounds checking. This at the same time
allows to take care of not applying off twice for the bounds checking
against vif->num_queues.

It is also insufficient to bounds check copy_op.len, as this is len
truncated to 16 bits.

This is XSA-270 / CVE-2018-15471.

Reported-by: Felix Wilhelm <fwilhelm@google.com>
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Tested-by: Paul Durrant <paul.durrant@citrix.com>
Cc: stable@vger.kernel.org [4.7 onwards]
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netback/hash.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -332,20 +332,22 @@ u32 xenvif_set_hash_mapping_size(struct
 u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
 			    u32 off)
 {
-	u32 *mapping = &vif->hash.mapping[off];
+	u32 *mapping = vif->hash.mapping;
 	struct gnttab_copy copy_op = {
 		.source.u.ref = gref,
 		.source.domid = vif->domid,
-		.dest.u.gmfn = virt_to_gfn(mapping),
 		.dest.domid = DOMID_SELF,
-		.dest.offset = xen_offset_in_page(mapping),
-		.len = len * sizeof(u32),
+		.len = len * sizeof(*mapping),
 		.flags = GNTCOPY_source_gref
 	};
 
-	if ((off + len > vif->hash.size) || copy_op.len > XEN_PAGE_SIZE)
+	if ((off + len < off) || (off + len > vif->hash.size) ||
+	    len > XEN_PAGE_SIZE / sizeof(*mapping))
 		return XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER;
 
+	copy_op.dest.u.gmfn = virt_to_gfn(mapping + off);
+	copy_op.dest.offset = xen_offset_in_page(mapping + off);
+
 	while (len-- != 0)
 		if (mapping[off++] >= vif->num_queues)
 			return XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER;


