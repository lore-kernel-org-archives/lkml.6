Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450FCC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119FD218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nQVJEQVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAXVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:19:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32991 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:19:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id p65so3058579ywe.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QPyzRVQ4R9ubbGUT3VNVZFb5dATQ9TpxnhOu99Lads=;
        b=nQVJEQVXSIbr+sl2nooGWUwi1XOyYrbkDY5MU4zGNF6ylfmVIkl6HDKC23kg9lGtbq
         BMWdw1WUXFzg6pzTdMgeJ8pwu8KS5EjVQ03erOwZb/l0A8MXYnQJ2HQuCO6ZyS6uCihD
         z7qBw+J7yvGaPa6RjBUX3tcwUrtbRCXaUbLuhsVYFXfo6WiI97D6B58I2fffjgpKEr+s
         va45jfQ/1CPpWhMlUn+yMmlYK8jxtptGV22VP0Fe/V7HfOmmnuBCx21yWtI7Lhpz9l/T
         iB3LIKtxLTrAC2VtOi08y5JdjVKTSUQf1Gcf/f0Q5kg1FsBWh90koZ3gh8zsHjaWK2BN
         2ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QPyzRVQ4R9ubbGUT3VNVZFb5dATQ9TpxnhOu99Lads=;
        b=E966jIdMBD5ToqEcBkfKbn0dX5mekS/j4IW0LM4izE1OqqcTy5Sy4MDnZlxFL796fb
         EH3XpO3wNhZMopotxRSLBSAcRqXboMyhK5uROLMHinNELdAJqsrlRfji3s8AUQQ9uh7B
         0KVFv5LocaP7YAFeHaD1XihKJAXU1esrf/bfVgDgOgYSZ/MeXgGvwGQaBnFAFUnndkFn
         JBTOcvqnAJURAccb9Q+KeyUC7++vnP7h8yuzzgzYP8ILNHGTwZUraOIoi4j60Wn654fs
         7nZ8Ai/8hkW1S8tqbAZeNeqvjjjPtode76KSmNwqFyzt0oz6ExFrZB5JnoIPFXmXuubk
         RprA==
X-Gm-Message-State: AJcUukf914FCVmzwkvWl1DA4C4SV5wXyS+6BPRT7YkhNITzY3c+ePxlY
        XY2+Q8wflmVe+dJrzFrfo1Xapg==
X-Google-Smtp-Source: ALg8bN5QgiUU+g48rE/96HAWile468gtyMbzx3a0SJKY/4pmq1tyiXqeH1UwqvQ06Ab+SNUJq8JjVw==
X-Received: by 2002:a81:7542:: with SMTP id q63mr7782292ywc.321.1548364740673;
        Thu, 24 Jan 2019 13:19:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9b5d])
        by smtp.gmail.com with ESMTPSA id w2sm14299241ywl.10.2019.01.24.13.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:18:59 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:18:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Extract memcg maxable seq_file logic to
 seq_show_memcg_tunable
Message-ID: <20190124211858.GB14136@cmpxchg.org>
References: <20190124194100.GA31425@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124194100.GA31425@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:41:00PM -0500, Chris Down wrote:
> memcg has a significant number of files exposed to kernfs where their
> value is either exposed directly or is "max" in the case of
> PAGE_COUNTER_MAX.
> 
> This patch makes this generic by providing a single function to do this
> work. In combination with the previous patch adding mem_cgroup_from_seq,
> this makes all of the seq_show feeder functions significantly more
> simple.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
>  mm/memcontrol.c | 64 +++++++++++++++----------------------------------
>  1 file changed, 19 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 98aad31f5226..81b6f752471a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5375,6 +5375,16 @@ static void mem_cgroup_bind(struct cgroup_subsys_state *root_css)
>  		root_mem_cgroup->use_hierarchy = false;
>  }
>  
> +static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
> +{
> +	if (value == PAGE_COUNTER_MAX)
> +		seq_puts(m, "max\n");
> +	else
> +		seq_printf(m, "%llu\n", (u64)value * PAGE_SIZE);
> +
> +	return 0;
> +}
> +
>  static u64 memory_current_read(struct cgroup_subsys_state *css,
>  			       struct cftype *cft)
>  {
> @@ -5385,15 +5395,8 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>  
>  static int memory_min_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long min = READ_ONCE(memcg->memory.min);
> -
> -	if (min == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->memory.min));
>  }

Thanks for doing this.

The main thing that bugged me about the macro is that the data lookup
was split into two places:

	DEFINE_MEMCG_THING(seq, memory_min_show, memory.min);

where memory.min is just a fragment of a designator and you have to
look at the macro to find out what exactly it gets turned into.

With this patch it's obvious, and you don't have to look at the
implementation of seq_puts_memcg_tunable() to understand what's being
printed out.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
