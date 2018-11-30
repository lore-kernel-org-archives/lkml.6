Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD67C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B543020989
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d9S28PaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B543020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeK3L5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:57:52 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38215 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeK3L5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:57:52 -0500
Received: by mail-yb1-f193.google.com with SMTP id u103-v6so1562065ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDRqRZXht0al4fumxf5Qwq7iaJUOr2Tzj5rEJUpl5ng=;
        b=d9S28PaIvuV4qdYXFY9qtFAlVKJnSI3pZx/gqjXMODjiatCXhMBvtpEFD5F4gvflmG
         cSxVypj9uWETv6+QiU/UgXI5OCxprwrKGrgrr3MAN8rYPP1l+oAzcpkq0GYcPTmlA2jU
         skeOwRSlRsAt/eVyvm2T0YR0OF1YL9UG5AOtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDRqRZXht0al4fumxf5Qwq7iaJUOr2Tzj5rEJUpl5ng=;
        b=n1Sug6OIiX6haNbWj78MFTYOAzqPEsMa7V5bpP4xvnKv8nhIVIVd8mGiUVprT4t8Af
         UgVIvPhLa5jLMhXqT0W2+FVBFlHNNBp/wdr34vkFgpMM/+ghvZaquObLJxoe+hFAU05A
         1K915Lcf0Tixgn88M5DBh5ff/sKuPso9L9+soDVW6JmPARKMORmWsViJI/nIsjrNPMre
         sh0w/zdsGDBIsgb0m/XEagN7NRUxQvgaDGMgxruSdMRnCiuUFM1gn2xcWd9MadhTk5zM
         KVANAznJ+Uw8VyJW2RS7/VO+/V72fi4FkaqrJ1/tBrszhkLQoHHFKc3OZzv1xgNYx0tn
         jS5w==
X-Gm-Message-State: AA+aEWZCuoAc0r1J+YdNqZgr+cBiHS4bGclatRBW1uxVdsRWQPGPWULZ
        UQWDGjqhMI116mxngxR80HLOaZw6ZMc=
X-Google-Smtp-Source: AFSGD/V+VenKa3CSU6d1vc6Cn2sn9lCQsN0eKNxIKsQYReVQF2TQv3w4bEAw7eFEqcCiQZFm6A9n9A==
X-Received: by 2002:a25:bf81:: with SMTP id l1-v6mr3514018ybk.492.1543539025388;
        Thu, 29 Nov 2018 16:50:25 -0800 (PST)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id f188sm1075269ywc.70.2018.11.29.16.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 16:50:25 -0800 (PST)
Received: by mail-yw1-f44.google.com with SMTP id r130so1589680ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:50:24 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr3837315ywp.407.1543538551723;
 Thu, 29 Nov 2018 16:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20180605085450.GA3506@scapa.corsac.net> <20180606082130.GA3730@scapa.corsac.net>
 <CAGXu5jKw-En2p3ffgfJja63E3WnF+Q7-b0S6QHOf3FOTjgu7ew@mail.gmail.com> <20181129.155200.484195944365513578.davem@davemloft.net>
In-Reply-To: <20181129.155200.484195944365513578.davem@davemloft.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 16:42:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKXk60UQ8vnX5bAGmNwru2xZxertw9kTGNy9aLU926nPQ@mail.gmail.com>
Message-ID: <CAGXu5jKXk60UQ8vnX5bAGmNwru2xZxertw9kTGNy9aLU926nPQ@mail.gmail.com>
Subject: Re: Freeze when using ipheth+IPsec+IPv6
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Yves-Alexis Perez <corsac@corsac.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        David Windsor <dwindsor@gmail.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Network Development <netdev@vger.kernel.org>, agk@godking.net,
        Johannes Berg <johannes.berg@intel.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:52 PM David Miller <davem@davemloft.net> wrote:
>
> From: Kees Cook <keescook@chromium.org>
> Date: Thu, 29 Nov 2018 15:31:25 -0800
>
> > Did you ever solve this?
>
> I think it was fixed by:
>
> commit 45611c61dd503454b2edae00aabe1e429ec49ebe
> Author: Bernd Eckstein <3erndeckstein@gmail.com>
> Date:   Fri Nov 23 13:51:26 2018 +0100
>
>     usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Ah-ha! Thanks. :)

-- 
Kees Cook
