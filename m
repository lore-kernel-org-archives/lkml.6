Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B95208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B95208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbeKOBVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:21:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:43644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732367AbeKOBVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:21:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E09BAAD18;
        Wed, 14 Nov 2018 15:17:37 +0000 (UTC)
Date:   Wed, 14 Nov 2018 16:17:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-ID: <20181114151737.GA23419@dhcp22.suse.cz>
References: <20181113151629.14826-1-urezki@gmail.com>
 <20181113151629.14826-2-urezki@gmail.com>
 <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-11-18 14:10:46, Andrew Morton wrote:
[...]
> > +static int vmalloc_test_init(void)
> > +{
> > +	__my_vmalloc_node_range =
> > +		(void *) kallsyms_lookup_name("__vmalloc_node_range");
> > +
> > +	if (__my_vmalloc_node_range)
> > +		do_concurrent_test();
> > +
> > +	return -EAGAIN; /* Fail will directly unload the module */
> > +}
> 
> It's unclear why this module needs access to the internal
> __vmalloc_node_range().  Please fully explain this in the changelog.
> 
> Then, let's just export the thing.  (I expect this module needs a
> Kconfig dependency on CONFIG_KALLSYMS, btw).  A suitable way of doing
> that would be
> 
> /* Exported for lib/test_vmalloc.c.  Please do not use elsewhere */
> EXPORT_SYMBOL_GPL(__vmalloc_node_range);

There was a previous discussion that testing for internal infrastructure
is useful quite often and such a testing module needs an access to such
an internal infrastructure. Exporting those symbols via standard
EXPORT_SYMBOL_GPL is far from optimal because we can be pretty much sure
an abuse will arise sooner than later. I was proposing
EXPORT_SYMBOL_SELFTEST that would link only against testing modules.

If that is not viable for some reason then kallsyms_lookup_name is a
dirty-but-usable workaround.
-- 
Michal Hocko
SUSE Labs
