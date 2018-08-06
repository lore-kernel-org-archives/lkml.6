Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724D21925
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXv3oRx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724D21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHFP70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:59:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbeHFP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:59:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so6260137pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FouZBfQpDASkZRb3ZM6EkV9QkAEZM8NYmG5mRiHTFy0=;
        b=NXv3oRx4bpOTJ6owAvmWArFVLM6TVOTRCsVWWYPN5fMvWs4cBkU1Unv24WJ3eiH4aU
         qlyz9QWrLYQvIZJ+xo4i5k4QFV7Xjkasac8onuKx42IqNp6jmqPSmCoyBqPJw8QLvg1M
         9h/gi4S6aaViETEktk2MuilowMrSg7HXSIeE1ZXn9waZEAVriOdOFO3pCfys/sHN8enH
         TpeJnzGWbIZuHaRpj8OIkgec/6zLGWk7rug54d4hGZAxIi1cakPnmBjeom97gkQqgIYe
         XsBrH3S/ySwRmg0x2Pk/iMoQcA0V5AIDJVeu/muXTH1AH+D62/S2aVfgvsLpyUqTiEY8
         vLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FouZBfQpDASkZRb3ZM6EkV9QkAEZM8NYmG5mRiHTFy0=;
        b=Ay713+miOM0fnzcLPjfR8chwcLhrIXOqXLwnfBRMs3QSAWd2xXmy0AjfyLl+BWeJXm
         P0cms/qZmYTbwIc3YPCv4SzFh3KHqhDCtMLuR/Y3ouLXO6UvStpkSbNKgNCHWTSCgv7e
         rO1r/BakxY+Qk8oz+81824TCJhAIcA7y0+T+nNbTWSQG5hxDEBt1lGyWYzRWXuYbsWHB
         OnZ8LlfDgIA2xqL7PhgMqsGAEO51BTViNjhCBjSHxj/7wXkfolG38r6ipaWYcKhjlsmg
         dav0ennddUy0Az6TQNDImoUICpWjVDcG7SZtU3bobSW2i9tL80ol2ekVechUFkJ3WaU/
         27QA==
X-Gm-Message-State: AOUpUlHdVifYo7P062qkATPoeC8mvFpXKGwywiTXDyecnCrYHQLJoTot
        EWnRxqvYVcC68R+db9Ie8nE=
X-Google-Smtp-Source: AAOMgpd8OU7aajZXOk/oHu6tB6bouCOESWeVr6wW3dSANmqWhPYaIvtz+pouKLmlTL2TUvxW8Xm2Jw==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr17342411pfd.233.1533563413784;
        Mon, 06 Aug 2018 06:50:13 -0700 (PDT)
Received: from danjae.aot.lge.com ([182.210.106.170])
        by smtp.gmail.com with ESMTPSA id t30-v6sm21002381pgm.81.2018.08.06.06.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 06:50:12 -0700 (PDT)
Date:   Mon, 6 Aug 2018 22:45:07 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 14/20] perf annotate: Pass struct annotation_options to
 map_symbol__annotation_dump
Message-ID: <20180806134507.GA6983@danjae.aot.lge.com>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-15-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-15-jolsa@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sat, Aug 04, 2018 at 03:05:15PM +0200, Jiri Olsa wrote:
> Passing struct annotation_options to map_symbol__annotation_dump,
> to carry on and pass the percent_type value.
> 
> Link: http://lkml.kernel.org/n/tip-5toohgdkgpk3vn6zebusr3bb@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

[SNIP]
> @@ -2523,7 +2526,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
>  
>  static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
>  				     bool first_line, bool current_entry, bool change_color, int width,
> -				     void *obj,
> +				     void *obj, unsigned int percent_type,
>  				     int  (*obj__set_color)(void *obj, int color),
>  				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
>  				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
> @@ -2531,7 +2534,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  				     void (*obj__write_graph)(void *obj, int graph))
>  
>  {
> -	double percent_max = annotation_line__max_percent(al, notes);
> +	double percent_max = annotation_line__max_percent(al, notes, percent_type);
>  	int pcnt_width = annotation__pcnt_width(notes),
>  	    cycles_width = annotation__cycles_width(notes);
>  	bool show_title = false;
> @@ -2552,8 +2555,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  		for (i = 0; i < notes->nr_events; i++) {
>  			double percent;
>  
> -			percent = annotation_data__percent(&al->data[i],
> -							   PERCENT_HITS_LOCAL);
> +			percent = annotation_data__percent(&al->data[i], percent_type);
>  
>  			obj__set_percent_color(obj, percent, current_entry);
>  			if (notes->options->show_total_period) {
> @@ -2680,13 +2682,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  }
>  
>  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> -			    struct annotation_write_ops *ops)
> +			    struct annotation_write_ops *wops,
> +			    struct annotation_options *opts)
>  {
> -	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
> -				 ops->change_color, ops->width, ops->obj,
> -				 ops->set_color, ops->set_percent_color,
> -				 ops->set_jumps_percent_color, ops->printf,
> -				 ops->write_graph);
> +	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> +				 wops->change_color, wops->width, wops->obj,
> +				 opts->percent_type,
> +				 wops->set_color, wops->set_percent_color,
> +				 wops->set_jumps_percent_color, wops->printf,
> +				 wops->write_graph);

This doesn't look good.  Why not just passing a pointer to wops
instead of each fields separately?

Thanks,
Namhyung


>  }
>  
>  int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 145dec845f33..3d4579e68d28 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -185,7 +185,8 @@ struct annotation_write_ops {
>  };
>  
>  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> -			    struct annotation_write_ops *ops);
> +			    struct annotation_write_ops *ops,
> +			    struct annotation_options *opts);
>  
>  int __annotation__scnprintf_samples_period(struct annotation *notes,
>  					   char *bf, size_t size,
> @@ -351,7 +352,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
>  void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
>  void annotated_source__purge(struct annotated_source *as);
>  
> -int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel);
> +int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
> +				struct annotation_options *opts);
>  
>  bool ui__has_annotation(void);
>  
> -- 
> 2.17.1
> 
