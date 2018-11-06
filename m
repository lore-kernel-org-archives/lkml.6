Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D32420869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqopeBwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D32420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbeKGBLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:11:43 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40823 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeKGBLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:11:43 -0500
Received: by mail-lf1-f42.google.com with SMTP id v5so4204080lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVQbWrfe44pNoMdsg2b+Rsnq3zVxKH+3cxMKeM8fjEg=;
        b=ZqopeBwN2u/ur0Z3zyAfJG8mOLqnjfgcDo4hI0hQ9M1/q7OUbGAAzXkcxKWdmB68qx
         /icFGDtfjXS7KqKMD+Pqpvx3kZkR8wHB3woUV1P6N+pnURMxOgW9j7ongnAGdYFw+Mzk
         7pzrj6Td0gv4gL/sRNyvyJE+Yt9FjqPskov7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVQbWrfe44pNoMdsg2b+Rsnq3zVxKH+3cxMKeM8fjEg=;
        b=WNvr4ib1hDGuWi0Sh8aiaEKRB+gnwXt2tu8GKWDf3nCGHplzkH2ONYpkxBSPRRe8Oh
         ++Fu8MxC/288kvXwrJs8Gl/tZEpaHcO03KzSaGJHPQSLEBvRgfvyRm26NWJGKcFxaguJ
         V30exo+9mdkkHRJitv9cUSPoQES+kxfYNKlRowulcXbS6cUe9v/xwHqAN6E8wn0qBc8A
         isKxl/lnXFKLyf2x035TCgkJk+KTZdDuK3Ypoxeh2g4DZFh8hdqot5QkgUtJFVi22Kxz
         Mg1YsH4/Inbx2dhIzSFKBqoC5+HdGs0+V61yu1GeuQnUw7hUC4mqGaqT5/+DGznMh+/S
         5LCQ==
X-Gm-Message-State: AGRZ1gIAzcKeimBtA4oTGOVvzdhWjB+ddvz6zV3UKORFPUVP7t/gYnZ7
        oYxrZEskV5Tcp1MXweBwizWC3lr0leFbyA==
X-Google-Smtp-Source: AJdET5cxlyc/ElP/2ipSbFIuQS5RktG1KdkwBAvn22z8o+Xqee86bqpzVH46eTFtXzm0NNELiHeorA==
X-Received: by 2002:a19:e601:: with SMTP id d1mr13621364lfh.71.1541519152636;
        Tue, 06 Nov 2018 07:45:52 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p63-v6sm7520510lfg.46.2018.11.06.07.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 07:45:51 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id p86so9205085lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:45:51 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr15961062lfg.117.1541519150658;
 Tue, 06 Nov 2018 07:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20181105.174242.2248944127095829834.davem@davemloft.net>
In-Reply-To: <20181105.174242.2248944127095829834.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Nov 2018 07:45:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG5i1ScMuO-cw3PuLJ=UCB=x2Vp6Uu0+YN_ON2et5eUg@mail.gmail.com>
Message-ID: <CAHk-=whG5i1ScMuO-cw3PuLJ=UCB=x2Vp6Uu0+YN_ON2et5eUg@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 5:42 PM David Miller <davem@davemloft.net> wrote:
>
> 1) Handle errors mid-stream [...]

Pulled,

                Linus
