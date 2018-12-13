Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C7BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A019020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A019020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeLMUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:50:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLMUuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:50:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED861A4023;
        Thu, 13 Dec 2018 20:50:04 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74AB6104C529;
        Thu, 13 Dec 2018 20:50:00 +0000 (UTC)
Date:   Thu, 13 Dec 2018 14:49:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <der.herr@hofr.at>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 V2] livepatch: handle kzalloc failure properly
Message-ID: <20181213204958.tkapx6qi7fnm5t6h@treble>
References: <1544709956-16701-1-git-send-email-hofrat@osadl.org>
 <1544709956-16701-2-git-send-email-hofrat@osadl.org>
 <daf5bf66-3bcc-476c-6237-0e46028cb269@redhat.com>
 <20181213153954.GA9816@osadl.at>
 <2d712c92-e661-a32c-06cf-4de93ad93f77@redhat.com>
 <20181213185126.GA24202@osadl.at>
 <7aa8369b-0e64-ecf4-79a1-986c6ffeb59b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aa8369b-0e64-ecf4-79a1-986c6ffeb59b@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 13 Dec 2018 20:50:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:39:20PM -0500, Joe Lawrence wrote:
> Ahh, I understand the question now.  Yeah, by making those routines local 
> static, the compiler applied optimizations that renamed the symbols:
> 
>   noinline static
>   % readelf --syms samples/livepatch/livepatch-shadow-mod.o | grep dummy_                                          
>        5: 0000000000000000    20 FUNC    LOCAL  DEFAULT    1 dummy_check.isra.0
>        7: 0000000000000020    52 FUNC    LOCAL  DEFAULT    1 dummy_free.constprop.1
>       12: 00000000000000c0    32 OBJECT  LOCAL  DEFAULT    3 dummy_list_mutex
>       13: 00000000000000e0    16 OBJECT  LOCAL  DEFAULT    3 dummy_list
>       15: 0000000000000160   115 FUNC    LOCAL  DEFAULT    1 dummy_alloc
> 
> 
> I can avoid that optimization (and successfully load all the modules) 
> by using either:
> 
>   __attribute__((optimize("O0"))) noinline static
>   % readelf --syms samples/livepatch/livepatch-shadow-mod.o | grep dummy_
>        6: 0000000000000000  6016 FUNC    LOCAL  DEFAULT    1 dummy_alloc
>       11: 00000000000000c0    32 OBJECT  LOCAL  DEFAULT    3 dummy_list_mutex
>       12: 00000000000000e0    16 OBJECT  LOCAL  DEFAULT    3 dummy_list
>       14: 0000000000001810    73 FUNC    LOCAL  DEFAULT    1 dummy_free
>       16: 0000000000001860   108 FUNC    LOCAL  DEFAULT    1 dummy_check
> 
> or:
> 
>   __noclone noinline static
>   % readelf --syms samples/livepatch/livepatch-shadow-mod.o | grep dummy_
>        5: 0000000000000000    22 FUNC    LOCAL  DEFAULT    1 dummy_check
>        7: 0000000000000020    51 FUNC    LOCAL  DEFAULT    1 dummy_free
>       12: 00000000000000c0    32 OBJECT  LOCAL  DEFAULT    3 dummy_list_mutex
>       13: 00000000000000e0    16 OBJECT  LOCAL  DEFAULT    3 dummy_list
>       15: 0000000000000160   115 FUNC    LOCAL  DEFAULT    1 dummy_alloc
> 
> but I'm not sure if either is the definitive way to avoid such
> optimization.  Anyone know for sure?

Yeah, for now I think "static __noclone" is the way to go.  Soon we'll
have a GCC flag which disables such optimizations for all functions.

And the dummy_list* variables can just be "static".

-- 
Josh
