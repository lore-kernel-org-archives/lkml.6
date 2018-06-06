Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lZwPMgZFGFsWZwAAmS7hNA
	; Wed, 06 Jun 2018 20:33:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B5466608BF; Wed,  6 Jun 2018 20:33:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DB24605BD;
	Wed,  6 Jun 2018 20:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DB24605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932347AbeFFUdI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:33:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeFFUdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:33:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88688AEBF;
        Wed,  6 Jun 2018 20:33:02 +0000 (UTC)
Date: Wed, 6 Jun 2018 22:32:57 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc: Martijn Coenen <maco@android.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Chris Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-arm-msm@vger.kernel.org, mcgrof@kernel.org
Subject: Do Qualcomm drivers use DMA buffers for request_firmware_into_buf()?
Message-ID: <20180606203257.GH4511@wotan.suse.de>
References: <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
 <20180508153805.GC27853@wotan.suse.de>
 <20180601192346.GQ4511@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601192346.GQ4511@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 09:23:46PM +0200, Luis R. Rodriguez wrote:
> On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> > On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > > 
> > > I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> > > cc'd here) are better suited to answer that question.
> > 
> > Andy, David, Bjorn?
> 
> Andy, David, Bjorn?

A month now with no answer...

Perhaps someone who has this hardware can find out empirically for us, as
follows (mm folks is this right?):

page = virt_to_page(address);
if (!page)
   fail closed...
if (page_zone(page) == ZONE_DMA || page_zone(page) == ZONE_DMA32)
	this is a DMA buffer
else
	not DMA!

Note that when request_firmware_into_buf() was being reviewed Mimi had asked back
in 2016 [0] that if a DMA buffer was going to be used READING_FIRMWARE_DMA should be
used otherwise READING_FIRMWARE_PREALLOC_BUFFER was fine.

If it is a DMA buffer *now*, why / how did this change?

[0] https://patchwork.kernel.org/patch/9074611/

  Luis
