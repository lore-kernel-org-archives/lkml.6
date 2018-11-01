Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD64C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71CF204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NMnHts3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71CF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKBHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:12:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47075 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeKBHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:12:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so19464262lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZkIkymw17XE3cqn53DMJkvZ47QXl3j9f8ocvL8XoAc=;
        b=NMnHts3k/sBoKSN2U20EWKkFVumIMMCc0807xeoG/kbx04C5mqyZK4MZtxQkmnsMaP
         kq74Y4T7Jn0/hMWcVNtHP8VV7RztFLQkPsCXFZNDllbVscBDuAw7uyXXFuKQWBgB71KV
         00h6YjmoRIkRSzOGLoRK30QgQrcsJmhI8jl3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZkIkymw17XE3cqn53DMJkvZ47QXl3j9f8ocvL8XoAc=;
        b=KkCRvTEijPzJNkXsxp64O7VbyZIx+n6Rwmvz3yzrDkwLAXzDXJPeiMXBLYUtCN76WB
         J0ixaNb/3zTtqRC73l05xtbbtzJeuQrAK3g01yJfA8PmTpMRLTu7iylYSki1UkBS7Etd
         5zLIX1Yz5tDF9ovdCzotrW9Ym7ApMfc/cz7kmStanH3Bicol0EvUNXBwrcnpWFvXkgIq
         m8K4xFY1o5oVsYieDgAtw1pBe+i7ZoJ3MtUJGDUxg/DEZlAqwgTf9BS0FU3UVeVCoig1
         M/UkvlGOTKWgCVza9W88Oi0LOu7CuLgL4xCxQ0TM0no+DCgV+d2NAIjm6Dp9kD0jceHL
         zElA==
X-Gm-Message-State: AGRZ1gLgzN+YarDCr/kid7T4lILpsKcqtagGD7iZIDKS8uqS9iCyuJfS
        wjwsolKKrMz4RpDUTZrceSkDha3dYtJUmA==
X-Google-Smtp-Source: AJdET5cAuX8D0FYkMEXAYPAfq9IXq2QCs5dZ4MhaBnFlJLBpZXDqAE0T7IfLzspCfBhtmeuShyZv0Q==
X-Received: by 2002:a2e:2a46:: with SMTP id q67-v6mr3106573ljq.38.1541110054622;
        Thu, 01 Nov 2018 15:07:34 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b79-v6sm3514127lfb.40.2018.11.01.15.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:07:34 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t22-v6so2011lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:07:33 -0700 (PDT)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr2830900lja.148.1541110052845;
 Thu, 01 Nov 2018 15:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181031053355.GQ32577@ZenIV.linux.org.uk> <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
 <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com> <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
 <28156.1541092687@warthog.procyon.org.uk> <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
 <20181101220518.GT32577@ZenIV.linux.org.uk>
In-Reply-To: <20181101220518.GT32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 15:07:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+=W1HN4CCp-_awNs9+WGSt3iDq_dWBhyYGu=iF_aHTw@mail.gmail.com>
Message-ID: <CAHk-=wg+=W1HN4CCp-_awNs9+WGSt3iDq_dWBhyYGu=iF_aHTw@mail.gmail.com>
Subject: Re: [git pull] mount API series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, swhiteho@redhat.com,
        john.johansen@canonical.com, alan.christopher.jenkins@gmail.com,
        ebiederm@redhat.com, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  Do you mind if we end up with work.mount rebased?
> The usual objections re testing in -next do not apply in this case,
> AFAICS...

I was assuming that the work.mount branch would be entirely re-done, yes.

              Linus
