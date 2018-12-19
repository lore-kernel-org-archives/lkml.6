Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604AA21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545208151;
	bh=R2MOlTK0gBdmXndrDqI7Vvb9vGIlBzZbV4QrVgx0F34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DGTq/JXSHsWJpzXK7JlCbu3WwOdzrN+JCEw09RIkwsnfFSJj1SJEd0P+UDZK7HEQr
	 On4OyrVcsyGBAJwesrJRSUyKZK7T7GkEWUecwvyQXt77B5Sg1He4LDMd3AGZz4zEQ4
	 fHYQZ1CkjZvLBz+U0wRitVAU5E0C+deW4mCN87tI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeLSI3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeLSI3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:29:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A03220675;
        Wed, 19 Dec 2018 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545208149;
        bh=R2MOlTK0gBdmXndrDqI7Vvb9vGIlBzZbV4QrVgx0F34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmbMcXQpe3M8HhUXiMsUQ1uV+U8XDvptKTWoJ/Qv9YZ7Muh3aDTLYjFbxpzBwlxEK
         pF/SCczacxzYLyTE32Hfl9BgiA+Jej19D+Cj+F5BuKIG8LPSXEjCx0o0swmwbUtXSq
         7f+Q5lj+NTL93eMtyySfMj/PwcIIInu4UdP2RBOA=
Date:   Wed, 19 Dec 2018 09:29:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 1/6] perf: Introduce ioctl to communicate
 driver configuration to kernel
Message-ID: <20181219082906.GA31670@kroah.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:21:41AM -0700, Mathieu Poirier wrote:
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
> index 9de8780ac8d9..a39d8dc2e7a9 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -462,6 +462,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
>  
>  enum perf_event_ioc_flags {
>  	PERF_IOC_FLAG_GROUP		= 1U << 0,
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 9de8780ac8d9..a39d8dc2e7a9 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -462,6 +462,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)

A pointer to an unknown structure?  That's just asking for abuse :(

