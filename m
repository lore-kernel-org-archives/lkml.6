Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F791C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E5920652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E5920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJBW3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:29:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBW3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18E9E9090D;
        Tue,  2 Oct 2018 15:45:19 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A16452010CEC;
        Tue,  2 Oct 2018 15:45:16 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 333131AEB; Tue,  2 Oct 2018 12:45:13 -0300 (BRT)
Date:   Tue, 2 Oct 2018 12:45:13 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Sanskriti Sharma <sansharm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, acme@kernel.org
Subject: Re: [PATCH 1/5] perf strbuf: match va_{add,copy} with va_end
Message-ID: <20181002154513.GB9457@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
 <1538490554-8161-2-git-send-email-sansharm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538490554-8161-2-git-send-email-sansharm@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Oct 2018 15:45:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 10:29:10AM -0400, Sanskriti Sharma escreveu:
> Ensure that all code paths in strbuf_addv() call va_end() on the
> ap_saved copy that was made.
> 
> Fixes the following coverity complaint:
> 
>   Error: VARARGS (CWE-237): [#def683]
>   tools/perf/util/strbuf.c:106: missing_va_end: va_end was not called
>   for "ap_saved".
 

Thanks, applied to perf/core

- Arnaldo

> Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
> ---
>  tools/perf/util/strbuf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
> index 3d1cf5b..9005fbe 100644
> --- a/tools/perf/util/strbuf.c
> +++ b/tools/perf/util/strbuf.c
> @@ -98,19 +98,25 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
>  
>  	va_copy(ap_saved, ap);
>  	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> -	if (len < 0)
> +	if (len < 0) {
> +		va_end(ap_saved);
>  		return len;
> +	}
>  	if (len > strbuf_avail(sb)) {
>  		ret = strbuf_grow(sb, len);
> -		if (ret)
> +		if (ret) {
> +			va_end(ap_saved);
>  			return ret;
> +		}
>  		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
>  		va_end(ap_saved);
>  		if (len > strbuf_avail(sb)) {
>  			pr_debug("this should not happen, your vsnprintf is broken");
> +			va_end(ap_saved);
>  			return -EINVAL;
>  		}
>  	}
> +	va_end(ap_saved);
>  	return strbuf_setlen(sb, sb->len + len);
>  }
>  
> -- 
> 1.8.3.1
