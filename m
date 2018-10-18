Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA185ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E92421476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsqyY9Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E92421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJSEcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeJSEcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:32:41 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F38D2145D;
        Thu, 18 Oct 2018 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894598;
        bh=xTQvPGCt9XL0vh4wtjwuR3v8u8YLbxZqxpqm+U3/y/A=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gsqyY9QnfBJ5ZnL4KWct/JSLJ+b3yP6wZeCy2t5CSDntLwGHeNf5zCgBgl4JZLu5w
         aiVNe1/FEuXXMNJF1Uz0NjGCgYmhlgv3V8cnRa1tioXEogyErz44sKM5Py5qs1aL6z
         xw9IsvU4XkpQi/NSe0IGtAtqCzaW2BZz2yAPnsiM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181018191340.30440-1-natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20181018191340.30440-1-natechancellor@gmail.com>
Message-ID: <153989459788.53599.2276628850158968119@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: s2mps11: Add used attribute to s2mps11_dt_match
Date:   Thu, 18 Oct 2018 13:29:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2018-10-18 12:13:40)
> Clang warns after commit 8985167ecf57 ("clk: s2mps11: Fix matching when
> built as module and DT node contains compatible"):
> =

> drivers/clk/clk-s2mps11.c:242:34: warning: variable 's2mps11_dt_match'
> is not needed and will not be emitted [-Wunneeded-internal-declaration]
> static const struct of_device_id s2mps11_dt_match[] =3D {
>                                  ^
> 1 warning generated.
> =

> This warning happens when a variable is used in some construct that
> doesn't require a reference to that variable to be emitted in the symbol
> table; in this case, it's MODULE_DEVICE_TABLE, which only needs to hold
> the data of the variable, not the variable itself.
> =

> $ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_dt_match
> 00000078 000003d4 R __mod_of__s2mps11_dt_match_device_table
> =

> Normally, with device ID table variables, it means that the variable
> just needs to be tied to the device declaration at the bottom of the
> file, like s2mps11_clk_id:
> =

> $ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_clk_id
> 00000000 00000078 R __mod_platform__s2mps11_clk_id_device_table
> 00000000 00000078 r s2mps11_clk_id
> =

> However, because the comment above this deliberately doesn't want this
> variable added to .of_match_table, we need to mark s2mps11_dt_match as
> __used to silence this warning. This makes it clear to Clang that the
> variable is used for something, even if a reference to it isn't being
> emitted.
> =

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Just curious if this is a common occurrence? Maybe we should make a new
MODULE_DEVICE_TABLE macro that can declare the table, struct type, and
add in __used to the declaration like is done here? That way this gotcha
goes away without us having to remember that the table is used or not
used somewhere.

Anyway, I'll apply this patch to clk-next.

