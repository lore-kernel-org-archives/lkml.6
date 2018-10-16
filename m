Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsymsbce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A15920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeJPMRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeJPMCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1417B2147C;
        Tue, 16 Oct 2018 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663225;
        bh=4YB1G998KDYMamC4PoG5Fhg0GCz85RJKEf8icvu4dJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsymsbcepGwO0PqNCDhl+Xws1c/tNlUXUy953WBh0snZUtl08Ph7XJdWth059kgJE
         PJWxGchsKTsXAmNJYcZueWRFpm9kt9Kt7Z230U1Mn0QJYulty52P/RCe0En0c129JU
         fFAIBezSDWOx6TyLeg9suTXegb5X9+tQhdsKoDLo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 088/100] net: dsa: b53: Keep CPU port as tagged in all VLANs
Date:   Tue, 16 Oct 2018 00:12:09 -0400
Message-Id: <20181016041221.135528-88-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit ca8931948344c485569b04821d1f6bcebccd376b ]

Commit c499696e7901 ("net: dsa: b53: Stop using dev->cpu_port
incorrectly") was a bit too trigger happy in removing the CPU port from
the VLAN membership because we rely on DSA to program the CPU port VLAN,
which it does, except it does not bother itself with tagged/untagged and
just usese untagged.

Having the CPU port "follow" the user ports tagged/untagged is not great
and does not allow for properly differentiating, so keep the CPU port
tagged in all VLANs.

Reported-by: Gerhard Wiesinger <lists@wiesinger.com>
Fixes: c499696e7901 ("net: dsa: b53: Stop using dev->cpu_port incorrectly")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d93c790bfbe8..ad534b90ef21 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1107,7 +1107,7 @@ void b53_vlan_add(struct dsa_switch *ds, int port,
 		b53_get_vlan_entry(dev, vid, vl);
 
 		vl->members |= BIT(port);
-		if (untagged)
+		if (untagged && !dsa_is_cpu_port(ds, port))
 			vl->untag |= BIT(port);
 		else
 			vl->untag &= ~BIT(port);
@@ -1149,7 +1149,7 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 				pvid = 0;
 		}
 
-		if (untagged)
+		if (untagged && !dsa_is_cpu_port(ds, port))
 			vl->untag &= ~(BIT(port));
 
 		b53_set_vlan_entry(dev, vid, vl);
-- 
2.17.1

