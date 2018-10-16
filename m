Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4AFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C956920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+hWncMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C956920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeJPMWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbeJPMBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFB521471;
        Tue, 16 Oct 2018 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663176;
        bh=znFxxPAPWnj0xhgY05NVA/pLNqsRBifjZAOER+Xr1C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+hWncMVqXd4cn1cGCJ0dL0+yMIy0Nw+9sQ7n+8Oezug9WX/tzashGIiJWlFlX0xO
         cgYpaRmeGNgXGzTOFGY3uFpj4WaGfh1cpgGdxyfk/UNxy1YI0FrhO8jvMLCQ60d63U
         JMvq8bvQOUZF7tSWFPIczgaiZfmaAbdDllsOrOfE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 036/100] qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
Date:   Tue, 16 Oct 2018 00:11:17 -0400
Message-Id: <20181016041221.135528-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 77f2d753819b7d50c16abfb778caf1fe075faed0 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1713:25: warning: implicit
conversion from enumeration type 'enum tcp_ip_version' to different
enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
                cm_info->ip_version = TCP_IPV4;
                                    ~ ^~~~~~~~
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1733:25: warning: implicit
conversion from enumeration type 'enum tcp_ip_version' to different
enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
                cm_info->ip_version = TCP_IPV6;
                                    ~ ^~~~~~~~
2 warnings generated.

Use the appropriate values from the expected type, qed_tcp_ip_version:

TCP_IPV4 = QED_TCP_IPV4 = 0
TCP_IPV6 = QED_TCP_IPV6 = 1

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 90a2b53096e2..51bbb0e5b514 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1710,7 +1710,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
 		cm_info->local_ip[0] = ntohl(iph->daddr);
 		cm_info->remote_ip[0] = ntohl(iph->saddr);
-		cm_info->ip_version = TCP_IPV4;
+		cm_info->ip_version = QED_TCP_IPV4;
 
 		ip_hlen = (iph->ihl) * sizeof(u32);
 		*payload_len = ntohs(iph->tot_len) - ip_hlen;
@@ -1730,7 +1730,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 			cm_info->remote_ip[i] =
 			    ntohl(ip6h->saddr.in6_u.u6_addr32[i]);
 		}
-		cm_info->ip_version = TCP_IPV6;
+		cm_info->ip_version = QED_TCP_IPV6;
 
 		ip_hlen = sizeof(*ip6h);
 		*payload_len = ntohs(ip6h->payload_len);
-- 
2.17.1

