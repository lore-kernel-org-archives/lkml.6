Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363FC214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FC214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=golosunov.pp.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeIRC3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:29:11 -0400
Received: from relay13.nicmail.ru ([195.208.6.7]:60672 "EHLO
        relay13.nicmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:29:11 -0400
X-Greylist: delayed 1528 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 22:29:09 EDT
Received: from [109.70.25.185] (port=55717 helo=sghpc.hn.golosunov.pp.ru)
        by f17.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1g20EE-00022o-3x; Mon, 17 Sep 2018 23:34:42 +0300
Received: from [46.0.59.155] (account sghpc@golosunov.pp.ru HELO sghpc.hn.golosunov.pp.ru)
        by proxy06.mail.nic.ru (Exim 5.55)
        with id 1g20EE-0000rm-59; Mon, 17 Sep 2018 23:34:42 +0300
Received: from stepan by sghpc.hn.golosunov.pp.ru with local (Exim 4.89)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1g20EB-0003sy-2R; Tue, 18 Sep 2018 00:34:39 +0400
Date:   Tue, 18 Sep 2018 00:34:39 +0400
From:   Stepan Golosunov <stepan@golosunov.pp.ru>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH v3 4/5] pselect6: use __kernel_timespec
Message-ID: <20180917203438.maary2eo64dbuhw2@sghpc.golosunov.pp.ru>
References: <20180917010458.23159-1-deepa.kernel@gmail.com>
 <20180917010458.23159-5-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917010458.23159-5-deepa.kernel@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 06:04:57PM -0700, Deepa Dinamani wrote:
>  static long do_compat_pselect(int n, compat_ulong_t __user *inp,
>  	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
> -	struct old_timespec32 __user *tsp, compat_sigset_t __user *sigmask,
> -	compat_size_t sigsetsize)
> +	void __user *tsp, compat_sigset_t __user *sigmask,
> +	compat_size_t sigsetsize, enum poll_time_type type)
>  {
>  	sigset_t ksigmask, sigsaved;
>  	struct timespec64 ts, end_time, *to = NULL;
>  	int ret;
>  
>  	if (tsp) {
> -		if (get_old_timespec32(&ts, tsp))
> -			return -EFAULT;
> +		switch (type) {
> +		case PT_OLD_TIMESPEC:
> +			if (get_old_timespec32(&ts, tsp))
> +				return -EFAULT;
> +			break;
> +		case PT_TIMESPEC:
> +			if (get_old_timespec32(&ts, tsp))
> +				return -EFAULT;
> +			break;
> +		default:
> +			BUG();
> +		}

One of the two get_old_timespec32 calls here should be
get_timespec64.
