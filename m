Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBSLyp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:54:45 -0500
Received: from foss.arm.com ([217.140.101.70]:58070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbeBSLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:54:44 -0500
Date: Mon, 19 Feb 2018 11:54:53 +0000
From: Will Deacon <will.deacon@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] nospec: Move array_index_nospec parameter checking into
 separate macro
Message-ID: <20180219115452.GC30394@arm.com>
References: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
 <CAMuHMdU=DybUCyL3S11Uij1sHSoyBoeR3KXZz2A__kvgqVQmQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU=DybUCyL3S11Uij1sHSoyBoeR3KXZz2A__kvgqVQmQA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Feb 19, 2018 at 12:47:08PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2018 at 3:16 PM, Will Deacon <will.deacon@arm.com> wrote:
> > For architectures providing their own implementation of
> > array_index_mask_nospec in asm/barrier.h, attempting to use WARN_ONCE to
> > complain about out-of-range parameters using WARN_ON results in a mess
> > of mutually-dependent include files.
> >
> > Rather than unpick the dependencies, simply have the core code in nospec.h
> > perform the checking for us.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>

[...]

> > @@ -61,7 +67,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
> >  ({                                                                     \
> >         typeof(index) _i = (index);                                     \
> >         typeof(size) _s = (size);                                       \
> > -       unsigned long _mask = array_index_mask_nospec(_i, _s);          \
> > +       unsigned long _mask = array_index_mask_nospec_check(_i, _s);    \
> >                                                                         \
> >         BUILD_BUG_ON(sizeof(_i) > sizeof(long));                        \
> >         BUILD_BUG_ON(sizeof(_s) > sizeof(long));                        \
> 
> This change is commit 8fa80c503b484ddc ("nospec: Move array_index_nospec()
> parameter checking into separate macro") in v4.16-rc2, and triggers the
> following warning with gcc-4.1.2:
> 
>     net/wireless/nl80211.c: In function ‘parse_txq_params’:
>     net/wireless/nl80211.c:2099: warning: comparison is always false
> due to limited range of data type
> 
> Reverting the commit gets rid of the warning.

This is all getting ripped out, so stay tuned. The check is bogus, generates
crappy code and I did a poor job at macro-ising it. Apart from that, it's
great.

https://git.kernel.org/tip/1d91c1d2c80cb70e2e553845e278b87a960c04da

Will
