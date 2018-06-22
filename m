Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51862C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F724099
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081F724099
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFVKy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:54:27 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:45106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751301AbeFVKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:54:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5DF47100E86CF;
        Fri, 22 Jun 2018 10:54:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: songs07_7dc0c4614fd59
X-Filterd-Recvd-Size: 2471
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jun 2018 10:54:24 +0000 (UTC)
Message-ID: <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if
 condition
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <michael.straube@posteo.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 03:54:22 -0700
In-Reply-To: <20180622104007.ob5nt2rip2fu436h@mwanda>
References: <20180621182230.27823-1-michael.straube@posteo.de>
         <20180622104007.ob5nt2rip2fu436h@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 13:40 +0300, Dan Carpenter wrote:
> On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
> > Fix checkpatch error 'do not use assignment in if condition'.
[]
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > index e55895632921..87a4ced41028 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > +++ b/ 
> > @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
> >  	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> >  	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
> >  	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {

Should also use is_broadcast_ether_addr and is_zero_ether_addr

> > -		if (np &&
> > -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
> > -		    len == ETH_ALEN) {
> > +		addr = of_get_property(np, "local-mac-address", &len);
> > +		if (np && addr && len == ETH_ALEN) {
> 
> You can remove the "np" check.
> 
> 		if (addr && len == ETH_ALEN) {

It looks more like the rewrite is incorrect
as np is tested before of_get_property

It could be written something like:

	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
		bool assigned = false;

		if (np) {
			addr = of_get_property(np, "local-mac-address", &len);
			if (len == ETH_ALEN) {
				memcpy(mac_addr, addr, ETH_ALEN);
				assigned = true;
			}
		}
		if (!assigned) {
			mac_addr[0] = 0x00;
			mac_addr[1] = ...
		}
	}
