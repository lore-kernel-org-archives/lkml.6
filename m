Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77889C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A632075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwc/Q3Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A632075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJZGPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:15:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46357 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZGPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:15:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so3735152pgt.13;
        Thu, 25 Oct 2018 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Niel0KEmhUwWcjnvAuDhEXCrtzzbLc7BGh2YCD3Uca4=;
        b=kwc/Q3VhUhTIg7chssyeNEJxScvbhcwi3O01VqvjCp4xa1pJPiQPAsx2+xAgxV+y53
         TP+NJbWqlH52VTYbQfepHuD9UNvHFylHS1zHvGAy8d4SB/zdeL+ZTDL7jd0QHvAYSRHb
         9h9Dda0XsX70CS9iLV3uRePpeEYLqhnyyiJaXbjsouhv9FDujc6ytsQhHiHH92wLbaZi
         GaUV3m87c+xrlYZNWj/BN28nvXfNPA+ER4nJN8nbUwqw/qaYJ3JJ6X4fqkNPaqoZHQsm
         wTqsONnefNVrs3X0DzcrtyxSvOePYzSrprkoQlikwr29uI5zFg4MeZBoabMwBx4oyr+S
         mpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Niel0KEmhUwWcjnvAuDhEXCrtzzbLc7BGh2YCD3Uca4=;
        b=KT17szmfk1Yx9tocBh5xHU6B6APqab1kStCC16mUj4Ep6zxZ+fSMj/uqrLGRm1UlTS
         3M3mc7iIPKMPVcnBcpYQmfw9yKbS0Di6v8O1lC4ZsBrTsCkL7phSQK1prfZvzn49U+DU
         /njOQ6+C9HJYs1thqnNOD0UWUD86n5CDuqRY4ELeNMryXM14lGb2zeA9vHnCoHdwVklG
         5ufhmW1vetoLAPAIvvq2Toqvmmp4vSKbPqEBmsEdbAivzxs9q778PZW+EsT+/xRIK2wn
         DNKutn0xsYYNoRYXyMH2IehbAiDsA9DAaxOLNTxCYlAPls8/netHHDYREY/RTFjheBiX
         /KyQ==
X-Gm-Message-State: AGRZ1gKFbiIMY75+qpBUU5IgmQ+YdU0Q267Tn8bhZcaxfO4AE2motQHU
        ZGWykK+u5ExpMJHMchO1Xa4a3UV/
X-Google-Smtp-Source: AJdET5e3Z0AHVd0VMRQ22pFzWtRtG/A7lJS9qLc1Mp9cmhmr+QX6eOdzI68Wcy3UpADflHBA1WAe6g==
X-Received: by 2002:a63:4384:: with SMTP id q126mr823224pga.160.1540503647152;
        Thu, 25 Oct 2018 14:40:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id d69-v6sm538781pfg.125.2018.10.25.14.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 14:40:45 -0700 (PDT)
Subject: Re: [PATCH v1] net: ipv6: fix racey clock check in route cache aging
 logic
To:     Brendan Higgins <brendanhiggins@google.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181025211352.112096-1-brendanhiggins@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d787249c-0679-065a-62cb-ee9f87b1fba3@gmail.com>
Date:   Thu, 25 Oct 2018 14:40:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025211352.112096-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2018 02:13 PM, Brendan Higgins wrote:
> Fix a bug where, with certain settings, the aging logic does not use the
> time passed in as the current time, but instead directly checks jiffies.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1156
> 
> Fixes: 31afeb425f7f ("ipv6: change route cache aging logic")
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1156
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 2a7423c394560..54d28b91fd840 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1734,7 +1734,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
>  			rt6_remove_exception(bucket, rt6_ex);
>  			return;
>  		}
> -	} else if (time_after(jiffies, rt->dst.expires)) {
> +	} else if (time_after(now, rt->dst.expires)) {
>  		RT6_TRACE("purging expired route %p\n", rt);
>  		rt6_remove_exception(bucket, rt6_ex);
>  		return;
> 


I do not think there is a bug here ?

As a matter of fact, using the latest value of jiffies is probably better,
since in some cases the @now variable could be quite in the past.

