Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C13C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeJBWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50001 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbeJBWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0165F80474
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 15:50:32 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A0433091327;
        Tue,  2 Oct 2018 15:50:29 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 1B97E2F34; Tue,  2 Oct 2018 12:50:26 -0300 (BRT)
Date:   Tue, 2 Oct 2018 12:50:26 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Sanskriti Sharma <sansharm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 5/5] perf tools: free temporary 'sys' string in
 read_event_files()
Message-ID: <20181002155026.GF9457@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
 <1538490554-8161-6-git-send-email-sansharm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538490554-8161-6-git-send-email-sansharm@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Oct 2018 15:50:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 10:29:14AM -0400, Sanskriti Sharma escreveu:
> For each system in a given pevent, read_event_files() reads in a
> temporary 'sys' string.  Be sure to free this string before moving onto
> to the next system and/or leaving read_event_files().
> 
> Fixes the following coverity complaints:
> 
>   Error: RESOURCE_LEAK (CWE-772):
> 
>   tools/perf/util/trace-event-read.c:343: overwrite_var: Overwriting
>   "sys" in "sys = read_string()" leaks the storage that "sys" points to.
> 
>   tools/perf/util/trace-event-read.c:353: leaked_storage: Variable "sys"
>   going out of scope leaks the storage it points to.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
> ---
>  tools/perf/util/trace-event-read.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
> index 6a0d0f2..dd045fd 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -347,9 +347,12 @@ static int read_event_files(struct tep_handle *pevent)
>  		for (x=0; x < count; x++) {
>  			size = read8(pevent);
>  			ret = read_event_file(pevent, sys, size);
> -			if (ret)
> +			if (ret) {
> +				free(sys);
>  				return ret;
> +			}
>  		}
> +		free(sys);
>  	}
>  	return 0;
>  }
> -- 
> 1.8.3.1
