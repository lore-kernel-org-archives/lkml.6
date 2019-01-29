Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7DCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC420882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CdwiNsJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfA2TqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:46:21 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:40010 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbfA2TqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548791179;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=I1UMXyrSr5C9Wun+bynXFwq9gdNq5eFAuCB5rD45GeY=;
        b=CdwiNsJ2r657gEyE3VWjT8bFrQoX+MIgKoI/inh4198n5xeIYCQIneLveQFCdnky
        czEodJ8+dXQfx098odBEhCc/i/zaImbuMRrakHEu832HISxBrmWPOvqOHzS/BOoWkbv
        om5p9VV4VQadUGmLIRFmfi5sv6EyVmOl654odqWk=
Date:   Tue, 29 Jan 2019 19:46:19 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Miles Chen <miles.chen@mediatek.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] mm/slub: introduce SLAB_WARN_ON_ERROR
In-Reply-To: <1548748424.18511.34.camel@mtkswgap22>
Message-ID: <010001689b25e696-3caebea9-56c2-46eb-bb49-34e504a123ee-000000@email.amazonses.com>
References: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com> <20190128122954.949c2e6699d6e5ef060a325c@linux-foundation.org> <0100016898251824-359bbfae-e32b-43a6-8c58-8811a7b24520-000000@email.amazonses.com> <1548748424.18511.34.camel@mtkswgap22>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.29-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Miles Chen wrote:

> a) classic slub issue. e.g., use-after-free, redzone overwritten. It's
> more efficient to report a issue as soon as slub detects it. (comparing
> to monitor the log, set a breakpoint, and re-produce the issue). With
> the coredump file, we can analyze the issue.

What usually happens is that the systems fails with a strange error
message. Then the system is rebooted using slub_debug options and the
issue is reproduced yielding more information about the problem.

Then you run the scenario again with additional debugging in the subsystem
that caused the problem.

So you are already reproducing the issue because you need to activate
debugging to get more information. Doing it for the 3rd time is not that
much more difficult.

None of your modifications will be active in a production kernel.
slub_debug must be activated to use it and thus you are already
reproducing the issue.

> b) memory corruption issues caused by h/w write. e.g., memory
> overwritten by a DMA engine. Memory corruptions may or may not related
> to the slab cache that reports any error. For example: kmalloc-256 or
> dentry may report the same errors. If we can preserve the the coredump
> file without any restore/reset processing in slub, we could have more
> information of this memory corruption.

If debugging is active then reporting will include the accurate slab cache
affected. The memory layout is already changing when you enable the
existing debugging code. None of your code runs without that and thus is
cannot add a coredump for the prod case without debugging.

> c) memory corruption issues caused by unstable h/w. e.g., bit flipping
> because of xxxx DRAM die or applying new power settings. It's hard to
> re-produce this kind of issue and it much easier to tell this kind of
> issue in the coredump file without any restore/reset processing.

But then you patch does not help in this situation because the code has to
be enabled by special  slub debug options.


> Users can set the option by slub_debug. We can still have the original
> behavior(keep the system alive) if the option is not set. We can turn on
> the option when we need the coredump file. (with panic_on_warn is set,
> of course).

I think we would need to turn on debugging by default and have your patch
for this to make sense. We already reproducing the issue multiple times
for debugging. This patch does not change that.


