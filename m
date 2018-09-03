Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EF72086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUeSqedX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeICXdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:33:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33248 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICXdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:33:47 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so2571819oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCGTOiLZtuBSfkxGIzuJrWE3aME+7YDJMu6yNOSkf9k=;
        b=WUeSqedX6OCaeeEbkMVZ+JUhpUYt/JSjkRtJQ07GEgeLCXAsSmMuvA6C1slQtG+G7k
         YQ05QUble67X0fgml/poUZSDBhASCzjF78aYTiTnvumwdJI6W/rW5Yr/cWiCU5w5SPJU
         kootkIqeOYZH/xttNihLQui2DyR4luFJ1y/eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCGTOiLZtuBSfkxGIzuJrWE3aME+7YDJMu6yNOSkf9k=;
        b=q0NWU+QbaYauaccrpOURRsrGtGbLUBWsLcQ0Pu3jG8BWd7jRWVR5knnOukt44Y5igJ
         WTLK72zroff1tJsxyQY4GHYlmV3bmaphGFE8xHZlgvQ7OSICBZL+HUu9k201iVdqaWhj
         cEghePaPdXeosJ2skxGAWolzHQJHgqtgZU9S2b50SzenkqCSoHTQekkSIdQZZzbF2lqh
         o3qIhqbcqg2Iday4oyjnYN7VKsf4339fopRVn4PxtH94OGj5oCRXERBNJLdXatndWNzd
         /YxDykt/oQKBMWfkkEYnW/o5NNojvZmn9myBAFlIAJPZOesaiw6N5nvmrJO23eM/WDVv
         3RUg==
X-Gm-Message-State: APzg51AhRokh1Xu2ud51SSRtVqmn9tGC8e0SUcq8/4Emf4QmD2sUal3T
        JODLzUtCZ6+aFJwoGU/fNb6I4chpwpM=
X-Google-Smtp-Source: ANB0VdbbKOGHLcBxOXzOApHD2My4/33eUqLtyY+bu5VKdooJ7GTNCX6oRsf46zhUOM3Qh0uSvaFTeQ==
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr1326234oif.71.1536001933718;
        Mon, 03 Sep 2018 12:12:13 -0700 (PDT)
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id p132-v6sm11344308oia.31.2018.09.03.12.12.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:12:12 -0700 (PDT)
Received: by mail-oi0-f47.google.com with SMTP id m11-v6so2558281oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:12:12 -0700 (PDT)
X-Received: by 2002:aca:3546:: with SMTP id c67-v6mr22070902oia.249.1536001932096;
 Mon, 03 Sep 2018 12:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org> <20180903190457.27088-1-rafael.tinoco@linaro.org>
In-Reply-To: <20180903190457.27088-1-rafael.tinoco@linaro.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Mon, 3 Sep 2018 16:11:46 -0300
X-Gmail-Original-Message-ID: <CABdQkv_ZM7JCM+k2F4PzauzU+cooydLfF=uk98EpZTti9_Z93g@mail.gmail.com>
Message-ID: <CABdQkv_ZM7JCM+k2F4PzauzU+cooydLfF=uk98EpZTti9_Z93g@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: membarrier: reorganized test for LTS supportability
To:     shuah@kernel.org
Cc:     rafael.tinoco@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 4:05 PM Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:
>
> This commit re-organizes membarrier test, solving issues when testing
> LTS kernels. Now, the code:
>
>  - always run the same amount of tests (even on older kernels).
>  - allows each test to succeed, fail or be skipped independently.
>  - allows testing features even when explicitly unsupported (force=1).
>  - able to consider different return codes for diff kernel versions.
>  - checks false positive/negative by checking ret code and errno.
>  - can be extended easily: to expand an array with commands.
>
> Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Shuah,

You will find all tests, for kernels 4.4 4.9 4.14 4.16 4.17 main and next, here:

https://bugs.linaro.org/show_bug.cgi?id=3771#c8

I hope this address all your previous concerns for the test.
Please, let me know if it does not and/or you find something I should change.
Thanks in advance,
-Rafael
