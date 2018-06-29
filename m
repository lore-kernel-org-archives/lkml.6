Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F023D6F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="bmWq31VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650F023D6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeF2R3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:29:46 -0400
Received: from mail.horus.com ([78.46.148.228]:59345 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932548AbeF2R3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:29:44 -0400
Received: from [192.168.1.20] (193-83-224-126.adsl.highway.telekom.at [193.83.224.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 71D55640A0;
        Fri, 29 Jun 2018 19:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1530293382;
        bh=x+rQuJtOeKk4F8fXQfrQXhU1ia+bd2AzIihaDp36Yvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmWq31VJyQfiCnMGlXO/eijMtfo6YgPP+tgHWxDRlUVUn+7amxSpQkAr0+dQHW5dR
         JukXHpSxy/LHRgWRi+tLD8XpcanaKR25oVQ7JMwAOixp9zDvZl8X/o+WGlswUaWh7F
         Le/7BNeW6WH4IuSsZfbThQaAqG0DAjPd+2q9H/Fc=
Received: by camel2.lan (Postfix, from userid 1000)
        id 4B2E81C78CA; Fri, 29 Jun 2018 19:29:41 +0200 (CEST)
Date:   Fri, 29 Jun 2018 19:29:40 +0200
From:   Matthias Reichl <hias@horus.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
Message-ID: <20180629172940.i653fp6tjnimj4a5@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, Phil Elwell <phil@raspberrypi.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20171205114709.f6aj6i426keq2cn5@camel2.lan>
 <20171205131416.GW10595@n2100.armlinux.org.uk>
 <20171205132339.behn34z6b7ci2m4j@camel2.lan>
 <5b9b86cf-4b62-c984-fe52-a22df8fce33c@raspberrypi.org>
 <20171205133601.GX10595@n2100.armlinux.org.uk>
 <CAGXu5jJb0PCSuC4DuOkh5-901iVLcmmPpn1G7UBq3-r9DaeMvw@mail.gmail.com>
 <20171205200935.GY10595@n2100.armlinux.org.uk>
 <CAGXu5jKvVpyLs0+zP34mG=XyGSkzeKFj6WtW+tTfKv7tLKsD2g@mail.gmail.com>
 <20180629144714.hkvwqzpikweyihmo@camel2.lan>
 <20180629111658.02bfcc11@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629111658.02bfcc11@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:16:58AM -0400, Steven Rostedt wrote:
> On Fri, 29 Jun 2018 16:47:14 +0200
> Matthias Reichl <hias@horus.com> wrote:
> 
> > On Tue, Dec 05, 2017 at 12:14:46PM -0800, Kees Cook wrote:
> > > On Tue, Dec 5, 2017 at 12:09 PM, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:  
> > > > On Tue, Dec 05, 2017 at 11:35:59AM -0800, Kees Cook wrote:  
> > > >> We don't _need_ to, but they're all contiguous, so the ro_perms array
> > > >> used by set_kernel_text_*() is actually only a single entry:
> > > >>
> > > >> static struct section_perm ro_perms[] = {
> > > >>         /* Make kernel code and rodata RX (set RO). */
> > > >>         {
> > > >>                 .name   = "text/rodata RO",
> > > >>                 .start  = (unsigned long)_stext,
> > > >>                 .end    = (unsigned long)__init_begin,
> > > >> ...  
> > > >
> > > > Well, they may not be contiguous - it depends on DEBUG_ALIGN_RODATA.  
> > > 
> > > Maybe I'm picking a slightly wrong word. I guess I meant adjacent. The
> > > range _stext to __init_begin is all read-only, though there may be
> > > padding (controlled by DEBUG_ALIGN_RODATA), to allow a split for NX
> > > markings on rodata.
> > >   
> > > > Either way, we have __start_rodata_section_aligned, which is either
> > > > the start of the read-only data section, or the start of the first
> > > > section beyond __start_rodata if DEBUG_ALIGN_RODATA is not set.
> > > >
> > > > Given that __start_rodata_section_aligned will always be less than
> > > > __init_begin, is there any reason not to make the above end at
> > > > __start_rodata_section_aligned, thereby allowing more of the read-only
> > > > data (in the case of DEBUG_ALIGN_RODATA=n) or all of the read-only
> > > > data (in the case of DEBUG_ALIGN_RODATA=y) to remain write-protected?  
> > > 
> > > Sure, there's no reason not to split this into two entries. It'll
> > > require some reworking of the function calls to get it right,
> > > obviously.  
> > 
> > Gentle ping, arm is still oopsing when the function tracer is
> > enabled at boot time.
> > 
> 
> I take it that my patch never got applied:
> 
>  http://lkml.kernel.org/r/20180621124710.453ee0ae@gandalf.local.home

Yes, sorry, forgot to include this info in my mail.

Your patch no longer applies cleanly - a8e53c151fe7a added a
debug_checkwx() to mark_rodata_ro() - but when applying it manually
it still fixes the oops.

so long,

Hias
> 
> -- Steve
> 
> 
> > Tested on bcm2835 (RPiB+) with current mainline tree
> > (githash 90368a37fbbe) and bcm2835_defconfig.
> > 
> > arm64 seems to be fine, tested on bcm2837 (RPi3) with same tree and
> > arm64 defconfig plus function tracer enabled.
> 
