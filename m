Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D9C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F65720824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SGQfsiNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F65720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJXTTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:19:00 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:45846 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeJXTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:19:00 -0400
Received: by mail-lf1-f49.google.com with SMTP id c24-v6so3573451lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8fpNZgBwP03I04wKzss8HNVJHCepCy3mKSjCctRFao=;
        b=SGQfsiNdUWmhRlHsCHWj1khRioB9glSY+xazUQNXsbx6lTCCvwdYt06KahZq2RuJ/Z
         SI2kYi2MWXZr2585GPy5nmHhOlnTvsCprCy+tYBr6byobgYUwym6PzNirnQKppVUM4qT
         /kkoaoWzeR7TVs3DfvEmEYQDzdtCniZYucQWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8fpNZgBwP03I04wKzss8HNVJHCepCy3mKSjCctRFao=;
        b=Z6+T0sCvQxFgNWszbOEv71ixR07Hbm/n05bxrm0CaYdSGtwGH/hNmwzrwC4jImba6+
         OknLM8c21c+LJxiM4SUUOf6hmGQEktBnJ1Ui6OLSD8RPGlAbW6jjR6D+62nhaVaIFoBZ
         CrCVH38x7gCnhSeYzOnlTTvA1GDiI9b5ioyGHoXyuxbwBuK53iB+DON3pjqMt7CtvaJw
         SMaC79KOXRluzYDNlnQdemWgH3J+1vFU0fNWd3dhIB3U9furqGW6W8fcjMDjsnkCbnCr
         sqf/p++RtwTZdroowvGCqck8NO1AFE+BX9VNPo9620XRpSRYGPsDKO/0zWEqUcdlcfzD
         u2Fg==
X-Gm-Message-State: ABuFfojGlaZjpMvcOrtHWjIrQ/VKAHSfuQ1uCrLd1zTWzmt258Zz8F0M
        6OEqgEwbAVIIy3hD6WJGcpQ3u46vFpAdxG9z
X-Google-Smtp-Source: ACcGV61argvwdpljNMiydKyvbXWrbfA/SECavaQNqZ7lIi/8T/1Jm1IxSJ1OQNs06chVwAsZgnGSrQ==
X-Received: by 2002:a19:1202:: with SMTP id h2mr8888843lfi.122.1540378281290;
        Wed, 24 Oct 2018 03:51:21 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q141-v6sm650947lfe.73.2018.10.24.03.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:51:20 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p11-v6so3584241lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:51:20 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr3948781lfa.106.1540378279949;
 Wed, 24 Oct 2018 03:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810232013020.19032@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810232013020.19032@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:51:03 +0100
X-Gmail-Original-Message-ID: <CAHk-=wi8Z5tF+B+6ReZzKXLpG9Nn-91y1ahSqgvU29vaq7t=WA@mail.gmail.com>
Message-ID: <CAHk-=wi8Z5tF+B+6ReZzKXLpG9Nn-91y1ahSqgvU29vaq7t=WA@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for 4.20
To:     jmorris@namei.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:22 AM James Morris <jmorris@namei.org> wrote:
>
> Please pull these general updates for the security subsystem.

Thanks, pulled,

            Linus
