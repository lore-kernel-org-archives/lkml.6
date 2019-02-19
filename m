Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1CF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfBSIvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:51:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfBSIvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:51:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 521EE3B73B;
        Tue, 19 Feb 2019 08:51:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D9D5600C0;
        Tue, 19 Feb 2019 08:51:47 +0000 (UTC)
Date:   Tue, 19 Feb 2019 09:51:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190219085145.GC13284@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-6-songliubraving@fb.com>
 <20190217230516.GA7443@krava>
 <4784383E-1BFA-4387-8864-B1814FFEC937@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4784383E-1BFA-4387-8864-B1814FFEC937@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 08:51:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 05:52:20AM +0000, Song Liu wrote:
> 
> 
> > On Feb 17, 2019, at 3:05 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Fri, Feb 15, 2019 at 01:53:48PM -0800, Song Liu wrote:
> > 
> > SNIP
> > 
> >> 	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
> >> 	if (IS_ERR_OR_NULL(info_linear)) {
> >> @@ -151,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> >> 						     machine, process);
> >> 	}
> >> 
> >> -	/* Synthesize PERF_RECORD_BPF_EVENT */
> >> 	if (opts->bpf_event) {
> >> +		/* Synthesize PERF_RECORD_BPF_EVENT */
> >> 		*bpf_event = (struct bpf_event){
> >> 			.header = {
> >> 				.type = PERF_RECORD_BPF_EVENT,
> >> @@ -165,6 +179,19 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> >> 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
> >> 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
> >> 		event->header.size += machine->id_hdr_size;
> >> +
> >> +		/* save bpf_prog_info to env */
> >> +		info_node = malloc(sizeof(struct bpf_prog_info_node));
> >> +		if (info_node) {
> >> +			info_node->info_linear = info_linear;
> >> +			perf_env__insert_bpf_prog_info(env, info_node);
> >> +			info_linear = NULL;
> >> +		}
> > 
> > what if the allocation fails? we don't care?
> > 
> > jirka
> 
> My original plan is to just ignore it and accept that this program
> doesn't have annotation. Any suggestion on what would be a better 
> approach?

there's an error path in the function, I'd bail out if the malloc fails

jirka
