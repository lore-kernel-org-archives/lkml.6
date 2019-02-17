Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87A321773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBQXGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:06:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61031 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfBQXGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:06:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 769B9A789F;
        Sun, 17 Feb 2019 23:06:33 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 10D604DC3A;
        Sun, 17 Feb 2019 23:06:30 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:06:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190217230630.GJ7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-9-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 17 Feb 2019 23:06:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:51PM -0800, Song Liu wrote:
> This patch enables perf-record to save btf information as headers to
> perf.data A new header type HEADER_BTF is introduced for this data.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/header.c | 99 +++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h |  1 +
>  2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 0889ad797940..2de4f4e9b590 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1127,6 +1127,45 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_btf(struct feat_fd *ff,
> +		     struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	u32 count = 0;
> +	int ret;
> +
> +	down_read(&env->bpf_progs.bpf_info_lock);
> +
> +	root = &env->bpf_progs.btfs;
> +	next = rb_first(root);
> +	while (next) {
> +		++count;
> +		next = rb_next(next);
> +	}
> +
> +	ret = do_write(ff, &count, sizeof(count));
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	next = rb_first(root);
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		ret = do_write(ff, node,
> +			       sizeof(struct btf_node) + node->data_size);

hm, you write the whole struct btf_node with struct rb_node? why?

thanks,
jirka
