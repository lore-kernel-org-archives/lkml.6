Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8849C208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU0LU2Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8849C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934100AbeGIRzz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:55:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43082 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeGIRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:55:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so14178371pfm.10;
        Mon, 09 Jul 2018 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f8QO5WqfUQOgzzgfchj1hVcmA26Mq/ogTsNcKPmJQ1Q=;
        b=JU0LU2Uy44qXDajKxYOv6nhtGsGU6Zs4IjZ9TycHTF/YYE+G4TekQLEbg6nVOiww1/
         JwPOXfgx6trZ3rBOCJZwIaWEZrQyUppMZ/vmiN3A3uxBAC9S4KJ6nx2drtrmqAWRhY/N
         L16YrDG+Z0Mw5U6jOoexJ0P7a4OORdF1P3f/7A1byB8Gv8jOUrjwOKIw9SvD4smYH/Tr
         Y96F4OVPC66F7kx9bUrCimL2XO0invgyJhpQ1JR78mAnriarcFBPXoKFdMKHH2dG1lxr
         Vzj3snG4Mj/mbjU7h9pG3QaTcArBfbwPb3tv2TnZs+4HWyV20YrjU7ApGup7qkyAoVzP
         kfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=f8QO5WqfUQOgzzgfchj1hVcmA26Mq/ogTsNcKPmJQ1Q=;
        b=GZhZg3GAnmau9oX7cpkDeUsWgrikwlFzBPtiwaOekvsBiYVYumieQYdK2x7Awj+gJM
         vcw9UA8ZDD2NFjIimyGqfOsaC36UpHsSOcaiqBFTIjSJdjALSSUajSxjl0iomAy7P+Hc
         1d+DDoImoCAl1fMue4ET8qZ5bQDIFTO13MjftHLZd6ZWRp9b1melqx7uRlpUTaBYVaSu
         +d9w0y9ewET7Rvzm/eCUtWKoqo4NL6hZl4m1RroxBnBdxds1T8WIpgHs91R+IHSFfW3R
         o8uf1UKWvfPKqYfLmH824NKT7fzwwYBb/V285H+J1H8vewypATRcFU88TSEDe1o581BG
         BbWA==
X-Gm-Message-State: APt69E2vTl7DKQUFjOch3StCJSWrZekNa99ypPyb9Nq8QFl9Yr+WU4Ep
        iVuwNAgatzQRYWfzSLaPHBPPeA==
X-Google-Smtp-Source: AAOMgpc6WGvip5ANtA6WgHA1vqgxH0c6mSjB4HTvF7/SrRWkg4lSuUJMDuCsVDXLwU3+rD8kDmLHyg==
X-Received: by 2002:a65:5803:: with SMTP id g3-v6mr20036394pgr.117.1531158953255;
        Mon, 09 Jul 2018 10:55:53 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 16-v6sm625340pfp.6.2018.07.09.10.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:55:52 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:55:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Build/qemu test results for v4.18-rc4
Message-ID: <20180709175550.GA7469@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build results:
	total: 134 pass: 130 fail: 4
Failed builds: 
	nds32:defconfig 
	nds32:allnoconfig 
	s390:allmodconfig 
	sparc32:allmodconfig
Qemu test results:
	total: 158 pass: 158 fail: 0

---
nds32:defconfig:

nds32le-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
timekeeping.c:(.init.text+0x1a8): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ac): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ec): undefined reference to `__lshrdi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1f0): undefined reference to `__lshrdi3'

Fix is available in -next with commit 78945c357f5 ("nds32: Fix build error
caused by configuration flag rename").

---
s390:allmodconfig:

arch/s390/kernel/als.o: In function `verify_facilities':
als.c:(.init.text+0x24): undefined reference to `latent_entropy'
als.c:(.init.text+0xae): undefined reference to `latent_entropy'
make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
make[1]: *** [bzImage] Error 2

This problem is only seen when using a compiler which has the relevant
plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
know if a fix for v4.18 has been submitted. The s390 boot code in -next
has been rearranged and the problem is no longer seen there.

---
sparc32:allmodconfig:

include/linux/highmem.h: In function 'clear_user_highpage':
include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type

A possible fix is available at https://patchwork.kernel.org/patch/10497941/.

Guenter
