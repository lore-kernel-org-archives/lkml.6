Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B972146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788891;
	bh=WpjLEwZmyU5pDSgLxclwf9bZotWqr0hYDwXNJkKmkZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qtwnwxR1JGU/WNB6di6XGkJ2KC6soAtugoS8uMq2wpxdCp54nrejSSS9XRFMV0wYn
	 saVEaSF/HEKD7uHa8rPyo39HcejFomXxglr5j3tlRHlXdInCHXYsY9o66yI49euQ8v
	 9vx8qYEZcNzO94s3fU8tPSO9hqPfJAMn100ckFzk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B972146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeLNMBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNMB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ADC2133F;
        Fri, 14 Dec 2018 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788886;
        bh=WpjLEwZmyU5pDSgLxclwf9bZotWqr0hYDwXNJkKmkZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/vbLg0Rf8Tv9VsDAGLJ4LQf/aGG4uafbISitId7n2RowTU16ZPIArd/iBBAFVxKZ
         fIxV+V9ZmKhc0cYS3WUtPmKDeZ2wjWVu1ExPjbCHbOUa3efOL05MSjX+xMuKyvnX2y
         zx1QsP3BJJdKqaGObcTvYzSED2d/FO/QWVls4nyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 011/142] Revert "net/ibm/emac: wrong bit is used for STA control"
Date:   Fri, 14 Dec 2018 12:58:16 +0100
Message-Id: <20181214115747.498608467@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit 5b3279e2cba2238b37f6c18adfdea8bddb32715a ]

This reverts commit 624ca9c33c8a853a4a589836e310d776620f4ab9.

This commit is completely bogus. The STACR register has two formats, old
and new, depending on the version of the IP block used. There's a pair of
device-tree properties that can be used to specify the format used:

	has-inverted-stacr-oc
	has-new-stacr-staopc

What this commit did was to change the bit definition used with the old
parts to match the new parts. This of course breaks the driver on all
the old ones.

Instead, the author should have set the appropriate properties in the
device-tree for the variant used on his board.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/emac/emac.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/emac/emac.h
+++ b/drivers/net/ethernet/ibm/emac/emac.h
@@ -231,7 +231,7 @@ struct emac_regs {
 #define EMAC_STACR_PHYE			0x00004000
 #define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
-#define EMAC_STACR_STAC_WRITE		0x00000800
+#define EMAC_STACR_STAC_WRITE		0x00002000
 #define EMAC_STACR_OPBC_MASK		0x00000C00
 #define EMAC_STACR_OPBC_50		0x00000000
 #define EMAC_STACR_OPBC_66		0x00000400


