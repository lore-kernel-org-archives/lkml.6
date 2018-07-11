Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F92BC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C1F20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C1F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbeGKVfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:35:33 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:44982 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388831AbeGKVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:35:33 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fdMfY-0003Zq-Is; Wed, 11 Jul 2018 23:29:04 +0200
Date:   Wed, 11 Jul 2018 23:29:04 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to
 screen characters
Message-ID: <20180711212904.pvvgedidavvwfaca@angband.pl>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org>
 <20180627035642.8561-2-nicolas.pitre@linaro.org>
 <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
 <20180711091848.GA2889@kroah.com>
 <CAGXu5j+3M6go8HZRC0=ZW8v6_qkFKuLE_cQGta7tnG6t+SBnxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+3M6go8HZRC0=ZW8v6_qkFKuLE_cQGta7tnG6t+SBnxA@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:39:56PM -0700, Kees Cook wrote:
> On Wed, Jul 11, 2018 at 2:18 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jul 10, 2018 at 05:52:01PM -0700, Kees Cook wrote:
> >> On Tue, Jun 26, 2018 at 8:56 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> > +++ b/drivers/tty/vt/vt.c
> >> > [...]
> >> > +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> >> > +                            enum con_scroll dir, unsigned int nr)
> >> > +{
> >> > +       struct uni_screen *uniscr = get_vc_uniscr(vc);
> >> > +
> >> > +       if (uniscr) {
> >> > +               unsigned int s, d, rescue, clear;
> >> > +               char32_t *save[nr];
> >>
> >> Can you adjust this to avoid the VLA here? I've almost gotten all VLAs
> >> removed from the kernel[1], and this is introducing a new one. :)
> >
> Yup, that's fine. (It's how I noticed it: linux-next VLA build tests.)
> I'm just hoping it can get solved before the merge window opens. :)

This one is actually nasty: max console height is 32767, if you resize it
that big then issue a large scroll request, boom it goes.

> There are still a bunch of VLAs I'm chipping away at, but this was a
> newly added one, so I was hoping Nicolas (when he's back from
> vacation) will have ideas on how to best avoid it.

Nicolas: what about just moving line pointers one at a time?  Rotating an
array slice in-place isn't that slow -- and optimizing that much when
reasonable sizes don't exceed 100ish (depending on how good your eyes are)
is quite ridiculous.  Thanks to your change, we don't need to move actual
contents, just line pointers -- that's fast enough.


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
