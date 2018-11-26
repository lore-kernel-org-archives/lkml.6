Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C18213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C18213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeK0EQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:16:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbeK0EQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:16:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714CD15AB;
        Mon, 26 Nov 2018 09:21:52 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1163F5AF;
        Mon, 26 Nov 2018 09:21:50 -0800 (PST)
Date:   Mon, 26 Nov 2018 17:21:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, longman@redhat.com,
        yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugobjects: avoid recursive calls with kmemleak
Message-ID: <20181126172148.GI33554@arrakis.emea.arm.com>
References: <20181126165343.2339-1-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165343.2339-1-cai@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:53:43AM -0500, Qian Cai wrote:
> CONFIG_DEBUG_OBJECTS_RCU_HEAD does not play well with kmemleak due to
> recursive calls.
> 
> fill_pool
>   kmemleak_ignore
>     make_black_object
>       put_object
>         __call_rcu (kernel/rcu/tree.c)
>           debug_rcu_head_queue
>             debug_object_activate
>               debug_object_init
>                 fill_pool
>                   kmemleak_ignore
>                     make_black_object
>                       ...
> 
> Hence, adding SLAB_NOLEAKTRACE to kmem_cache_create() to not register a
> newly allocated debug objects at all.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Qian Cai <cai@gmx.us>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
