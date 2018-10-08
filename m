Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB976C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A558B2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbL4LmG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A558B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeJICCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2CA204FD;
        Mon,  8 Oct 2018 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024586;
        bh=YzCbdlM4Yo60Qll6wnJl9mha16RDeW9NZozhV0vmLzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbL4LmG6Ri4kwqeL8EQ4DCjqX/4xxp3L/osF8anjTc30JzV63Ul5FHqETpXYFu63p
         mrHNd5hWWRgC1UTmWVctgT2a8MrgyqzMt3jk+Xyad64K7mSJciXWYBTp12G5s68+uE
         nzF5Jc8vaUN727WEyJ1ZzdOyqlT7brFHIUKbPwoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Mikhaylov <ivan@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 065/168] net/ibm/emac: wrong emac_calc_base call was used by typo
Date:   Mon,  8 Oct 2018 20:30:45 +0200
Message-Id: <20181008175622.519674208@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Ivan Mikhaylov <ivan@de.ibm.com>

[ Upstream commit bf68066fccb10fce6bbffdda24ee2ae314c9c5b2 ]

__emac_calc_base_mr1 was used instead of __emac4_calc_base_mr1
by copy-paste mistake for emac4syn.

Fixes: 45d6e545505fd32edb812f085be7de45b6a5c0af ("net/ibm/emac: add 8192 rx/tx fifo size")
Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/emac/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -494,9 +494,6 @@ static u32 __emac_calc_base_mr1(struct e
 	case 16384:
 		ret |= EMAC_MR1_RFS_16K;
 		break;
-	case 8192:
-		ret |= EMAC4_MR1_RFS_8K;
-		break;
 	case 4096:
 		ret |= EMAC_MR1_RFS_4K;
 		break;
@@ -537,6 +534,9 @@ static u32 __emac4_calc_base_mr1(struct
 	case 16384:
 		ret |= EMAC4_MR1_RFS_16K;
 		break;
+	case 8192:
+		ret |= EMAC4_MR1_RFS_8K;
+		break;
 	case 4096:
 		ret |= EMAC4_MR1_RFS_4K;
 		break;


