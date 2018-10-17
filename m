Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F96ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ABE21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ABE21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeJQXkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:40:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44548 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeJQXkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:40:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so16747771qka.11;
        Wed, 17 Oct 2018 08:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hC5+/aeRgdkw2kRABeizbTqREY0y51ywyP4l5uHV8w=;
        b=AB9qaNth661jc/M7mWoMKb5YIattiSNZuDYfxQ7ruzLq5pR0niQK08iTuCvD+w3XS0
         Ep4BF6zTGI2tFXbpJzoisv6uPcdJQmFrQsYAnntDPeXQbTZ5VPfU/y2BbOiCd+yKH8qU
         wssmT7uFAXtD3cKc27hW9bECaNvfz83K7s9URxy0saAWukpq4/z/zVeumyXNH2fCFuhv
         ZyOmv1u6ZJAiw7J9kAGc7xKXQakrV28ymbgmvR5V2O+9+PZgC/28G8oxulvlDFm3iI+i
         SO3KctcZIRMLJd54Lci56s5L3sWs6MKfC+MtYlGIlpn8WKffJFUG2kZgMIG6yvb3nmFm
         Irew==
X-Gm-Message-State: ABuFfogqTaz6QdM5065tEEi7b8JU5WSOKVCyeeMxRMkdBc0N1dMIknOk
        GwE4IxJ8PxJ8Cl2ooPmaNmtYbq7nRC9p0DcmO7k=
X-Google-Smtp-Source: ACcGV61S467qTDt/ZbQmvJoqR2qH6toJvVowFu6soH0rtJK89+K/A4Sp/5w05bQ3RDDP4isvdQ8Vj9Mg3osFVQEaeDQ=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr24611380qki.330.1539791073838;
 Wed, 17 Oct 2018 08:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:44:17 +0200
Message-ID: <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
Subject: Re: [PATCH V9 21/21] csky: support dword access for get_user_size()
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:33 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Support dword access for get_user_size and redesign put_user_size with
> the same style of get_user_size. It's Ok to use xxx_user_asm_common for
> all size of variable with ldb, ldh, ldw, ld.d
>
> ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
> follow abiv2 gcc ABI for dword access.

Are you sure this is correct for this?

static inline u32 get_64_to_32(__u64 __user *p)
{
      u32 ret;
      get_user(ret, p);
      return ret;
}

If I read __get_user_asm_common() right, the ld.d would overwrite
two registers, but the caller only expects one, so it clobbers one
that might be in use.

     Arnd
