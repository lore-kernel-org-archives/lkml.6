Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0437C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q4yKF9vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7728920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLLDyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:54:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37862 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLDyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:54:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so9978270qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 19:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=om3HVc6pjUbCI7961bkoT5XS78zOdIdclaAUd3I6+vU=;
        b=q4yKF9vqDdGLcNOB7/JfXVNMWNLwPVQOD6406S+mDgQ/6whX3j5sjNkkkpeez4EYMs
         AbIw7IegfWXqomtyg1OPdRsVpXx36NVhA3u+8DfNhCNzZBKCSt/KMh5Ig0cJwl8UgiT6
         Gskiu1ZkNHjFJXc0zpVCtXxXUolF4sF5MsQtgdkQpUIjOS3Pd+7XfOcPGNPG+JUEL9Ja
         n6qiWG6EsgdohJ1Iq4zvHqxp5rSkp7C13mS3TOS6cvFQt2Fa/e7zmIbMXL9qAQLR3OuG
         6nLoMDkxfMvpPis5rc1XT8gpcWpq+jeiPQTCS6EoZy3x2T9rnS20Dyl0FL8tGiBsPAxd
         Y7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=om3HVc6pjUbCI7961bkoT5XS78zOdIdclaAUd3I6+vU=;
        b=V4J7cGud6Y18k12uUbLxwzGC4gO4ru32G5adkurM2dk5REittYTy9QcoagqWnDtH0o
         AGJUodwKshPk+ABhETwiq84Zf9qqzFItep0LsorMTut0mjVNDDdstE5ZGAAFcqQEULt4
         Pt1XP5EwzE7KTT6TMnX83d833YwPgSVEt0hqwconqBdngOT+Ub4d36/AzO4qEgzJX2o3
         VQr6vTrixAZskLUG9tlG0CklPCPgRxAfsoxRPHhVYjkbxGatRT63aECzOKdRKy0+uyQi
         /gBo5aMwzpsmMU6rOVlKpqT7rCVLFmVbY29GNDfIt58DBdZa/fLL0RjECu+PgFMh7h+3
         CmNA==
X-Gm-Message-State: AA+aEWZpDFdgBGAURzfY2ZZk0GO3s9jBjq9IrpNTCTr7BRJlFzdSFyIi
        E3cOL6+er28DDncT33YMcm+YulfjRWk=
X-Google-Smtp-Source: AFSGD/Xo4z31X9dF8RETJ+IsP3Eko+70mfc+SDRP4bzmb/KjU1ev5CFYLnFjKbqvYL+XLkiYG0MqHw==
X-Received: by 2002:a37:6155:: with SMTP id v82mr16360390qkb.72.1544586879679;
        Tue, 11 Dec 2018 19:54:39 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 195sm8762104qki.76.2018.12.11.19.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 19:54:39 -0800 (PST)
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
 <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
 <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
 <1544566937.18411.9.camel@lca.pw>
 <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <9248f272-4b8f-183d-73eb-28fed1debcd2@lca.pw>
Date:   Tue, 11 Dec 2018 22:54:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/18 6:06 PM, Arnd Bergmann wrote:
>> I am thinking about something it is probably best just waiting for those major
>> distors to complete upgrading to GCC9 or back-porting those stack reduction
>> patches first. Then, it is good time to tie up loose ends for those default
>> stack sizes in all combinations.
> 
> I was basically trying to make sure we don't forget it when it gets to that.

I added a reminder in my calendar to check the GCC9 adoption in Q2 FY19.

> 
> Another alternative would be to just disable KASAN_EXTRA now
> for gcc versions before 9, which essentially means for everyone,
> but then we get it back once a working version gets released. As
> I understand, this kasan option is actually fairly useless given its
> cost, so very few people would miss it.
> 
> On a related note, I think we have to turn off asan-stack entirely
> on all released clang versions. asan-stack in general is much more
> useful than the use-after-scope check, but we clang produces some
> very large stack frames with it and we probably can't even work
> around it with KASAN_THREAD_SHIFT=2 but would need even
> more than that otherwise.
> 
>          Arnd
> 
