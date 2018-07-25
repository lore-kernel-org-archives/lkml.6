Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DB92088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DB92088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeGYGgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:36:47 -0400
Received: from leo.clearchain.com ([199.73.29.74]:57605 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeGYGgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:36:46 -0400
Received: from leo.clearchain.com (localhost [127.0.0.1])
        by mail.clearchain.com (8.15.2/8.15.2) with ESMTPS id w6P5QkxS046776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 14:56:46 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: Host localhost [127.0.0.1] claimed to be leo.clearchain.com
Received: (from whot@localhost)
        by leo.clearchain.com (8.15.2/8.15.2/Submit) id w6P5QjNE046773;
        Wed, 25 Jul 2018 14:56:45 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Date:   Wed, 25 Jul 2018 15:26:41 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        l.stach@pengutronix.de, nick.dyer@itdev.co.uk
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
Message-ID: <20180725052641.GA7072@jelly>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-9-nick@shmanahar.org>
 <20180723223347.GJ100814@dtor-ws>
 <CAO-hwJ+BoWdXbH1sbde2+qb_sgFBMarM0156a1VrRSQdhNf3xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+BoWdXbH1sbde2+qb_sgFBMarM0156a1VrRSQdhNf3xQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3 (mail.clearchain.com [127.0.0.1]); Wed, 25 Jul 2018 14:56:47 +0930 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:23:27AM +0200, Benjamin Tissoires wrote:
> On Tue, Jul 24, 2018 at 12:34 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> > > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > >
> > > input_mt_report_slot_state() ignores the tool when the slot is closed.
> > > Remove the tool type from these function calls, which has caused a bit of
> > > confusion.
> >
> > Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
> > rid of the 3rd parameter? It will require a bit of macro trickery for a
> > release or 2...
> 
> I am not sure what would be the benefit of adding those new tools, if
> the input_mt code discards them. Do you want to forward them to the
> userspace with the release?
> This reminds me the discussion we had recently with the touchscreens
> releasing the slots with a MT_TOOL_PALM.
> 
> Anyway, better include Peter as he will be using this new MT_TOOL.

thanks for the CC, would've missed this.

From what I read this would be a helper for internal changes only, not
exposed to userspace? If so maybe it's better/easier/more readable to break
it into two functions
  input_mt_open_slot(dev, MT_TOOL_FINGER)
  input_mt_close_slot(dev)
  
This removes any ambiguity about the handling of the tool and should be a
fairly trivial search/replace. Replace the 'open/close' terminology with
whatever suits better.

Cheers,
   Peter

> > > Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> > > ---
> > >  drivers/input/touchscreen/atmel_mxt_ts.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > index d7023d261458..c31af790ef84 100644
> > > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > @@ -838,8 +838,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
> > >                * have happened.
> > >                */
> > >               if (status & MXT_T9_RELEASE) {
> > > -                     input_mt_report_slot_state(input_dev,
> > > -                                                MT_TOOL_FINGER, 0);
> > > +                     input_mt_report_slot_state(input_dev, 0, 0);
> > >                       mxt_input_sync(data);
> > >               }
> > >
> > > @@ -855,7 +854,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
> > >               input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
> > >       } else {
> > >               /* Touch no longer active, close out slot */
> > > -             input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
> > > +             input_mt_report_slot_state(input_dev, 0, 0);
> > >       }
> > >
> > >       data->update_input = true;
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
