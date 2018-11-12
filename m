Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021BE224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021BE224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeKMA3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:29:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbeKMA3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 409E4B131;
        Mon, 12 Nov 2018 14:36:10 +0000 (UTC)
Message-ID: <1542033367.2661.33.camel@suse.de>
Subject: Re: Performance regression in ast drm driver
From:   Jean Delvare <jdelvare@suse.de>
To:     David Airlie <airlied@redhat.com>
Cc:     christian.koenig@amd.com, "Iwai, Takashi" <tiwai@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Nov 2018 15:36:07 +0100
In-Reply-To: <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
References: <20181101162707.598c1718@endymion>
         <20181108130509.3b2d42ff@endymion>
         <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 2018-11-09 at 10:04 +1000, David Airlie wrote:
> On Thu, Nov 8, 2018 at 10:05 PM Jean Delvare <jdelvare@suse.de> wrote:
> > 
> > On Thu, 1 Nov 2018 16:27:07 +0100, Jean Delvare wrote:
> > > Hi David,
> > > 
> > > The following commit:
> > > 
> > > commit 7cf321d118a825c1541b43ca45294126fd474efa
> > > Author: Dave Airlie
> > > Date:   Mon Oct 24 15:37:48 2016 +1000
> > > 
> > >     drm/drivers: add support for using the arch wc mapping API.
> > > 
> > > is causing a huge performance regression for the ast drm driver. In a
> > > text console, if I call "cat" on a large text file, it takes almost
> > > twice as much time to be displayed and scrolled completely.
> > > 
> > > Can you please check that the ast driver portion of that commit is both
> > > correct and complete?
> > 
> > And in the meantime, what bad will happen if we just revert the ast
> > portion of that commit?
> 
> This seems likely to be a hw problem with PCI writes to the AST "GPU",
> since it's just some sort of RAM + ARM on the end of a PCIE bus, we've
> definitely seen possible issues in the past with write combining
> around some of the mga GPUs with some CPUs.

Takashi asked me to compare the contents of
/sys/kernel/debug/x86/pat_memtype_list before and after the commit
above. Before the commit, we have:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000
write-combining @ 0xfb005000-0xfb584000

After the commit, we have:

uncached-minus @ 0xfafe0000-0xfb000000
uncached-minus @ 0xfb000000-0xfb005000
uncached-minus @ 0xfb000000-0xfb800000
uncached-minus @ 0xfb005000-0xfb584000

The corresponding lines in /proc/iomem are:

f0000000-fed8ffff : PCI Bus 0000:00
  faf00000-fb7fffff : PCI Bus 0000:01
    fafe0000-faffffff : 0000:01:01.0
    fb000000-fb7fffff : 0000:01:01.0

Does it help? Is the change of type expected? Is it not a problem that
one of the ranges is overlapping with 2 other ranges?

-- 
Jean Delvare
SUSE L3 Support
