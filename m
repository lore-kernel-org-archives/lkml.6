Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16000ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0BC21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBSH052q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0BC21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJRJbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:31:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46608 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:31:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id o21so28165868otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARWAj6381CPA1r2hjfrM+Gzrg9iwTEgDHx4ygvanqnM=;
        b=TBSH052qjzYookIrhMq8gQ79WGBn+reDmaJ2Z0t0UeIEbL+EvbyQAu2/rMxehVuM2y
         MPB1/3KgjO3Oq2T9qOkwwd94LhNk3i4UHPwd4rOwUhgbkzz2WFL/eUsyw1oQbN7rWYJz
         QNtUXwraJp1dzo8SygSRuU/xlMrZ/z7sjIPPtUtHW2+EzofQAdBLmQX9p359W0fGKVBP
         Y8nTfRZtqLYWBBs0Tp5JZ+u1ilNSFjiHwxxOKFjX9Pc2BeqlER+BlIHh6xuTKTy+3cs6
         siKAfrDOcqxxANY4bFQD2Fcz/YLYTvXwTC8hww1bdwzYuk/mguZtFVKDnngMyPIp4/0A
         qjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARWAj6381CPA1r2hjfrM+Gzrg9iwTEgDHx4ygvanqnM=;
        b=SzKjbXVuDYF/YCrEV2HAKV9ELlbXIe9dKFUPbuvZEblktIDidfyQHOhJ7P/xMlHsfO
         FEkN7vFRUQ7ncZia97YoJdJxmvvs4KKnWSeqJZTSKuCQHQfDJJmtNKJ74j2O9PGDcXGH
         6XdzGVkDiS+rj4sSbGeic+3FOuytc6i1YGwLzYfut47OXr9VvmzBSRU8NLA3h5WkYxec
         BuBSOoq8jPItGwcNVTI7/G3A2FrPeVHjTB9hc347Tn1RQbJ5nfk33PxzsCQKOfrW/T4n
         zsW6degyyqQ0MU1dbC/ACtIA46aHLy9VWPFI82+ecNR5Xl+sTbtAWKmzYeyjKYWhlt8o
         e3Xg==
X-Gm-Message-State: ABuFfoiKZ461evSsdhDpl3PspPCjiWVcmqtdKP9aGuLpiOmR4EykUX3X
        ogqXt70UBq4xP3p5zhZcs8OzRnPRXGzTeZXzu8w8Zg==
X-Google-Smtp-Source: ACcGV60j2XCxcCp4TN+lGfIvW6SGXSqM2XWsOQwzMGtyJnUKljSLMpowjoyT30emGtw0Wc/8LHqEzsW6LYctiFzu2+Y=
X-Received: by 2002:a9d:6509:: with SMTP id i9mr2082151otl.338.1539826359244;
 Wed, 17 Oct 2018 18:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-23-brendanhiggins@google.com> <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
In-Reply-To: <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 18:32:27 -0700
Message-ID: <CAFd5g44v3BrRYosoFhD8iP4nxEKdJJ=VjhN3aMexOtWJ87WX-g@mail.gmail.com>
Subject: Re: [RFC v1 22/31] kunit: mock: add the concept of spyable functions
To:     rob.herring@linaro.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 3:47 PM Rob Herring <rob.herring@linaro.org> wrote:
>
> On Tue, Oct 16, 2018 at 6:54 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Adds the concept of spying like in Mockito
> > (http://static.javadoc.io/org.mockito/mockito-core/2.20.0/org/mockito/Mockito.html#spy-T-).
> > This allows a function declaration to be labled as spyable which allows
> > the function to be mocked *and* to allow the mock to invoke the original
> > function definition.
>
> We can already hook into arbitrary functions ftrace. Wouldn't
> utilizing that simplify features like this and avoid having to touch
> existing code for testing? Not sure what it would take to enable
> ftrace on UML. It is at least partially compiler dependent.

Regardless of what we end up doing, this definitely needs more work.

After looking at include/linux/ftrace.h, it does look feasible to use
ftrace for spying. I totally agree that we don't want to reinvent this
wheel if we can avoid it, but I have no idea what getting it working
on UML would look like. Dependence on compiler features could be an
issue: pretty much anyone who can build the kernel should be able to
run our tests.
