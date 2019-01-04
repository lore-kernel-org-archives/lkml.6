Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ABE218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546616930;
	bh=Xw2FIjLTDre0nYg/MuTf/Jy+ILjleZHZAQbdbu9tWp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aaGlznRoLclYlcWwhNpotE46pq5o94wAjakWoUHn30ITp3SvzesqXrQH8YJgSEqt4
	 M91h9Hz0I9vG6PeolFb06hf84G8SnOxnZO88f1NATxBYH4NWsUu6T52Le6EYj6GV2d
	 jlPXpcRD0s7pKpVAuRkPSc+vszDGa+zj14uhGCkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfADPst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:48:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A471821874;
        Fri,  4 Jan 2019 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546616928;
        bh=Xw2FIjLTDre0nYg/MuTf/Jy+ILjleZHZAQbdbu9tWp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=js1Pv3CiluuIHBrMORduy/OZi1i2hw32Iqg9KNT99ywWwW2df1XpLOb9m+u5zr1hm
         qHhQCmdt7tkQ4xCDt6Ykcz9L3wsoaRa+5ApTrwg1EMYImQshL7HGsYhS+ZqPXI+z/Z
         OFUXJycwhQEamMRr+Boouv66L7yDcTOE2HbBs/uQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 752A240341; Fri,  4 Jan 2019 12:48:46 -0300 (-03)
Date:   Fri, 4 Jan 2019 12:48:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     peterz@infradead.org, mingo@redhat.com, sansharm@redhat.com,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf tools: util: remove redundant va_end() in
 strbuf_addv()
Message-ID: <20190104154846.GC9833@kernel.org>
References: <20181229141750.16945-1-2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229141750.16945-1-2pi@mok.nu>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 29, 2018 at 03:17:50PM +0100, Mattias Jacobsson escreveu:
> Each call to va_copy() should have one, and only one, corresponding call
> to va_end(). In strbuf_addv() some code paths result in va_end() getting
> called multiple times. Remove the superfluous va_end().
> 
> Fixes: ce49d8436cff ("perf strbuf: Match va_{add,copy} with va_end")
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>

Its nice that you included the Fixes tag!

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/strbuf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
> index 9005fbe0780e..23092fd6451d 100644
> --- a/tools/perf/util/strbuf.c
> +++ b/tools/perf/util/strbuf.c
> @@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
>  			return ret;
>  		}
>  		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
> -		va_end(ap_saved);
>  		if (len > strbuf_avail(sb)) {
>  			pr_debug("this should not happen, your vsnprintf is broken");
>  			va_end(ap_saved);
> -- 
> 2.20.1

-- 

- Arnaldo
