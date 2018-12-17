Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC88217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PzUATGYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeLQD4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:56:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41141 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeLQD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:56:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so10764231qtf.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J6dyAvn8Sg9/D17tQCbSOy8eshFI39kBEVg41+gzMD0=;
        b=PzUATGYo6IbgTMftyvwBNWYRCmkh54sVzoCYkOs3dsNmZvcEYGMXpOBsUF6obZ3cWq
         UDBWhuA5aIH4A61xTDJKlrl+RtMLsYvkwASa9m2YLlToXZLWA9aAMvebf3cEefGfbf5h
         qlHK3JKN+ENynt+7Jg4BqT34s/kbLBkv8rMnlCYcdOlrEVlBaQ1LGgsa+CpMEot6nTyL
         B0u5HIDe3w4ZKK/qEiaUkXhH2yxo99f1bd2Bhghn5IsuqK+8tbar3U5bi6RS3dJZjYlI
         Vye2VXu6kAa1sHPqXP/CJnKqIkvbvCh2DkNSwrKQQ5cQbqtH7q6wVuxpkfePUXvk3/AR
         nVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J6dyAvn8Sg9/D17tQCbSOy8eshFI39kBEVg41+gzMD0=;
        b=i5Ni8BL5E5o8UNou0kcgXX5UCizrTI7o1v8fE8VlJPRqC5AAIWTYjiVLdlw1NP7aoW
         27jQ2yY7oa5i8qtHZmkBNtphqY7ldRn38b1YOY6JS5fa/QSlGTVPf45h6vtX71Rfy9Oc
         yZ2+GMTCfpi1P/1Q3FoF70VRlQoBzHJmgcZt5I8lh306bAAjzD8eD8vgzat7w9gn1xFD
         IDxn7Lffp3vJG+PZc8c2pn5PXgZzwa5asFXVJ0Yc7d+gjfpkfJELI6PZepQEubnOAdlB
         eXjCRccrWfbrPXnRt4B919K92R6JcpF51GDM13IzuzM+NpuvmFaQeB1dKz39+7ymu1dz
         J/kQ==
X-Gm-Message-State: AA+aEWZmck4dw7Y4CrHNfzbV/hkMzsXxb32oNopZsQUunwlKmJMn/aby
        2VitnHvMl3t3dacsQQVvm8LVXtecXDA=
X-Google-Smtp-Source: AFSGD/WaO37Z67vT/MzvjPnWWKX4DIG6OwYLk7I53fkkT1SnajOaoIo8dJC5d7zbfhyBHw29ybmV+g==
X-Received: by 2002:ac8:240a:: with SMTP id c10mr10979023qtc.93.1545018994492;
        Sun, 16 Dec 2018 19:56:34 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u50sm8116964qta.23.2018.12.16.19.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 19:56:34 -0800 (PST)
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Qian Cai <cai@lca.pw>
Subject: include/config/auto.conf not sync up with .config
Message-ID: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
Date:   Sun, 16 Dec 2018 22:56:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug can be reproduced this way on x86_64.

* make sure none of libelf-dev, libelf-devel or elfutils-libelf-devel installed.

# make distclean

* generate a default .config where CONFIG_UNWINDER_ORC is enabled by default.
# make menuconfig (exit -> save)

# grep CONFIG_UNWINDER_ORC .config
CONFIG_UNWINDER_ORC=y

# make menuconfig (unselect CONFIG_UNWINDER_ORC)

# grep CONFIG_UNWINDER_ORC .config
# CONFIG_UNWINDER_ORC is not set

# make
Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install
libelf-dev, libelf-devel or elfutils-libelf-devel

# grep CONFIG_UNWINDER_ORC include/config/auto.conf
CONFIG_UNWINDER_ORC=y

This is due to this receipe in Makefile had never been executed even though
.config has is more recent than auto.conf.

# The actual configuration files used during the build are
# stored in include/generated/ and include/config/. Update
# them if .config is newer than include/config/auto.conf
#(which mirrors .config).
include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig

Actually, replaced that rule with any rule would never executed the recipe
there, For example,

/tmp/noexist:
	$(warning "never print anything")
