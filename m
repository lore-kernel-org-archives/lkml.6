Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FF42081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FF42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeK2QQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:16:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2QQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:16:18 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40EE6868;
        Thu, 29 Nov 2018 05:12:13 +0000 (UTC)
Date:   Wed, 28 Nov 2018 21:12:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Daniel Walker <dwalker@fifo99.com>, xe-linux-external@cisco.com,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] add generic builtin command line
Message-Id: <20181128211212.060295fb9055e403d0060e7a@linux-foundation.org>
In-Reply-To: <20181109173433.1271-1-danielwa@cisco.com>
References: <20181109173433.1271-1-danielwa@cisco.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 09:34:31 -0800 Daniel Walker <danielwa@cisco.com> wrote:

> This code allows architectures to use a generic builtin command line.
> The state of the builtin command line options across architecture is
> diverse. On x86 and mips they have pretty much the same code and the
> code prepends the builtin command line onto the boot loader provided
> one. On powerpc there is only a builtin override and nothing else.
> 
> The code in this commit unifies the mips and x86 code into a generic
> header file under the CONFIG_GENERIC_CMDLINE option. When this
> option is enabled the architecture can call the cmdline_add_builtin()
> to add the builtin command line.

I'm not sure what's happened to this and I haven't seen the other two
patches but...

> [maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Daniel Walker <danielwa@cisco.com>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>

Two SOB's is nice, but some reviews and acks would be nicer.

> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +/*
> + *
> + * Copyright (C) 2015. Cisco Systems, Inc.
> + *
> + * Generic Append/Prepend cmdline support.
> + */
> +
> +#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
> +
> +#ifndef CONFIG_CMDLINE_OVERRIDE
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dest: The destination of the final appended/prepended string
> + * @src: The starting string or NULL if there isn't one.
> + * @tmp: temporary space used for prepending
> + * @length: the maximum length of the strings above.
> + */
> +static inline void
> +_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
> +{
> +	if (src != dest && src != NULL) {
> +		strlcpy(dest, " ", length);
> +		strlcat(dest, src, length);
> +	}
> +
> +	strlcat(dest, " ", length);
> +
> +	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
> +		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
> +
> +	/*
> +	 * You need to convert you old style CONFIG_CMDLINE to use

"your"

> +	 * the prepend, or append defines. Some architectures use one

"one and"

> +	 * some use the other. You need to figure out which ones is

"one"

> +	 * right for your situation. I would recommend prepending
> +	 * because it's the safest (i.e. CONFIG_CMDLINE_PREPEND).
> +	 */
> +	BUILD_BUG_ON(sizeof(CONFIG_CMDLINE) != 1);
> +
> +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
> +		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
> +		strlcat(tmp, " ", length);
> +		strlcat(tmp, dest, length);
> +		strlcpy(dest, tmp, length);
> +	}
> +}

And... holy cow.  Does this monster really need to be inlined?

> +#define cmdline_add_builtin(dest, src, length)				    \
> +{									    \
> +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
> +		static char cmdline_tmp_space[length] __initdata;	    \
> +		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
> +	} else {							    \
> +		_cmdline_add_builtin(dest, src, NULL, length);		    \
> +	}								    \
> +}

And this will generate __initdata storage at each invocation site.  Can
it be redone in real, non-inlined C?

> +#else
> +#define cmdline_add_builtin(dest, src, length)				   \
> +{									   \
> +	strlcpy(dest, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,    \
> +		length);						   \
> +}
> +#endif /* !CONFIG_CMDLINE_OVERRIDE */
> +
> +#else
> +#define cmdline_add_builtin(dest, src, length) { \
> +	if (src != NULL)						   \
> +		strlcpy(dest, src, length);				   \
> +}
> +#endif /* CONFIG_GENERIC_CMDLINE */
> +
> +
> +#endif /* _LINUX_CMDLINE_H */

