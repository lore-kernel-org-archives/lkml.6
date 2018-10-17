Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F10B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYomkZL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F10B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJRGo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:44:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40510 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJRGo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:44:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so31463735wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgDZtxs+8PHwUpEzYdFhW6BWl26WBmcLen5s8o6wKXQ=;
        b=YYomkZL2uQ/A7k6UEvzO1LqwfDwjfxPbNqsYfwWe7a7RTa+UTu24LbPJEUkx3qq+ms
         J3qCLFoPoS9xtZBMgl9/2Uf4gBPhyvrWacnIPDR7BjsnMZga+3wy+drGv7PmSV64IQ/Q
         H9jr+IqFL1s0pwTfIhgpAUzJ/OnND7FUyRLcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgDZtxs+8PHwUpEzYdFhW6BWl26WBmcLen5s8o6wKXQ=;
        b=RLgtysIpumStXi9f7NUZrWZ6qGPVs+j92vYlwjI8wQkwpRjN7mZHeVEMHcOcuKPmTQ
         UiW+dGcnZG3xrFhkGGAJ4t1r8dCNiMNNPEzbvD8+naIBd0KlIZkax0/T6P5614zmLEDP
         ZVVb2JlrREFrWhFs+/GrquiPzXYJMIlGREE+caFdHAxq5NeGm/8ff7tyuTDKn66KnFf/
         lwUXXGs850CM6zx+VNl0F613hlg7QzNzxXZY08RoQnaJXnu0BYctK4mgUVz1B+tnu5qH
         Rtf+yXJj0VKGm4o6vV408vhl6CqxEEtCKu1sZekL81ftgP3i7zYxJEeKa7bXYcWqpMIf
         U0jg==
X-Gm-Message-State: ABuFfogZjTl0X1EmHSzNPrFs1xA8R/VlR/s+2KBnkWpXPUlS0JDXtOY4
        qDCJD58t0ooZUSsPLGgUsANhcM77J/FUBQzNpbbByw==
X-Google-Smtp-Source: ACcGV61Uksf6GZZnr2JkGdv8r4BxOn/o/WRkyQ4UNIuhG28gWSygczMK2cw1Pvgklvz0wVj/+MQJ3noaujNEuJDolcM=
X-Received: by 2002:adf:916a:: with SMTP id j97-v6mr26929538wrj.179.1539816424987;
 Wed, 17 Oct 2018 15:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com> <20181016235120.138227-23-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-23-brendanhiggins@google.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 17 Oct 2018 17:46:54 -0500
Message-ID: <CABGGiswwS9NJJ__WVgimcFUiTy_76AtDOxeSbSuv-oz1xjjD5w@mail.gmail.com>
Subject: Re: [RFC v1 22/31] kunit: mock: add the concept of spyable functions
To:     brendanhiggins@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        joel@jms.id.au, Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:54 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Adds the concept of spying like in Mockito
> (http://static.javadoc.io/org.mockito/mockito-core/2.20.0/org/mockito/Mockito.html#spy-T-).
> This allows a function declaration to be labled as spyable which allows
> the function to be mocked *and* to allow the mock to invoke the original
> function definition.

We can already hook into arbitrary functions ftrace. Wouldn't
utilizing that simplify features like this and avoid having to touch
existing code for testing? Not sure what it would take to enable
ftrace on UML. It is at least partially compiler dependent.

Rob
