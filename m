Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E8A22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EbKq9yhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E8A22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeKMUYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:24:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46329 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeKMUYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:24:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so10314197ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yvaLrMYlmShFxWOE6/uiTzd6EuykZhWYPK7sNtKjcUc=;
        b=EbKq9yhJl2mTlhzV6TAkUKOcPERzyipemuuIqfZBxhfrRpM2ouxI1Jkdh2RodOQLtA
         giV/VLrsbfSZbzTRhOnpnR6MX1KhyIvr9WcbEN/Ovp36sWKUwoUpP6OooJyKDpeA6I6A
         Z609n20lKPYqCh+Jxwkzjj3ehfd22sbSQsAwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvaLrMYlmShFxWOE6/uiTzd6EuykZhWYPK7sNtKjcUc=;
        b=KoqDUsssMQESyFcaRdsbDbK8oeIPvnIvFSNgWZDucJWyOguZWMW1hCm9rXrKVYNGmL
         fbgUbyh2q8KFmMx0pGXnoj3cb1k06xN7y0dv4jr4/PQc12sQGiaSxGtU5k2p9XRCHEGj
         oYI7qVeNPPUpzSe4RQuQGEzNAlnj/tAQ/n3c+3RqA1NGDzsAVZbv43W2G0jXy9DcI9kv
         TlInps3pNTRIV8LziyiRZr1UQGRo6wHfsJBiN3jM1EogDzQjRs1pfXiWFOtbtj4Kx6Y/
         vwJhvieBsX9Yub6wcDpolQ7yKYElz8bZgtp1wbuI07lkujmcvF3ZnuH7I56XW1S28Aog
         1RqQ==
X-Gm-Message-State: AGRZ1gJIlNUvDayMLVAN2Sa6g28S04IwAYV2YXLNtVlczQpxM9kWaIDo
        1tGncWqE3WIIuOf0lX83X/XG2A==
X-Google-Smtp-Source: AJdET5cpk7eZDtajfMRkxYoNbUOYtzZO9cwAd9NO5L1J8gtxINdIR/HrwbBvhmO0330vKK8wgRDF4Q==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr2786396ljv.68.1542104810013;
        Tue, 13 Nov 2018 02:26:50 -0800 (PST)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t7-v6sm3326482ljh.1.2018.11.13.02.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 02:26:49 -0800 (PST)
Subject: Re: [PATCH] fork: Fix two -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        konrad.wilk@oracle.com, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, riel@redhat.com,
        viro@ZenIV.linux.org.uk, zhong.weidong@zte.com.cn
References: <1542093988-42041-1-git-send-email-wang.yi59@zte.com.cn>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <cba61508-3e50-f8df-d75a-37d2e41a17c4@rasmusvillemoes.dk>
Date:   Tue, 13 Nov 2018 11:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542093988-42041-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 08.26, Yi Wang wrote:
> We get two warning when building kernel with W=1:
> kernel/fork.c:167:13: warning: no previous prototype for ‘arch_release_thread_stack’ [-Wmissing-prototypes]
> kernel/fork.c:779:13: warning: no previous prototype for ‘fork_init’ [-Wmissing-prototypes]

I think you should also remove the "manual" declarations from the .c
files that call the function, in this case fork_init() in  init/main.c;
otherwise there's no guarantee that those translation units actually
include the header that contain the proper declaration.

arch_release_thread_stack can probably just be removed completely after
the recent arch cleanup, since bb9d81264 (arch: remove tile port) no
arch seems to implement it.

Rasmus
