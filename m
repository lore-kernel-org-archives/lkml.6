Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98566C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6156621477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN6+mypf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6156621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJQBDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:41 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFA22147C;
        Tue, 16 Oct 2018 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709939;
        bh=Ef7ei2uh4fJ0+s3antgBEIL6+ceWDycr9FPiw6wYFFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN6+mypfS+cd/ujoV3vV7HpJcmEPo8ujMxPkX8/FDSHHyklDsg8v2KPvlRpCjmCEg
         JS3nmDCVuQ8lpLK5+4NO/8hLTMfgq88KEjVWj/A6Jus9JaBtKAlWSLVijMssZOhhAo
         mAvb7Sr9V5FbxtEyhYKNcwoCn/iQlGVPwghRIMxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gerhard Wiesinger <lists@wiesinger.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 049/135] net: dsa: b53: Keep CPU port as tagged in all VLANs
Date:   Tue, 16 Oct 2018 19:04:39 +0200
Message-Id: <20181016170518.068876258@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1107,7 +1107,7 @@ void b53_vlan_add(struct dsa_switch *ds,
 		b53_get_vlan_entry(dev, vid, vl);
 
 		vl->members |= BIT(port);
-		if (untagged)
+		if (untagged && !dsa_is_cpu_port(ds, port))
 			vl->untag |= BIT(port);
 		else
 			vl->untag &= ~BIT(port);
@@ -1149,7 +1149,7 @@ int b53_vlan_del(struct dsa_switch *ds,
 				pvid = 0;
 		}
 
-		if (untagged)
+		if (untagged && !dsa_is_cpu_port(ds, port))
 			vl->untag &= ~(BIT(port));
 
 		b53_set_vlan_entry(dev, vid, vl);


