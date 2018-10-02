Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6020C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776620652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9776620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeJBWb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBWb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 574D63082E71;
        Tue,  2 Oct 2018 15:47:26 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9D5614C6;
        Tue,  2 Oct 2018 15:47:22 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id C3D532E6A; Tue,  2 Oct 2018 12:47:18 -0300 (BRT)
Date:   Tue, 2 Oct 2018 12:47:18 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Sanskriti Sharma <sansharm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, acme@kernel.org
Subject: Re: [PATCH 2/5] perf tools: cleanup trace-event-info 'tdata' leak
Message-ID: <20181002154718.GC9457@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
 <1538490554-8161-3-git-send-email-sansharm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538490554-8161-3-git-send-email-sansharm@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Oct 2018 15:47:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 10:29:11AM -0400, Sanskriti Sharma escreveu:
> Free tracing_data structure in tracing_data_get() error paths.
> 
> Fixes the following coverity complaint:
> 
>   Error: RESOURCE_LEAK (CWE-772):
>   leaked_storage: Variable "tdata" going out of scope leaks the storage

Thanks, applied

- Arnaldo
 
> Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
> ---
>  tools/perf/util/trace-event-info.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
> index 7b0ca7c..8ad8e75 100644
> --- a/tools/perf/util/trace-event-info.c
> +++ b/tools/perf/util/trace-event-info.c
> @@ -531,12 +531,14 @@ struct tracing_data *tracing_data_get(struct list_head *pattrs,
>  			 "/tmp/perf-XXXXXX");
>  		if (!mkstemp(tdata->temp_file)) {
>  			pr_debug("Can't make temp file");
> +			free(tdata);
>  			return NULL;
>  		}
>  
>  		temp_fd = open(tdata->temp_file, O_RDWR);
>  		if (temp_fd < 0) {
>  			pr_debug("Can't read '%s'", tdata->temp_file);
> +			free(tdata);
>  			return NULL;
>  		}
>  
> -- 
> 1.8.3.1
