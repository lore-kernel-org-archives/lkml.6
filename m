Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30639C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0AD20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iqg84/XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0AD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLFSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:30:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45432 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:30:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so1265222ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMDaoQejAB9ZGnzrYT/osbFoXrrFabNbm+K7/F6LbLw=;
        b=Iqg84/XADlobWF3SZpv6o5m80DzeRc8kMD1tjHxHYPbt9m3n62jSvMqGponIBQKIrp
         K7/a5Dri1MlvhfVSItoW74ad9TeI1BwT3BbRqbDTvJt1YWN4Tq0Q4vhVJypozbGwBnfV
         bLsKx3uHlJuije//U5c1DK0EpVp33euiBlgkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMDaoQejAB9ZGnzrYT/osbFoXrrFabNbm+K7/F6LbLw=;
        b=TbdUGE8rEFqlndH9VGbpIzcmzxp2xsm1RrlHA1v/uuPeaaJTwLWCz9l5THwLR6up/J
         opCw5/sp4iMFRfpmxHJmbWatUTMcDaf0+oSyf1J0mHXuYi7JmKSeaLjUkr4iyZxpfg6L
         N/Io+78Vr1D13KkzxeufBss5imjMaRXJh3xC94FyyQXYBFpvpv+5eegBgpl5RBIIWyIr
         HoyRP0HyLd09s8zV2OH4mDX77qi2197YxCwwzFjBsEOLbZTvIDVhItoVk+4z4BjgAvf1
         uQNNfg+nzFyTc+zzBa3aTBZXsf7Ig7b+HykILFE0yynSid63JMi3+5pse8Q8ZkOt7D5q
         4+Jw==
X-Gm-Message-State: AA+aEWYD5m0or8ZYKQLjV/9o7XpyrF4aVgNyIArpF8Tz5yUKC+jMgozw
        nUvlpY800M2606Onw0JYuSp/7xoSB44=
X-Google-Smtp-Source: AFSGD/VJxUizsXXEQn9UqpM5hmCgxYApAtEE19fBzev6ve9e/1o9G7Lphct4DGCD6WYgq5B5qebRfg==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr19256191ljc.172.1544121049935;
        Thu, 06 Dec 2018 10:30:49 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r76-v6sm189125ljr.83.2018.12.06.10.30.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:30:48 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e5-v6so1310447lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:30:48 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr20873772ljj.6.1544121048107;
 Thu, 06 Dec 2018 10:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
In-Reply-To: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 10:30:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQ46wvdsXUS9BJkzQo-AuiCq-tAf1iP0i+G1Ym_M4pmw@mail.gmail.com>
Message-ID: <CAHk-=whQ46wvdsXUS9BJkzQo-AuiCq-tAf1iP0i+G1Ym_M4pmw@mail.gmail.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, brouer@redhat.com,
        tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk,
        robin.murphy@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Put another way, you made the fast case unnecessarily slow.

Side note: the code seems to be a bit confused about it, because
*some* cases test the fast case first, and some do it after they've
already accessed the pointer for the slow case.

So even aside from the performance and code generation issue (and
possible future "use a special bit pattern for the fast case"), it
would be good for _consistency_ to just always do the fast-case test
first.

                Linus
