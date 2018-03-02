Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981337-2-2737757800539973710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981336; b=gMkzeTzYtb2YOvSZkQiUjVGJhjANLlr7z0ZebOMqX0NNasD
    tS5dR/8Z5J70328p5k7vUoQZ7Jx8IIzlzLnr+XUlMN0kIzy9SAb9dYxOytBS6WZh
    tqIc3879k2i6NWmgK+R4twbbPK1mtCX+0FT9foAuGXcK6Nfiqvm4vUkp7Xv299Cb
    faeXd0aGVVKuvMh6Sgl0vkTODLAQGx7adbxfXqJLNSYNZcCTAox2CbRyDOEGrfF0
    y1GYjgnKFLBXjHZpXegljaOEheDOhroNtZYoH21XYIXrqHX567FXamdYyFdg8+uG
    gAbrzpIotAuFIBZg8Yy6oOfZ9k9sFUeg3qcVh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981336; bh=6EwNuoWU8YJtWYfe4e8ErxWfCS
    aEsYnRQUyIzla7i+4=; b=VAa6UATHVj/h8TWfy6c6FrJJ/YjNH1UG+rCml0xmm2
    cIfNPz7rhuFsyRdRfHRoC49o7Qjq/1s/56SFnyz+KYDr98xMYHHGpHo2btIqdFuj
    DsF92qnjzerG1qwTDtcDCZrHINKpeTWK5699hcs1W/nXTsnwhKw5BYEDXNs/gy24
    VrFKuU3Mwq4kdEztwKSsU0x6pOvCUi2DtDpiD12HlvkV5JbIKbBdqaaRN8fyD5CH
    R8JqXU+4f2ybR5M5JsvIfg+IBCIukSMLJ3HY84ZPYAZMkXH/FwZyRWM9LbF3S2TG
    L1ae2foqAIbRh+qdw39qPgeX57H4wU3eEq5mZryRkXuw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424828AbeCBJCN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:02:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424496AbeCBJCK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:02:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 024/115] mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio_nl
Date: Fri,  2 Mar 2018 09:50:27 +0100
Message-Id: <20180302084504.851899499@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 162bd5e5fd921785077b5862d8f2ffabe2fe11e5 ]

The driver may sleep under a spinlock.
The function call path is:
hwsim_get_radio_nl (acquire the spinlock)
  nlmsg_new(GFP_KERNEL) --> may sleep

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3220,7 +3220,7 @@ static int hwsim_get_radio_nl(struct sk_
 		if (!net_eq(wiphy_net(data->hw->wiphy), genl_info_net(info)))
 			continue;
 
-		skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 		if (!skb) {
 			res = -ENOMEM;
 			goto out_err;
