Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34879C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DA208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaSRR06A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2DA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPG3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:29:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42332 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPG3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:29:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id a197-v6so8163421ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JlaMNNLZrRMcmPipXvj1MaffeFHJzKl11I1sInu5gCg=;
        b=BaSRR06AmgkkvNJPCSEbCGNGzOwshYKfXZmAzg/CYB2hgUxzpUmROD21/qqVD2CsX7
         qGXVJF3lsGXiPBkG3S+7GWHJPexOvtz5fQ9AY6iXUMTiWQWAqkFQyJiIN3ytN2jVdwAa
         kcYkyOiM0IKZKe3YHYe0dcU00snUiY1Kn/INA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JlaMNNLZrRMcmPipXvj1MaffeFHJzKl11I1sInu5gCg=;
        b=DVQJx3DeuoVwwxMrYMqhkGzeAfvCY/dzQZFUeiPrjmNApEszvvglgjdhFnDQDrzlGN
         peuwSKqdOiVgTueZUJzJ/7NJqBXTq+IKaQtEGbeWp4VTPwnq9JeSqAIGN59RnDDIPnIw
         KxuDhu4TNqdO/8yjVM6stTzhA2IE9IzMgk6IzA+ewZa5BoZNe4BLBoylC2o87LNSyhum
         RAUEv+v7SZACGNWFypRVtIOOAAMMBTEco8MRhd6yA+ZmRuTHD3Wj/t/H21buIE2CBDzT
         m8yKa6X2NduYG/igWZCgd2/baC01GtfWrjFSmNXAcHGJSD06zER/CrqRqKMDcUUI9eqh
         GNuQ==
X-Gm-Message-State: ABuFfoiF5oLl7GDjYEjqKWU2M2VUFCSxxLSle+u+IWxq37bBzsI4VLKj
        aSXfPA0w52uI+I+LzhlFMdxw4P8OscI=
X-Google-Smtp-Source: ACcGV63LNTl9Ms9Uk9mHSFTku3+47SS+DdarIg1cuEYsDT3K/mSZR7EaBl8prLDiA8bquoIvrpd0XA==
X-Received: by 2002:a0d:f385:: with SMTP id c127-v6mr10294265ywf.10.1539643354698;
        Mon, 15 Oct 2018 15:42:34 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id j202-v6sm3075114ywb.69.2018.10.15.15.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:42:33 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id o8-v6so8140668ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:42:32 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr10381772ybk.209.1539643352452;
 Mon, 15 Oct 2018 15:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 15:42:31
 -0700 (PDT)
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 15:42:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
Message-ID: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> This series adds support for the ARMv8.3 pointer authentication
> extension. The series contains Mark's original patches to enable pointer
> authentication for userspace [1], followed by early RFC patches using
> pointer authentication in the kernel.

It wasn't obvious to me where the PAC mismatch exceptions will be
caught. I'm mainly curious to compare the PAC exception handling to
the existing stack-protector panic(). Can you point me to which
routines manage that? (Perhaps I just missed it in the series...)

Thanks for the series! I'm quite excited for ARMv8.3 hardware. :)

-Kees

-- 
Kees Cook
Pixel Security
