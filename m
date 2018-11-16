Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCB62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPAbaZs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCB62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeKQJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:12:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44708 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:12:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so2554369pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RHMU7FC4FSigZnswvFS/blw86ceh/1RAWF2TH8IAqpQ=;
        b=iPAbaZs1E85xTUioGtNJVgPqwLdjUIofsrNK8VPNQrlTFxVeS6btjL+BqumDTF7rmM
         kwRO69yw0PtBDGzCrdR2xSdhWAcAw6bw7q1cstABvVG+3pLdiupQSFXugG3hZwv5kHNC
         gdj95brPl8AGXkmIt2tmq7zrEFngDvQLtinPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RHMU7FC4FSigZnswvFS/blw86ceh/1RAWF2TH8IAqpQ=;
        b=jiMen5xqMdU7Yi/lFZIC83QuNvCwM8KJJP6YGzSEmVqRKq4OELFJlbhzftU/n9/VV6
         Fv+i5IZuR63KkP8j/SejuntIaC0uXBGHOHPa55GYd+wVs8r/axitqhYzQZrOVRIyqk0+
         3UUpw+6rw5lV/jkjpNEBORTwNSBWB/FyGekkLg1C86PTr53mFSFJ0aMDqgvAZfTWxc94
         7BhObO9MrjWScTVFuTbMQ/YxwrQ5SjSXjqKBcGMrA5qKTkMHc3HN127qWZHlYfDwhQpr
         yM7PDTX4XCkF0G7yFYpgLPHJeZt0knE7mZuDXMik4/XLgOKngjis49qGFZsWUhGAqixd
         MVZQ==
X-Gm-Message-State: AGRZ1gK8PlxlFJbGCqpZqVSYVS0/Dqpqy433F5+PwUb78wQRp+Pv3yWJ
        neIoSgBOPoBk1JQrE2vMJcbGaw==
X-Google-Smtp-Source: AJdET5e6QOn98/zDVdOPM74E+xy996Svn5+qcERKIiRoK3NtJ3xOqVYHyAbprjc4oPddw/f6TkPqAQ==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr11591576pgi.305.1542409121932;
        Fri, 16 Nov 2018 14:58:41 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o86-v6sm41601034pfk.8.2018.11.16.14.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:58:41 -0800 (PST)
Date:   Fri, 16 Nov 2018 15:58:38 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v1 1/5] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
Message-ID: <20181116225838.GA25258@xps15>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-2-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541912383-19915-2-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:59:39PM +0800, Leo Yan wrote:
> The structure cs_etm_queue uses 'prev_packet' to point to previous
> packet, this can be used to combine with new coming packet to generate
> samples.
> 
> In function cs_etm__flush() it swaps packets only when the flag
> 'etm->synth_opts.last_branch' is true, this means that it will not
> swap packets if without option '--itrace=il' to generate last branch
> entries; thus for this case the 'prev_packet' doesn't point to the
> correct previous packet and the stale packet still will be used to
> generate sequential sample.  Thus if dump trace with 'perf script'
> command we can see the incorrect flow with the stale packet's address
> info.
> 
> This patch corrects packets swapping in cs_etm__flush(); except using
> the flag 'etm->synth_opts.last_branch' it also checks the another flag
> 'etm->sample_branches', if any flag is true then it swaps packets so
> can save correct content to 'prev_packet'.  Finally this can fix the
> wrong program flow dumping issue.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 48ad217..fe18d7b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -997,7 +997,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>  	}
>  
>  swap_packet:
> -	if (etmq->etm->synth_opts.last_branch) {
> +	if (etm->sample_branches || etmq->etm->synth_opts.last_branch) {

This seems like the right thing to do, if only to be consistent with that is
done in cs_etm__sample().

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		/*
>  		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>  		 * the next incoming packet.
> -- 
> 2.7.4
> 
