Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F319C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2145B20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDdXC32R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2145B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeIFEDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:03:50 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42292 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeIFEDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:03:50 -0400
Received: by mail-yb1-f195.google.com with SMTP id j8-v6so3396787ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n5roczbVBjuyr3RkTd7v8JkHuLRrvCkLrxlQRyWV2FQ=;
        b=aDdXC32RTQCZktyfg+SqlpTiEZvorCbh4WbM56ADAy5Lrj7RBvnjeUX3szV7Al238C
         fbF5XWm2itp7vx4PIe0yZbtPCiIJAkp0oVdZ3lvGhYwqVxoBoMWchCfz6Q3/Tq2LoDt9
         5NrxYm5/lDlFkblLmghleifOYwofd+eJhxSVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n5roczbVBjuyr3RkTd7v8JkHuLRrvCkLrxlQRyWV2FQ=;
        b=AmSDtoRe78/+M+6jMCctXUfsP1MIq/76Tu1DpeG7hadDEVBHdWvjh/298hEdApWwoo
         w2bLUsG+D+Y6WxdYII48VCeT20c1EVb8vp6/xlWe2oBKNF9apaJ08lN5n2W6QGTMLX60
         oASuvBhD04H7HA5DLLTTvET4yR4jhuMtFx1CidOM1QO5DxNpf3VFEC2uPNqqLQCzMnDd
         CQBHniVxOTXRoDvPyKOECm6ncbOZjzmnhsMT5EaMsfx5kI62zlhSgsF3jdmjxzNKumY/
         HTE0vMuHUjaq2NjtkgkMuYtS3LW4lCf4wuSiSOdO1ej2hMTltARspHssUkovq+ynK039
         rkfQ==
X-Gm-Message-State: APzg51BIDQNfG0cqG1YJttihW+HA+jdDaGu9CBm+b7U1NxfuXJugJ+/U
        d7eY4AwUPXFGDVVBntfXQsPHGZskUqI=
X-Google-Smtp-Source: ANB0VdbWIoAx5pmr85Aw12tg57TdAOrSHtDRWOwYWSAt+G0FjhqI3/YYzA5N5wkqSTvPYFIqngCLng==
X-Received: by 2002:a25:53c3:: with SMTP id h186-v6mr24814ybb.472.1536190281084;
        Wed, 05 Sep 2018 16:31:21 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p62-v6sm1189900ywh.73.2018.09.05.16.31.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:31:19 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id h22-v6so3393436ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 16:31:19 -0700 (PDT)
X-Received: by 2002:a25:a28f:: with SMTP id c15-v6mr19193ybi.137.1536190279091;
 Wed, 05 Sep 2018 16:31:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 16:31:18 -0700 (PDT)
In-Reply-To: <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
 <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com> <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 16:31:18 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
Message-ID: <CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 3:49 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
>
> On 06/09/18 01:23, Kees Cook wrote:
>
>> Should I take this, or is it part of your series going somewhere else?
>
>
> It turned out it doesn't really work to have a generic series against 20
> trees :-/

I know that pain very well!

> I'm submitting them individually to each subsystem.
> So this one is just for security.

Sounds good.

James, can you take this directly, or would you prefer a pull request from me?

-Kees

-- 
Kees Cook
Pixel Security
