Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C2EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96D215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="LWtsM4Lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA96D215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeHOQNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:13:43 -0400
Received: from services.gouders.net ([141.101.32.176]:51285 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeHOQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:13:43 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w7FDEsi5021514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 15:14:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1534338895; bh=yuWfQTTOZJJXKcsJtr/7gKBElFuEj6hZRtcnw2m3FlY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=LWtsM4LoX+XGbEripAND6xryPGtIjvarYrRIZvMWDaJab5TY6rmJNNCgdvnBN4MQv
         QBaSfH3dqjqdvQK9gztQZgU5ZgPMQ8kUBNvfYtIyx0AyXMI2ggutFg0nYyDEXlDdL1
         elFK9AubKJ1zkCWtNmkj5OZBxdQ1SYCZ8vc5odws=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] kconfig: error out when seeing recursive dependency
In-Reply-To: <1534312785-28434-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Wed, 15 Aug 2018 14:59:43 +0900")
References: <1534312785-28434-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Wed, 15 Aug 2018 15:14:54 +0200
Message-ID: <ghd0uj22lt.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Originally, recursive dependency was a fatal error for Kconfig
> because Kconfig cannot compute symbol values in such a situation.
>
> Commit d595cea62403 ("kconfig: print more info when we see a recursive
> dependency") changed it to a warning, which I guess was not intentional.
>
> Get it back to an error again.
>
> Also, rename the unit test directory "warn_recursive_dep" to
> "err_recursive_dep" so that it matches to the behavior.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I tested v2 of this series and to me it looks all good, now:

Tested-by: Dirk Gouders <dirk@gouders.net>

> ---
>
> Changes in v2:
>  - Newly added
>
>  scripts/kconfig/symbol.c                                       |  3 ---
>  .../tests/{warn_recursive_dep => err_recursive_dep}/Kconfig    |  0
>  scripts/kconfig/tests/err_recursive_dep/__init__.py            | 10 ++++++++++
>  .../{warn_recursive_dep => err_recursive_dep}/expected_stderr  |  0
>  scripts/kconfig/tests/warn_recursive_dep/__init__.py           |  9 ---------
>  5 files changed, 10 insertions(+), 12 deletions(-)
>  rename scripts/kconfig/tests/{warn_recursive_dep => err_recursive_dep}/Kconfig (100%)
>  create mode 100644 scripts/kconfig/tests/err_recursive_dep/__init__.py
>  rename scripts/kconfig/tests/{warn_recursive_dep => err_recursive_dep}/expected_stderr (100%)
>  delete mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
>
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 4ec8b1f..688f487 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -1248,9 +1248,6 @@ struct symbol *sym_check_deps(struct symbol *sym)
>  		sym->flags &= ~SYMBOL_CHECK;
>  	}
>  
> -	if (sym2 && sym2 == sym)
> -		sym2 = NULL;
> -
>  	return sym2;
>  }
>  
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/Kconfig b/scripts/kconfig/tests/err_recursive_dep/Kconfig
> similarity index 100%
> rename from scripts/kconfig/tests/warn_recursive_dep/Kconfig
> rename to scripts/kconfig/tests/err_recursive_dep/Kconfig
> diff --git a/scripts/kconfig/tests/err_recursive_dep/__init__.py b/scripts/kconfig/tests/err_recursive_dep/__init__.py
> new file mode 100644
> index 0000000..5f3821b
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_dep/__init__.py
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +Detect recursive dependency error.
> +
> +Recursive dependency should be treated as an error.
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig() == 1
> +    assert conf.stderr_contains('expected_stderr')
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/expected_stderr b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
> similarity index 100%
> rename from scripts/kconfig/tests/warn_recursive_dep/expected_stderr
> rename to scripts/kconfig/tests/err_recursive_dep/expected_stderr
> diff --git a/scripts/kconfig/tests/warn_recursive_dep/__init__.py b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
> deleted file mode 100644
> index adb2195..0000000
> --- a/scripts/kconfig/tests/warn_recursive_dep/__init__.py
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -"""
> -Warn recursive inclusion.
> -
> -Recursive dependency should be warned.
> -"""
> -
> -def test(conf):
> -    assert conf.oldaskconfig() == 0
> -    assert conf.stderr_contains('expected_stderr')
