Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A80C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF90208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF90208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeLEUR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:17:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLEUR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46501C075D6C;
        Wed,  5 Dec 2018 20:17:56 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E61B6910B;
        Wed,  5 Dec 2018 20:17:55 +0000 (UTC)
Date:   Wed, 5 Dec 2018 15:17:54 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
Message-ID: <20181205201754.cvvywqlmxwgcbqzt@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-9-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-9-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 05 Dec 2018 20:17:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:28AM +0100, Petr Mladek wrote:
> Replaced patches are removed from the stack when the transition is
> finished. It means that Nop structures will never be needed again
> and can be removed. Why should we care?
> 
>   + Nop structures make false feeling that the function is patched
                     ^^^^^^^^^^^^^^^^^^
re-wording suggestion: "give the impression"

>     even though the ftrace handler has no effect.
> 
>   + Ftrace handlers are not completely for free. They cause slowdown that
                                         ^^^^^^^^
re-wording suggesions: "free" or "do not come for free"

>     might be visible in some workloads. The ftrace-related slowdown might
>     actually be the reason why the function is not longer patched in
                                                 ^^^^^^^^^^
s/not longer/no longer

>     the new cumulative patch. One would expect that cumulative patch
>     would allow to solve these problems as well.
            ^^^^^^^^^^^^^^
re-wording suggestion: "help solve"

> 
>   + Cumulative patches are supposed to replace any earlier version of
>     the patch. The amount of NOPs depends on which version was replaced.
>     This multiplies the amount of scenarios that might happen.
> 
>     One might say that NOPs are innocent. But there are even optimized
>     NOP instructions for different processor, for example, see
                                     ^^^^^^^^^
s/processor/processors

>     arch/x86/kernel/alternative.c. And klp_ftrace_handler() is much
>     more complicated.
> 
>   + It sounds natural to clean up a mess that is not longer needed.
                                                   ^^^^^^^^^^
s/not longer/no longer

>     It could only be worse if we do not do it.
> 
> This patch allows to unpatch and free the dynamic structures independently
> when the transition finishes.
> 
> The free part is a bit tricky because kobject free callbacks are called
> asynchronously. We could not wait for them easily. Fortunately, we do
> not have to. Any further access can be avoided by removing them from
> the dynamic lists.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
