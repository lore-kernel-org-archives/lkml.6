Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB915C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672212084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672212084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeLLWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:11:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32895 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeLLWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:11:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so14033qko.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4hveH0+pxskiKEONYlkZn2mEsco1rz93C2T/TG9bhA=;
        b=Gj+98H/GX5LoQ0vCWlNFgLOPFp4FnnLeHVUY2bOeF2Ommv0UpWxNij5hPBndVGR3cH
         p3UYFRfl8MXMOU/QvTy7aBgkN6hq2jJ3bYElDKqLIT0x9tXxIngK1vQx1X1oo8Ae6Joq
         6z612l39SMUAx1ME+aM9Zv6FdNP+v5J03vb7CH+aa7rExxxy1/xpF8ubv+sICiFjXykb
         BOgwOajqwmP6PbgvQthFmTFqJX068dnVSBTsZTd+0i608OkOdTRnfXVpX4LsQl4OZWj8
         O3AiE5hxWgWjFFgU7MCCQnjS/klLGXFLonAhay5HEfukQw8T7/Uw4iJSqec/bMRhjH4k
         TOjg==
X-Gm-Message-State: AA+aEWYGzt5b/GqB7cq0SA6XtombHtV/nGretsYGv3144EUZadBtVb12
        AZbZLkWvycR28y6ibGC/f7gNROPrrfYBmaViHtAhUHHy
X-Google-Smtp-Source: AFSGD/VFBgfLL1Kz14JMpWi9zTruSiShlUK2pA9meBTn5215mbYrPCpoEFEAx6aJ4BOJqbj2EH64cPSvAV1e1oj8E2o=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr18775076qkm.343.1544652695287;
 Wed, 12 Dec 2018 14:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Dec 2018 23:11:17 +0100
Message-ID: <CAK8P3a0aUTNOwz2BJjm4H2m2E+oYeeX4G7j6=Yk3PZWvat79Yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: vchiq: fix completion routines & semaphores
To:     nsaenzjulienne@suse.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        gregkh <gregkh@linuxfoundation.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        driverdevel <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 7:54 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> As pointed out by Arnd Bergman[1] there where some issues on how I
> converted semaphores to completion routines. I wasn't aware of a
> macro override happening in vchiq_killable.h, which was changing
> down_interruptible()'s meaning.
>
> This patch changes all completions so they use the proper APIs and gets
> rid of vchiq_killable.h. I took into account Arnd's commit to avoid
> merge conflicts.
>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the follow-up!

      Arnd
