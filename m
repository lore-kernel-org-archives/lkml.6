Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F2321476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfWQ6kp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F2321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeJPMCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbeJPMCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B192147E;
        Tue, 16 Oct 2018 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663272;
        bh=buJQPBx11UhCMdrkhHFQFdG/wh0umJV3sgcpzFZ2cUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfWQ6kp85Mynnl34IviWPuPkaWMbDQ7Kz4a/HtXhwIUcAtDEHE4J9wYirYmxmp5q+
         7zvZvwMNrSAImamK6yVa6LxdYwrBBOPR8ha1F3Jf6LC8ZML/XB2HHc/UUiOuyb9S+x
         WJiHgo78A8UDKTzCxJ/H+mrSVSGAAcRgTxIMVHyM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 31/61] qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
Date:   Tue, 16 Oct 2018 00:13:33 -0400
Message-Id: <20181016041403.135678-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
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
index e41f28602535..eb666877d1aa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1672,7 +1672,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
 		cm_info->local_ip[0] = ntohl(iph->daddr);
 		cm_info->remote_ip[0] = ntohl(iph->saddr);
-		cm_info->ip_version = TCP_IPV4;
+		cm_info->ip_version = QED_TCP_IPV4;
 
 		ip_hlen = (iph->ihl) * sizeof(u32);
 		*payload_len = ntohs(iph->tot_len) - ip_hlen;
@@ -1692,7 +1692,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 			cm_info->remote_ip[i] =
 			    ntohl(ip6h->saddr.in6_u.u6_addr32[i]);
 		}
-		cm_info->ip_version = TCP_IPV6;
+		cm_info->ip_version = QED_TCP_IPV6;
 
 		ip_hlen = sizeof(*ip6h);
 		*payload_len = ntohs(ip6h->payload_len);
-- 
2.17.1

