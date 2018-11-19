Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8073C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E121104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD4iiFdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2E121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbeKTDSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390145AbeKTDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EE420851;
        Mon, 19 Nov 2018 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646438;
        bh=Wh1iL7Nh0gKm1H7wDj3Au//WRYDh/Qd9OiBA3ha7qd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sD4iiFdolKcIczcj2jBGYLLhjj3URn09PFwZXyKZXZziIo/ufiogPpRVZSk7lFx72
         7k2RyB3WRmS3fL8qS1nk9mQOjbN89ZAq6/0HzXl8WzPrmG43/Y10yKTvgYAjd46JVc
         fHDWuANj7qzDpT/YSgE35pz/70koMjbM5PXc2ddU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Edwards <gedwards@ddn.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 42/83] vhost/scsi: truncate T10 PI iov_iter to prot_bytes
Date:   Mon, 19 Nov 2018 17:29:08 +0100
Message-Id: <20181119162620.824987501@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Edwards <gedwards@ddn.com>

commit 4542d623c7134bc1738f8a68ccb6dd546f1c264f upstream.

Commands with protection information included were not truncating the
protection iov_iter to the number of protection bytes in the command.
This resulted in vhost_scsi mis-calculating the size of the protection
SGL in vhost_scsi_calc_sgls(), and including both the protection and
data SG entries in the protection SGL.

Fixes: 09b13fa8c1a1 ("vhost/scsi: Add ANY_LAYOUT support in vhost_scsi_handle_vq")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 09b13fa8c1a1093e9458549ac8bb203a7c65c62a
Cc: stable@vger.kernel.org
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/scsi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -999,7 +999,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *
 				prot_bytes = vhost32_to_cpu(vq, v_req_pi.pi_bytesin);
 			}
 			/*
-			 * Set prot_iter to data_iter, and advance past any
+			 * Set prot_iter to data_iter and truncate it to
+			 * prot_bytes, and advance data_iter past any
 			 * preceeding prot_bytes that may be present.
 			 *
 			 * Also fix up the exp_data_len to reflect only the
@@ -1008,6 +1009,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *
 			if (prot_bytes) {
 				exp_data_len -= prot_bytes;
 				prot_iter = data_iter;
+				iov_iter_truncate(&prot_iter, prot_bytes);
 				iov_iter_advance(&data_iter, prot_bytes);
 			}
 			tag = vhost64_to_cpu(vq, v_req_pi.tag);


