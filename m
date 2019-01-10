Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003ED2064C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfAJWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:43:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36665 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAJWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:43:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so15886670qtn.3;
        Thu, 10 Jan 2019 14:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BQxy77aw0o+DSOGQG1SQtIdLEpkaKMICEdNR1LQ13U=;
        b=ggAj9vAT5WGEP5ApMiqfssHwl/dQskyj+bcfmb5AyWMfmpvJhfuFkqioSyolrYc9TU
         gdqt7zFs0kD7jWxdbKppu/0pTxAnUVImUs9iDyCzknRrP0AxBYXc8kRInflA9zy3Z112
         n1RP5F6pfwIDXh8n6ynSWC2mfGIkmy1/VHY59K7VDtLF5sFZObhPjYCa0CMcf2+AHn1V
         seXaixTmWE9NNv/IoaBeB8HOdGWPDjAZxpPNAXP+SxI6f7273l4H5iOnrX4it1yGlaLP
         ePVKxfucr2q4R0G3eUaOKDsmmEVPfsN6l6nisqAL+C8UaK0YtdyhCfY649wdgbhxpvo+
         3IvQ==
X-Gm-Message-State: AJcUukdn5OtGQutjgGpwace7l1KpMatpHL+YqL6bOMj3FlnWQ18sYvDT
        GE9Q7M3RoUIJBOMwPbHumEHwkDQpDSjeJCDd+RQArg==
X-Google-Smtp-Source: ALg8bN6HaEyY/0zx6RGqFtKtlSPz+RZx+KrllRYiKjcCjzeA51uZ4VQUxl3HD7ARydoqD46n7kKW7Dhkol5Ir927zA4=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr10538686qkf.107.1547160230039;
 Thu, 10 Jan 2019 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com> <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
In-Reply-To: <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Jan 2019 23:43:32 +0100
Message-ID: <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for y2038
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > The system call tables have diverged a bit over the years, and a number
> > > > of the recent additions never made it into all architectures, for one
> > > > reason or another.
> > > >
> > > > This is an attempt to clean it up as far as we can without breaking
> > > > compatibility, doing a number of steps:
> > >
> > > Thanks a lot!
> > >
> > > > - Add system calls that have not yet been integrated into all
> > > >   architectures but that we definitely want there.
> > >
> > > It looks like you missed wiring up io_pgetevents() on m68k.
> > > Is that intentional?
> >
> > Yes, I thought I had described that somewhere but maybe I
> > forgot: semtimedop() and io_pgetevents() get replaced with
> > time64 versions in the follow-up, so I only added them in
> > 64-bit architectures. If you think we should have both
> > io_pgetevents() and io_pgetevents_time32() on all 32-bit
> > architectures, I can add that as well.
>
> Thanks, sounds fine to me.

Just to be sure, you mean it's fine to not add it, not that we should
add it?

     Arnd
