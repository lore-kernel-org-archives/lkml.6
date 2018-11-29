Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4EA20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq/gkA1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4EA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeK2Svv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeK2Svu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:51:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CBB206B6;
        Thu, 29 Nov 2018 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543477643;
        bh=Lsz4mTvdoqcwWqo4Lubt8iBi5mVJoSD6B53HO8icfdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq/gkA1FjuGpWGN2D3heloLYUwF4IW+eOUJDbHlyRYWLpYQYEkMRE7JdmiVJTj77M
         dTh3awjFt2mcpA1qXlOdj4RcpSkZmrF2cT3K7/L8TOZM5M4r+/U/beorpInzu7LfTu
         BoyCnVynqTtgvnEqNITMEeIEjSFB5VnV9+h06yJQ=
Date:   Thu, 29 Nov 2018 08:47:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/6] perf: Introduce ioctl to communicate driver
 configuration to kernel
Message-ID: <20181129074721.GC12347@kroah.com>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-2-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543442478-31465-2-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:01:13PM -0700, Mathieu Poirier wrote:
> Adding a new IOCTL command to communicate PMU specific configuration to
> PMU kernel drivers.  This can be anything a PMU might need for
> configuration that doesn't fit in the perf_event_attr structure, such
> as the CoreSight sink to use for a session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  include/uapi/linux/perf_event.h       | 1 +
>  tools/include/uapi/linux/perf_event.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 9de8780ac8d9..bb558caeb33b 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -462,6 +462,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)


A generic "char *" that the kernel is then going to parse?  Can you make
any more flexible of a new syscall to the kernel that allows anyone to
do anything with this?  :)

Please make this a lot more specific, this is way to generic, sorry.

greg k-h
