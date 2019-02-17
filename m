Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6233DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AEB21773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBQXHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfBQXG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:06:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11540C04BD4E;
        Sun, 17 Feb 2019 23:06:59 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89DE41024978;
        Sun, 17 Feb 2019 23:06:56 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:06:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190217230655.GM7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-6-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 17 Feb 2019 23:06:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:48PM -0800, Song Liu wrote:

SNIP

> @@ -165,6 +179,19 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>  		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>  		event->header.size += machine->id_hdr_size;
> +
> +		/* save bpf_prog_info to env */
> +		info_node = malloc(sizeof(struct bpf_prog_info_node));
> +		if (info_node) {
> +			info_node->info_linear = info_linear;
> +			perf_env__insert_bpf_prog_info(env, info_node);
> +			info_linear = NULL;
> +		}
> +
> +		/*
> +		 * process after saving bpf_prog_info to env, so that
> +		 * required information is ready for look up
> +		 */
>  		err = perf_tool__process_synth_event(tool, event,
>  						     machine, process);
>  	}
> @@ -175,7 +202,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  	return err ? -1 : 0;
>  }
>  
> -int perf_event__synthesize_bpf_events(struct perf_tool *tool,
> +int perf_event__synthesize_bpf_events(struct perf_session *session,
>  				      perf_event__handler_t process,
>  				      struct machine *machine,
>  				      struct record_opts *opts)

please move the prototype change into separate patch

thanks,
jirka
