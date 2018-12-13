Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8FEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53872086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53872086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ze-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeLMUyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:54:05 -0500
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:15936 "EHLO
        vie01a-dmta-pe06-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeLMUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:54:05 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <thomas.zeitlhofer@ze-it.at>)
        id 1gXXze-0002Bg-B7
        for linux-kernel@vger.kernel.org; Thu, 13 Dec 2018 21:54:02 +0100
Received: from localhost.localdomain ([80.108.25.171])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id XXzdg9Liy5WeQXXzdg5CeI; Thu, 13 Dec 2018 21:54:02 +0100
X-Env-Mailfrom: thomas.zeitlhofer@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.25.171
X-CNFS-Analysis: v=2.3 cv=YaJsGDZf c=1 sm=1 tr=0
 a=cw3iLm2b3cPoAt0NIr38/g==:117 a=cw3iLm2b3cPoAt0NIr38/g==:17
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=jBlPrOwmUf4zLZhRtaoA:9 a=CjuIK1q_8ugA:10
Date:   Thu, 13 Dec 2018 21:53:57 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
Message-ID: <20181213205357.GA5012@x1>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135921.817957465@linuxfoundation.org>
 <20181212225334.GA2651@x1>
 <20181213073640.GA31371@kroah.com>
 <06384740-496f-ce37-34bc-3e55fd9ed538@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06384740-496f-ce37-34bc-3e55fd9ed538@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfHtekzhFVo0o9ZaLNSkfUNjkVkIY1tS+1fDZVGXYcdN0eXg9yAAKvMOb+La/OVfFyJA05tcmkfUmSu7E27uTpCSpf6pMDJH8DTH+P92vj8vuiJiSxasM
 fq5hy7hfFLprVw9tAiyQ6xXcjfVd/uMeqMlcHj0dc1a7f20e+e9NwFL71v7WhogMVU6SzjE3Tm/CKM91knXShH7QHy09QO9GObmACj5hd6HhfH80g0bAEuzg
 OatrJV5kby1YSX0V+n2cqpxThZt5/aTr10XC5XwOy5I2JCqiwj1F6RMwufVQ0X2IjZ48r6bMpwYExMi9JzSfG1eA9HX/pJ41+lbQqMV9Ay8ji42u8xg6FO6x
 P7+8HU0U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:24:14PM +0200, Mathias Nyman wrote:
> On 13.12.2018 09:36, Greg Kroah-Hartman wrote:
> > On Wed, Dec 12, 2018 at 11:53:34PM +0100, Thomas Zeitlhofer wrote:
> > > Hello,
> > > 
> > > On Thu, Nov 29, 2018 at 03:11:45PM +0100, Greg Kroah-Hartman wrote:
> > > > 4.19-stable review patch.  If anyone has any objections, please let me
> > > > know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Mathias Nyman <mathias.nyman@linux.intel.com>
> > > > 
> > > > commit 2f31a67f01a8beb22cae754c53522cb61a005750 upstream.
> > > [...]
> > > 
> > > on a current Thinkpad X1 Yoga, this breaks resume from hibernate such
> > > that opening the lid has (in the regular use case, see below) no effect
> > > any more:
> > > 
> > > The system is configured to hibernate when the lid is closed. So, the
> > > expected behavior, which is restored by reverting this patch, is:
> > > 
> > > 	close lid => system hibernates
> > > 	open lid => system resumes
> > > 
> > > With this patch, the following two cases are observed:
> > > 
> > > 	1)
> > > 		close lid => system hibernates
> > > 		open lid => system stays off
> > > 		press power button => system boots and resumes
> > > 
> > > 	2)
> > > 		# systemctl hibernate => system hibernates
> > > 		close lid
> > > 		open lid => system resumes
> > > 
> > 
> > So this is a problem in Linus's tree?  If so, let's work to get this
> > fixed there first.
> > 
> > If not, then we have other issues :)
> > 
> 
> That patch incorrectly reacts to USB2 polling states as well,
> which could cause issues like this.
> 
> Does applying the below code help?
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 94aca1b..01b5818 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1507,7 +1507,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
>                 portsc_buf[port_index] = 0;
>                 /* Bail out if a USB3 port has a new device in link training */
> -               if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
> +               if ((hcd->speed >= HCD_USB3) &&
> +                   (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
>                         bus_state->bus_suspended = 0;
>                         spin_unlock_irqrestore(&xhci->lock, flags);
>                         xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");

Yes, this fixes the problem.

Thanks,

Thomas
