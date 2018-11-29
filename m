Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3FFC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1BD21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQOPwjew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1BD21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeK3B2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbeK3B2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3430205C9;
        Thu, 29 Nov 2018 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501397;
        bh=hjDqvIfRX4zdxAq2r36kcOloYpYNZk4fezaQ2vqjPJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQOPwjewsBahxycT+5UGVllPp9rIaApcbE4RQJ8eYVNwLIGk0Ra9SWUyDJ05781wm
         VL+PrUdWyOmza2vQTgFDHIfDCnpD4m4fe6DLXanvMnB5N+FvZzp3mHMJK8dUDrWe5D
         3Uv6xf20YjNQGkbY8AIvxBlLqM8TObS2RBrVrun0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karthik D A <karthida@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 74/92] mwifiex: fix p2p device doesnt find in scan problem
Date:   Thu, 29 Nov 2018 15:12:43 +0100
Message-Id: <20181129140112.396794586@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karthik D A <karthida@marvell.com>

commit 3d8bd85c2c9e47ed2c82348aa5b6029ed48376ae upstream.

Marvell p2p device disappears from the list of p2p peers on the other
p2p device after disconnection.

It happens due to a bug in driver. When interface is changed from p2p
to station, certain variables(bss_type, bss_role etc.) aren't correctly
updated. This patch corrects them to fix the issue.

Signed-off-by: Karthik D A <karthida@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1209,6 +1209,12 @@ mwifiex_cfg80211_change_virtual_intf(str
 			priv->adapter->curr_iface_comb.p2p_intf--;
 			priv->adapter->curr_iface_comb.sta_intf++;
 			dev->ieee80211_ptr->iftype = type;
+			if (mwifiex_deinit_priv_params(priv))
+				return -1;
+			if (mwifiex_init_new_priv_params(priv, dev, type))
+				return -1;
+			if (mwifiex_sta_init_cmd(priv, false, false))
+				return -1;
 			break;
 		case NL80211_IFTYPE_ADHOC:
 			if (mwifiex_cfg80211_deinit_p2p(priv))


