Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A469C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215D921479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="COFQxgwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfBSWRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:17:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40411 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfBSWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:17:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so25096432qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/AADH7d9dPw/Xlf484yHkcGyiZK43PrzsOjFifHGL0=;
        b=COFQxgwhRUGp+dQANarOvJpdGglFUtsDRm13pOqtjyEgoFqognzyLa+oTlFjdIomJ3
         EmoBPFgmqNbNw35fn4jBz3v3rso8XItYJ0zY2WzL/WUXCYjsiCtgs+pzQiWDWzCUdjo5
         OSYAJS5Zhkdm3DXNuCIMVBngbaEEq/0zdmjcNe/eLxkjDwrkwMypBEEiAvWypYMTsNq+
         FiBAF8D/1ynqgxdRB+nfuUAEQuqMU6/6YycAo+QBoop1geNNPqV2DmTC1AMtrVlJvfdY
         4qgOw3VxzthvIC7KoCphNzie6yKEgV+CeJ/0wRXe0dknwPFyEN+kGrb9qtSHZqND3FqY
         Du+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/AADH7d9dPw/Xlf484yHkcGyiZK43PrzsOjFifHGL0=;
        b=uXaCoctYNSvTt2tzsYTS1FJn8mL8OqQFhbS5XV8Uju/SLqUiYkWFPJSsn4EVYldp6R
         eIx9iEe1pyTw2g5lwW/Doi0IbDaUAOA9zRiljHqjOOgA/rzgO/xAWiDXoB0ZMLjWny3J
         7oFJh8YDL67PA1bG6BbJshJSnklNBPxzZa33nbdwA/9m7m3Xx911wZbMKOCPAqsOypHc
         r2oY44Ed3YHH4AQ69Itz9BHA6Xm4yyBXWnX/wtP/WnLj5RrJAKMMJsg6dG+Rjn/3jeM5
         c9u5FTY7mQjkJnPEtXWPXhg25PmVUpI4cqmJLKtv/OWdwoA3ysOg5f/eEHcJIrkpnDVN
         WESA==
X-Gm-Message-State: AHQUAuZ3zWNm4hShlCGSsLjQzlvTQrK8aw5lr9Zz6NnIIDOE1jCtnQQr
        TwFdRfKWE/4BqOwBZqK9txCP0Q==
X-Google-Smtp-Source: AHgI3IaktnIhhelEWrARCTRyyhHIfM6pj9uHjCcrsYTDwd2aUlACh+U7Cu3DeoDZUAVF1gGpGFK+qQ==
X-Received: by 2002:aed:3b25:: with SMTP id p34mr24118031qte.310.1550614666905;
        Tue, 19 Feb 2019 14:17:46 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o124sm9793596qkf.72.2019.02.19.14.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 14:17:46 -0800 (PST)
Message-ID: <1550614664.6911.45.camel@lca.pw>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kasan-dev@googlegroups.com
Date:   Tue, 19 Feb 2019 17:17:44 -0500
In-Reply-To: <20190219214940.391081-1-arnd@arndb.de>
References: <20190219214940.391081-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-19 at 22:49 +0100, Arnd Bergmann wrote:
> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> about overly large stack frames, the worst ones being:
> 
> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size
> of 20224 bytes in function 'st7789v_prepare'
> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12:
> error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes
> in function 'max3421_spi_thread'
> drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes
> in function 'slic_ds26522_probe'
> drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in
> function 'ccp_run_cmd'
> drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840
> bytes in function 'stv0367ter_algo'
> 
> None of these happen with gcc today, and almost all of these are the result
> of a single known bug in llvm.  Hopefully it will eventually get fixed with
> the
> clang-9 release.
> 
> In the meantime, the best idea I have is to turn off asan-stack for clang-8
> and earlier, so we can produce a kernel that is safe to run.
> 
> I have posted three patches that address the frame overflow warnings that are
> not addressed by turning off asan-stack, so in combination with this change,
> we get much closer to a clean allmodconfig build, which in turn is necessary
> to do meaningful build regression testing.

Well, I am using clang 8.0 on arm64 and running the kernel just fine for a few
weeks now and never trigger a single stack overflow (THREAD_SHIFT = 15) because
I never use any of those drivers you mentioned above. I don't think it is a good
idea to blankly remove the testing coverage here and affect people don't use all
those offensive functions at all.
