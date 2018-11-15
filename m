Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7216A223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7216A223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbeKOXFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:59456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeKOXFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:05:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51E6DADC9;
        Thu, 15 Nov 2018 12:57:51 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:57:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-ID: <20181115125750.GS23831@dhcp22.suse.cz>
References: <20181113151629.14826-1-urezki@gmail.com>
 <20181113151629.14826-2-urezki@gmail.com>
 <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
 <20181114151737.GA23419@dhcp22.suse.cz>
 <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
 <20181115083957.GE23831@dhcp22.suse.cz>
 <20181115084642.GB19286@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115084642.GB19286@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 00:46:42, Matthew Wilcox wrote:
> On Thu, Nov 15, 2018 at 09:39:57AM +0100, Michal Hocko wrote:
> > On Wed 14-11-18 15:00:53, Andrew Morton wrote:
> > > #define EXPORT_SYMBOL_SELFTEST EXPORT_SYMBOL_GPL
> > >
> > > then write a script which checks the tree for usages of the
> > > thus-tagged symbols outside tools/testing and lib/ (?)
> > 
> > and then yell at people? We can try it out of course. The namespace
> > would be quite clear and we could document the supported usage pattern.
> > We also want to make EXPORT_SYMBOL_SELFTEST conditional. EXPORTs are not
> > free and we do not want to add them if the whole testing infrastructure
> > is disabled (assuming there is a global one for that).
> 
> How about adding
> 
> #ifdef CONFIG_VMALLOC_TEST
> int run_internal_vmalloc_tests(void)
> {
> ...
> }
> EXPORT_SYMBOL_GPL(run_internal_vmalloc_tests);
> #endif
> 
> to vmalloc.c?  That would also allow calling functions which are marked
> as static, not just functions which aren't exported to modules.

Yes that would be easier but do we want to pollute the normal code with
testing? This looks messy to me.

-- 
Michal Hocko
SUSE Labs
