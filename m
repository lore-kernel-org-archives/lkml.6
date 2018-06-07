Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HkpFGthVGVubOgAAmS7hNA
	; Thu, 07 Jun 2018 15:57:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 557096089E; Thu,  7 Jun 2018 15:57:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0A20601D2;
	Thu,  7 Jun 2018 15:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0A20601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFGP5J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932578AbeFGP5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:57:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A940ABBD;
        Thu,  7 Jun 2018 15:57:04 +0000 (UTC)
Date: Thu, 7 Jun 2018 17:57:02 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180607155702.GA5527@wotan.suse.de>
References: <20180601125330.25054-1-hdegoede@redhat.com>
 <20180601125330.25054-3-hdegoede@redhat.com>
 <20180605210753.GC4511@wotan.suse.de>
 <30260c62-eb8b-7d88-4ce1-83e969546790@redhat.com>
 <20180606214205.GI4511@wotan.suse.de>
 <4cb520a0-d3c8-477d-5d05-7b05637f5faf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb520a0-d3c8-477d-5d05-7b05637f5faf@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 03:46:11PM +0200, Hans de Goede wrote:
> On 06-06-18 23:42, Luis R. Rodriguez wrote:
> > On Wed, Jun 06, 2018 at 08:39:15PM +0200, Hans de Goede wrote:
> > > On 05-06-18 23:07, Luis R. Rodriguez wrote:
> > > 2) Should this flag then be checked inside _request_firmware() before it
> > > calls fw_get_efi_embedded_fw() (which may be an empty stub),
> > 
> > You are the architect behind this call, so its up to you.
> > 
> > To answer this you have to review the other flags and see if other users of the
> > other flags may want your functionality. For instance the Android folks for
> > instance rely on the FW_OPT_NOFALLBACK - the sysfs fallback mechanism to
> > account for odd partition layouts. Could they ever want to use your fallback
> > mechanism? Granted your mechanism is for x86, but they could eventually add
> > support for it on ARM.
> > 
> > Checking if the firmware is on the EFI platform firmware list is much faster
> > than the fallback mechanism, that would be one gain for them, as such it may
> > make sense to check for firmware_request_platform() before using the sysfs
> > fallback mechanism.  However if Android folks want to always override the
> > platform firmware with the sysfs fallback interface we'd need another flag
> > added and call to then change the order later if we checked for for the
> > platform firmware first.
> 
> I believe we agreed a while back that the platform fallback would
> replace the sysfs one when requested. I believe that still makes
> sense. If a driver wants both it can simply call request_firmware_foo
> itself twice and determine the order itself.

Fine by me, so in your case the syfs fallback will be ignored.

Which gets me thinking that perhaps we should have a separate
syfs fallback call. There are only two drivers that use it
explicitly:

  o CONFIG_LEDS_LP55XX_COMMON
	request_firmware_nowait(THIS_MODULE, false, ...);
  o CONFIG_DELL_RBU
	request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG, ...)

And FW_ACTION_NOHOTPLUG is 0.

The above revelation of the async call being data driven is a good
opportunity to break that tradition to the more preferred functional
one. And so we'd also get rid of the FW_ACTION_NOHOTPLUG option
all together.

So a new firmware_request_sysfs_async() I suppose.

  Luis
