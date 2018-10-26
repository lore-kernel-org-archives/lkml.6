Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E3C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1C20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ND/0eDoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE1C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJZIvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:51:46 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:45140 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeJZIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:51:45 -0400
Received: by mail-lf1-f54.google.com with SMTP id c24-v6so8153964lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eptw+ZoNN1znnFanLIYW7GWriNq3uNAu7d4rCxtZ55w=;
        b=ND/0eDoSK9yb/l34zaQY77j0u/svhZQkSLY+t/BCwDvU7JGJgj83D4DxIxIb13URKx
         L0K8MUZlSaEuyCBnARk/N4E/i2Q6icqB8Z+EC4Yo/yohZToo4MAPeveYEqaciTRmNoUu
         xexeQ0ScM8qJzLsy5V7t/lBtek14YLiYp4y8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eptw+ZoNN1znnFanLIYW7GWriNq3uNAu7d4rCxtZ55w=;
        b=LNL6WNKf1cfjkglPytM4Ai8N0WO6sB4Vv5tmExStj8GoPyR2aVblhsnm2t2wwT9f1U
         1d9kroFyVO+k5SdiE8y0P1l3UOi32AkGXE6c961/CKYmjoAhOG28QW3ORIGV1i8n1/Tp
         bDLcOwFUJjp1rmNcLIupMybCXbRuuS5wgUCyocwTatQAtwSmE1RN+b6p4PVxhju2YfBS
         NEtu3UsGCDG5NGLwE8cECaw4yqMxlJjHiT6kFC7Z4eY5mnFszq4ZLfDBdy4kfmKU5l2+
         GJHOPXRFXiwP9UVrfCtKPQ9juu6ggod4W2uk5UDybOJktDJShS7/Q7ebJK5epwR9UwDI
         o3vg==
X-Gm-Message-State: AGRZ1gIVnH6DDhsS4bLui4wUGVUiHVm9q1ZFtQzfDS78/PB8aZlpPD4Q
        1SV5dTtMdNBXHu/NRo3GB5eN8aRAYyUKiQ==
X-Google-Smtp-Source: AJdET5cDUnyntDIsLfFr0CIDepqeUuktqJf8c1S13Ff212JoOaroNcPaOVgz6IwRthuVgB06JRarOw==
X-Received: by 2002:a19:7112:: with SMTP id m18-v6mr773808lfc.64.1540513018416;
        Thu, 25 Oct 2018 17:16:58 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h25-v6sm1372652ljh.12.2018.10.25.17.16.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:16:57 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w16-v6so6062538lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:16:57 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr754546lfa.106.1540513017108;
 Thu, 25 Oct 2018 17:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181025144029.GE4182586@devbig004.ftw2.facebook.com>
In-Reply-To: <20181025144029.GE4182586@devbig004.ftw2.facebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 17:16:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAHDD7gSOmM1EX_hOyef6_tBtoKT0H3p70f9zDKPzdDg@mail.gmail.com>
Message-ID: <CAHk-=wgAHDD7gSOmM1EX_hOyef6_tBtoKT0H3p70f9zDKPzdDg@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v4.20-rc1
To:     tj@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 7:40 AM Tejun Heo <tj@kernel.org> wrote:
>
> All trivial changes - simplification, typo fix and adding
> cond_resched() in a netclassid update loop.

Thanks, pulled,

                      Linus
