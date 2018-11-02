Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12214C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863920847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjofC504"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863920847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeKCD4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbeKCD4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9000520847;
        Fri,  2 Nov 2018 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184505;
        bh=WqfXxv1YdzjirqatRzcnOl2Clv3zySITnFODakSQpQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjofC504ONtXQVRz3ib6s2r710c4IE023g0srZ+34W9I4HIp/Sjt1Qq7i+HoWXCnK
         0r9HnNfJCp3FijRWggbtoXIl1Jnnv23baa0tfq9I6611qIgc6T+kzfi0pO2Phae+cS
         9Gg9vIL+lzjudLbzu3y9emfB87kO3oZJX23STRTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/143] qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
Date:   Fri,  2 Nov 2018 19:33:29 +0100
Message-Id: <20181102182858.990575407@linuxfoundation.org>
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

[ Upstream commit a898fba32229efd5e6b6154f83fa86a7145156b9 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:163:25: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->vxlan.tun_cls = type;
                             ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:165:26: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->l2_gre.tun_cls = type;
                              ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:167:26: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->ip_gre.tun_cls = type;
                              ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:169:29: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->l2_geneve.tun_cls = type;
                                 ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:171:29: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->ip_geneve.tun_cls = type;
                                 ~ ^~~~
5 warnings generated.

Avoid this by changing type to an int.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index 46d0c3cb83a5..d7c5965328be 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -154,7 +154,7 @@ qed_set_pf_update_tunn_mode(struct qed_tunnel_info *p_tun,
 static void qed_set_tunn_cls_info(struct qed_tunnel_info *p_tun,
 				  struct qed_tunnel_info *p_src)
 {
-	enum tunnel_clss type;
+	int type;
 
 	p_tun->b_update_rx_cls = p_src->b_update_rx_cls;
 	p_tun->b_update_tx_cls = p_src->b_update_tx_cls;
-- 
2.17.1



