Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF92081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mon6TVNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAF92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeKKEiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:38:07 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:36385 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeKKEiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:38:07 -0500
Received: by mail-ua1-f53.google.com with SMTP id j3so1773108uap.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ipA7cP/QRAn5BQtieYyFEI4rFzLtmBirdQQRvTDA9s8=;
        b=mon6TVNMl3i0xl5uLJqLPi75pOuhNl6IKxPEejWCqtWGecnYi2vNZPszh0xtuPXc/U
         SGWAnRitiMytmIws82Imoj8Y6UL7psffV6P2KxZVgRn50du/9040nknbpYcFeWnPDmNc
         kkRSa/LxAz/X4xGGvNz0iOE4+b8jxK42eapw6HF4mb9pT/f26nVy3xacUmVkOAyTgcSo
         dlGMjZbDeITCA9wY5HU43/VNifx0AGUhea/SxZ/VwTMKjx6uq5qq4n7uE2y6tN3Dmd0C
         rPDqajJJYp+Q0RxFArOytEcKS23VnqJo8wU8rRWSW/HwcgOxKZK44aNRAhSY1iGkGk8i
         8UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ipA7cP/QRAn5BQtieYyFEI4rFzLtmBirdQQRvTDA9s8=;
        b=YYDcqBdwURvmrXQWwzYiOMjH0E4IzL1IEVdWLtQSCgKd9wr4skhmwzmhYvTyXMXf0c
         z6AVsETvRbo5Xr0mba20fd+ML9LI01T4W9CfY8prWuE24QWl54Df2uFDzlfI2gahYjwL
         I0Jp4lOCOqTD0pCuf+V34ltlyzuaR4g0vOfEISh95KhY5WyfYFTJM/oWad/j48k8Ur0g
         jlj2/msJhLFW4q8Y0ODyJ+xItgJpODF3EtRl7Fo2VOeD4UHD1O2Fg6u57WHoegRRPEKl
         20KG/B96rN/bIcEaEMkAswodR0XgCQbRaQglNXuJ9ltemSSVSdq3L4tbUkNVZwyBI8Ep
         N43Q==
X-Gm-Message-State: AGRZ1gKt24nMpj/jDdN+OfPpgJgPuRxVdg+OXOrvjjAGJI/KoLf+BmEf
        ogJDeTM4jd8sqway1gTRoGvGwZAqEUhufw+79OpJetYc6Qs=
X-Google-Smtp-Source: AJdET5dZCUn4mfRDL/6PsJLKWErhfFeJSMbtj9YCnXv0FT38cw4zoIP6Dle3vyyWFrqV5egupi41Zthw1zs8rv5epG8=
X-Received: by 2002:ab0:648b:: with SMTP id p11mr6308395uam.128.1541875927525;
 Sat, 10 Nov 2018 10:52:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 10:52:06
 -0800 (PST)
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 10 Nov 2018 10:52:06 -0800
Message-ID: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
Subject: Official Linux system wrapper library?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that glibc is basically not adding any new system call wrappers,
how about publishing an "official" system call glue library as part of
the kernel distribution, along with the uapi headers? I don't think
it's reasonable to expect people to keep using syscall(__NR_XXX) for
all new functionality, especially as the system grows increasingly
sophisticated capabilities (like the new mount API, and hopefully the
new process API) outside the strictures of the POSIX process.
