Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765919;
	bh=VKWP7J3F85iZxuzl8iXn6OTP5+YyKZLhhuvNl8PWFDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v6y9CG9WG59MTJdy6IbTtXXRbtB+trkm3RI0dbNaQB2mswN6RF4WtJiH5/FjOEWhU
	 frdzEzPZv2jaaQ5fzy+bOlNL3t2pCRGpvTYuxGcl0FTn7svujYgyO2F9NOu4BwK5B8
	 U5RM8JrJEkt7cuv9bFcUNpcCwQe03NR4ncJMAf7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfBUQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:18:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44789 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfBUQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:18:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id a81so1838308oii.11;
        Thu, 21 Feb 2019 08:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKWP7J3F85iZxuzl8iXn6OTP5+YyKZLhhuvNl8PWFDw=;
        b=tOay44o/ouFCRVxfMUlCd4XrjwPGCuVy1pe0HPzv5u7M2V9hNeJ/CKvQOa2E2orxsq
         3uQAmBqrb47yN0lUGXGCx8ELL6ESIY6uRJpsryTgC8NobGMrSFI6a8TsmC8QPgnE9Nqh
         a0glMCnRuFaxthyCH4kWvATl1LlcgAfm+YwKvoaPrB9dDVzSt/092Xtk68z0Fx8fAAIt
         dmeV//OYFnTcVMh8FtBO3m8oirClu/igIxfZGShJhUYxZJkv7FWoHLD3dRpPO2kV/KCN
         JaEiSYpGWNkutJa/muDoVmoGz0NSzvPn6UQA+2yJ7LZv5Hk5MG0YDyrO6yKmM5bPTr9C
         BUrA==
X-Gm-Message-State: AHQUAuY0EP6aKj/geQXOZT4h0azB8idAWTNcjx5zY0tA0Ot0HyqUpoqz
        J25tEeTXX16M5dgT/HImHxDcZksAS4LAtfIrR552ig==
X-Google-Smtp-Source: AHgI3IYkX3rM505BnYbgfXMYpkOpy9iNf8GrzZSXcfpFi/BYoYuRIA1aY6LZtRI7WUMyAV57Q1lvXqFm7uqMZiXYloU=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr9810181oih.178.1550765916803;
 Thu, 21 Feb 2019 08:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190221145631.26356-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Feb 2019 17:18:25 +0100
Message-ID: <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Predicting the next event on the current CPU is implemented in the
> idle state selection function, thus the selection logic and the
> prediction are tied together and it is hard to decorrelate both.
>
> The following change introduces the cpuidle function to give the
> opportunity to the governor to store the guess estimate of the
> different source of wakeup and then reuse them in the selection
> process. Consequently we end up with two separate operations clearly
> identified.
>
> As the next events are stored in the cpuidle device structure it is
> easy to propagate them in the different governor callbacks.

Can you explain a bit how you would use this new callback in a governor?
