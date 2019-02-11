Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD05217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897641;
	bh=BoYquLxXaCuXZyUpL3VTtT5ofVgGeDlgiXxkMd0fnjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDTLn4ZbKqUhDd5E6s849YXj92qRoCzQz17tZvc8IKoott7LPfIlosBwXe2w1I8Kt
	 XxLPH+pe2EJj9BH0N6+Lgv/iZLjcJRH0mUTdzajlIczPucnOilS9HFAmPD+Mp/Tokb
	 uU7qjSKljp5d1PtZtGn+NsEWFgi6DQYNydm9ed24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbfBKPHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403784AbfBKPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F86222AD;
        Mon, 11 Feb 2019 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897632;
        bh=BoYquLxXaCuXZyUpL3VTtT5ofVgGeDlgiXxkMd0fnjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4mCq65Y8Aoj8CAELqJkNSRgfe2bk6e+gHFyYw9M3gFOAcuhDvz4YwuZzI1/T0EZ6
         Tk5itNpiHNCMyAxZmiKRi2WyT+Y05Ry/IPwaZxYlynOWoTi1X7ewdN+K8xIiXQ8isu
         tNSkPv44COSbNGFAEDA6R+RfdCWFWjwo8LVH4J1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 063/137] xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi
Date:   Mon, 11 Feb 2019 15:19:04 +0100
Message-Id: <20190211141817.807723865@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fa89a4593b927b3f59c3b69379f31d3b22272e4e ]

gcc warn this:

net/ipv6/xfrm6_tunnel.c:143 __xfrm6_tunnel_alloc_spi() warn:
 always true condition '(spi <= 4294967295) => (0-u32max <= u32max)'

'spi' is u32, which always not greater than XFRM6_TUNNEL_SPI_MAX
because of wrap around. So the second forloop will never reach.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index e1c0bbe7996c..3a2701d42f47 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -144,6 +144,9 @@ static u32 __xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
 		index = __xfrm6_tunnel_spi_check(net, spi);
 		if (index >= 0)
 			goto alloc_spi;
+
+		if (spi == XFRM6_TUNNEL_SPI_MAX)
+			break;
 	}
 	for (spi = XFRM6_TUNNEL_SPI_MIN; spi < xfrm6_tn->spi; spi++) {
 		index = __xfrm6_tunnel_spi_check(net, spi);
-- 
2.19.1



