Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900EF21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198155;
	bh=jFHWkWRw26p02TRN15v96mLRgiaZCiVc7qw9ncNPpZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKCfqm1BDQEKFYlRhVnO1Wa55j/k2D86HKy4+IMxZPpBFtVLNMLlOd/XyxSBLYcBI
	 OLjZPhkDSpFjnPKTk4sjjUADmXEJFUSRyEZryFAqxJwVjX6oFY58/Rfn2db+yUsaeM
	 Y49Ils2Pint4PSUqCSQSP6ICgmFv4tiqrp2FHXA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfBOCLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731997AbfBOCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1545222A1;
        Fri, 15 Feb 2019 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196658;
        bh=jFHWkWRw26p02TRN15v96mLRgiaZCiVc7qw9ncNPpZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1AMY7SNpDXWFv50h2lBFirw240QwYB8QCGEy6RL/cV/eh1P8G6UiwDnvrL5gGJD6N
         u4mZANeW3qe2k1YRBD3qtj/mRrkKHOSxYmcQQhzR2bzA1vCHylIFgz115IqdtakEbz
         6wO09K+f07JrlYAiOQVWbWRdSV58tN+sGD/17EDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 68/77] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
Date:   Thu, 14 Feb 2019 21:08:46 -0500
Message-Id: <20190215020855.176727-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit 3b707c3008cad04604c1f50e39f456621821c414 ]

__bpf_redirect() and act_mirred checks this boolean
to determine whether to prefix an ethernet header.

Signed-off-by: Maciej Żenczykowski <maze@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 6756fea18b69..e44746de95cd 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -54,6 +54,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_IPGRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
+	case ARPHRD_RAWIP:
 		return false;
 	default:
 		return true;
-- 
2.19.1

