Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyswaXFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJPMWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbeJPMBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251DF208E4;
        Tue, 16 Oct 2018 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663171;
        bh=3VVWvhvfOr3OYjuHV3W6sYJenuV2BT/iBczLXP1gy7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyswaXFY6jCcBlfRDQek7HFRkeR77KIysBuRHnKCUVBSXREAqRe3Xbme6nQXAd1pr
         HWgR6vzkMFsvq7j1OEDm5bGho9H00EOFDB7CFKRusICbqu9sFgxNYDzuZMk5kmRzhd
         YBXkwbUfu2JkXEaQ4l9l3UmSDDP+f0TTSe/vIL70=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 030/100] qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
Date:   Tue, 16 Oct 2018 00:11:11 -0400
Message-Id: <20181016041221.135528-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

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
index 8de644b4721e..77b6248ad3b9 100644
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

