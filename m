Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF92C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EDC2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EDC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeLLMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:15:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeLLMPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:15:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 464B481F01;
        Wed, 12 Dec 2018 12:15:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 97C0C19743;
        Wed, 12 Dec 2018 12:15:39 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:15:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20181212121538.GE25240@krava>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 12 Dec 2018 12:15:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:

SNIP

>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
>  {
> +	int c, nr_cpus, node;
>  	/*
>  	 * The last one will be done at perf_mmap__consume(), so that we
>  	 * make sure we don't prevent tools from consuming every last event in
> @@ -344,6 +369,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>  	map->cpu = cpu;
>  
>  	CPU_ZERO(&map->affinity_mask);
> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
> +		nr_cpus = cpu_map__nr(mp->cpu_map);
> +		node = cpu__get_node(map->cpu);
> +		for (c = 0; c < nr_cpus; c++) {
> +			if (cpu__get_node(c) == node) {
> +				CPU_SET(c, &map->affinity_mask);
> +			}
> +		}
> +	} else if (mp->affinity == PERF_AFFINITY_CPU) {
> +		CPU_SET(map->cpu, &map->affinity_mask);
> +	}

won't both of this end up in same mask?

jirka
