Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40072133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfB0NVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC61E30FD830;
        Wed, 27 Feb 2019 13:21:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id D2C2160637;
        Wed, 27 Feb 2019 13:21:17 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 15/15] perf, bpf: save information about
 short living bpf programs
Message-ID: <20190227132116.GD18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-16-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-16-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Feb 2019 13:21:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:19PM -0800, Song Liu wrote:

SNIP

> +	btf_id = info_linear->info.btf_id;
> +
> +	info_node = malloc(sizeof(struct bpf_prog_info_node));
> +	if (info_node) {
> +		info_node->info_linear = info_linear;
> +		perf_env__insert_bpf_prog_info(env, info_node);
> +	} else
> +		free(info_linear);
> +
> +	if (btf_id == 0)
> +		goto out;
> +
> +	if (btf__get_from_id(btf_id, &btf)) {
> +		pr_debug("%s: failed to get BTF of id %u, aborting\n",
> +			 __func__, btf_id);
> +		goto out;
> +	}
> +	perf_env__fetch_btf(env, btf_id, btf);

so is this the main reason we are doing this? getting the btf
data for bpf prog ids and store them?

please describe the whole bpf events/features data flow in
changelog as I asked in previous email

thanks,
jirka
