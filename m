Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D71C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB24221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfAVPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729648AbfAVPWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32428B04E;
        Tue, 22 Jan 2019 15:22:45 +0000 (UTC)
Date:   Tue, 22 Jan 2019 07:22:38 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 6/7] perf hist: Use cached rbtrees
Message-ID: <20190122152238.rbm6pxg7muasa5mv@linux-r8p5>
References: <20181206191819.30182-1-dave@stgolabs.net>
 <20181206191819.30182-7-dave@stgolabs.net>
 <20190122135901.GE14973@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190122135901.GE14973@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Arnaldo Carvalho de Melo wrote:

>Em Thu, Dec 06, 2018 at 11:18:18AM -0800, Davidlohr Bueso escreveu:
>> At the cost of an extra pointer, we can avoid the O(logN) cost
>> of finding the first element in the tree (smallest node), which
>> is something heavily required for histograms. Specifically, the
>> following are converted to rb_root_cached, and users accordingly:
>>
>> hist::entries_in_array
>> hist::entries_in
>> hist::entries
>> hist::entries_collapsed
>> hist_entry::hroot_in
>> hist_entry::hroot_out
>
>  CC       /tmp/build/perf/util/hist.o
>ui/browsers/hists.c: In function ???hierarchy_set_folding???:
>ui/browsers/hists.c:511:21: error: passing argument 1 of ???rb_first??? from incompatible pointer type [-Werror=incompatible-pointer-types]
>  for (nd = rb_first(&he->hroot_out); nd; nd = rb_next(nd)) {
>                     ^~~~~~~~~~~~~~
>In file included from ui/browsers/hists.c:8:
>/home/acme/git/perf/tools/include/linux/rbtree.h:83:24: note: expected ???const struct rb_root *??? but argument is of type ???struct rb_root_cached *???
> extern struct rb_node *rb_first(const struct rb_root *);
>                        ^~~~~~~~
>ui/browsers/hists.c: In function ???__hist_browser__set_folding???:
>ui/browsers/hists.c:569:16: error: passing argument 1 of ???rb_first??? from incompatible pointer type [-Werror=incompatible-pointer-types]
>  nd = rb_first(&browser->hists->entries);
>                ^~~~~~~~~~~~~~~~~~~~~~~~
>
>So I added this on top, please check:

Looks good thanks (sorry I thought I had tested all this -- even ran perf
several times :/)

Thanks,
Davidlohr
