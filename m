Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378BC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA092148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfBBBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfBBBNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:13:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 521F57F771;
        Sat,  2 Feb 2019 01:13:47 +0000 (UTC)
Received: from sky.random (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2486460C62;
        Sat,  2 Feb 2019 01:13:41 +0000 (UTC)
Date:   Fri, 1 Feb 2019 20:13:40 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] mm/mmu_notifier: use unsigned for event field in
 range struct
Message-ID: <20190202011340.GD12463@redhat.com>
References: <20190131183706.20980-1-jglisse@redhat.com>
 <20190131183706.20980-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131183706.20980-3-jglisse@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 02 Feb 2019 01:13:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:37:04PM -0500, Jerome Glisse wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Use unsigned for event field in range struct so that we can also set
> flags with the event. This patch change the field and introduce the
> helper.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>  include/linux/mmu_notifier.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index be873c431886..d7a35975c2bd 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -6,6 +6,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
>  #include <linux/srcu.h>
> +#include <linux/log2.h>
>  
>  struct mmu_notifier;
>  struct mmu_notifier_ops;
> @@ -38,8 +39,11 @@ enum mmu_notifier_event {
>  	MMU_NOTIFY_PROTECTION_VMA,
>  	MMU_NOTIFY_PROTECTION_PAGE,
>  	MMU_NOTIFY_SOFT_DIRTY,
> +	MMU_NOTIFY_EVENT_MAX
>  };
>  
> +#define MMU_NOTIFIER_EVENT_BITS order_base_2(MMU_NOTIFY_EVENT_MAX)
> +
>  #ifdef CONFIG_MMU_NOTIFIER
>  
>  /*
> @@ -60,7 +64,7 @@ struct mmu_notifier_range {
>  	struct mm_struct *mm;
>  	unsigned long start;
>  	unsigned long end;
> -	enum mmu_notifier_event event;
> +	unsigned event;
>  	bool blockable;
>  };

This is only allocated in the stack, so saving RAM by mixing bitfields
with enum in the same 4 bytes to save 4 bytes isn't of maximum
priority.

A possibly cleaner way to save those 4 bytes without mixing enum with
bitfields by hand, is to add a "unsigned short flags" which will make
"event/flags/blockable" fit in the same 8 bytes (bool only needs 1
byte) as before the patch (the first bitfield can start from 0 then).

Yet another way is to drop blockable and convert it to a flag in
"unsigned int flags".
