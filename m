Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C3C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116272229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lB8/ch13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfBLSEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfBLSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id j18so1670312pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5RL/uims0dzv6hgVjpHlDAiv61sh4MWVmBGXV5JulH8=;
        b=lB8/ch13db9Egk5T5wRC8GehSg+qyyjSPpSLRlcZijx8k3auSzek/Fh+CVdkW+y4ce
         hFxNafX3BTH+ie82QVOsCkrfmociqSMMTFssPTNzl8MPtor2AU3mFoXJFs/h6Kg7aqO3
         GwKJHkueWtIWH3Q/CpiBTy+soQ+ojN2hUcM7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5RL/uims0dzv6hgVjpHlDAiv61sh4MWVmBGXV5JulH8=;
        b=YwuDWYGE7du7EbppFkbD2zYzNwLv0mcy8jsvdViBlhWducOxMbpPaZlKd01bNpQXvY
         Feg8cT0NI3siU2DwKu0a+2he3Yp6rPew4JoZLVK1hX0WqQieDgOz8fvRNw6n5PsLOVoc
         MWnYfMO/7z/XopqL0PGEAPlP38rpxBnaaqpVj5nBqdALhNztiCyeTe7yqWfM4Ytcyz1A
         DseaE8WwfOMUX4PbFsz9Fk/tbb6vCtKXIaOTsOzuWrRHR3QS1lvbs28KgNglZqitvokg
         +LBiFq0je45IbIvu9IiRG2HH/AzDPhET6/T3vGSEtWbLb5cYou/QsGgPGw2d6u6crsED
         DWxg==
X-Gm-Message-State: AHQUAuYn4r6Wzgm4RAgtKCpMzh/5oN5mTFW9lAGA5TpwTRSawtqhzNUV
        G3aOTeuAtPlXDAkq7plgq+1lSg==
X-Google-Smtp-Source: AHgI3IaZQbO/YwHeT/78fiLag+0976Gh9N2AvcOlucjqpNoMgwQVu09NPWySOCiXUPRy2xCp42rpQw==
X-Received: by 2002:a65:424c:: with SMTP id d12mr4752306pgq.126.1549994690641;
        Tue, 12 Feb 2019 10:04:50 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h128sm19370649pgc.15.2019.02.12.10.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:04:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 0/2] gcc-plugins: structleak: Generalize to all variable types
Date:   Tue, 12 Feb 2019 10:04:39 -0800
Message-Id: <20190212180441.15340-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a new plugin for stack initialization[1], this improves
structleak to handle initialization of all variable types. Since the
instrumentation happens at a different point, the "switch" statement
changes from the earlier posting[2] are no longer needed. As before,
this also introduces a stack initialization regression testing module to
validate various kinds of stack variable usage vs compiler instrumentation
for initialization. See the individual patches for more details.

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com
[2] https://lkml.kernel.org/r/20190123110349.35882-1-keescook@chromium.org

Kees Cook (2):
  gcc-plugins: structleak: Generalize to all variable types
  lib: Introduce test_stackinit module

 lib/Kconfig.debug                       |  10 +
 lib/Makefile                            |   1 +
 lib/test_stackinit.c                    | 378 ++++++++++++++++++++++++
 scripts/Makefile.gcc-plugins            |   2 +
 scripts/gcc-plugins/Kconfig             |  58 +++-
 scripts/gcc-plugins/structleak_plugin.c |  36 ++-
 6 files changed, 463 insertions(+), 22 deletions(-)
 create mode 100644 lib/test_stackinit.c

-- 
2.17.1

