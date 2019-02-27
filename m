Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0848C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfB0NVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C9FE30833C2;
        Wed, 27 Feb 2019 13:21:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54FD361371;
        Wed, 27 Feb 2019 13:21:32 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190227132130.GF18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-7-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 27 Feb 2019 13:21:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:10PM -0800, Song Liu wrote:

SNIP

> @@ -38,6 +116,12 @@ void perf_env__exit(struct perf_env *env)
>  	zfree(&env->memory_nodes);
>  }
>  
> +static void init_bpf_rb_trees(struct perf_env *env)
> +{
> +	env->bpf_progs.prog_infos = RB_ROOT;
> +	init_rwsem(&env->bpf_progs.lock);
> +}
> +
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
>  {
>  	int i;
> @@ -59,6 +143,7 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
>  
>  	env->nr_cmdline = argc;
>  
> +	init_bpf_rb_trees(env);

this souldn't be in perf_env__set_cmdline,
it's there to set the cmdline

struct bpf_progs is first in perf_env that
needs other than zero initialization, so
I think we need to add perf_env__init function,
that will do that for all the paths that uses
perf_env


jirka
