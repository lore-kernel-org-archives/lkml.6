Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A888C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA92D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA92D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeLMXHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeLMXHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E096531256A8;
        Thu, 13 Dec 2018 23:06:59 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5507D26355;
        Thu, 13 Dec 2018 23:06:55 +0000 (UTC)
Date:   Thu, 13 Dec 2018 17:06:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 10/11] livepatch: Remove ordering and refuse loading
 conflicting patches
Message-ID: <20181213230652.e2vn27qvqhumtaog@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-11-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-11-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Dec 2018 23:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:30AM +0100, Petr Mladek wrote:
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

I'm not sure about this patch.  I like the removal of the stacking.  But
do we really want to enforce no dependencies between non-cumulative
patches?  It can be done correctly if the user is careful.

Maybe we should just let users do it if they want to.  And then that
also would mean less code for us to maintain.

And as usual, I apologize if I'm either contradicting or repeating past
versions of myself. :-)

-- 
Josh
