Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C921781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C921781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeHMWYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:24:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbeHMWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:24:33 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61391CE7;
        Mon, 13 Aug 2018 19:40:54 +0000 (UTC)
Date:   Mon, 13 Aug 2018 21:40:51 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 2/5] vmbus: add driver_override support
Message-ID: <20180813194051.GA11620@kroah.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
 <20180810230611.2114-2-kys@linuxonhyperv.com>
 <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 07:30:50PM +0000, Michael Kelley (EOSG) wrote:
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Friday, August 10, 2018 4:06 PM
> 
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > Add support for overriding the default driver for a VMBus device
> > in the same way that it can be done for PCI devices. This patch
> > adds the /sys/bus/vmbus/devices/.../driver_override file
> > and the logic for matching.
> > 
> > This is used by driverctl tool to do driver override.
> > https://gitlab.com/driverctl/driverctl
> > 
> > Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index b1b548a21f91..e6d8fdac6d8b 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -498,6 +498,54 @@ static ssize_t device_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(device);
> > 
> > +static ssize_t driver_override_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct hv_device *hv_dev = device_to_hv_device(dev);
> > +	char *driver_override, *old, *cp;
> > +
> > +	/* We need to keep extra room for a newline */
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> 
> Does 'count' actually have a relationship to PAGE_SIZE, or
> is PAGE_SIZE just used as an arbitrary size limit?  I'm
> wondering what happens on ARM64 with a 64K page size,
> for example.  If it's just arbitrary, coding such a constant
> would be better.

sysfs buffers are PAGE_SIZE big.

