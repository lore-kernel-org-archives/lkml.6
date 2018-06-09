Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ytGoJej3G1vVBwAAmS7hNA
	; Sat, 09 Jun 2018 15:54:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A938608B8; Sat,  9 Jun 2018 15:54:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaxfYfKJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B73D9606FA;
	Sat,  9 Jun 2018 15:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B73D9606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeFIPyP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753402AbeFIPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:30:54 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A07204EC;
        Sat,  9 Jun 2018 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558253;
        bh=dGcPriKt0Ob0k+UsH7JyxzDDjj76UupHkZUtTh5kXSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaxfYfKJeNl6XrVcpL95UW641BGg+U16OdeWY4ODuGif4lSdJYUxlbuJudqCl4PVo
         CmD18PDYvsdy89UGzbP3n/R/eStKIGNDBvaTBM8zEmIemqwQOoUAscLwwHbaUsX+EB
         UMMZH6xvOyTdUBgTSkx2y2rdOjmLBcdCiRUS1QFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 11/15] team: use netdev_features_t instead of u32
Date: Sat,  9 Jun 2018 17:29:46 +0200
Message-Id: <20180609150001.319224838@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 25ea66544bfd1d9df1b7e1502f8717e85fa1e6e6 ]

This code was introduced in 2011 around the same time that we made
netdev_features_t a u64 type.  These days a u32 is not big enough to
hold all the potential features.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1004,7 +1004,8 @@ static void team_port_disable(struct tea
 static void __team_compute_features(struct team *team)
 {
 	struct team_port *port;
-	u32 vlan_features = TEAM_VLAN_FEATURES & NETIF_F_ALL_FOR_ALL;
+	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
+					  NETIF_F_ALL_FOR_ALL;
 	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
 	unsigned short max_hard_header_len = ETH_HLEN;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
