Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966074AbeEJAzf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:55:35 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:47302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965932AbeEJAze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:55:34 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:7514:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12296:12438:12555:12663:12679:12683:12740:12760:12895:13439:13868:14110:14180:14181:14659:14721:21060:21080:21627:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:72,LUA_SUMMARY:none
X-HE-Tag: sofa90_6a9bd73232228
X-Filterd-Recvd-Size: 3518
Message-ID: <3204aa16ab0609f75afd480e06be4f93b9fdf2f0.camel@perches.com>
Subject: Re: [PATCH] input: fix coding style issues in input.c
From: Joe Perches <joe@perches.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nick Simonov <nicksimonovv@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 09 May 2018 17:55:30 -0700
In-Reply-To: <20180510003313.GD91762@dtor-ws>
References: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
         <20180510003313.GD91762@dtor-ws>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 17:33 -0700, Dmitry Torokhov wrote:
> Hi Nick,
> On Wed, May 09, 2018 at 05:07:14PM +0300, Nick Simonov wrote:
> > This is a patch to the input.c file that fixes
> > up warning found by checkpatch.pl tool
> > 
> > Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> > ---
> >  drivers/input/input.c | 52 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 33 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 9785546..e18fdae 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * The input core
> >   *
> > @@ -252,7 +253,8 @@ static int input_handle_abs_event(struct input_dev *dev,
> >  	}
> >  
> >  	/* Flush pending "slot" event */
> > -	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
> > +	if (is_mt_event && mt && mt->slot !=
> > +		input_abs_get_val(dev, ABS_MT_SLOT)) {
> >  		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
> 
> So now it is not immediately clear what is part of condition and what is
> part of body.
> 
> I am sorry to say, but with most of these changes the cure is worse than
> the disease. If you were fixing the code and adjusted the affected lines
> so they are under 80 columns limit that would be one thing, but just
> reformatting for the sake of it is not really helpful.

Completely true.

btw: it might be faster to avoid the
	mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)
test and simply always do the write.

So maybe just:

	if (is_mt_event && mt)
		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);

And to make it easier to grep the definition of input_abs_set_val
and the other get/sets it might be better to add something like:
---
 include/linux/input.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/input.h b/include/linux/input.h
index 7c7516eb7d76..243cf4e3006a 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -459,6 +459,14 @@ static inline void input_abs_set_##_suffix(struct input_dev *dev,	\
 		dev->absinfo[axis]._item = val;				\
 }
 
+/* static inline definitions of:
+ *	input_abs_get_val/input_abs_set_val
+ *	input_abs_get_min/input_abs_set_min
+ *	input_abs_get_max/input_abs_set_max
+ *	input_abs_get_fuzz/input_abs_set_fuzz
+ *	input_abs_get_flat/input_abs_set_flat
+ *	input_abs_get_res/input_abs_set_res
+ */
 INPUT_GENERATE_ABS_ACCESSORS(val, value)
 INPUT_GENERATE_ABS_ACCESSORS(min, minimum)
 INPUT_GENERATE_ABS_ACCESSORS(max, maximum)
