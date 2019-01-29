Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F23C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A33620989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KWDKmtCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfA2Fqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:46:35 -0500
Received: from a9-37.smtp-out.amazonses.com ([54.240.9.37]:47034 "EHLO
        a9-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfA2Fqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548740794;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=bB1FCkNUdswjLFqFVeg1iGIzwpsiuISE6MtB5gKVSTY=;
        b=KWDKmtCftgtgM2ZJcqVw4AL9rYmnXIGiC3KihZlVuwymWamuVEOrIzQAWGDPCMyK
        v01J/DJUit96069vJpL7d1G4EeFObs09La7bxos9AZ1B9iRWw9JK3IJFv9xYB6pC//f
        8F7sWarq8ACrydMAfd5INljkzut40byhQoc4/ZPM=
Date:   Tue, 29 Jan 2019 05:46:34 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     miles.chen@mediatek.com, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] mm/slub: introduce SLAB_WARN_ON_ERROR
In-Reply-To: <20190128122954.949c2e6699d6e5ef060a325c@linux-foundation.org>
Message-ID: <0100016898251824-359bbfae-e32b-43a6-8c58-8811a7b24520-000000@email.amazonses.com>
References: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com> <20190128122954.949c2e6699d6e5ef060a325c@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.29-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Andrew Morton wrote:

> > When debugging slab errors in slub.c, sometimes we have to trigger
> > a panic in order to get the coredump file. Add a debug option
> > SLAB_WARN_ON_ERROR to toggle WARN_ON() when the option is set.
> >
> > Change since v1:
> > 1. Add a special debug option SLAB_WARN_ON_ERROR and toggle WARN_ON()
> > if it is set.
> > 2. SLAB_WARN_ON_ERROR can be set by kernel parameter slub_debug.
> >
>
> Hopefully the slab developers will have an opinion on this.

Debugging slab itself is usually done in kvm or some other virtualized
environment. Then gdb can be used to set breakpoints. Otherwise one may
add printks and stuff to the allocators to figure out more or use perf.

What you are changing here is the debugging for data corruption within
objects managed by slub or the metadata. Slub currently outputs extensive
data about the metadata corruption (typically caused by a user of
slab allocation) which should allow you to set a proper
breakpoint not in the allocator but in the subsystem where the corruption
occurs.


