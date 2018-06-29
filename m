Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2EBC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DA327DA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdjS0JUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DA327DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937290AbeF2Tpq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933642AbeF2Tpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:45:45 -0400
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com [209.85.223.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C6827DAB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530301545;
        bh=rEuogYijxiMZQjoPHWMdXh9O/1gbzZsjNoZ7ClIuDyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RdjS0JUVa7MEYzqFnunYIBgqcd5m2yXZKyMnfc2qyrcN7Iv1poeLuq8rtf6i7DxkH
         8MdYCfgILF5hMmTB5KrqbWGflgdM+nMXG3KwdUsboU6NeCgwGWS08pfoPjQgURAas/
         QBa3C/Wh22yEKnPLt/UxZEtz7thHQ71Ujen2sZ/M=
Received: by mail-io0-f178.google.com with SMTP id l25-v6so9436633ioh.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:45:45 -0700 (PDT)
X-Gm-Message-State: APt69E0b7NiSntt5bHQXsbR6vNLiyTUI1dYKSRqNIIl8j0LBLbYl5nx4
        1qk62YguPPOt+ueCclD9FC+sTPOR7VYQkvhPZQ==
X-Google-Smtp-Source: AAOMgpdg0/FcuGn3NyyctC48IEZcH5xTVuzPV2pzcQ9RtCkLpkRji9nhWR639JQlef2DUsacyp8OXKbZs+i7m1wNbfI=
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr6563819iof.79.1530301544742;
 Fri, 29 Jun 2018 12:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180629185212.GA37517@beast>
In-Reply-To: <20180629185212.GA37517@beast>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Jun 2018 13:45:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKjcvLOxoWvqaZYJwEoc_s_B-0KnAfhZYEg9Cwytd4sA@mail.gmail.com>
Message-ID: <CAL_JsqKKjcvLOxoWvqaZYJwEoc_s_B-0KnAfhZYEg9Cwytd4sA@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a maximum size and adds a sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Not sure how you came up with the CC list, but you should probably
have some i.MX folks CC'ed.

Rob
