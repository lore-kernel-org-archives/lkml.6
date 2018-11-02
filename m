Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3739C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604220840
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9uVat5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeKCD4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCD4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D7E2082D;
        Fri,  2 Nov 2018 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184467;
        bh=msCWdqE7ZYR/w6KjTuEPKGivu2WllCr+jTh+JUUWZi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9uVat5v2OgMaOBNVGOxqc8ZQwX8TSWgqaPz2EUyIoApdvnJSxxfg0vo4d12qBgq5
         RsGpbQcO3fCFpjxWLKZD18TcANgTkHoOU7ohgFymUAZPxPDxMA7FCo4it7EW2hXCF3
         U7UVUQ5L3kAl1Vm6rT8+CzhOIgCuKQbGcBJQSNOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 004/143] xfrm: reset crypto_done when iterating over multiple input xfrms
Date:   Fri,  2 Nov 2018 19:33:09 +0100
Message-Id: <20181102182857.439558411@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 782710e333a526780d65918d669cb96646983ba2 ]

We only support one offloaded xfrm (we do not have devices that
can handle more than one offload), so reset crypto_done in
xfrm_input() when iterating over multiple transforms in xfrm_input,
so that we can invoke the appropriate x->type->input for the
non-offloaded transforms

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 9f492dc417d5..8e75319dd9c0 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -453,6 +453,7 @@ resume:
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 			goto drop;
 		}
+		crypto_done = false;
 	} while (!err);
 
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-- 
2.17.1



