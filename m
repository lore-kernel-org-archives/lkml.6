Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89FA20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfA3XD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48382 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfA3XDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:03:22 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goxu4-0006Z1-1W; Wed, 30 Jan 2019 23:00:16 +0100
Date:   Wed, 30 Jan 2019 23:00:15 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Cox <alan@llwyncelyn.cymru>
cc:     Rusty Russell <rusty@rustcorp.com.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
In-Reply-To: <20190130204544.1b50027d@alans-desktop>
Message-ID: <alpine.DEB.2.21.1901302248430.8200@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de> <875zu620yn.fsf@rustcorp.com.au> <20190130204544.1b50027d@alans-desktop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Alan Cox wrote:
> On Wed, 30 Jan 2019 15:31:20 +1030
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > Thanks taking on such a thankless task Thomas,
> > 
> > Might have been overzealous in assuming a verionless GPL string meant
> > "or later" (I'm happy for that for my own code, FWIW).  My memory is
> > fuzzy, but I don't think anyone cared at the time.
> 
> Versionless always meant 'or later' outside of the tags. It's the default
> version of the licence. (Whether v2 only has any meaning beyond intent is
> another debate that I guess some year a lawyer will have to figure out).
> 
> I think the description change makes sense given the ambiguity and the
> fact we now have SPDX headers. (IANAL etc)
> 
> > >  2) The dual licensed strings became ill defined as well because following
> > >     the "GPL" vs. "GPL v2" distinction all dual licensed (or additional
> 
> The dual ones were IMHO a mistake. They should just have used GPL and
> additional rights. Either you have GPL rights (and it's ok to use in the
> kernel) or you don't (and it's proprietary and the rest is down to
> derivative works).
> 
> We don't actually care whether its dual licensed BSD, or whether it
> merely grants you an additional right to cheap pizza.

Actually for the purpose of module loading the only relevant information is
whether there are GPL rights or not. Whether there are additional rights is
irrelevant for the binary blob. That only matters vs. the source code
itself.

> > > As of 5.0-rc2 2873 out of 9200 instances of MODULE_LICENSE() strings are
> > > conflicting with the actual license in the source code (either SPDX or
> > > license boilerplate/reference). A comparison between the scan of the
> 
> The SPDX tag isn't correctly capable of expressing the licence anyway. If
> you have functions in a file and two of them are GPL v2+ and someone
> added a GPLv2 only one and updated the header there isn't a valid SPDX tag
> for it because I can still use the GPLv2+ bits with GPLv3.
 >
> This is nothing new - the headers on the files provided no more data on
> that and took up lots more space 8) We've simply never tracked licence
> data by line.

Correct, there are files which have both a v2 only and a v2 or later
boilerplate and there is no way to figure out what that actually means for
the affected source file.

I found a recent patch adding the v2 or later boilerplate right next to the
v2 only and the patch content is mostly fiddling with the existing code.

Most people simply do not care and I'd say most do not understand what
licensing means in the first place. But at the same time a lot of people do
not care at all what they are doing.

Thanks,

	tglx





