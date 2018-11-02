Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651C820833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwS0dCfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651C820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeKCDr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeKCDr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF352082E;
        Fri,  2 Nov 2018 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183955;
        bh=RPEpBJ0qIElvSRdMgREDFVkNqnku9DQH+L7SYAfnGRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwS0dCfplEI0eZ92sppyrOiIiEd89EmWdluIDKdVIuqzpdDTEm2EZEaArR6etjp1b
         y5y0d18PSKFjo8fx0y2kX/NOhtJQ7iyQ+VJhSewg8tlu4Gig/RaOVuv9SCY3dbNys6
         BGipTd69TLnS7ZyFWkuVHgRtYFy8eS6aM5bSDF4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 033/150] qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
Date:   Fri,  2 Nov 2018 19:33:15 +0100
Message-Id: <20181102182905.639291405@linuxfoundation.org>
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



