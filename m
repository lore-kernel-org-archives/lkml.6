Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15CD20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBEVRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:17:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEVRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:17:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FC1B89AC5;
        Tue,  5 Feb 2019 21:17:15 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4C31054FC9;
        Tue,  5 Feb 2019 21:17:14 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] livepatch: Proper error handling in the shadow
 variables selftest
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204135653.31406-1-pmladek@suse.com>
 <20190204135653.31406-4-pmladek@suse.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <6c313c97-fd7b-8ab6-446f-6dac4c34a30c@redhat.com>
Date:   Tue, 5 Feb 2019 16:17:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204135653.31406-4-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 05 Feb 2019 21:17:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 8:56 AM, Petr Mladek wrote:
> Add proper error handling when allocating or getting shadow variables
> in the selftest. It prevents an invalid pointer access in some situations.
> It shows the good programming practice in the others.
> 
> The error codes are just the best guess and specific for this particular
> test. In general, klp_shadow_alloc() returns NULL also when the given
> shadow variable has already been allocated. In addition, both
> klp_shadow_alloc() and klp_shadow_get_or_alloc() might fail from
> other reasons when the constructor fails.
> 
> Note, that the error code is not really important even in the real life.
> The use of shadow variables should be transparent for the original
> livepatched code.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>   lib/livepatch/test_klp_shadow_vars.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> index f5441c193166..fe5c413efe96 100644
> --- a/lib/livepatch/test_klp_shadow_vars.c
> +++ b/lib/livepatch/test_klp_shadow_vars.c
> @@ -154,22 +154,37 @@ static int test_klp_shadow_vars_init(void)
>   	 * Allocate a few shadow variables with different <obj> and <id>.
>   	 */
>   	sv1 = shadow_alloc(obj, id, size, gfp_flags, shadow_ctor, &var1);
> +	if (!sv1)
> +		return -ENOMEM;
> +
>   	sv2 = shadow_alloc(obj + 1, id, size, gfp_flags, shadow_ctor, &var2);
> +	if (!sv2)
> +		return -ENOMEM;
> +
>   	sv3 = shadow_alloc(obj, id + 1, size, gfp_flags, shadow_ctor, &var3);
> +	if (!sv3)
> +		return -ENOMEM;
>   
>   	/*
>   	 * Verify we can find our new shadow variables and that they point
>   	 * to expected data.
>   	 */
>   	ret = shadow_get(obj, id);
> +	if (!ret)
> +		return -EINVAL;
>   	if (ret == sv1 && *sv1 == &var1)
>   		pr_info("  got expected PTR%d -> PTR%d result\n",
>   			ptr_id(sv1), ptr_id(*sv1));
> +
>   	ret = shadow_get(obj + 1, id);
> +	if (!ret)
> +		return -EINVAL;
>   	if (ret == sv2 && *sv2 == &var2)
>   		pr_info("  got expected PTR%d -> PTR%d result\n",
>   			ptr_id(sv2), ptr_id(*sv2));
>   	ret = shadow_get(obj, id + 1);
> +	if (!ret)
> +		return -EINVAL;
>   	if (ret == sv3 && *sv3 == &var3)
>   		pr_info("  got expected PTR%d -> PTR%d result\n",
>   			ptr_id(sv3), ptr_id(*sv3));
> @@ -179,7 +194,12 @@ static int test_klp_shadow_vars_init(void)
>   	 * The second invocation should return the same shadow var.
>   	 */
>   	sv4 = shadow_get_or_alloc(obj + 2, id, size, gfp_flags, shadow_ctor, &var4);
> +	if (!sv4)
> +		return -ENOMEM;
> +
>   	ret = shadow_get_or_alloc(obj + 2, id, size, gfp_flags, shadow_ctor, &var4);
> +	if (!ret)
> +		return -EINVAL;
>   	if (ret == sv4 && *sv4 == &var4)
>   		pr_info("  got expected PTR%d -> PTR%d result\n",
>   			ptr_id(sv4), ptr_id(*sv4));
> @@ -207,6 +227,8 @@ static int test_klp_shadow_vars_init(void)
>   	 * We should still find an <id+1> variable.
>   	 */
>   	ret = shadow_get(obj, id + 1);
> +	if (!ret)
> +		return -EINVAL;
>   	if (ret == sv3 && *sv3 == &var3)
>   		pr_info("  got expected PTR%d -> PTR%d result\n",
>   			ptr_id(sv3), ptr_id(*sv3));
> 

Fixes look good to me,

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
