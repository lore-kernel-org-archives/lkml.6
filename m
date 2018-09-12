Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E8EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5512520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5512520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeILLcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:32:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeILLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:32:09 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9186C96;
        Wed, 12 Sep 2018 06:29:07 +0000 (UTC)
Date:   Wed, 12 Sep 2018 08:29:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pheragu@codeaurora.org
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v2 2/2] Embedded USB Debugger (EUD) driver
Message-ID: <20180912062905.GD10268@kroah.com>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
 <1536096853-30473-3-git-send-email-pheragu@codeaurora.org>
 <c68c466a-576f-43d9-a7dd-7ee8e0ebba3f@codeaurora.org>
 <20180905111800.GA30003@kroah.com>
 <aade97184ee5027ac6e32fd742cfbc5a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aade97184ee5027ac6e32fd742cfbc5a@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:40:19PM -0700, pheragu@codeaurora.org wrote:
> On 2018-09-05 04:18, Greg KH wrote:
> > On Wed, Sep 05, 2018 at 03:01:26PM +0530, Manu Gautam wrote:
> > > Hi,
> > > 
> > > 
> > > On 9/5/2018 3:04 AM, Prakruthi Deepak Heragu wrote:
> > > > Add support for control peripheral of EUD (Embedded USB Debugger) to
> > > > listen to events such as USB attach/detach, charger enable/disable, pet
> > > > EUD to indicate software is functional.
> > > >
> > > > Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> > > > Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> > > > ---
> > > >  drivers/soc/qcom/Kconfig  |  12 ++
> > > >  drivers/soc/qcom/Makefile |   1 +
> > > >  drivers/soc/qcom/eud.c    | 338 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 351 insertions(+)
> > > >  create mode 100644 drivers/soc/qcom/eud.c
> > > >
> > > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > [snip]
> > > > +
> > > > +#define EUD_ENABLE_CMD 1
> > > > +#define EUD_DISABLE_CMD 0
> > > 
> > > Why not use module param as boolean? I mean zero to disable and
> > > non-zero to enable?
> > 
> > Never use module parameters on new code, as it's really hard to ever
> > change them.  It also doesn't work for multiple devices of the same
> > type.
> > 
> If not for module_param, do you suggest we use sysfs?

It depends on what you want to control.

> module_param also provides a facility to control these parameters
> through command line too. If we can't use module_param, do you expect
> us to use __setup(..) API?

Again, it depends on what you are wanting to handle here.  module
parameters and setup variables are all "global" in that they affect all
devices of the same type.  sysfs can be "per device" which is almost
always what you want to have happen.

But don't use any of those for things that should be "automatic" in that
the driver should figure out what needs to be done here and not need any
external configuration.  That's the best way of all to handle this.

thanks,

greg k-h
