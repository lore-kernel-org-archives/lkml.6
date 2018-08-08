Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF55C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAA721AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAA721AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeHIAgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:36:03 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:32814 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727337AbeHIAgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:36:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9988C100E86C3;
        Wed,  8 Aug 2018 22:14:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap60_4329dbe4b9a58
X-Filterd-Recvd-Size: 2166
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Aug 2018 22:14:21 +0000 (UTC)
Message-ID: <cb7de144fb0b6796dc5fc6013120fc95c8e564a9.camel@perches.com>
Subject: Re: [PATCH v2 01/15] staging:rtl8192u: Remove macro eqMacAddr -
 Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Wed, 08 Aug 2018 15:14:19 -0700
In-Reply-To: <20180808210036.22580-2-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
         <20180808210036.22580-2-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 22:00 +0100, John Whitmore wrote:
> The macro eqMacAddr implements the same functionality as the
> ether_addr_equal function defined in etherdevice.h, as a result the
> macro has been removed from the code, and its use replaced with the
> function call.
[]
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
[]
> @@ -4460,15 +4460,15 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
>  
>  	/* Check if the received packet is acceptable. */
>  	bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
> -			       (eqMacAddr(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
> +			       (ether_addr_equal(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
>  			       && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
>  	bpacket_toself =  bpacket_match_bssid &
> -			  (eqMacAddr(praddr, priv->ieee80211->dev->dev_addr));
> +			  (ether_addr_equal(praddr, priv->ieee80211->dev->dev_addr));

Likely this should be

	bpacket_match_bssid = bpacket_match_bss &&

as boolean use with a bitwise & is odd.

