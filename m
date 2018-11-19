Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/3cpRTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A4520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeKSWo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36023 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbeKSWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so2367991lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVSy+uRJIJhKGegpw54bdgZPAeH6fG67Foz3V97ekgc=;
        b=H/3cpRTxJbpsF7Blh132PgvUO7zD4BkC9pIdNrDv/6ZyP+5kpHoMXSHRDYtRU72L2l
         8fT9nGCOJTB72/MBWTYF9D8kc98DwrtKmMgDZmsSW64GDsR4lvK8RdKyTNa89seZsc9o
         4H+IP98Kr3XQ6ffFTF+Dn508Zd1c3hbSq+Bi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVSy+uRJIJhKGegpw54bdgZPAeH6fG67Foz3V97ekgc=;
        b=hxjb8vBWKan7+i3PA48j1xuJlz1XfLeDA7UJYPmMJegXpbwdFCI73JbDd1Hrw33Jiq
         QedkdIGJJxKbiFH7F9Ssx9tuzPQ+5FRJx15hgoZwuW+SyPomBqSayAhJHcZCQkLV3Mi2
         EQLO/uDgqL5DFe1PbVdLJ8ekaLT/KhYyR6YvY527kmtVM5Cu2xiX/e1NnB8o7wBjKvPP
         Qh3j0p6qV0FzD9maOkTr+tF2UV0kVo0qHuDqShBIvERdRLSt9Z1xh3PjfsxFH53ggKhw
         vyDhQxSd4rFgfBkNE/jUIOCJDOI4BSXAH5dLB3pOiIikbn9Kqbm34uYKC7v5yC/VB6xe
         VR9g==
X-Gm-Message-State: AGRZ1gIpX2SagL5Yb/Y/InVULXWZiB9bvIRAT/+mXJNRL2eyPwzsuowB
        1eGVC6ZugRjU1dHPCmZkNVpv+IOVSzcUOLseERpM1A==
X-Google-Smtp-Source: AJdET5etmyiRtoTmZXFf1RuIvSprLi3FMZw5RrmbguJQK9SGFlntIlG7AKGYdROswJ1DPjfzvPoQOc239sUJWAKrjXY=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr11201597lfa.32.1542630057789;
 Mon, 19 Nov 2018 04:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181113095142.32015-1-benjamin.gaignard@st.com> <20181113095142.32015-3-benjamin.gaignard@st.com>
In-Reply-To: <20181113095142.32015-3-benjamin.gaignard@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 13:20:46 +0100
Message-ID: <CACRpkdZD5EurbTRyUg7AWRZqVQ-6rmUQDUmVVCFU3r0Y1bwnVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: stm32: protect configuration registers with
 a hwspinlock
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:51 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:

> If a hwspinlock if defined in device tree use it to protect
> configuration registers.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Patch applied with Alex' ACK.

Out of curiosity: what is it protecting against?
I would guess simultaneous access from another CPU
but the commit doesn't say.

Simultaneous access from two CPUs makes it extra important
that all register access is read-modify-write, so I'd have a second
check over the code to make sure this is the case.

Yours,
Linus Walleij
