Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeCKMAT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:00:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34756 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeCKMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:00:17 -0400
X-Google-Smtp-Source: AG47ELv1GerVbOz7Q6JTHWpdLALfdiRKKxNNSr9Uf8CRWEoUOXeITKt/7JEPC1IpYWixDgy7SfJqgg==
Subject: Re: [RFC v2 05/83] Add NOVA filesystem definitions and useful helper
 routines.
To: Andiry Xu <jix024@eng.ucsd.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>, herbert@gondor.apana.org.au
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-6-git-send-email-jix024@eng.ucsd.edu>
From: Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <0924a2b3-6f21-4aaf-224d-2f5accc21d10@gmail.com>
Date: Sun, 11 Mar 2018 14:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520705944-6723-6-git-send-email-jix024@eng.ucsd.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Herbert Xu to CC since he is the maintainer of the crypto subsys
maintainer]

On 10.03.2018 20:17, Andiry Xu wrote:
<snip>

> +static inline u32 nova_crc32c(u32 crc, const u8 *data, size_t len)
> +{
> +	u8 *ptr = (u8 *) data;
> +	u64 acc = crc; /* accumulator, crc32c value in lower 32b */
> +	u32 csum;
> +
> +	/* x86 instruction crc32 is part of SSE-4.2 */
> +	if (static_cpu_has(X86_FEATURE_XMM4_2)) {
> +		/* This inline assembly implementation should be equivalent
> +		 * to the kernel's crc32c_intel_le_hw() function used by
> +		 * crc32c(), but this performs better on test machines.
> +		 */
> +		while (len > 8) {
> +			asm volatile(/* 64b quad words */
> +				"crc32q (%1), %0"
> +				: "=r" (acc)
> +				: "r"  (ptr), "0" (acc)
> +			);
> +			ptr += 8;
> +			len -= 8;
> +		}
> +
> +		while (len > 0) {
> +			asm volatile(/* trailing bytes */
> +				"crc32b (%1), %0"
> +				: "=r" (acc)
> +				: "r"  (ptr), "0" (acc)
> +			);
> +			ptr++;
> +			len--;
> +		}
> +
> +		csum = (u32) acc;
> +	} else {
> +		/* The kernel's crc32c() function should also detect and use the
> +		 * crc32 instruction of SSE-4.2. But calling in to this function
> +		 * is about 3x to 5x slower than the inline assembly version on
> +		 * some test machines.

That is really odd. Did you try to characterize why this is the case? Is
it purely the overhead of dispatching to the correct backend function?
That's a rather big performance hit.

> +		 */
> +		csum = crc32c(crc, data, len);
> +	}
> +
> +	return csum;
> +}
> +

<snip>
