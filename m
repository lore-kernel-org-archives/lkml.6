Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F68A2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F68A2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbeKMCfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:35:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728018AbeKMCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:35:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53D5BB174;
        Mon, 12 Nov 2018 16:41:46 +0000 (UTC)
Message-ID: <1542040904.2661.35.camel@suse.de>
Subject: Re: Performance regression in ast drm driver
From:   Jean Delvare <jdelvare@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     David Airlie <airlied@redhat.com>, christian.koenig@amd.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Nov 2018 17:41:44 +0100
In-Reply-To: <s5hh8gmfj7a.wl-tiwai@suse.de>
References: <20181101162707.598c1718@endymion>
         <20181108130509.3b2d42ff@endymion>
         <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
         <1542033367.2661.33.camel@suse.de> <s5hh8gmfj7a.wl-tiwai@suse.de>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 15:45 +0100, Takashi Iwai wrote:
> On Mon, 12 Nov 2018 15:36:07 +0100,
> Jean Delvare wrote:
> > Takashi asked me to compare the contents of
> > /sys/kernel/debug/x86/pat_memtype_list before and after the commit
> > above. Before the commit, we have:
> > 
> > uncached-minus @ 0xfafe0000-0xfb000000
> > uncached-minus @ 0xfb000000-0xfb005000
> > write-combining @ 0xfb005000-0xfb584000
> > 
> > After the commit, we have:
> > 
> > uncached-minus @ 0xfafe0000-0xfb000000
> > uncached-minus @ 0xfb000000-0xfb005000
> > uncached-minus @ 0xfb000000-0xfb800000
> > uncached-minus @ 0xfb005000-0xfb584000
> 
> Just to be sure:
> could you double-check whether you're checking the right order
> (i.e. not checking against the revert)?  The change above looks
> illogical from what I can see from the commit...

Yes, I double checked and can only confirm what I wrote above. However
while checking I noticed another strange thing: the contents of
pat_memtype_list depend on whether I'm reading the file from an xterm
or from the text console (Ctrl+Alt+F2). So I summarize again:

Commit "drm/drivers: add support for using the arch wc mapping API"
APPLIED, reading pat_memtype_list from the text console:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000
uncached-minus @ 0xfb000000-0xfb800000
uncached-minus @ 0xfb005000-0xfb584000

Commit "drm/drivers: add support for using the arch wc mapping API"
APPLIED, reading pat_memtype_list from an xterm:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000
uncached-minus @ 0xfb000000-0xfb800000

Commit "drm/drivers: add support for using the arch wc mapping API"
REVERTED, reading pat_memtype_list from the text console:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000
write-combining @ 0xfb005000-0xfb584000

Commit "drm/drivers: add support for using the arch wc mapping API"
REVERTED, reading pat_memtype_list from an xterm:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000

If you don't find it logical, remember that if things were the way they
are supposed to be, customers and myself would not be reporting this
bug ;-)

-- 
Jean Delvare
SUSE L3 Support
