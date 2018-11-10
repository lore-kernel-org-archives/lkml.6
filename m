Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C259C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B420840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bba6HCAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4B420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeKKDl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:41:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44255 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:41:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so7117507qkh.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding
         :references:date:in-reply-to:subject;
        bh=iULDBYyPE6AFQPLd4i0McCGCSaI9+qyothMxeHkTiCE=;
        b=Bba6HCAvcXys2NAOqYsjvqPX5JBoMhGqwba/G9s8aAZ5PFLlukjexjkWtwjKkpU3yU
         otVqpBpuost2rpqLP8mUzGGqIZ7AkwGtJzg0FUhgRdvFDQNCxAUHPYUpWvDPvmmi5MCe
         LdxpYwTYEsoNWQWIFZXXtvwu5UJtr0XQCi1gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:references:date:in-reply-to:subject;
        bh=iULDBYyPE6AFQPLd4i0McCGCSaI9+qyothMxeHkTiCE=;
        b=fG0T6Rpl8rLT+/YhsGP1y+0qvlSJFDgOX7OKbqJzlhoQyu8+DIalLQy4Y5PPPZ3I/x
         a7CRkEtXqnm4X8K/r9MOkjSmzPgK3jZl9Emh3edpyXcNnifUcYENnqaPbwRcERl9IKYh
         XpHdfms1W3FaCzckoJDM5VL2lX7LRmzNSdCaG1719Opdm8Bm71vzadg3td4jraB0QW7L
         54mgMme9DJExZC2lUzv0xsJYHxa5pdjACDYjm4xXyi6bBJzX4ER1qkD2+wxcvTvFw7Ai
         wtyWwte9iDWGexPK1v2KpsfW4uBbtE7iVijF93SZB7sqXZJ+ghfOot7i9BELeK8ziRd6
         1lgw==
X-Gm-Message-State: AGRZ1gI+BYgiafjzKP9iJMh8lTDAabsRzZjYhgEj+2u8GNsOMv7Ooy1W
        EGruFjsrzdfZDdEoE5C32xsDvg==
X-Google-Smtp-Source: AJdET5fTvQl4zVb0hIFTE50OzA8Lmr4ZhuOUxxn9iKZJ3y8XewvVD4IGj1u6pOTkWniK+BI03IL1SA==
X-Received: by 2002:ac8:67d6:: with SMTP id r22-v6mr13195362qtp.356.1541872565224;
        Sat, 10 Nov 2018 09:56:05 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k38sm7064259qkh.72.2018.11.10.09.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:56:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id B900821C5F;
        Sat, 10 Nov 2018 12:56:03 -0500 (EST)
Received: from web1 ([10.202.2.211])
  by compute1.internal (MEProxy); Sat, 10 Nov 2018 12:56:03 -0500
X-ME-Sender: <xms:sxvnW52zFGMamfjpwFyi694nQuQLvCVXixZLnV1b1bHyFAtb-A2QOw>
X-ME-Proxy: <xmx:sxvnW1P27EcRd6uzeFqmhl5GxhThjgOHS46el5WQVCQcVWleSG0jDw>
    <xmx:sxvnW_PZh5hR9P3oJQEqow_7DlDlihPlO1cSiEpFlRZZoo0mOW12SA>
    <xmx:sxvnW82AN5R9IhE7UGqtLFWRao-dAPZjevbQpYaBOB3iQzLrriI34w>
    <xmx:sxvnW_GkyV15P1LMXZ3AJofIlQu6yMq596cg3UqjyBy5WexKndhxUw>
    <xmx:sxvnW1iW9FYBtN08vluY7O4mcgGylQ-IKZd34geYQs99IrGxcFbW8A>
    <xmx:sxvnW0FkKI6a7Fedf3Vpei-mS-GLetkl5R65m2-XzHnLEiiel-52gW8aCOeRXOwV>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 60C6A9412A; Sat, 10 Nov 2018 12:56:03 -0500 (EST)
Message-Id: <1541872563.3175498.1572453416.153B57C9@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     gorcunov@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181110174727.GA26417@avx2>
Date:   Sat, 10 Nov 2018 15:56:03 -0200
In-Reply-To: <20181110174727.GA26417@avx2>
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018, at 3:47 PM, Alexey Dobriyan wrote:
> On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> > Merge proc-self-map-files tests into one since this test should focus in
> > testing readlink in /proc/self/map_files/* only, and not trying to test
> > mapping virtual address 0.
> > 
> > Lowest virtual address for user space mapping in other architectures,
> > like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> > guarantee that when MAP_FIXED flag, important to this test, is given.
> > This patch also fixes this issue in remaining test.
> 
> > -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
> > +	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
> 
> I don't know ARM. Is this 2 page limitation a limitation of hardware or
> kernel's?

Kernel:
https://bugs.linaro.org/show_bug.cgi?id=3782#c7
