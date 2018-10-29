Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73BAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FE620843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/i29sGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FE620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeJ2MHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:07:03 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36193 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeJ2MHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:07:02 -0400
Received: by mail-lf1-f51.google.com with SMTP id h192so4905670lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7cvyGyfwxlvet4RhM+vogEmgZ3RuXyJYV2XuAB77A0=;
        b=f/i29sGUR8XNSCnmUZg0TF8WWxaujJW3W5kNBYiFpOJCMauPTSubLS/IAi3e7sSip5
         8hVLp8PlSvtRqmrebR+Z/M+LWg+l1R/2gxC6wovR/5grWrg06ZyA3L0T5u4oBFaJHapA
         VPyBRoh/KaIwjBmyoBUO/rgZ6M03cF4+XOdR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7cvyGyfwxlvet4RhM+vogEmgZ3RuXyJYV2XuAB77A0=;
        b=hb2WjRg8+mlkhVRBqK5Q2odFoDm6kPPhIyRvunLUJl4br6g0f3sjcZP2Z5sIbDyU9i
         0glIrfphq3ERcpzYZP0TrOjIe9JzJ/caf4CeVkdURbj0DggfAO/7J/VUHu6SGJyvOCiu
         moiJf+MmPQe3ag/X1zmIRUIsZaRQCUut8S9IqpRYrcuyy0L/9oJYMufXAfXkU1AMOiX6
         LlemneZGVYtxLTJRy7soxUWyuEsq2QymU/6chKT8m8kwJp216PmskHSaV5llh7+C/o+H
         mtvVvAT2R3t5mpHTouQX8gjFcDMJDaai1QBpgVlhyT3gBvobKb+WwRQsy0Ouo77Cjyus
         8mUA==
X-Gm-Message-State: AGRZ1gKJ8CBZ3hbRPezwccSiOYWgMVoTIQ2t+QklZO3kZYv0zkn/XjKN
        4diz6zcSn4kR9e11BDv6aUFSHZnpFQ9CPg==
X-Google-Smtp-Source: AJdET5e7nqOag1l9lFyyANVPc8me52Hd9T0shk8R6/7DDZFeia4uv81SQA1syVRhYT+xff1StFOVhw==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr6773231lfb.121.1540783213531;
        Sun, 28 Oct 2018 20:20:13 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u27-v6sm1732845lfc.36.2018.10.28.20.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 20:20:12 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t22-v6so6324736lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 20:20:12 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr2832640ljc.120.1540783211726;
 Sun, 28 Oct 2018 20:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181028.194639.720600183842499774.davem@davemloft.net>
In-Reply-To: <20181028.194639.720600183842499774.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 20:19:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaLTH8ZmZF8fAycTmeoHV9Csy0nW7X24J5eNR=YTbWWA@mail.gmail.com>
Message-ID: <CAHk-=whaLTH8ZmZF8fAycTmeoHV9Csy0nW7X24J5eNR=YTbWWA@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 7:46 PM David Miller <davem@davemloft.net> wrote:
>
> Please pull, thanks a lot!

Pulled,

                  Linus
