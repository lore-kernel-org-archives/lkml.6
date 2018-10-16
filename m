Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA7EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FF62145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJQElx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQElx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6754F3084259;
        Tue, 16 Oct 2018 20:49:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B126663BA3;
        Tue, 16 Oct 2018 20:49:37 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, linux-api@vger.kernel.org
References: <20181016195337.2440-1-christian@brauner.io>
 <20181016195337.2440-3-christian@brauner.io>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e8d3d39a-6880-486b-84fc-7fd0848bb4a3@redhat.com>
Date:   Tue, 16 Oct 2018 16:49:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181016195337.2440-3-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Oct 2018 20:49:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 03:53 PM, Christian Brauner wrote:
> Currently, when writing
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
> This commit sets the max and min value for file-max and returns -EINVAL
> when a long int is exceeded. Any higher value cannot currently be used as
> the percpu counters are long ints and not unsigned integers. This behavior
> also aligns with other tuneables that return -EINVAL when their range is
> exceeded. See e.g. [1], [2] and others.
>
> [1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
> [2]: 196851bed522 ("s390/topology: correct topology mode proc handler")
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v2->v1:
> - consistenly fail on overflow
> v0->v1:
> - if max value is < than ULONG_MAX use max as upper bound
> - (Dominik) remove double "the" from commit message
> ---
>  kernel/sysctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7d98e02e5d72..0874001e5435 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
>  static unsigned long one_ul = 1;
> +static unsigned long long_max = LONG_MAX;
>  static int one_hundred = 100;
>  static int one_thousand = 1000;
>  #ifdef CONFIG_PRINTK
> @@ -1696,6 +1697,8 @@ static struct ctl_table fs_table[] = {
>  		.maxlen		= sizeof(files_stat.max_files),
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &zero,
> +		.extra2		= &long_max,
>  	},
>  	{
>  		.procname	= "nr_open",
> @@ -2797,6 +2800,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>  				break;
>  			if (neg)
>  				continue;
> +			if ((max && val > *max) || (min && val < *min)) {
> +				err = -EINVAL;
> +				break;
> +			}
>  			val = convmul * val / convdiv;

Should the conversion be done before the min/max check?

>  			if ((min && val < *min) || (max && val > *max))
>  				continue;

You may be able to drop the above statement.

Cheers,
Longman

