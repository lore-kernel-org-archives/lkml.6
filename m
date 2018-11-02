Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D96C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0E20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDnW6g2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A0E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeKCDsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeKCDsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:51 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB5320840;
        Fri,  2 Nov 2018 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184039;
        bh=HZCQ/2+GextAS7M6Bb1kLZbirzYs/D9qIQwzNq/LTe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDnW6g2rYa8c9JPtD0fWVSAoj2b0eoUYlxVigC9KWpbqmdJslZeRJbymAbbsxy2iz
         nI0kzKlSJaaBvN+78b4cRkZ+/D3as6aDsJ1ORslllmyEJtuqPG3etsTe3JXmAKWs3b
         icKTKOQ+LPA96P5f+3xbktxrXNCk0sm6aG1jWAOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 030/150] qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
Date:   Fri,  2 Nov 2018 19:33:12 +0100
Message-Id: <20181102182905.440405340@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

[ Upstream commit db803f36e56f23b5a2266807e190d1dc11554d54 ]

Clang complains when one enumerated type is implicitly converted to
another.

drivers/net/ethernet/qlogic/qed/qed_vf.c:686:6: warning: implicit
conversion from enumeration type 'enum qed_tunn_mode' to different
enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
                                 QED_MODE_L2GENEVE_TUNN,
                                 ^~~~~~~~~~~~~~~~~~~~~~

Update mask's parameter to expect qed_tunn_mode, which is what was
intended.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index be6ddde1a104..ac3f54bbe9b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -572,7 +572,7 @@ free_p_iov:
 static void
 __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			   struct qed_tunn_update_type *p_src,
-			   enum qed_tunn_clss mask, u8 *p_cls)
+			   enum qed_tunn_mode mask, u8 *p_cls)
 {
 	if (p_src->b_update_mode) {
 		p_req->tun_mode_update_mask |= BIT(mask);
@@ -587,7 +587,7 @@ __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 static void
 qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			 struct qed_tunn_update_type *p_src,
-			 enum qed_tunn_clss mask,
+			 enum qed_tunn_mode mask,
 			 u8 *p_cls, struct qed_tunn_update_udp_port *p_port,
 			 u8 *p_update_port, u16 *p_udp_port)
 {
-- 
2.17.1



