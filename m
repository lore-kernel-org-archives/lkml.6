Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E82C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33922081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33922081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLDRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeLDRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:43:36 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B472081B;
        Tue,  4 Dec 2018 17:43:35 +0000 (UTC)
Date:   Tue, 4 Dec 2018 12:43:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/12] tracing/uprobes: Add busy check when cleanup
 all uprobes
Message-ID: <20181204124333.00f4c5ee@vmware.local.home>
In-Reply-To: <154140841557.17322.12653952888762532401.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
        <154140841557.17322.12653952888762532401.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 18:00:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a busy check loop in cleanup_all_probes() before
> trying to remove all events in uprobe_events as same as
> kprobe_events does.
> 
> Without this change, writing null to uprobe_events will
> try to remove events but if one of them is enabled, it
> stopped there but some of events are already cleared.
> 
> With this change, writing null to uprobe_events make
> sure all events are not enabled before removing events.
> So, it clears all events, or return an error (-EBUSY)
> with keeping all events.
> 

Hmm, should this patch be marked as stable?

-- Steve

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 31ea48eceda1..b708e4ff7ea7 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -587,12 +587,19 @@ static int cleanup_all_probes(void)
>  	int ret = 0;
>  
>  	mutex_lock(&uprobe_lock);
> +	/* Ensure no probe is in use. */
> +	list_for_each_entry(tu, &uprobe_list, list)
> +		if (trace_probe_is_enabled(&tu->tp)) {
> +			ret = -EBUSY;
> +			goto end;
> +		}
>  	while (!list_empty(&uprobe_list)) {
>  		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
>  		ret = unregister_trace_uprobe(tu);
>  		if (ret)
>  			break;
>  	}
> +end:
>  	mutex_unlock(&uprobe_lock);
>  	return ret;
>  }

