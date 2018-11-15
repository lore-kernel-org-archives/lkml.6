Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE12C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB4220858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeKPHHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:07:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:07:21 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7983CB43;
        Thu, 15 Nov 2018 20:57:54 +0000 (UTC)
Date:   Thu, 15 Nov 2018 12:57:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-Id: <20181115125753.278720db11306755265c42ae@linux-foundation.org>
In-Reply-To: <20181115134706.GC19286@bombadil.infradead.org>
References: <20181113151629.14826-1-urezki@gmail.com>
        <20181113151629.14826-2-urezki@gmail.com>
        <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
        <20181114151737.GA23419@dhcp22.suse.cz>
        <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
        <20181115083957.GE23831@dhcp22.suse.cz>
        <20181115084642.GB19286@bombadil.infradead.org>
        <20181115125750.GS23831@dhcp22.suse.cz>
        <20181115134706.GC19286@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 05:47:06 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Nov 15, 2018 at 01:57:50PM +0100, Michal Hocko wrote:
> > On Thu 15-11-18 00:46:42, Matthew Wilcox wrote:
> > > How about adding
> > > 
> > > #ifdef CONFIG_VMALLOC_TEST
> > > int run_internal_vmalloc_tests(void)
> > > {
> > > ...
> > > }
> > > EXPORT_SYMBOL_GPL(run_internal_vmalloc_tests);
> > > #endif
> > > 
> > > to vmalloc.c?  That would also allow calling functions which are marked
> > > as static, not just functions which aren't exported to modules.
> > 
> > Yes that would be easier but do we want to pollute the normal code with
> > testing? This looks messy to me.
> 
> I don't think it's necessarily the worst thing in the world if random
> people browsing the file are forced to read test-cases ;-)
> 
> There's certainly a spectrum of possibilities here, one end being to
> basically just re-export static functions,

Yes, if we're to it this way then a basic

#ifdef CONFIG_VMALLOC_TEST
EXPORT_SYMBOL_GPL(__vmalloc_node_range);
#endif

should suffice.  If the desired symbol was a static one, a little
non-static wrapper would be needed as well.

> and the other end putting
> every vmalloc test into vmalloc.c.  vmalloc.c is pretty big at 70kB, but
> on the other hand, it's the 18th largest file in mm/ (can you believe
> page_alloc.c is 230kB?!)
