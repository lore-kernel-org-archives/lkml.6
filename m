Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77180C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95F820892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WOD4upa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeKHCtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:49:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41729 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKHCtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:49:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so15426777ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu0imVlHQSXCQ13xpKyfZqQYvV6Ml3hZ3UVNGW0yxLg=;
        b=WOD4upa9G6dOvJgFrZPOQjkaQXCyDQe6Jp1+KttKdrbAu8Nx5IYynA3hMkhLVESyT/
         txi/5+4b46szFAMcRBfmfRk0n7OBwg9Ldxv5bzIqd9jiQhibqmDLpqDeKd1hwncWvI9X
         YIkk1Lae0FyGjWA/CeOFGYAJ0mHSIsVSi0r2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu0imVlHQSXCQ13xpKyfZqQYvV6Ml3hZ3UVNGW0yxLg=;
        b=SgEuTj/hxUUFOxTxufMQ/QUaR6InkZWeiOA8MowbXaL3mCnYRWyPTELjETmCgGBBZy
         YJYMWitWsScg0hX63RKuHdRhddyDJH6yTygfSyABgZYwXhTRPMNxdNbt8roLpJHtPeBE
         lo3WWLfFo6SAFuXXhn4JZUP5jE2two5fH3ADTjJi6kD6j5WrYWXNLsKFbmX/do2Ky8X1
         yAoxt9v98PDcz0XvYObSCKhP7AH+sHGNrX6JaEp92Z3nnmlpgWDBrmDqfr2iEbcuQZ/k
         UCq0oVowMj2U+RtjbAx3nTi21uRpG2wAV38lNelZHp7F07xUPmlXU9ZJ/L0yT+mKgLFN
         orNA==
X-Gm-Message-State: AGRZ1gKs50i+4I6jujkv1quRkavkaMYfi+VxoIbwBTjMkCWrB3c/mnhd
        OqSsvBt0sZHGPLouAN8pjbWsz3wHqzo=
X-Google-Smtp-Source: AJdET5fSHZcAGBpR22IbixF0uxF6qzM2YF0MPZFwkbCKG+3LikgLbv7gDMpGCRHtLVAvWqgdmFpjSQ==
X-Received: by 2002:a2e:9e81:: with SMTP id f1-v6mr757181ljk.100.1541611064658;
        Wed, 07 Nov 2018 09:17:44 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m65sm228923lfe.39.2018.11.07.09.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:17:43 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e5-v6so11314877lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:17:43 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr661665ljh.59.1541611063006;
 Wed, 07 Nov 2018 09:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
In-Reply-To: <20181107171023.zoo6qox5eewy3pmk@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Nov 2018 09:17:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
Message-ID: <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
To:     Olof Johansson <olof@lixom.net>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
>
> ARM: SoC fixes

Pulled.

> I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> and it ended up regressing at least BeagleBone XM boards.

Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
preempt being off? Otherwise I don't see how/why preempt should fail
in a board-specific manner..

                  Linus
