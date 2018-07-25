Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeGYO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:56:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbeGYO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:56:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C0C915A2;
        Wed, 25 Jul 2018 06:44:18 -0700 (PDT)
Received: from [10.4.12.117] (e107460-lin.Emea.Arm.com [10.4.12.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 514A23F6A8;
        Wed, 25 Jul 2018 06:44:12 -0700 (PDT)
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
From:   "Vincenzo Frascino@Foss" <vincenzo.frascino@arm.com>
Message-ID: <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
Date:   Wed, 25 Jul 2018 14:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 02:15 PM, Andrey Konovalov wrote:

> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
>   
>   void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
>   {
> -	return kasan_kmalloc(cache, object, cache->object_size, flags);
> +	object = kasan_kmalloc(cache, object, cache->object_size, flags);
> +	if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
> +		/*
> +		 * Cache constructor might use object's pointer value to
> +		 * initialize some of its fields.
> +		 */
> +		cache->ctor(object);
>
This seams breaking the kmem_cache_create() contract: "The @ctor is run 
when new pages are allocated by the cache." 
(https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)

Since there might be preexisting code relying on it, this could lead to 
global side effects. Did you verify that this is not the case?

Another concern is performance related if we consider this solution 
suitable for "near-production", since with the current implementation 
you call the ctor (where present) on an object multiple times and this 
ends up memsetting and repopulating the memory every time (i.e. inode.c: 
inode_init_once). Do you know what is the performance impact?

-- 
Regards,
Vincenzo

