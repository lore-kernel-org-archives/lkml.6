Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F71C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A62216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZP1mrXp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A62216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeI0WKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:10:11 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:33962 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbeI0WKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538063477;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=hR2a9hgOe1QRCBus72KewrkyO1ERzF2MY5w6erYJanI=;
        b=ZP1mrXp5JEPwUxETfj9h3dBxx1e7WhHDKgFW2llgwGdIkY4L6Voce8W8rHN5rSTm
        7Vm+NlKswP6jmvUsQOm6mv1SOZ6ZFlVeFdiG5tmk6FH8mRwNKdvxd3mvouOJVue6/fH
        ODJ2d0DTWtYORLkUbSiXG1icl1KsF8yOPSuFu6Xg=
Date:   Thu, 27 Sep 2018 15:51:17 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@gmail.com>
cc:     penberg@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn about large allocations for slab
In-Reply-To: <20180927130707.151239-1-dvyukov@gmail.com>
Message-ID: <010001661bba2bbc-a5074e00-2009-414a-be8c-05c58545c7ec-000000@email.amazonses.com>
References: <20180927130707.151239-1-dvyukov@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.27-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Dmitry Vyukov wrote:

> From: Dmitry Vyukov <dvyukov@google.com>
>
> This warning does not seem to be useful. Most of the time it fires when
> allocation size depends on syscall arguments. We could add __GFP_NOWARN
> to these allocation sites, but having a warning only to suppress it
> does not make lots of sense. Moreover, this warnings never fires for
> constant-size allocations and never for slub, because there are
> additional checks and fallback to kmalloc_large() for large allocations
> and kmalloc_large() does not warn. So the warning only fires for
> non-constant allocations and only with slab, which is odd to begin with.
> The warning leads to episodic unuseful syzbot reports. Remote it.

/Remove/

If its only for slab then KMALLOC_MAX_CACHE_SIZE and KMALLOC_MAX_SIZE are
the same value.

> While we are here also fix the check. We should check against
> KMALLOC_MAX_CACHE_SIZE rather than KMALLOC_MAX_SIZE. It all kinda
> worked because for slab the constants are the same, and slub always
> checks the size against KMALLOC_MAX_CACHE_SIZE before kmalloc_slab().
> But if we get there with size > KMALLOC_MAX_CACHE_SIZE anyhow
> bad things will happen.

Then the WARN_ON is correct just change the constant used. Ensure that
SLAB does the same checks as SLUB.

