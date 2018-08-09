Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC5921EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC5921EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeHITjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:39:19 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:59856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730634AbeHITjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:39:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 79CD937E7;
        Thu,  9 Aug 2018 17:13:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: geese10_75cccaa04bb14
X-Filterd-Recvd-Size: 1662
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 Aug 2018 17:13:29 +0000 (UTC)
Message-ID: <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Aug 2018 10:13:28 -0700
In-Reply-To: <20180809170131.29279-3-straube.linux@gmail.com>
References: <20180809170131.29279-1-straube.linux@gmail.com>
         <20180809170131.29279-3-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 19:01 +0200, Michael Straube wrote:
> Use is_multicast_ether_addr instead of custom IS_MCAST in
> core/rtw_xmit.c.

Have you verified that all accesses are __aligned(2) ?

If so, please state that in the patch description.

> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
[]
> @@ -460,10 +460,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>  	if ((pattrib->ether_type == ETH_P_ARP) || (pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
>  		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
>  
> -	bmcast = IS_MCAST(pattrib->ra);
> +	mcast = is_multicast_ether_addr(pattrib->ra);

i.e.:  is pattrib->ra __aligned(2) ?

etc...

