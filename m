Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20145C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D124001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0D124001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeGFMoc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:44:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbeGFMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:44:31 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MWbbG-1fczk43BtK-00Xehr; Fri, 06 Jul 2018 14:44:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Yotam Gigi <yotamg@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: fix br_vlan_get_{pvid,info} return values
Date:   Fri,  6 Jul 2018 14:44:02 +0200
Message-Id: <20180706124420.3129099-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:iPZOj7eBk6iL7Btc1sfOR1LSnfgsJ/nQpnfPN9od1SmpKOJk8Gn
 9N/XonlXWyie11O1q6DIWIUTjN40R5CHH+veDfTPG9idaZGDqDtfrRpscJahdZEOJe9tB7V
 IcHHHUEfiGIi/KUMP3Jfl7z4Prmp0Tv5pwBO3Q/59FaL5hqc2uBkeQXvrAhOES27n4T9Sff
 sODVjCWotioJB0vx03isA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kGFIZK7SvLA=:gu7gV06jJ3UquvfeuqhNOY
 HX9/V3TEmg7XlXeem+iFltw4BUPqPbUBTvXfaTMPQ8qLGN2rJxu7Aibhx1H76mohHx/vTG0Pf
 iykQfEkLGEmIagmCSlOk3aps7twVsQmkh8JTqHNJRxCrWmV3mLy9DrZ7mVyB3DRAtgz2us4bc
 9oVi4rZvJVQf4NsqYJkv+E1/YbYsa3hTzk7aESfc98qrFSMhNFZC1QnGTql1v9ktR0IqMRSMG
 dui+PIvhnmHlosfB6Fw2XGgdcDvm+ZIAcgxtus6pKKwy0enq7mblehKzcXVPHrIYIE66zIr0x
 LRtU2QR6Y8W05BF8g3wnw1YrDewp0vWG7qrS33YxVGFcrq9HlqOHsCMGQTDuh7m0uOdwgngJ/
 bFXFhMJB8DL9n1UT8XDpXS7pfYLl2zG0ypMNU/K9TJw8IKWrhdkHkoT17j6FBAW8fPBXZ/K2L
 hP4mii7oG/wxlB3ZiFO6V6TQqoxILnzM2u+6gsKtKm/rkFs1XvmI3Lwvkf/62wRaonWvvnd6G
 T/8rNr/v6h36goDWmpE+4vYbAU9aKNM3GdbJd8mTyPTdszxijlUHN4K/37uB12ltXSxw73rf8
 y+uECN7nwlJIi8omjc57zk58ZHXtTpplU+wV8eqF2EROOXsxo1Ypq9S1Pq9DlP6VDYCykcqR/
 FgGR2zNei+TkVUPNoS15Onr4LCxVk703Np+BU1sgRMiSZJQipIO/KkWn/k8ncioNR9P0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions return the regular -EINVAL failure in the normal
code path, but return a nonstandard '-1' error otherwise, which gets
interpreted as -EPERM.

Let's change it to -EINVAL for the dummy functions as well.

Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/if_bridge.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 7843b98e1c6e..c20c7e197d07 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -105,13 +105,13 @@ static inline bool br_vlan_enabled(const struct net_device *dev)
 
 static inline int br_vlan_get_pvid(const struct net_device *dev, u16 *p_pvid)
 {
-	return -1;
+	return -EINVAL;
 }
 
 static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 				   struct bridge_vlan_info *p_vinfo)
 {
-	return -1;
+	return -EINVAL;
 }
 #endif
 
-- 
2.9.0

