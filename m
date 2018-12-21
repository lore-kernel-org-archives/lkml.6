Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7E421920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="qFa5XFJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbeLUQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:05:16 -0500
Received: from dougal.metanate.com ([90.155.101.14]:39445 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbeLUQFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NOwvhVdcPFWzLduLqDqyQbNnEYBnCK66DE311pDNx1E=; b=qFa5XFJltUiyPTZWQZjOxJxv9/
        GL8nvZtPLU+QwPKdfGfnW7a2I9XT6J6h2y+dpy+R4Ym47LvZEsdDBdF0X6B0J9Mha9jAj8F/Qz7Xn
        Tmzly7DbtownP2GLWESoLUQuyVUfiJN/lebH6qMTXEKqipk35xy+5Txu82k+86PqMCdTkWt3UH6v4
        Z74c2D7F+DPfkUVgSOFGsBijh1TfrFilf5gHT2qFvNDbGCHwBRjik06AdvN95AH1XTfQcCZJ/Dp5C
        fxm0TW/zY5z9WihTBUBlLrrfmm/QudwKkmKI/XChwfNo1kvwCEBfg+2JMrsVlsEOBeYjkFo4RVgjg
        DosJV/cA==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1gaNIR-00018m-2x; Fri, 21 Dec 2018 16:05:07 +0000
Date:   Fri, 21 Dec 2018 16:05:04 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Message-ID: <20181221160504.15e93827@donbot>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7BECBB@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
        <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
        <20181108173654.118f9e3e@donbot>
        <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
        <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
        <20181109184246.33cb4487@donbot>
        <410670D7E743164D87FA6160E7907A56013A7A27D7@am04wembxa.internal.synopsys.com>
        <20181112224626.6b44568a@donbot>
        <410670D7E743164D87FA6160E7907A56013A7BAB28@am04wembxa.internal.synopsys.com>
        <20181218143504.027fc53c@donbot>
        <410670D7E743164D87FA6160E7907A56013A7BECBB@am04wembxa.internal.synopsys.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Wed, 19 Dec 2018 14:09:01 +0000
Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:

> On 12/18/2018 6:35 PM, John Keeping wrote:
> > Hi Minas,
> > 
> > On Fri, 14 Dec 2018 09:00:08 +0000
> > Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:  
> >> First of all, sorry for delayed answer.
> >> Looks like similar issue seen by Andrzej Pietrasiewicz
> >> <andrzej.p@samsung.com>: "dwc2 isochronous transfers issues". Same
> >> feedback provided to Andrzej.
> >>
> >> I run tests on 4.20.0-rc4 in DDMA. By default IN ISOC traffic
> >> failed because of BNA interrupts. It's happen because UAC2
> >> requests count set by default to 2. Our core and driver can't work
> >> in DDMA with descriptor list length equal to 2. It's not possible
> >> on time prepare next descriptors to avoid BNA interrupt.
> >>
> >> By changing UAC2_DEF_REQ_NUM to 4 all audio gadget tests passed
> >> smoothly. Could you please apply this patch and run tests in DDMA
> >> mode:
> >>
> >> diff --git a/drivers/usb/gadget/function/u_uac2.h
> >> b/drivers/usb/gadget/function/u_uac2.h
> >> index 8362ee572e1e..5e649259ab76 100644
> >> --- a/drivers/usb/gadget/function/u_uac2.h
> >> +++ b/drivers/usb/gadget/function/u_uac2.h
> >> @@ -21,7 +21,7 @@
> >>    #define UAC2_DEF_CCHMASK 0x3
> >>    #define UAC2_DEF_CSRATE 64000
> >>    #define UAC2_DEF_CSSIZE 2
> >> -#define UAC2_DEF_REQ_NUM 2
> >> +#define UAC2_DEF_REQ_NUM 4
> >>
> >>    struct f_uac2_opts {
> >>           struct usb_function_instance    func_inst;
> >>
> >>
> >> If it will OK on your side also then will switch to BDMA mode and
> >> debug.  
> > 
> > With DDMA enabled, I see the following error after the stream has
> > been running for a while (anything from a few seconds to a few
> > minutes): 
> > -- >8 --  
> > [ 1798.836322] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called for
> > ep0 [ 1798.836329] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called
> > for ep0 [ 1798.851092] dwc2 ff580000.usb: new device is high-speed
> > [ 1798.924461] dwc2 ff580000.usb: new device is high-speed
> > [ 1798.982887] dwc2 ff580000.usb: new address 25
> > [ 1799.002463] configfs-gadget gadget: high-speed config #1: config
> > -- 8< --
> > 
> > On the host side (Linux 4.18.16 Intel xHCI), I see this logged at
> > the same time:
> >   
> > -- >8 --  
> > [1735740.716242] retire_capture_urb: usb 1-2.2.7: frame 0 active:
> > -71 [1735740.716990] retire_capture_urb: usb 1-2.2.7: frame 0
> > active: -71 [1735740.717906] retire_capture_urb: usb 1-2.2.7: frame
> > 0 active: -71 [1735740.718905] retire_capture_urb: usb 1-2.2.7:
> > frame 0 active: -71 [1735740.719916] retire_capture_urb: usb
> > 1-2.2.7: frame 0 active: -71 [1735740.720032] usb 1-2.2-port7:
> > disabled by hub (EMI?), re-enabling... [1735740.720036] usb
> > 1-2.2.7: USB disconnect, device number 28 [1735740.937500] usb
> > 1-2.2.7: new high-speed USB device number 29 using xhci_hcd -- 8< --
> > 
> > The device does then enumerate and works for a period of time
> > before the same error happens again.
> >   
>  From logs not clear who initiate disconnect: host or device.  More 
> probably host, after some errors in retire_capture_urb initiate 
> disconnect. Do you have any idea?
> Can't you connect device to host on same platform?
> If root cause of disconnect by host is device issue, i.e. not able to 
> send to host data packets in time then I need device side dmesg log
> with debug enabled. USB trace around the disconnect will help to
> debug.

I remember running a test with a hardware USB analyzer and which showed
an isochronous packet with an incorrect length (much larger than it
should have been) when the failure occurred.

I don't have any logs from that test and I'm out of the office at the
moment, but I will capture logs when I'm back in January.


Thanks,
John
