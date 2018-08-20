Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D65FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B24A208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SRdLS1+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B24A208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeHTWk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:40:29 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38888 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:40:29 -0400
Received: by mail-io0-f195.google.com with SMTP id y3-v6so9102926ioc.5;
        Mon, 20 Aug 2018 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4VNIlPMh0zyNUyt9orrk8l4nfoluwyEg9+fFVhNc9Y=;
        b=SRdLS1+5/E6EfDfOQKdwpiii8vU9NLlT2rZDs6Z4NS2fjrnZTSoGiXf/oKZ8s4XAIS
         qdrzSfkzO8iTaVtf7l5iOfOyVJSk6LjR219xfgGWjBRSy5OVa/4WXiC0e4VPSusjxLTR
         J7VFJkhdhvbFmHSj+29gxW7q1rv0ASfVW1tqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4VNIlPMh0zyNUyt9orrk8l4nfoluwyEg9+fFVhNc9Y=;
        b=swljRIlh+wFNK7RNiyXN8OwAhw592v10oSGIbNnvXy+R9hHFA6ffIf/oga76pibp1Z
         wqUQNeW7RNjJI6TrH749cSCS74sZtF4+IRl5XL0TVCn6dzmqZLw4Qlnz/sJ+1j7XVzFw
         hTEzy3dD5fRsQ+QD4r/dPNE+MaTMLhWe/iueOPNKrTI7GIyUqH0GlOkEr8LTLUXVx5Cw
         o2T1z48PMaFgJvz3nMa1qcmMSFssW4cys7OwOiergcOsB8ps02z+kzekhxS6FtxbTqOs
         u0hWXN5NJCtz2xlnikonFQLhnbZi1dBohx2kcbF+wjwBwELXnYNapXBVlrqmcKNTx0Xn
         WBdQ==
X-Gm-Message-State: AOUpUlGbkpSHHz8YLSdM/rV2yIfUDeH9yWZcv4nWzyt+4skkiyNSGfVS
        sTk5kTpGbEkglEHOOzW9SxZE6sBII/YQkEy7t//frA==
X-Google-Smtp-Source: AA+uWPyNM1yjakQeDbLD2vs6wL9z4agltcNYVIafAKrUqV68hE923c7Hf2dfb6n0WdLub++aNlNItLYymJfSxthEn4k=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr23649211ioh.259.1534793017584;
 Mon, 20 Aug 2018 12:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0Jk_Q-9c7PizRF4HteigfiOprRszpaV9SCk-6tUYfVVQ@mail.gmail.com>
 <20180820163104.12879-1-tony.luck@intel.com>
In-Reply-To: <20180820163104.12879-1-tony.luck@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 12:23:26 -0700
Message-ID: <CA+55aFzLnJbAO=_ZNAU3mOnp+LsZj2=SLSxWfDkRxbyFXzWtNw@mail.gmail.com>
Subject: Re: [PATCH] ia64: Fix kernel BUG at lib/ioremap.c:72!
To:     Tony Luck <tony.luck@intel.com>
Cc:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, boris.brezillon@bootlin.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>, tn@semihalf.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        miquel.raynal@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 9:31 AM Tony Luck <tony.luck@intel.com> wrote:
> I'd suggested an #if !CONFIG_IA64 in the functon, but Arnd
> suggested keeping the fix inside the arch/ia64 tree.
>
> Fixes: 0bbf47eab469 ("ia64: use asm-generic/io.h")

Applied.

            Linus
