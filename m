Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCFCC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ECC2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762536;
	bh=i+5AeL2JWsA7yI9KX1yTt6BjWcFs/KbbXb5giWCslmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVbedHr1HSGygtc5KIGOkVsqhVJAwrRGsZnuXzUzzi4umnt81Wsna1r1pFK2ZDvm+
	 qK35FjhFc5JfDptaGw7V+MQVsIe3G0LP3PO6vlH+PRv8VAap5AJdJWRqxMePcUoYas
	 w7YC4p7Vj3ZdUltRgx+GOizYSH+xq+4otDzbk+Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfA2Lsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbfA2Lsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6528320882;
        Tue, 29 Jan 2019 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762530;
        bh=i+5AeL2JWsA7yI9KX1yTt6BjWcFs/KbbXb5giWCslmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOz2BWMDRlLGozwrz0cYpqDMB3nBkTT0LZhfky8FEwO2zie7sRjs211kdIk+Z2z0i
         SEzoK/waGm8yw4yXDpcu5Epy519MNdlLRheOCgLb6CluX2dcH0tJEpLpQ8/g4kBoGn
         oc45wCNUQk8IdrcJKxP+FU2mMNDBLVyobCu0vnOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/68] openvswitch: Avoid OOB read when parsing flow nlattrs
Date:   Tue, 29 Jan 2019 12:35:28 +0100
Message-Id: <20190129113132.204417179@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 04a4af334b971814eedf4e4a413343ad3287d9a9 ]

For nested and variable attributes, the expected length of an attribute
is not known and marked by a negative number.  This results in an OOB
read when the expected length is later used to check if the attribute is
all zeros. Fix this by using the actual length of the attribute rather
than the expected length.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -459,7 +459,7 @@ static int __parse_flow_nlattrs(const st
 			return -EINVAL;
 		}
 
-		if (!nz || !is_all_zero(nla_data(nla), expected_len)) {
+		if (!nz || !is_all_zero(nla_data(nla), nla_len(nla))) {
 			attrs |= 1 << type;
 			a[type] = nla;
 		}


