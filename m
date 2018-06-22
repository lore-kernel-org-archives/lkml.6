Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71030C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F0246C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193F0246C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeFVR2z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:28:55 -0400
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:54124 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932752AbeFVR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:28:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 52F831811F04B;
        Fri, 22 Jun 2018 17:28:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg12_4cb736c2b4754
X-Filterd-Recvd-Size: 4329
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jun 2018 17:28:47 +0000 (UTC)
Message-ID: <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if
 condition
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <michael.straube@posteo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 10:28:45 -0700
In-Reply-To: <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
References: <20180621182230.27823-1-michael.straube@posteo.de>
         <20180622104007.ob5nt2rip2fu436h@mwanda>
         <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
         <20180622105719.pt3lh6fqi2nziqsz@mwanda>
         <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 14:48 +0200, Michael Straube wrote:
> On 06/22/18 12:57, Dan Carpenter wrote:
> > On Fri, Jun 22, 2018 at 03:54:22AM -0700, Joe Perches wrote:
> > > On Fri, 2018-06-22 at 13:40 +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
> > > > > Fix checkpatch error 'do not use assignment in if condition'.
> > > []
> > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > > > index e55895632921..87a4ced41028 100644
> > > > > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > > > +++ b/
> > > > > @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
> > > > >   	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> > > > >   	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
> > > > >   	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
> > > 
> > > Should also use is_broadcast_ether_addr and is_zero_ether_addr
> > > 
> > > > > -		if (np &&
> > > > > -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
> > > > > -		    len == ETH_ALEN) {
> > > > > +		addr = of_get_property(np, "local-mac-address", &len);
> > > > > +		if (np && addr && len == ETH_ALEN) {
> > > > 
> > > > You can remove the "np" check.
> > > > 
> > > > 		if (addr && len == ETH_ALEN) {
> > > 
> > > It looks more like the rewrite is incorrect
> > > as np is tested before of_get_property
> > > 
> > 
> > That's what I was worried about too, but if "np" is NULL then
> > of_get_property() just returns NULL so it's fine.
> 
> So it should be this?
> 
>          if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
>               (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>              ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
>               (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00)) &&
>              (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))) {

No as the mac[] tests are the same as is_<foo>_ether_addr
and there's nothing really objectionable about embedding
the assignment in the if here.

Output from checkpatch is not gospel and can be ignored
whenever appropriate.

I think the below is ok:

	if ((is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) &&
	    ((addr = of_get_property(np, "local-mac-address", &len)) &&
	     len == ETH_ALEN))
		memcpy(mac_addr, addr, ETH_ALEN);
	else
		memcpy(mac_addr, ""\x00\xe0\x4c\x87\x00\x00", ETH_ALEN);

Although the last memcpy of a fixed mac address could
probably use eth_random_addr to reduce the likelihood
of mac address collision so maybe

	if ((is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) &&
	    ((addr = of_get_property(np, "local-mac-address", &len)) &&
	
     len == ETH_ALEN))
		memcpy(mac_addr, addr, ETH_ALEN);
	else
		eth_random_addr(mac_addr);

> If yes, I'm not sure how to proceed as these are the very first patches I send.
> Should I send a v2 patch with both changes or just a v2 with "np" removed and
> another one for adding 'is_broadcast_ether_addr' and 'is_zero_ether_addr' checks?

I'd send 1 patch.

