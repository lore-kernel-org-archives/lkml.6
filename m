Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1176720837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8bKMz7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1176720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeKCD5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbeKCD5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:01 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2812082D;
        Fri,  2 Nov 2018 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184527;
        bh=hpbu7Qs1Xkx2YpmaaGTnP7Xl8Zdrc5kRSvjfhgqw2JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8bKMz7lencFOuVmItC5OSLjxoeECk7kHQW2ZH6Tkt6A7tMl5jG3J+FZ0qXKsL7Hw
         QGwUUj5GMGu0vUc/R97ee5FfKLY8pwgedfQh3p3+tJ3Ec6D+3aljDIUiso+WpIEP31
         VA5+eHgwexpV3Ecx5pimI7/MJMPl8KteGTTcXcOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/143] qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
Date:   Fri,  2 Nov 2018 19:33:33 +0100
Message-Id: <20181102182859.306312065@linuxfoundation.org>
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



