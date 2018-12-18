Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B96FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B25B21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="ZjEjSMOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeLROfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:35:14 -0500
Received: from dougal.metanate.com ([90.155.101.14]:5278 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeLROfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fDf8w06EvPPnJnz2mbgwzBBRvCSx7x9J3JyHflpLMEc=; b=ZjEjSMOvTWfykSCFmvLaxbjR3+
        zXJGXIO/KXHtTqk5RKFHvgSHJtZGL9qX+ZL1tR9kjTI760XeGMBksNHQI3PXL/5V04p5kAMPC4pYO
        byX2eMiGEx+D2zAMxRJi3HXnv82u738eKtQq8L16zGARwY//MAiiqNhmkbjeEn/ZI6/4+mcxe3J/X
        CmqdebmuJNYg/0LfbpWUaPv5+tNO8CEkSBqxiJf35ys0SAoKDtOUuHe//YUsNkru9iZMRIgGyXup5
        obRZj0DYnApZNQ9vv99LOFx/7t5Z+QX72WF6hzPa/0eXZL1qY+aGzkWuUszg0w/hXCsGDrcumtSFg
        0Mm5fayg==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1gZGSg-0002Q1-Ol; Tue, 18 Dec 2018 14:35:06 +0000
Date:   Tue, 18 Dec 2018 14:35:04 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Message-ID: <20181218143504.027fc53c@donbot>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7BAB28@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
        <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
        <20181108173654.118f9e3e@donbot>
        <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
        <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
        <20181109184246.33cb4487@donbot>
        <410670D7E743164D87FA6160E7907A56013A7A27D7@am04wembxa.internal.synopsys.com>
        <20181112224626.6b44568a@donbot>
        <410670D7E743164D87FA6160E7907A56013A7BAB28@am04wembxa.internal.synopsys.com>
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

On Fri, 14 Dec 2018 09:00:08 +0000
Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:
> First of all, sorry for delayed answer.
> Looks like similar issue seen by Andrzej Pietrasiewicz 
> <andrzej.p@samsung.com>: "dwc2 isochronous transfers issues". Same 
> feedback provided to Andrzej.
> 
> I run tests on 4.20.0-rc4 in DDMA. By default IN ISOC traffic failed 
> because of BNA interrupts. It's happen because UAC2 requests count
> set by default to 2. Our core and driver can't work in DDMA with
> descriptor list length equal to 2. It's not possible on time prepare
> next descriptors to avoid BNA interrupt.
> 
> By changing UAC2_DEF_REQ_NUM to 4 all audio gadget tests passed
> smoothly. Could you please apply this patch and run tests in DDMA
> mode:
> 
> diff --git a/drivers/usb/gadget/function/u_uac2.h 
> b/drivers/usb/gadget/function/u_uac2.h
> index 8362ee572e1e..5e649259ab76 100644
> --- a/drivers/usb/gadget/function/u_uac2.h
> +++ b/drivers/usb/gadget/function/u_uac2.h
> @@ -21,7 +21,7 @@
>   #define UAC2_DEF_CCHMASK 0x3
>   #define UAC2_DEF_CSRATE 64000
>   #define UAC2_DEF_CSSIZE 2
> -#define UAC2_DEF_REQ_NUM 2
> +#define UAC2_DEF_REQ_NUM 4
> 
>   struct f_uac2_opts {
>          struct usb_function_instance    func_inst;
> 
> 
> If it will OK on your side also then will switch to BDMA mode and
> debug.

With DDMA enabled, I see the following error after the stream has been
running for a while (anything from a few seconds to a few minutes):

-- >8 --
[ 1798.836322] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called for ep0
[ 1798.836329] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called for ep0
[ 1798.851092] dwc2 ff580000.usb: new device is high-speed
[ 1798.924461] dwc2 ff580000.usb: new device is high-speed
[ 1798.982887] dwc2 ff580000.usb: new address 25
[ 1799.002463] configfs-gadget gadget: high-speed config #1: config
-- 8< --

On the host side (Linux 4.18.16 Intel xHCI), I see this logged at the
same time:

-- >8 --
[1735740.716242] retire_capture_urb: usb 1-2.2.7: frame 0 active: -71
[1735740.716990] retire_capture_urb: usb 1-2.2.7: frame 0 active: -71
[1735740.717906] retire_capture_urb: usb 1-2.2.7: frame 0 active: -71
[1735740.718905] retire_capture_urb: usb 1-2.2.7: frame 0 active: -71
[1735740.719916] retire_capture_urb: usb 1-2.2.7: frame 0 active: -71
[1735740.720032] usb 1-2.2-port7: disabled by hub (EMI?), re-enabling...
[1735740.720036] usb 1-2.2.7: USB disconnect, device number 28
[1735740.937500] usb 1-2.2.7: new high-speed USB device number 29 using xhci_hcd
-- 8< --

The device does then enumerate and works for a period of time before the
same error happens again.


Regards,
John
