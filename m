Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DFF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2g4QdF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DFF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeKCEDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbeKCEDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:54 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9687A2084C;
        Fri,  2 Nov 2018 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184938;
        bh=OH+/euWHkF5xo4Pbbv+3/Mwqf4Jx4xa16FnGp88MsDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2g4QdF/zWZ4YJprbLZRdpK1dNaT/zGjNSVDAPSaIAGfD8F2PXE3X+Q3ZcDF9w/Rl
         KZ/mAo78ibNgFUN0NuzpdZyxAWSX8e+JrmaZzVySnzwngkuZuhyw/2Ptj1kIseUCy+
         qIpY9L+G5Y1CaGp/wfjjQ89PMxO5yOXuI6LXHWeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jaime=20Caama=C3=B1o=20Ruiz?= <jcaamano@suse.com>,
        Greg Rose <gvrose8192@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 134/143] openvswitch: Fix push/pop ethernet validation
Date:   Fri,  2 Nov 2018 19:35:19 +0100
Message-Id: <20181102182908.485904133@linuxfoundation.org>
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

From: "Jaime Caamaño Ruiz" <jcaamano@suse.com>

[ Upstream commit 46ebe2834ba5b541f28ee72e556a3fed42c47570 ]

When there are both pop and push ethernet header actions among the
actions to be applied to a packet, an unexpected EINVAL (Invalid
argument) error is obtained. This is due to mac_proto not being reset
correctly when those actions are validated.

Reported-at:
https://mail.openvswitch.org/pipermail/ovs-discuss/2018-October/047554.html
Fixes: 91820da6ae85 ("openvswitch: add Ethernet push and pop actions")
Signed-off-by: Jaime CaamaÃ±o Ruiz <jcaamano@suse.com>
Tested-by: Greg Rose <gvrose8192@gmail.com>
Reviewed-by: Greg Rose <gvrose8192@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2622,7 +2622,7 @@ static int __ovs_nla_copy_actions(struct
 			 * is already present */
 			if (mac_proto != MAC_PROTO_NONE)
 				return -EINVAL;
-			mac_proto = MAC_PROTO_NONE;
+			mac_proto = MAC_PROTO_ETHERNET;
 			break;
 
 		case OVS_ACTION_ATTR_POP_ETH:
@@ -2630,7 +2630,7 @@ static int __ovs_nla_copy_actions(struct
 				return -EINVAL;
 			if (vlan_tci & htons(VLAN_TAG_PRESENT))
 				return -EINVAL;
-			mac_proto = MAC_PROTO_ETHERNET;
+			mac_proto = MAC_PROTO_NONE;
 			break;
 
 		default:


