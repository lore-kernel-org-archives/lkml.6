Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98C6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D320833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67D320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeGTP21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:28:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbeGTP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:28:27 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 10725E4A;
        Fri, 20 Jul 2018 14:39:50 +0000 (UTC)
Date:   Fri, 20 Jul 2018 16:39:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS
 APDO selection
Message-ID: <20180720143948.GA15680@kroah.com>
References: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
 <20180720135903.GB460@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337019830B6AA@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337019830B6AA@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:16:33PM +0000, Adam Thomson wrote:
> On 20 July 2018 14:59, Greg Kroah-Hartman wrote:
> 
> > On Tue, Jul 17, 2018 at 03:36:19PM +0100, Adam Thomson wrote:
> > > There is a bug in the sink PDO search code when trying to select
> > > a PPS APDO. The current code actually sets the starting index for
> > > searching to whatever value 'i' is, rather than choosing index 1
> > > to avoid the first PDO (always 5V fixed). As a result, for sources
> > > which support PPS but whose PPS APDO index does not match with the
> > > supporting sink PPS APDO index for the platform, no valid PPS APDO
> > > will be found so this feature will not be permitted.
> > >
> > > Sadly in testing, both Source and Sink capabilities matched up and
> > > this was missed. Code is now updated to correctly set the start
> > > index to 1, and testing with additional PPS capable sources show
> > > this to work as expected.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > ---
> > >  drivers/usb/typec/tcpm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > > index 74e0cda..4f1f421 100644
> > > --- a/drivers/usb/typec/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm.c
> > > @@ -2238,7 +2238,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> > tcpm_port *port)
> > >  			 * PPS APDO. Again skip the first sink PDO as this will
> > >  			 * always be 5V 3A.
> > >  			 */
> > > -			for (j = i; j < port->nr_snk_pdo; j++) {
> > > +			for (j = 1; j < port->nr_snk_pdo; j++) {
> > >  				pdo = port->snk_pdo[j];
> > >
> > >  				switch (pdo_type(pdo)) {
> > 
> > What commit id does this "fix"?
> > 
> > Does it need to go into 4.18-final?  To the stable kernels?
> 
> Sorry, missed that info. This fixes commit:
> 
> 2eadc33f40d4c59dd0649f8b6958872d85ad05d7
> 'typec: tcpm: Add core support for sink side PPS'
> 
> This patch only went into v4.18-rc1 so should only be targeted for v4.18-final.
> 
> Do you want me to resend with this information added?

It's ok, this time, I'll go hand-edit it...

greg k-h
