Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97459C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4B82188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FzKXCLLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4B82188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeHRCrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:47:20 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:34156 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeHRCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:47:20 -0400
Received: by mail-it0-f44.google.com with SMTP id d70-v6so2834754ith.1;
        Fri, 17 Aug 2018 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqHTk8J6rOcQLLf21dTwDV2LL3uPNh9wlzh1Q22AtRQ=;
        b=FzKXCLLWVPxsQNXZSm/JVmzO7n2coBD36/oXWvO8s9f0c+gHwZeYzfC3QAtvGReQvF
         0GxyAzxwAb2tkpeiimsWJ2k5+ui6PDNHqqOzzb3WEC9VuDCWijXLJmI89t5dsEj5mXk6
         FuskiuIvALe5Ix11SS4q4IOqvJl95lEeYl+D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqHTk8J6rOcQLLf21dTwDV2LL3uPNh9wlzh1Q22AtRQ=;
        b=G7RNIBVyETfQTck7YnzyJE0A1p9laMRTBATKQ0PT0f6UX8mFMNSiQkJC/MbqHMY0VK
         1gGk0ajImBSNzRzjkggHTKrp3Zo1Q3LSFnRrn37omkerGpMeCfNr7s14v+wCNDTKFVRr
         QmYZEV1ySJJ+C5tE1yErwFsMWUjVx4NvCzSy5o9aebTw55Yjj+L41UWz+xEO0WUqQJdK
         DhSz5X+PJXS0pTgD4j/iZ/Gy+I4dC4gDbXUlDL38LHi/G/cJqimDcU9dGsHGdPqVPkSA
         5y5RlRbx+hMnFfkNg7c7KepZ6PhEFAA0JuCPKMhwiOxk85Xhk2ht81tlu8s13ESum0L0
         fM+A==
X-Gm-Message-State: AOUpUlG+YIbBep6h8Sodf6wNNYr6+MdvPinfght2mIfBowx/Ky3RF9Dl
        /7TuvTDcbyuTLdly+E+j/8J8v0BKtw+vbWJwd2U=
X-Google-Smtp-Source: AA+uWPyktfiEibocrNaZlZFH6TN+sDYUGUUa5kYtBU0F5FxisG2sqkpAsxcwmoT2cTd/rwJyCojwWP7ES5jYvzO//PE=
X-Received: by 2002:a24:d0cd:: with SMTP id m196-v6mr28805251itg.9.1534549315460;
 Fri, 17 Aug 2018 16:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180813012347.GA32555@nautica> <20180817023307.GA32726@nautica>
 <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
 <20180817213648.GA31406@nautica> <CA+55aFx58-vbKca_KGdhOA3cJ_M7HP=wOsJ483os=CCobi2zOA@mail.gmail.com>
 <20180817154155.ebe6ffee995a37ade029db2f@linux-foundation.org>
In-Reply-To: <20180817154155.ebe6ffee995a37ade029db2f@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 16:41:44 -0700
Message-ID: <CA+55aFxzuLnK7E3hz_YZSNjjJ7TeMTmPrpn4rhHGjgrY2DgTtQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 4.19
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 3:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Please do.  I'll actually be sending you the MAINTAINERS update in
> about 55 seconds.

Heh. Ok, that resolves my biggest issue with the pull request.

            Linus
