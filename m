Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA07ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112A204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rl5MgxeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8112A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ0EAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:00:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36249 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJ0EAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:00:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so2175152lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQMZ6xnlMEmrRO49rM8jft+PyvwNNVPqEIdGl3D9B0c=;
        b=Rl5MgxeMe2tWveFWzA1T9vDk1nfzBn3zQMiZR6pEFsZvgUUBi2Xd5zDxM8BpsHycHA
         PV5U+OnR9FZvh61UuA/u3tBzRFs301EMmIHcuZs8eM+j9MtQABCM4qJOyLvZnW6k/Vll
         ZN8Y6G2NaYsCbK/q+ysQm9eNhA8cCEthJG5pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQMZ6xnlMEmrRO49rM8jft+PyvwNNVPqEIdGl3D9B0c=;
        b=bzI9f5Z8Lw6UHGMm0EV2VeH2kmxjSI+KsTWg1CIi62ZE1kbWPYjHqXHqs93Of3pEa7
         d9bPFkegGO5GWS+YS2hPgcEr2t6MiMRcfiWB9b1J4DubGcYrgce3ehqFurefGzoAAP3b
         kzUTpHBLj+obq0yVVrGijjoYYH6H5DxJZoB9oPGeuXpBRrd/nGQ+HFV9EP3QOcWmJnbF
         A3gZ1RXZ9DeKzmVmlIaeyoSvWy0CPOczZYuOpbiGEB3oQpTWArqI4kscKs054cuwvH7b
         U2fPmCjkJRrer6wg//F61F0z1T4gXW5zUdHr/uUyiVBFV61+zakjQ+gDM9tI2kam5l5F
         XDmA==
X-Gm-Message-State: AGRZ1gIdo3qS2we+fJAIu4sIWRMHHKqX6MJllfYbhZoJGdkpRrvMBYDD
        TYoml4sM2g1yYH15Rg3ptR+L3bj1wRGJmg==
X-Google-Smtp-Source: AJdET5czUOhGBoiWkHupW1sGeW31+5X1BXzm9Kmjr0XQZLqtnY6dzZggqwywRMPDevknFXgL8/XMHw==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr2101925ljf.5.1540581745186;
        Fri, 26 Oct 2018 12:22:25 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s69-v6sm1885459lfs.92.2018.10.26.12.22.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:22:23 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k11-v6so2163634lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:22:22 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr3455016ljj.80.1540581742234;
 Fri, 26 Oct 2018 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <20181026180515.GA12129@flashbox> <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com>
In-Reply-To: <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 12:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com>
Message-ID: <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, ooo@electrozaur.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Linus
> I'm not about the process of removing code from the kernel.  Doesn't
> that violate the "thou shalt not break userspace" rule?

The only thing that breaks the "thou shalt not break userspace" rule
is fairly simple: things that break user space.

Does removing the code break for somebody? If so we don't do it. But
if nobody notices because nobody uses, it's fine.

Basically, there is no "theoretical" rule about what breaks user space
or not. In particular, the rule is *not* that you can't change ABI.
You can do any change you want that changes a kernel exported ABI,
just as long as nobody actually notices the change.

But in practice, it's often _much_ more work to try to figure out
whether something breaks somebody than it is to just say "don't change
behavior", so 99% of the time, the rule ends up being just "try to
avoid intentionally changing behavior, because you'll likely get it
wrong".

              Linus
