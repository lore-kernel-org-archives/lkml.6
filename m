Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B955C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC32082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIbzEfqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BC32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbeKEBhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:37:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42374 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbeKEBhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:37:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so5816485ljk.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjJo6boeBa728v+iSfi+lNuHrxjPuo1AxeIaYriCncQ=;
        b=FIbzEfqbrNA9nScDmPZhue2VY+s2LUeCNsZ/ndxy4TI1DJHSDN4ZnquqCWRZhLjfOz
         JaPJ1aMXR29m+XGwgdHQ37NDgPW77pQdT/1XSQGrYwVCOUJCzE11oyl/P+2wusRLOgw5
         z2/I7gJFfYKGF7VWqRZHsarkYv+40wchrIAaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjJo6boeBa728v+iSfi+lNuHrxjPuo1AxeIaYriCncQ=;
        b=OUR7XVnTRRhNeJyegtiTuDesOx6kD2GgwxzxmCRBor62EjiUf+2AF9n1Lcjz9EZ3vy
         o+ZTTGibc12g50zeLsIS69N7cBAM6y7n8qVezFqQguLjVC3XP3+/U2QZ2qO1km4Ab4wD
         sseakJc79DjhF0LSgqFhxVrni8k91TVBWFFI2OlQA0x2ullHEOWNu3zMYEy9MsfqVTdV
         Oagt684P+llu1NqW3bf4fuQRGwctT5cwINHmWKTiFvmK8pDEKL8vllMPxC70DmOtXUDb
         zyR4cwKc7bwxka/y8B1dlR5rENSqWNR4zlTVLWHX3Xr7qLL74zH4KZ+VwfCQE9aHk7Rx
         3Q3w==
X-Gm-Message-State: AGRZ1gK5ENQNHZsIiH1jI8/c9oEHFmDJBNciRiyf3XnM67AGsdG+Jc43
        p8sV3gMXwrLKtNzvEOoaKsYDPz5ynkI=
X-Google-Smtp-Source: AJdET5cGzEsaetQnrmXY1GlrCWR++yCwm+a0XcNCBFMT4XEt1snqcRJlBcCfHIvRMWCdrSdST83T2w==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr13425939ljc.61.1541348513345;
        Sun, 04 Nov 2018 08:21:53 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z17-v6sm3012588lfd.14.2018.11.04.08.21.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 08:21:52 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id k19-v6so5800589lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:21:52 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1745136ljh.59.1541348511645;
 Sun, 04 Nov 2018 08:21:51 -0800 (PST)
MIME-Version: 1.0
References: <9d585276a55d788b98ba425910cd4a05a9e5cf99.camel@hammerspace.com>
In-Reply-To: <9d585276a55d788b98ba425910cd4a05a9e5cf99.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 08:21:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZk7D66JYh9-2XAypcTJuKs-qOJ_xGQpkvNoaLWoy+Zg@mail.gmail.com>
Message-ID: <CAHk-=wiZk7D66JYh9-2XAypcTJuKs-qOJ_xGQpkvNoaLWoy+Zg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client bugfix for 4.20
To:     trondmy@hammerspace.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 5:56 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> NFS client bugfixes for Linux 4.20

Pulled,

                          Linus
