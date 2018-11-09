Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B89C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A0320818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU17yqha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A0320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKJCth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:49:37 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:33875 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:49:36 -0500
Received: by mail-pl1-f176.google.com with SMTP id f12-v6so1220877plo.1;
        Fri, 09 Nov 2018 09:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEok+XwZ4rVtYqKnYBBuAW3zq87JeoaRr10G6fg8Tvs=;
        b=RU17yqhanwT0vvD2QZJjy+6DD8MTEZpq2DDcOJ2JCj2SIwYNhftK/keIstmOc8esnl
         GEItK59hIMfN9vS3zTVi2fEDyyq/UyBvKoMlrbn/fsCSFzdxR2ryY1vAnkdC2vfP/GJu
         B5LF2F7nFFJcr/nxg4jE4qbE1S9TojEkh7qXKHCdA9ERH64l3U7cq76/ZgwCiaUd2IJ1
         bFxBtA9woUwXSp22/SYMgxIS3dae0ParU0t70Zo1fnKigvZtt/0Md2FWgOMwxta1ZZ5L
         OaJAzjY7kksTyKmE/ZmJryArW+fQc+dwceYs7S2OCi1CqR8gIcYy9CEbnUAXRYIUDxX8
         O6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEok+XwZ4rVtYqKnYBBuAW3zq87JeoaRr10G6fg8Tvs=;
        b=n2RH0Y4LBx9AGdpqwcKiDtowkoXHCoKdlUJWgaBG5aZobJ+QniLxNshGn98KrAtXGn
         iZn03y7WyIzErGMtNDNGiUwDn6hp7t47W69iNdwXSXS4ETyCBq2MhLUu/le79C6qrShn
         yaMnYN9P7iQwK7gHFHFkPE8SZUNWFxzGxftGKdiWvSRrc7+00ZA++0to5abX7NtPBcWt
         YiUz9V6t98TMRmto0AlXcrutAbmhGomhdi/pFM+0ME94/7y19//POGPoo3cSuAScRVff
         rTeRPovqRGRV8lgBTU/RRM89wHsyuvTtGdlGnteG9Ki/ogkZ/VcpxE2u6SM+rGXYQ50l
         rY3A==
X-Gm-Message-State: AGRZ1gIWyIDblbJV8w3lbaBBJePv8XSUY3HyPzaAYBeZiKfvsbv507cF
        4Pr0UEdWBNXMiY80wnp4Bwo=
X-Google-Smtp-Source: AJdET5cFWrx1UzQruJ6xbFebJ8LxTNDqBW2ogAUh7JWaH6Ok3INHtYAM1jYScRnA9BrdgDMWYw6UiA==
X-Received: by 2002:a17:902:28e7:: with SMTP id f94-v6mr9747487plb.297.1541783289507;
        Fri, 09 Nov 2018 09:08:09 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:d22:ab19:3958:9c63? ([2601:282:800:fd80:d22:ab19:3958:9c63])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm9270689pfa.176.2018.11.09.09.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:08:08 -0800 (PST)
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
 <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
 <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
 <050ABAC6-6C3B-4B6B-BB68-727127E00B51@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <37d2c7a8-fe99-94bd-9b8f-24e9ca9fa39c@gmail.com>
Date:   Fri, 9 Nov 2018 10:08:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <050ABAC6-6C3B-4B6B-BB68-727127E00B51@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 11:49 AM, Song Liu wrote:
> Could you please point me to more information about the use cases you worry 
> about? I am more than happy to optimize the logic for those use cases. 

bpf load and unload as just another tracepoint to throw into a set of
events that are monitored. As mentioned before auditing the loads and
unloads is one example.

And that brings up another comment: Why are you adding a PERF_RECORD_*
rather than a tracepoint? From what I can see the PERF_RECORD_BPF_EVENT
definition does not include the who is loading / unloading a bpf
program. That is important information as well.
