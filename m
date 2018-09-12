Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6990C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B81B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeIMAA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:00:27 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45810 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeIMAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:00:27 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g0AHY-0005D8-Vm; Wed, 12 Sep 2018 19:54:33 +0100
Message-ID: <1536778472.3024.204.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 18/31] r8152: napi hangup fix after disconnect
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Jiri Slaby <jslaby@suse.cz>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Sep 2018 19:54:32 +0100
In-Reply-To: <3b118091-d600-0be8-3204-c0f794ef6288@suse.cz>
References: <20180720121340.158484922@linuxfoundation.org>
         <20180720121340.812996969@linuxfoundation.org>
         <1535128726.2902.32.camel@codethink.co.uk>
         <3b118091-d600-0be8-3204-c0f794ef6288@suse.cz>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-25 at 09:43 +0200, Jiri Slaby wrote:
> On 08/24/2018, 06:38 PM, Ben Hutchings wrote:
> > On Fri, 2018-07-20 at 14:13 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jiri Slaby <jslaby@suse.cz>
> > > 
> > > [ Upstream commit 0ee1f4734967af8321ecebaf9c74221ace34f2d5 ]
> > 
> > [...]
> > > --- a/drivers/net/usb/r8152.c
> > > +++ b/drivers/net/usb/r8152.c
> > > @@ -3139,7 +3139,8 @@ static int rtl8152_close(struct net_devi
> > >  #ifdef CONFIG_PM_SLEEP
> > >  	unregister_pm_notifier(&tp->pm_notifier);
> > >  #endif
> > > -	napi_disable(&tp->napi);
> > > +	if (!test_bit(RTL8152_UNPLUG, &tp->flags))
> > > +		napi_disable(&tp->napi);
> > >  	clear_bit(WORK_ENABLE, &tp->flags);
> > >  	usb_kill_urb(tp->intr_urb);
> > >  	cancel_delayed_work_sync(&tp->schedule);
> > 
> > This flag appears to be set only if the USB device is actually
> > disconnected.  In case the driver is unbound for some other reason
> > (like the module is removed), the same problem will occur.
> 
> Could you elaborate? I thought this would happen:
> module_exit -> usb_deregister -> usb_unbind_device -> rtl8152_disconnect
> -> unregister_netdev -> rtl8152_close
> 
> Am I missing something?

What I mean is that if the USB device has not been *physically*
disconnected then its usb_device::state will not be
USB_STATE_NOTATTACHED.  So rtl8152_disconnect() will not set the
RTL8152_UNPLUG flag and rtl8152_close() will still call napi_disable()
which will hang.

Some options to fix this:
- Add a separate flag which rtl8152_close() checks and
rtl8152_disconnect() always sets
- Call dev_close() before netif_napi_del()

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
