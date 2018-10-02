Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6436BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359DD20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJBWcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:32:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBWcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B05B8804E2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 15:47:58 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24F2C308BDA0;
        Tue,  2 Oct 2018 15:47:56 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 01B2B2F34; Tue,  2 Oct 2018 12:47:52 -0300 (BRT)
Date:   Tue, 2 Oct 2018 12:47:52 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Sanskriti Sharma <sansharm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 3/5] perf tools: free 'printk' string in
 parse_ftrace_printk()
Message-ID: <20181002154752.GD9457@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
 <1538490554-8161-4-git-send-email-sansharm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538490554-8161-4-git-send-email-sansharm@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 02 Oct 2018 15:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 10:29:12AM -0400, Sanskriti Sharma escreveu:
> parse_ftrace_printk() tokenizes and parses a line, calling strdup() each
> iteration.  Add code to free this temporary format string duplicate.
> 
> Fixes the following coverity complaints:
> 
>   Error: RESOURCE_LEAK (CWE-772):
>   tools/perf/util/trace-event-parse.c:158: overwrite_var: Overwriting
>   "printk" in "printk = strdup(fmt + 1)" leaks the storage that "printk"
>   points to.
> 
>   tools/perf/util/trace-event-parse.c:162: leaked_storage: Variable
>   "printk" going out of scope leaks the storage it points to.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
> ---
>  tools/perf/util/trace-event-parse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index e76214f..b15a9bf 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -158,6 +158,7 @@ void parse_ftrace_printk(struct tep_handle *pevent,
>  		printk = strdup(fmt+1);
>  		line = strtok_r(NULL, "\n", &next);
>  		tep_register_print_string(pevent, printk, addr);
> +		free(printk);
>  	}
>  }
>  
> -- 
> 1.8.3.1
