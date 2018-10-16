Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7EBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E38520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E38520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJPXE2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeJPXE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E51546202;
        Tue, 16 Oct 2018 15:13:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07C1169FBA;
        Tue, 16 Oct 2018 15:13:28 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <22319ca1-6dab-fe36-40d5-9c88f7a175ee@redhat.com>
Date:   Tue, 16 Oct 2018 11:13:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181015105544.4395-3-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Oct 2018 15:13:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 06:55 AM, Christian Brauner wrote:
> Currently, when writing
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
> This commit explicitly caps the value for file-max to ULONG_MAX.
>
> Note, this isn't technically necessary since proc_get_long() will already
> return ULONG_MAX. However, two reason why we still should do this:
> 1. it makes it explicit what the upper bound of file-max is instead of
>    making readers of the code infer it from proc_get_long() themselves
> 2. other tunebles than file-max may want to set a lower max value than
>    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
>    such cases too
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> - if max value is < than ULONG_MAX use max as upper bound
> - (Dominik) remove double "the" from commit message
> ---
>  kernel/sysctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 97551eb42946..226d4eaf4b0e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
>  static unsigned long one_ul = 1;
> +static unsigned long ulong_max = ULONG_MAX;
>  static int one_hundred = 100;
>  static int one_thousand = 1000;
>  #ifdef CONFIG_PRINTK
> @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
>  		.maxlen		= sizeof(files_stat.max_files),
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
> +		.extra2		= &ulong_max,

What is the point of having a maximum value of ULONG_MAX anyway? No
value you can put into a ulong type can be bigger than that.

>  	},
>  	{
>  		.procname	= "nr_open",
> @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>  				break;
>  			if (neg)
>  				continue;
> +			if (max && val > *max)
> +				val = *max;
>  			val = convmul * val / convdiv;
>  			if ((min && val < *min) || (max && val > *max))
>  				continue;

This does introduce a change in behavior. Previously the out-of-bound
value is ignored, now it is capped at its maximum. This is a
user-visible change.

Cheers,
Longman


