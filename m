Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFCC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3DE28017
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgT+IPrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3DE28017
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeF2VZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:25:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33206 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbeF2VZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:25:07 -0400
Received: by mail-lf0-f67.google.com with SMTP id u14-v6so2720040lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=264d1/sGizdXQ7pu/d1WhxTEmc82V/TX+3f+foUW27k=;
        b=PgT+IPrPh4vipbabRu9gauiSJAo9Cjp/ID95cQCRtdpPKf3OCCKQ3bUCrvj6rlWrEk
         nEAANMd4AL/BboLJjaxMo4+fkpocd0xZNmh5j36C9U3w7b5ha196f45mOYLtlryoEC9d
         mg+C1T8Jy5jseNMjdg4U0ykvSJns6O/WGIeYWWC0XqOHQDvZI0Yru5CV3qJPi2xJYbh6
         I/THEsUYsCMn970JViDm8C4kK5ezrEFF7n9ok87qfPr/qzJ4gtwGpnSwVRDjsZVj3APw
         glc4GCAofHBalW3fHdhr2tEukM7RvWRL+UkF51BQwRbq7WZf85OKN69pGKelihdLgMJb
         ibLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=264d1/sGizdXQ7pu/d1WhxTEmc82V/TX+3f+foUW27k=;
        b=apVlT0e31ORWyQuI9H2lh/UwnVucuAsKssEgpd9JMW1ljOyHcIL/xZNCPY1u2TAN9u
         a3fQT8IbzFPXcO4kMrldoSZ7gg5ncvCIsOUmWxm7XM3pHepU2Z1pSdM/Xt2DNGJ9pjrO
         mstOKHfGq7n3cSToB/9k49s0JK/CNNYXOg5GijbhgBcQSwx7Um+ATMArRA+bGqPZcopl
         FfvasMmPacz8VfggvEp7cHuC0rJu4c9HLW7zsHzuwe5mWAJu85Ns7ARnn70kH+Eiykh/
         EPgT2eleUhB+D8vocr1VPDUFRDdYMGa4McNXanId9+qhHp8IQhLJvrMtrjJ6ea1JAexd
         BXGA==
X-Gm-Message-State: APt69E0Iksso98hZqSikTgHNXn799KPTVl08/FpygiM0W1if8aazYUCd
        iBEmZz9QiDvDJA/QSByLo/qfMSZLj4jgy0b7ky0=
X-Google-Smtp-Source: AAOMgpdNj6ldSnBUScTTRYyaRnq3bpGvtYcAOdLo8zk955s1URBYOtfMUFoBr8bWWKEIIOrdVlgpzelyGAfZ606xFU8=
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr11384158lfd.17.1530307506593;
 Fri, 29 Jun 2018 14:25:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:25:05
 -0700 (PDT)
In-Reply-To: <20180629184618.GA37364@beast>
References: <20180629184618.GA37364@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 23:25:05 +0200
X-Google-Sender-Auth: oD3_djs9AyDSC_xqPqJdH7IT_jg
Message-ID: <CAK8P3a18SfxL5RfyrUuDGK9wr34kHEa2MxMxK1tHgRBBb7N3jQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:46 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a maximum size and adds sanity checks. Additionally
> cleans up some of the int-vs-u32 usage and adds additional bounds checking.
> As it currently stands, this will always be 8 bytes until the ABI changes.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Kees Cook <keescook@chromium.org>


Looks good to me.

    Arnd
