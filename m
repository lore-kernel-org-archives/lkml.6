Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3DECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FA32085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OE4U6iUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FA32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJ0FUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:20:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJ0FUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:20:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so1893431lfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVHuF2pQ7n/iYrqE81jlHPL+f1/5Mbp50K/TF++woLQ=;
        b=OE4U6iUQCbdp9WyVBV/t/NuyATDx7l7gYTjNDkP1D9NOQ21pPCBxOesG4/Jzfb4Tep
         AQGLLKUhLJ/cjKpUTulkIhkkoJgco1pElP/OdtcviNdyIAaNq/BfgvHHVo7CZPDwaXQ0
         aqppZ2baATIGB0kn9vI9PNLNvidfkq8wo3s5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVHuF2pQ7n/iYrqE81jlHPL+f1/5Mbp50K/TF++woLQ=;
        b=skw6JUKyLZbEfYKvxqC/3ZUJBw+MHLPOMIazv42aVvIffasAhB31toEJKySTE4AyAh
         m5r+Q+YJeR4P0HqqTaalE7G+CHumx3hv9gNAfM3sG0A0SCninKtPEgeqjqMVg/nD5UQd
         NuVeasp5S22s5TswrqQFLQIu2yY4zbXf0rNXXsILyXLkJzu++IluyKx9xcY/rVVOkmc0
         bYGWUlceaw9NkPgyyMbcZ9dXp3HhclboDkYgxfWrdoQl/KzWtTo6ngboay7f7PYEu2Ts
         fSlYGzkXsd98sv8WQw+PeLKC5xBGeTSbtk2OSiYOQE/uNrRKLHGsnHEMkc0Xl8mgyOZE
         3C4w==
X-Gm-Message-State: AGRZ1gJV/0qOk0xaKScnh0JNhpdPAMj8ozlLWOYW2RyLJEp73hRItPMq
        cjcd3g535qPRLrgSP/0PBfOjz74GkBsxzA==
X-Google-Smtp-Source: AJdET5diJmb0c2Dp4YhS/kOfuYtRB3bBsS63c8jBaE3Ns4Q5xYja3zJYjFyX12dHIS3yRS79cyqlDQ==
X-Received: by 2002:a19:d8ea:: with SMTP id r103mr2544301lfi.146.1540586539847;
        Fri, 26 Oct 2018 13:42:19 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z89-v6sm949211ljb.71.2018.10.26.13.42.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:42:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m18-v6so1875217lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:42:18 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3304130lfo.124.1540586537634;
 Fri, 26 Oct 2018 13:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <20181026180515.GA12129@flashbox>
 <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com>
 <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com> <CAKwvOd=c9RG2s3f-PgM1T84sHc5N9zcjrVpG5is+mGbTOxvtrQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=c9RG2s3f-PgM1T84sHc5N9zcjrVpG5is+mGbTOxvtrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 13:42:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whazvE2VnJiSFeQ_BzU2iUUt=v8BxhgJyq92ecDayJ14g@mail.gmail.com>
Message-ID: <CAHk-=whazvE2VnJiSFeQ_BzU2iUUt=v8BxhgJyq92ecDayJ14g@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, ooo@electrozaur.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is removing a filesystem considered a userspace breakage?

Yes - if a user notices.

The key word is *USER*.

Note that it's not "user space". It's not about _programs_ noticing,
it's literally about users and their workflows.

If some change breaks a real user workflow, it needs to be reverted.

So this is not about ABI or anything like that. We've had cases where
the ABI stayed the same, but the order of device probing changed, and
that broke peoples setups (because now /dev/sdb and /dev/sda switched
places), and we had to revert.

It's literally about "if a user upgrades a kernel, and something no
longer works, it's a regression".

In general, a good idea is "if you have to wonder about it, just don't
do it".  Because it turns out that users are odd, and often do odd
things much after you'd have thought they'd have long since switched
to more modern hardware or filesystems.

                      Linus
