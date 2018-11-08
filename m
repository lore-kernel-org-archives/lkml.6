Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C14ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8121019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="VPCGn2eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A8121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKIDNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:13:34 -0500
Received: from dougal.metanate.com ([90.155.101.14]:24524 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbeKIDNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AOp3pOwZWcY9f86KjSXjzVdOVqOQ6phSjniJ7lnCdVw=; b=VPCGn2eScnBh8szWUcLpS1Knp5
        s+YTVi3av0Lk4ewy2z9k/aJlMD5FRI0va2Ks/Xjz3jcFBHD1Wp2Vqw26R3Oo9fveQi8NJ5I0fHcTO
        zr8l6FsJWckVCyZEN9lC1Urg7qQdkYioMTT3QQcv7V7FqBb6YA+W5GcSggBXJIFS5LslVs9M+7ulW
        A77YktQ2UOuX+wIbnjCBnG3GECdnTHqoLX03gytyJVPtLspX/Cdh7TYh13yuTdgcgamjBYVQJCifG
        s+3j6EnJF7CmFg8Zm8j3EIK7HQSB0xMYH0Ds3Ez/oY7sNCG9v7ExrgbDL0IRTvUEsDLQoL9HifxPw
        3i8NGN7A==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1gKoEg-000673-Db; Thu, 08 Nov 2018 17:36:54 +0000
Date:   Thu, 8 Nov 2018 17:36:53 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Message-ID: <20181108173654.118f9e3e@donbot>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
        <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Mon, 5 Nov 2018 08:28:07 +0000
Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:

> On 10/23/2018 5:43 PM, John Keeping wrote:
> > By clearing the overrun flag as soon as the target frame is next
> > incremented, we can end up incrementing the target frame more than
> > expected in dwc2_gadget_handle_ep_disabled() when the endpoint's
> > interval is greater than 1.  This happens if the target frame has
> > just wrapped at the point when the endpoint is disabled and the
> > frame number has not yet done so.
> > 
> > Instead, wait until the frame number also wraps and then clear the
> > overrun flag.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >   drivers/usb/dwc2/gadget.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index 2d6d2c8244de..8da2c052dfa1 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -117,7 +117,7 @@ static inline void
> > dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep) if
> > (hs_ep->target_frame > DSTS_SOFFN_LIMIT) { hs_ep->frame_overrun =
> > true; hs_ep->target_frame &= DSTS_SOFFN_LIMIT;
> > -	} else {
> > +	} else if (hs_ep->parent->frame_number <
> > hs_ep->target_frame) { hs_ep->frame_overrun = false;
> >   	}
> >   }
> >   
> Did you tested mentioned by you scenario? If you see issue can you 
> provide debug log and point the issue line in the log.

It only reproduces very occasionally so it's difficult to capture a full
debug log containing the error.

I applied this patch to capture logging specifically around this
scenario:

-- >8 --
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 220c0f9b89b0..3770b9d3b523 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2722,13 +2722,20 @@ static void dwc2_gadget_handle_ep_disabled(struct dwc2_hsotg_ep *hs_ep)
        }
 
        do {
+               unsigned int target_frame = hs_ep->target_frame;
+               bool frame_overrun = hs_ep->frame_overrun;
+
                hs_req = get_ep_head(hs_ep);
                if (hs_req)
                        dwc2_hsotg_complete_request(hsotg, hs_ep, hs_req,
                                                    -ENODATA);
+
                dwc2_gadget_incr_frame_num(hs_ep);
                /* Update current frame number value. */
                hsotg->frame_number = dwc2_hsotg_read_frameno(hsotg);
+
+               dev_warn(hsotg->dev, "%s: expiring request frame_number=0x%04x target_frame=0x%04x overrun=%u\n",
+                        __func__, hsotg->frame_number, target_frame, frame_overrun);
        } while (dwc2_gadget_target_frame_elapsed(hs_ep));
 
        dwc2_gadget_start_next_request(hs_ep);
-- 8< --

and I captured this log (the first entry is a separate error and then
the remaining ones show this bug being triggered):

[  562.571227] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3eb9 target_frame=0x3ec0
[  562.611213] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff8 target_frame=0x0008
[  562.611219] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff8 target_frame=0x0010
[  562.611223] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0018
[  562.611228] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0020
[  562.611232] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0028
[  562.611236] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0030
[  562.611240] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0038
[  562.611244] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0040
[  562.611249] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0048
[  562.611253] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0050
[  562.611257] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0058
[  562.611261] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0060
[  562.611265] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0068
[  562.611269] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0070
[  562.611274] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0078
[  562.611278] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0080
[  562.611282] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0088
[  562.611286] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0090
[  562.611290] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x0098
[  562.611294] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request frame_number=0x3ff9 target_frame=0x00a0


This was on v4.19 with an additional patch to disable descriptor DMA
because that seems to be causing problems on RK3288 although I haven't
figured out exactly why it's a problem.


Regards,
John
