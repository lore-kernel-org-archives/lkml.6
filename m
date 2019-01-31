Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E19C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4892087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfAaMda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:33:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbfAaMd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:33:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82DC7AF6F;
        Thu, 31 Jan 2019 12:33:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3620DA78C; Thu, 31 Jan 2019 13:32:53 +0100 (CET)
Date:   Thu, 31 Jan 2019 13:32:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        jikos@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] tty: ipwireless: Fix potential NULL pointer
 dereference
Message-ID: <20190131123253.GC2900@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jiri Slaby <jslaby@suse.cz>,
        YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        jikos@kernel.org, linux-kernel@vger.kernel.org
References: <20190130103051.5256-1-yuehaibing@huawei.com>
 <3813e1a8-7a54-9df0-4464-c463d7fa0b63@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3813e1a8-7a54-9df0-4464-c463d7fa0b63@suse.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:58:30PM +0100, Jiri Slaby wrote:
> On 30. 01. 19, 11:30, YueHaibing wrote:
> > There is a potential NULL pointer dereference in case
> > alloc_ctrl_packet() fails and returns NULL.
> > 
> > Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > v2: fix return value
> > ---
> >  drivers/tty/ipwireless/hardware.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
> > index b0baa4c..1e21ae3 100644
> > --- a/drivers/tty/ipwireless/hardware.c
> > +++ b/drivers/tty/ipwireless/hardware.c
> > @@ -1516,6 +1516,8 @@ static void ipw_send_setup_packet(struct ipw_hardware *hw)
> >  			sizeof(struct ipw_setup_get_version_query_packet),
> >  			ADDR_SETUP_PROT, TL_PROTOCOLID_SETUP,
> >  			TL_SETUP_SIGNO_GET_VERSION_QRY);
> > +	if (!ver_packet)
> > +		return;
> 
> LGTM, the timer will retry 30 times, ticking every second.

This should be mentioned in the changelog though, it's not obvious at
all why just returning after a failure is ok and that the packet will be
resent.
