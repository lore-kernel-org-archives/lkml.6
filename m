Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4608C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E5520879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeLKSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:05:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbeLKSF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:05:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D6663082204;
        Tue, 11 Dec 2018 18:05:26 +0000 (UTC)
Received: from treble (ovpn-122-18.rdu2.redhat.com [10.10.122.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 645785DAA0;
        Tue, 11 Dec 2018 18:05:23 +0000 (UTC)
Date:   Tue, 11 Dec 2018 12:05:21 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 0/4] Static calls
Message-ID: <20181211180521.ljdvnnztjnvoijge@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 11 Dec 2018 18:05:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:06:32PM +0000, Edward Cree wrote:
> Sorry if this has been pointed out before (it's a very long thread), but
>  in the out-of-line implementation, it appears that static_call_update()
>  never alters key->func.  Am I right in thinking that this should be
>  fixed by adding 'WRITE_ONCE(key->func, func);' just after the call to
>  arch_static_call_transform() on line 159 of include/linux/static_call.h?

Yes, you're right about both bugs in the out-of-line case: key->func
needs to be written, and __static_call_update() needs to be called by
static_call_update.  I was so focused on getting the inline case working
that I overlooked those.

> Some background (why does key->func matter for the
>  CONFIG_HAVE_STATIC_CALL_OUTLINE case?): I am experimenting with
>  combining these static calls with the 'indirect call wrappers' notion
>  that Paolo Abeni has been working on [1], using runtime instrumentation
>  to determine a list of potential callees.  (This allows us to cope with
>  cases where the callees are in modules, or where different workloads may
>  use different sets of callees for a given call site, neither of which is
>  handled by Paolo's approach).
> The core of my design looks something like:
> 
> static int dynamic_call_xyz(int (*func)(some_args), some_args)
> {
> 	if (func == dynamic_call_xyz_1.func)
> 		return static_call(dynamic_call_xyz_1, some_args);
> 	if (func == dynamic_call_xyz_2.func)
> 		return static_call(dynamic_call_xyz_2, some_args);
> 	return (*func)(some_args);
> }
> 
> albeit with a bunch of extra (and currently rather ugly) stuff to collect
>  the statistics needed to decide what to put in the static call keys, and
>  mechanisms (RCU in my current case) to ensure that the static call isn't
>  changed between checking its .func and actually calling it.
> 
> -Ed
> 
> PS: not on list, please keep me in CC.
> 
> [1] https://lwn.net/Articles/773985/

Thanks, this sounds very interesting.  Adding Nadav to CC, as he has
been looking at a different approach to solving the same problem:

  https://lkml.kernel.org/r/20181018005420.82993-1-namit@vmware.com

-- 
Josh
