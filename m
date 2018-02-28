Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeB1Rs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:48:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47379 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932464AbeB1Rsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:48:52 -0500
X-ME-Sender: <xms:hOuWWgTRMAx-SVbS5ssvtfZoyLKiHWO4Xn6gJBWqkQMppGb4Q8QGXg>
Date: Wed, 28 Feb 2018 14:48:48 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] x86/microcode: Synchronize late microcode loading
Message-ID: <20180228174848.cs5jn2y7nzh6pu6u@khazad-dum.debian.net>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-8-bp@alien8.de>
 <20180228135931.uwveegfdv5afozxe@khazad-dum.debian.net>
 <20180228140806.GD3769@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228140806.GD3769@pd.tnic>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Borislav Petkov wrote:
> On Wed, Feb 28, 2018 at 10:59:31AM -0300, Henrique de Moraes Holschuh wrote:
> > Eek! If I read that right, this effectively halts the entire box until
> > every core is updated, with one core entering deep-coma at a time (the
> > rest are left either spinning or cpu_relax()ing
> 
> I think *you* should relax. :)

Well, I don't expect any general-use distro to unleash late loading on
the users, certainly :-)  Least of all, Debian...  It is, nowadays, "use
it only if you know what you're doing" land.

But it is not yet sufficiently documented as such, I fear.

> Late microcode loading on a long running box is not something you do
> more than 2-3 times a year. And if the box needs to restart, it'll get
> the early microcode.

Sure, but the thing is so damn expensive (and the time it takes is
directly proportional to the number of cores, thus likely to hurt worse
exactly those who would want to use it), that I was left wondering if it
should not be optimized further to do the work in parallel (if that can
be made safe enough).

Besides, we likely don't want to have early microcode updates end up
being the reason AP bringup has to be serialized during boot either (and
it *is* likely to dominate the time taken for AP bringup, too!), so it
would be nice to have a way to make parallel microcode updates possible
in general...  but I don't think we're there, yet.

No matter. I am not opposing the patch in the first place.  And any
paralell microcode update work would be best done in an incremental
fashion, on top of working serial updates, anyway.

> And yes, this is addressing *late* loading, if you haven't noticed yet.

I did get that message, yes :)

> So keep doing the early method and you'll be fine.

We need that in the documentation :-P  Microcode updates have always
been somewhat slow, but now they are potentially going to be *much* more
painful and noticeable in the late-update case...

-- 
  Henrique Holschuh
