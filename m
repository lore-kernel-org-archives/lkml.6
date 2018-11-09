Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A892081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYGOa0jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A892081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKJEan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:30:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39370 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeKJEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:30:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so3363179qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding
         :subject:in-reply-to:references:date;
        bh=LNt8LDY8VEI/4B0ghJVww5Nw4EOj0g1Gnn0F2TUIu7k=;
        b=BYGOa0jZ7gadutGue3Y52mz/eEKMdDXusbJGun1/LaFimgRPl0u3lFsrC/3KcNpTsA
         1z/DOzg5iglPDCkOBl1jSz0tkay40XWeav28JMwRAjNztTvq7s01xTteUr8F8NF1aCuR
         eO9h1kks+GSomXvK8CKoN4J+CxZNp5JMGcM64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:subject:in-reply-to:references:date;
        bh=LNt8LDY8VEI/4B0ghJVww5Nw4EOj0g1Gnn0F2TUIu7k=;
        b=UiNCEL7AMMLdSJFsdXv8X4DZYvhpI39Eras6Bh145l8jnoLVZxTGrFBhuKh6LYrGKW
         cMwmpb7UFsIUIFDzEqIxMxbf3zxn+LxkLeRuihO78PFvEZnBxzJA/UKwl72F1c50aLyd
         FPl0OICebhB29/5F3KWITd/3jDyjENqMBW7H1aw2rmxtr6u2TtphBmGr8vsUDmtLuT+E
         eLqWrtW3abxI6u++FlUi4XbN2pjp/jZAsdlPmQ0VKc7NJek4B8sFnA2CenYeDX/oJYT7
         sQFfOzJjA0j6lcv0f2WysHO2QyYVfZmxvsvG+WREe6snLXCY12xJlG1Ew2ONIh1W4BAW
         g09g==
X-Gm-Message-State: AGRZ1gLz1EIPaN+cOY6UUNiTbGwUjqzzfQXuAZ2nFZmOdUQV6WBtmavO
        5bpiOkR4VLUSw6Dam464XW2QZQ==
X-Google-Smtp-Source: AJdET5cAioxjPCqbpDxcsNTFdeEhZ6u4ExR2XXZMea4rPKDfCAMwGb2cyGpDqJYA/ictUCC5ZvZazQ==
X-Received: by 2002:ac8:955:: with SMTP id z21-v6mr9507301qth.305.1541789332021;
        Fri, 09 Nov 2018 10:48:52 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c187-v6sm3538228qkf.58.2018.11.09.10.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 10:48:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 907972211C;
        Fri,  9 Nov 2018 13:48:49 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute1.internal (MEProxy); Fri, 09 Nov 2018 13:48:49 -0500
X-ME-Sender: <xms:kdblW3FAHNhK72cT0l9AF3s90LrBsc9EHQpI6segrI6kluDIg95RgA>
X-ME-Proxy: <xmx:kdblW7UA-wjZeW2M_vpm5I5wEuHOn4SVHz8GKXQ4_HoUkaKXSLasyg>
    <xmx:kdblW4sBAnxWW7aksEvFE1JEg7xaoNvFVmeonCfVN8GYzDeLifvGag>
    <xmx:kdblW-qTEuCYendPkNaQgqT5dFmgQPoA5WobMW4j843yfcjO4S5LLA>
    <xmx:kdblW94XM16ct_5MyszEgnVxtKIgT1tLv9Tn6Qv7J5Unqf4WicnrfA>
    <xmx:kdblW8Hw_cQ5nMk1NR3hwgrwSE75QZ_5_Bf5UwjVIZSwqVfrDn2hrA>
    <xmx:kdblWxq2P_zGY1JkV4KU4SogxzjYSTj4JjTdmTBHuGgP6U6RiIkg3FIOJ7S9J6Hv>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 391C49E49A; Fri,  9 Nov 2018 13:48:49 -0500 (EST)
Message-Id: <1541789329.305173.1571657968.7229F301@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
In-Reply-To: <20181109180407.GO13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
 <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
 <20181109114850.GL13195@uranus.lan>
 <1541764873.3286172.1571234624.727F6284@webmail.messagingengine.com>
 <20181109180407.GO13195@uranus.lan>
Date:   Fri, 09 Nov 2018 16:48:49 -0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018, at 4:04 PM, Cyrill Gorcunov wrote:
> On Fri, Nov 09, 2018 at 10:01:13AM -0200, Rafael David Tinoco wrote:
> > 
> > Alright, I'm fixing membarrier_test before, so.. I guess we have a competition.. =o)
> 
> Rafael, Alexey, what about simply wrap the test code with x86 and extend later
> with all archs which support zero address mapping?
> ---
>  tools/testing/selftests/proc/proc-self-map-files-002.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> Index: linux-ml.git/tools/testing/selftests/proc/proc-self-map-files-002.c
> ===================================================================
> --- linux-ml.git.orig/tools/testing/selftests/proc/proc-self-map-files-002.c
> +++ linux-ml.git/tools/testing/selftests/proc/proc-self-map-files-002.c
> @@ -23,6 +23,11 @@
>  #include <sys/mman.h>
>  #include <stdlib.h>
>  
> +/*
> + * Should run on archs which support zero address mapping.
> + */
> +#if defined(__i386) || defined(__x86_64)
> +
>  static void pass(const char *fmt, unsigned long a, unsigned long b)
>  {
>  	char name[64];
> @@ -83,3 +88,12 @@ int main(void)
>  
>  	return 0;
>  }
> +
> +#else
> +
> +int main(void)
> +{
> +	return 0;
> +}
> +
> +#endif

let me see if I got this right.. the premise for this test is to have *at least*
2 vmas, so we can check if the symlink for the mem range, describing the mapped
area, is correct in procfs files, correct ? if yes, then why to have a totally
duplicated test... just to check if mmap(0, ... MAP_FIXED ...) would work ?

Wouldn't exist a better place to have such test ? like in
tools/testing/selftests/vm/mmap-null.c or something like it ?  genuine
curiosity.. thinking i'm missing something about this test...
