Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAEEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8773F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O04KaYBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8773F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeH2Lvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH2Lvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:51:47 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF372086B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535529370;
        bh=jYHgfKd1E9yVvMuZpw2qIqjwk5DNAoZRPLg7oRWx6hI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O04KaYBUK2YV04o2zZUmW8Hp0d8PFAQLE8BOgj7etxTvzgkxXHfwMX6zRxLafJc7w
         n+qjm2cKPu0sHRfM4xwKJbdrLJ2bUEMPKENTxEEyWWJUKCUhWKSzJRO7GN67zYYtyc
         Q4a6WTEB3DiKksUnPH75bAVoXe0rAa5djF5uLqsg=
Received: by mail-wm0-f44.google.com with SMTP id f21-v6so4269957wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:56:10 -0700 (PDT)
X-Gm-Message-State: APzg51B2+bYFYa+vHNGylyYDc8FHnx65NGu/WKMR8tl7G39yYS4lI5Xu
        9iippmzG2hd0MmK+LLFCj+g0KQhNscpyWbeCaYw=
X-Google-Smtp-Source: ANB0VdYJ5rOf32SZfZ0RejYoWdQSiQfBoX789b8alDd8K5bmdc2C8cRATXU/mzaUcZ3hs+TpVnUlJy02Qz/1PwAAsEs=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr3587358wmm.117.1535529369078;
 Wed, 29 Aug 2018 00:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1535527943-32566-1-git-send-email-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 09:55:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
Message-ID: <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with KERNEL_XZ
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     mkubecek@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 09:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> After commit faa16bc404d7 ("lib: Use existing define with
> polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> directory thus any other user of this code should define proper include
> path.
>
> This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
>
>     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
>                      from ../arch/powerpc/boot/decompress.c:42:
>     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
>
> Reported-by: Michal Kubecek <mkubecek@suse.cz>

Reported earlier by Kbuild:
https://lkml.org/lkml/2018/8/23/47

for the credits:
Reported-by: kbuild test robot <lkp@intel.com>

Best regards,
Krzysztof
