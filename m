Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FA821773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBQXGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:06:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfBQXGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:06:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB6622F9471;
        Sun, 17 Feb 2019 23:06:08 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2E1EB611B2;
        Sun, 17 Feb 2019 23:06:05 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:06:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 10/11] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190217230605.GG7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-11-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-11-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 17 Feb 2019 23:06:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:53PM -0800, Song Liu wrote:
> This patch enables the annotation of bpf program.
> 
> A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
> programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
> calls into a new function symbol__disassemble_bpf(), where annotation
> line information is filled based bpf_prog_info and btf saved in given
> perf_env.
> 
> symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Makefile.config  |   6 +-
>  tools/perf/util/annotate.c  | 149 +++++++++++++++++++++++++++++++++++-
>  tools/perf/util/bpf-event.c |  48 ++++++++++++
>  tools/perf/util/bpf-event.h |   4 +
>  tools/perf/util/dso.c       |   1 +
>  tools/perf/util/dso.h       |  33 +++++---
>  tools/perf/util/symbol.c    |   1 +
>  7 files changed, 229 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b441c88cafa1..ab223239f1fb 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -701,7 +701,7 @@ else
>  endif
>  
>  ifeq ($(feature-libbfd), 1)
> -  EXTLIBS += -lbfd
> +  EXTLIBS += -lbfd -lopcodes

hum, what's this -lopcodes lib? please add it in a separate
patch and explain why it's added and how it affects others
it looks like it could break some distros without that lib

jirka
