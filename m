Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86B208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhacfzcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D86B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeJPMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbeJPMCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A830421471;
        Tue, 16 Oct 2018 04:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663267;
        bh=M9xUZhxDexF0CDnPJy7/0FdaQJS94+KXt9hVL0s3O00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhacfzcmVPmCBrLRnRhLdcfL9gUP9OimBFYk9VGUQLfrPsP8iIaPQw/0ygfmG9tsf
         t5dnRAKkyPgXm6cY2vZ4oD9PZMDmsrCyB4+YYrBGlT43xnIKYeEqoU8BL5WAyAP7DH
         Onc6UWGa7VJHiVB2ry7uQ7ayrAo71t1w0hBrqyDs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 25/61] qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
Date:   Tue, 16 Oct 2018 00:13:27 -0400
Message-Id: <20181016041403.135678-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
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

