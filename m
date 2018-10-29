Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11941C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57B42082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tn1fv9w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57B42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeJ3AzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:55:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35214 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJ3AzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:55:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4145415ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdhJcZeXosYOeahKf1VNSPXOmnJepwE51rrCWCvI/Ps=;
        b=Tn1fv9w85uRppSWEZ+jaHoBn/zqFMJmSc53a/Z7XT4b0MKxE8PGx6Vvm10nnnvQDDy
         T3qc08puHk/fOpmgURlvlUnmhCE4qxt/4UFhJYjYeITnM5QNz4TWnnGKtkZJIArTBe8K
         AtKXbTrnm7hhlnAjJcBaNZ82mQw5rxiFk9CzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdhJcZeXosYOeahKf1VNSPXOmnJepwE51rrCWCvI/Ps=;
        b=FxKXZ3jtKCkQTR14NFgFPma/llLCMWrtjolfrdoDWASgoYXJRWm4t3M22I2DmvbBSw
         o3WI8x+rR0safLyKR9zFnCr3eDLKP8ct8F2C/9YhN3gcHaIUT9Ve5XBSZ2bGxewyoGD4
         Ide79nocWz5a1l8uNHLYAz08IHPLjwBRgdAWyP1IC/m+D7uLp1slkSrmuOjtGmxbBgzK
         hMmXEpf9sjIwvvl6Fx7dbiqUlvd9a+7TPTLt1UjxP1vH/BT7XaETAkamUQMjR09Wlk8S
         FwOG1aloz0a0Br21FDavHqk3cvuLBUAHBu+Wz8R+N4zHtJFyXSChzcd5YXFMeYF20t9U
         mlYw==
X-Gm-Message-State: AGRZ1gLHnGF1jI1DJcgdeY5IdQpN5D7JUNRQ57Y+IR+xC4gvN4nMhy0B
        oan0cSLEwGhq8rZAXpudfM/BomO9t8S3FA==
X-Google-Smtp-Source: AJdET5cibEFxsOomLoDKSssqbrVjZkCEDGdjag9BOoSqsKCn78De4waHUgNt16VLYO5d/mgf6VUghg==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr9495502ljh.59.1540829154267;
        Mon, 29 Oct 2018 09:05:54 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v19-v6sm3362020lji.10.2018.10.29.09.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:05:53 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id j4-v6so8336617ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:05:53 -0700 (PDT)
X-Received: by 2002:a2e:9f42:: with SMTP id v2-v6mr4976721ljk.80.1540829152657;
 Mon, 29 Oct 2018 09:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <4071c24c-db60-c098-9fe7-aad3dc528f39@linux-m68k.org>
In-Reply-To: <4071c24c-db60-c098-9fe7-aad3dc528f39@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 09:05:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0gMicoQEHXfLJVohDqoFjZq0Ry57i_vTu=O=YFZBN+g@mail.gmail.com>
Message-ID: <CAHk-=wj0gMicoQEHXfLJVohDqoFjZq0Ry57i_vTu=O=YFZBN+g@mail.gmail.com>
Subject: Re: [git pull] m68knommu fix for v4.20
To:     gerg@linux-m68k.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 8:20 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Only a single change to fix an out of bounds array access when
> parsing boot command line.

Pulled,

                    Linus
