Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19827C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B881D2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="FQaHQhgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B881D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeKJEYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:24:45 -0500
Received: from dougal.metanate.com ([90.155.101.14]:56127 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbeKJEYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DtdbtT30cGcxyiMkuCxHxgZhiY/whduZaSjPF+Ka9eY=; b=FQaHQhgTnUKymnaFxZEZvPasbz
        yMvOjZIzb7OCJo77CMjHVjNsMV6V8fa26g5modP4o/MCb8KTkpx6atjgjU3rQ3yiOu5gyZHEbam2q
        c2LZlt5k6tXo2ZxGVw7r08wEGwN6E5sl0CpqPm4I7I4izZG5smguL35ECmTnQXcUcwzn00y78W1Uc
        H78HvXlW59c89Udyf2dHPl7CiNfKHb9hrtSLu66GtrO7irMlR5cTwDUVhxBlFgiTSbQ5ub47hWybK
        XvDyv6HFf1cHOP6FbVs3BShTtU8yn1N2lap4FHImd74b0z/fCATXa8j/Vt12qcyDm7bXv6i+1uwp3
        2tKqcyWA==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=donbot)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1gLBjz-0001OR-9f; Fri, 09 Nov 2018 18:42:48 +0000
Date:   Fri, 9 Nov 2018 18:42:46 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Message-ID: <20181109184246.33cb4487@donbot>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
        <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
        <20181108173654.118f9e3e@donbot>
        <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
        <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Fri, 9 Nov 2018 14:36:36 +0000
Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:

> On 11/9/2018 12:43 PM, Minas Harutyunyan wrote:
> > Hi John,
> > 
> > On 11/8/2018 9:37 PM, John Keeping wrote:
> >> Hi Minas,
> >>
> >> On Mon, 5 Nov 2018 08:28:07 +0000
> >> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:
> >>
> >>> On 10/23/2018 5:43 PM, John Keeping wrote:
> >>>> By clearing the overrun flag as soon as the target frame is next
> >>>> incremented, we can end up incrementing the target frame more
> >>>> than expected in dwc2_gadget_handle_ep_disabled() when the
> >>>> endpoint's interval is greater than 1.  This happens if the
> >>>> target frame has just wrapped at the point when the endpoint is
> >>>> disabled and the frame number has not yet done so.
> >>>>
> >>>> Instead, wait until the frame number also wraps and then clear
> >>>> the overrun flag.
> >>>>
> >>>> Signed-off-by: John Keeping <john@metanate.com>
> >>>> ---
> >>>>     drivers/usb/dwc2/gadget.c | 2 +-
> >>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/usb/dwc2/gadget.c
> >>>> b/drivers/usb/dwc2/gadget.c index 2d6d2c8244de..8da2c052dfa1
> >>>> 100644 --- a/drivers/usb/dwc2/gadget.c
> >>>> +++ b/drivers/usb/dwc2/gadget.c
> >>>> @@ -117,7 +117,7 @@ static inline void
> >>>> dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep) if
> >>>> (hs_ep->target_frame > DSTS_SOFFN_LIMIT) { hs_ep->frame_overrun =
> >>>> true; hs_ep->target_frame &= DSTS_SOFFN_LIMIT;
> >>>> -	} else {
> >>>> +	} else if (hs_ep->parent->frame_number <
> >>>> hs_ep->target_frame) { hs_ep->frame_overrun = false;
> >>>>     	}
> >>>>     }
> >>>>     
> >>> Did you tested mentioned by you scenario? If you see issue can you
> >>> provide debug log and point the issue line in the log.
> >>
> >> It only reproduces very occasionally so it's difficult to capture
> >> a full debug log containing the error.
> >>
> >> I applied this patch to capture logging specifically around this
> >> scenario:
> >>
> >> -- >8 --
> >> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> >> index 220c0f9b89b0..3770b9d3b523 100644
> >> --- a/drivers/usb/dwc2/gadget.c
> >> +++ b/drivers/usb/dwc2/gadget.c
> >> @@ -2722,13 +2722,20 @@ static void
> >> dwc2_gadget_handle_ep_disabled(struct dwc2_hsotg_ep *hs_ep) }
> >>    
> >>           do {
> >> +               unsigned int target_frame = hs_ep->target_frame;
> >> +               bool frame_overrun = hs_ep->frame_overrun;
> >> +
> >>                   hs_req = get_ep_head(hs_ep);
> >>                   if (hs_req)
> >>                           dwc2_hsotg_complete_request(hsotg,
> >> hs_ep, hs_req, -ENODATA);
> >> +
> >>                   dwc2_gadget_incr_frame_num(hs_ep);
> >>                   /* Update current frame number value. */
> >>                   hsotg->frame_number =
> >> dwc2_hsotg_read_frameno(hsotg); +
> >> +               dev_warn(hsotg->dev, "%s: expiring request
> >> frame_number=0x%04x target_frame=0x%04x overrun=%u\n",
> >> +                        __func__, hsotg->frame_number,
> >> target_frame, frame_overrun); } while
> >> (dwc2_gadget_target_frame_elapsed(hs_ep)); 
> >>           dwc2_gadget_start_next_request(hs_ep);
> >> -- 8< --
> >>
> > According above patch in debug log should be printed overrun flag
> > also. Could you please resend log with this flag.

D'oh!  I included a log from an earlier version before I added the
overrun flag.

> One more request. Please add EP number to debug print.

Here's an updated log:

-- >8 --
[  264.926385] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x2161 target_frame=0x2168 overrun=0
[  265.905413] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0008 overrun=0
[  265.905421] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0010 overrun=0
[  265.905427] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0018 overrun=0
[  265.905432] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0020 overrun=0
[  265.905438] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0028 overrun=0
[  265.905443] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0030 overrun=0
[  265.905448] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0038 overrun=0
[  265.905454] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0040 overrun=0
[  265.905459] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expiring request ep=2 frame_number=0x3ff9 target_frame=0x0048 overrun=0
-- 8< --

Once again there is an initial failure before it enters the failure mode
my patch is trying to address.  This seems to be consistent, so it may
be important, but there is ~80ms before the failure starts.

> >> This was on v4.19 with an additional patch to disable descriptor
> >> DMA because that seems to be causing problems on RK3288 although I
> >> haven't figured out exactly why it's a problem.
> > 
> > In which mode you run tests Slave or Buffer DMA?

Buffer DMA but with descriptor DMA forced off (g_dma=1, g_dma_desc=0).

For the record, my test case is the standard UAC2 gadget with:

	c_srate = p_srate = 44100
	c_ssize = p_ssize = 4
	c_chmask = 0xf
	p_chmask = 3

and it seems that the failure only triggers when using arecord to
capture from the gadget interface (this is with a host program both
streaming in both directions over the USB connection); I suspect that
actually it just makes it more likely because there is more work done in
the completion handler, but I haven't seen the failure without arecord
running.


Regards,
John
