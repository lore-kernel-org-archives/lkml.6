Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BC32082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BC32082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeH3P4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:56:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35594 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeH3P4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:56:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id 89-v6so5511392qkp.2;
        Thu, 30 Aug 2018 04:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMkJRfcvKnFcYB76xEo03K/fDVUWqwMLhV2vmNlOfU8=;
        b=ct9PweLNJk45TIg4RlPR/ic9vvnXvO2OBWlPAbMfBkwvi8OgBoV9QotVQH4MsG+Q0l
         fAvzdrbPC74ukVFaFq6lNIgwnn3mZCdmCnjBAsfARfH7CLJBpP2mjE0+5q3SDCVmELMg
         X7nmK+0ozdpkG1gZHv71MlEi7JAi7yLp304S6+DYknjjSQB+TxjOihbF1IUoKhQF8uNE
         jPqBOwK6CrW5GZuB4gkV/0mJzNbeE4QjbjNbdLjO19PBJn2qg6tOsWv3Srg27j934kX4
         tOJ5wnlYN4nekUrreA0D0Hw1T5XSzzL657NKplrMquqSwviQ5HX3+UBVSwgQfF4OJfJF
         ACRA==
X-Gm-Message-State: APzg51Acr5OSxJZNLX3WkVDelojxBgLDXqkmPCq3NqkjAoYg/m/2DwSz
        Lz7yQ5SFh+sjXksEtKQuzg/h1fAmYKpPVIMuxXI=
X-Google-Smtp-Source: ANB0VdY3U6zDi9HUaEjrukl9kVYL1jk9k8HYjkWxAZ8zczTsoepeL9dt7Kp6lDjz7YbCDk/VNICNjQAuesChPEqkj4E=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr10932232qkh.173.1535630105117;
 Thu, 30 Aug 2018 04:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180829140409.833488-1-arnd@arndb.de> <20180830110453.GC1473@alphalink.fr>
In-Reply-To: <20180830110453.GC1473@alphalink.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Aug 2018 13:54:48 +0200
Message-ID: <CAK8P3a1WSa5yPWXYGieAc0+Xk=CAy_G-RhNNcQBsGQGOU-8WfA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] pppoe: fix PPPOEIOCSFWD compat handling
To:     g.nault@alphalink.fr
Cc:     Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, mitch@sfgoth.com,
        mostrows@earthlink.net, jchapman@katalix.com, xeb@mail.ru,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 1:04 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
>
> On Wed, Aug 29, 2018 at 04:03:26PM +0200, Arnd Bergmann wrote:
> > Support for handling the PPPOEIOCSFWD ioctl in compat mode was added in
> > linux-2.5.69 along with hundreds of other commands, but was always broken
> > sincen only the structure is compatible, but the command number is not,
> > due to the size being sizeof(size_t), or at first sizeof(sizeof((struct
> > sockaddr_pppox)), which is different on 64-bit architectures.
> >
> And the implementation was broken until 2016 (see 29e73269aa4d ("pppoe:
> fix reference counting in PPPoE proxy")), and nobody ever noticed. I
> should probably have removed this ioctl entirely instead of fixing it.
> Clearly, it has never been used.
>
> If you think it's worth fixing (as opposed to dropping this ioctl or
> its compat mode), then,
> Acked-by: Guillaume Nault <g.nault@alphalink.fr>

I don't care much, but fixing it seems seems easier than coming
up with a convincing rationale for dropping.

I'll update the changelog text to include your additional background
information though, unless someone else prefers to have it dropped.

       Arnd
