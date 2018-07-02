Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BFD25561
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BFD25561
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeGBJc5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:32:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933423AbeGBJcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:32:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE2547D84D;
        Mon,  2 Jul 2018 09:32:52 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-88.ams2.redhat.com [10.36.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2BF22026D5B;
        Mon,  2 Jul 2018 09:32:51 +0000 (UTC)
Subject: Re: [PATCH] Add renameat2 function [BZ #17662]
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     libc-alpha@sourceware.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20180630121447.E4C8643994575@oldenburg.str.redhat.com>
 <20180701214901.GA32498@yury-thinkpad>
 <60505ccf-a399-6320-74f5-e2e17965d25c@redhat.com>
 <20180702084622.GA15274@yury-thinkpad>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <83bc54c8-ea97-22f7-360f-523e5979864a@redhat.com>
Date:   Mon, 2 Jul 2018 11:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702084622.GA15274@yury-thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 09:32:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 09:32:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 10:46 AM, Yury Norov wrote:

> Is my understanding correct that glibc community finds <linux/fs.h>
> inappropriate for their use, and prefer to re-introduce (duplicate)
> its functionality locally? I think it's wrong. The right way to go
> is to make kernel headers comfortable for users instead of ignoring
> it.

In some cases, we already use UAPI headers (<linux/falloc.h> is an 
example), but it is not always possible.

> Are you OK to switch to kernel RENAME_* definitions if they will be
> located in separated small file? Like in the patch below.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>   include/uapi/linux/fs.h     |  4 +---
>   include/uapi/linux/rename.h | 12 ++++++++++++
>   2 files changed, 13 insertions(+), 3 deletions(-)
>   create mode 100644 include/uapi/linux/rename.h
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index c27576d471c2..46c03ea31a76 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -44,9 +44,7 @@
>   #define SEEK_HOLE	4	/* seek to the next hole */
>   #define SEEK_MAX	SEEK_HOLE
>   
> -#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
> -#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
> -#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
> +#include <linux/rename.h>
>   
>   struct file_clone_range {
>   	__s64 src_fd;
> diff --git a/include/uapi/linux/rename.h b/include/uapi/linux/rename.h
> new file mode 100644
> index 000000000000..7178f0565657
> --- /dev/null
> +++ b/include/uapi/linux/rename.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_RENAME_H
> +#define _UAPI_LINUX_RENAME_H
> +
> +/*
> + * Definitions for rename syscall family.
> + */
> +#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
> +#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
> +#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
> +
> +#endif /* _UAPI_LINUX_RENAME_H */

This would help.

We would need to provide definitions for compatibility with older kernel 
headers locally, but on newer kernels, we could use the UAPI header file.

Thanks,
Florian
