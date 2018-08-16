Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A062A2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A062A2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbeHPFAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:00:30 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:48253 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbeHPFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:00:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3EEC118224D6A;
        Thu, 16 Aug 2018 02:05:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw08_127f125cea227
X-Filterd-Recvd-Size: 2280
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Aug 2018 02:05:26 +0000 (UTC)
Message-ID: <fb8d7d867726b934650ed20ceb4fe0d2a6a4f0f9.camel@perches.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Aug 2018 19:05:25 -0700
In-Reply-To: <CA+55aFxZDYTFKM4-e89_2SKHjHh_8RCZe7whKa2kCWRFk4mAdg@mail.gmail.com>
References: <s5h36vhazyp.wl-tiwai@suse.de>
         <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
         <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
         <CA+55aFxZDYTFKM4-e89_2SKHjHh_8RCZe7whKa2kCWRFk4mAdg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 19:00 -0700, Linus Torvalds wrote:
> On Wed, Aug 15, 2018 at 6:27 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > I have no idea _why_, but it's consistent, and it bisects down to
> > 
> >   c647f806b8c2 "ALSA: hda - Allow multiple ADCs for mic mute LED controls"
> > 
> > where the previous commit works fine, but that commit definitely
> > causes the problem.
> 
> Hmm.
> 
> That commit changes the return value of the
> snd_hda_gen_add_micmute_led(), but doesn't change any of the callers.
> 
> Now, almost no caller actually checks the return value.
> 
> Almost.
> 
> There is *one* caller that does, though:
> 
> sound/pci/hda/dell_wmi_helper.c:
>   alc_fixup_dell_wmi()
> 
> And yes, the laptop that breaks is a Dell. An XPS13.
> 
> I bet that instead of reverting, I can just change that
> 
>                         (snd_hda_gen_add_micmute_led(codec,
>                                                      dell_micmute_update) <= 0);
> 
> to test for "< 0" instead of "<= 0".

Why does the commit change snd_hda_gen_add_micmute_led
to return 0; instead of return 1;

That bit looks wrong.

