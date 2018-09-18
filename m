Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED4D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED4D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtv.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeISBcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:32:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46657 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbeISBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:32:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id l42-v6so2912371qtf.13;
        Tue, 18 Sep 2018 12:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYROyUwfqDldF90CaxCV2Hkdw/AJW7rIIKDn49iLJx8=;
        b=OPrYQNyOTjsQ10TGfa3spiOd7Q905P41RKd4pRc4vRN4PPGUyBpxJxM7ZpmEotmDWx
         0k+7XwDO2WrTvqsY4xAfFkHNn3e5hLI0H8OX8/L7luuHS31qi6Ux96EhULXdE2Ib5QsM
         Je5D3V5iLOawtcGVkfDOBASapPb+m6Hhcl66oui/xEIcoOTbYG0utOgma0xyLVz2mmzh
         wYoD5v7tix+BqNYas0VoY7ECxft4nltnAoBU70NI5VktGOZQ0QVKE7nLSmc7uZo8+BPO
         GSRqMxdl/2JIlTX8Z2S9RRLXeSnAPaZmH/XTFqdPiz3dcWblmZIeLn+Akgczfec57Vhp
         pmyw==
X-Gm-Message-State: APzg51Dd891FJOgyxAZIGvtvQ6/Hb2z7ouPdHV1aJn5POgrIwCw9Wtwj
        vjlR/byhgE+47X5edAlLeUh7qn9dPuW7xK19s1I=
X-Google-Smtp-Source: ANB0VdZ3yljSeWKleghwrNXHrqY9OCVBP/g58XGamlYNPGGDT/LugbTxJVMh8l77Y8J/jhG/1foZrJPtspgmOwZDLV0=
X-Received: by 2002:ac8:1082:: with SMTP id a2-v6mr22013326qtj.307.1537300724613;
 Tue, 18 Sep 2018 12:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <1537284628-62020-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537284628-62020-1-git-send-email-zhongjiang@huawei.com>
From:   Michael Ira Krufky <mkrufky@linuxtv.org>
Date:   Tue, 18 Sep 2018 15:58:33 -0400
Message-ID: <CAOcJUbzfv8DLpRAbAiodqDDQ5wH1uyqjJ-sKN+qJGr=xagQBNg@mail.gmail.com>
Subject: Re: [PATCH] media: dvb-frontends: Use kmemdup instead of duplicating
 its function
To:     zhongjiang@huawei.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brad Love <brad@nextdimension.cc>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:42 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> kmemdup has implemented the function that kmalloc() + memcpy().
> We prefer to kmemdup rather than code opened implementation.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/media/dvb-frontends/lgdt3306a.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
> index 0e1f5da..abec2e5 100644
> --- a/drivers/media/dvb-frontends/lgdt3306a.c
> +++ b/drivers/media/dvb-frontends/lgdt3306a.c
> @@ -2205,15 +2205,13 @@ static int lgdt3306a_probe(struct i2c_client *client,
>         struct dvb_frontend *fe;
>         int ret;
>
> -       config = kzalloc(sizeof(struct lgdt3306a_config), GFP_KERNEL);
> +       onfig = kmemdup(client->dev.platform_data,
> +                       sizeof(struct lgdt3306a_config), GFP_KERNEL);
>         if (config == NULL) {
>                 ret = -ENOMEM;
>                 goto fail;
>         }
>
> -       memcpy(config, client->dev.platform_data,
> -                       sizeof(struct lgdt3306a_config));
> -
>         config->i2c_addr = client->addr;
>         fe = lgdt3306a_attach(config, client->adapter);
>         if (fe == NULL) {

Thank you for this patch, Zhong.  I suspect, however, that the patch
might contain a typo.  It looks like the `c` got dropped off of the
`config` variable.

Did you test this before sending it in?

Thanks again and best regards,

Michael Krufky
