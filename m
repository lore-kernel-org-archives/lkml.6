Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40001C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0966C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0966C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeLEK10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:27:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:48784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeLEK10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB560AF17;
        Wed,  5 Dec 2018 10:27:24 +0000 (UTC)
Date:   Wed, 5 Dec 2018 11:27:22 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 10/11] livepatch: Remove ordering and refuse loading
 conflicting patches
In-Reply-To: <20181129094431.7801-11-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812051126550.31935@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-11-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Petr Mladek wrote:

> The atomic replace and cumulative patches were introduced as a more secure
> way to handle dependent patches. They simplify the logic:
> 
>   + Any new cumulative patch is supposed to take over shadow variables
>     and changes made by callbacks from previous livepatches.
> 
>   + All replaced patches are discarded and the modules can be unloaded.
>     As a result, there is only one scenario when a cumulative livepatch
>     gets disabled.
> 
> The different handling of "normal" and cumulative patches might cause
> confusion. It would make sense to keep only one mode. On the other hand,
> it would be rude to enforce using the cumulative livepatches even for
> trivial and independent (hot) fixes.
> 
> This patch removes the stack of patches. The list of enabled patches
> is still needed but the ordering is not longer enforced.
> 
> Note that it is not possible to catch all possible dependencies. It is
> the responsibility of the livepatch authors to decide.
> 
> Nevertheless this patch prevents having two patches for the same function
> enabled at the same time after the transition finishes. It might help
> to catch obvious mistakes. But more importantly, we do not need to
> handle situation when a patch in the middle of the function stack
> (ops->func_stack) is being removed.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
