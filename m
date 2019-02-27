Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA802133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfB0NWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:22:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C60A7F3F4;
        Wed, 27 Feb 2019 13:21:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id C84FA5DA9A;
        Wed, 27 Feb 2019 13:21:56 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190227132155.GI18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-8-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 27 Feb 2019 13:21:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:11PM -0800, Song Liu wrote:

SNIP

> +		if (info_len > sizeof(struct bpf_prog_info)) {
> +			pr_warning("detected invalid bpf_prog_info\n");
> +			goto out;
> +		}
> +
> +		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
> +				     data_len);
> +		if (!info_linear)
> +			goto out;
> +		info_linear->info_len = sizeof(struct bpf_prog_info);
> +		info_linear->data_len = data_len;
> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
> +			goto out;
> +		if (__do_read(ff, &info_linear->info, info_len))
> +			goto out;
> +		if (info_len < sizeof(struct bpf_prog_info))
> +			memset(((void *)(&info_linear->info)) + info_len, 0,
> +			       sizeof(struct bpf_prog_info) - info_len);
> +
> +		if (__do_read(ff, info_linear->data, data_len))
> +			goto out;
> +
> +		/* endian mismatch, drop the info, continue */

so there's no way we can swap the data? why?

jirka

> +		if (ff->ph->needs_swap) {
> +			free(info_linear);
> +			continue;
> +		}

SNIP
