Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EAEFCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BA320020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6OA9fZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BA320020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935838AbeFMO2M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935692AbeFMO2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:28:10 -0400
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com [209.85.161.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3980208B2;
        Wed, 13 Jun 2018 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528900090;
        bh=uqy+vrAkFXplNRPqoWvQLEAqiq5xO96171wdQZxpOhQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=s6OA9fZSnUzuI4fpbcyK1JXGvw6Rl1UvA66qemvNTu+CrtlAwQLJl5K7/P+8DjSB5
         73Tfe377WHGtL6QorjzOZh8VJy4dW69P4Eq3v3h/r8vlAtH4D9TmXXSiPphuanQ8IM
         lafosyusYGIkTVZ4ijijTJEhUzQd/pie4YyvzMGk=
Received: by mail-yw0-f182.google.com with SMTP id p129-v6so940333ywg.7;
        Wed, 13 Jun 2018 07:28:09 -0700 (PDT)
X-Gm-Message-State: APt69E0RcjFiCNchhV6Noj7I2+ESM+aM5CJuQP2mwFM6elr4w4tK1ruC
        Fu/x+q2GicDjIeUZ7lgyITriG1wO9Y8ObcWyc90=
X-Google-Smtp-Source: ADUXVKL+IUPhxx8cpkFtT35Tvet3hgFHVl1KL99cvEzlRzwo5Uj3oQxbgCrCYpImuc/nhRfDV5/3Z0LWCzoMFgydEaE=
X-Received: by 2002:a81:ed0e:: with SMTP id k14-v6mr2457183ywm.196.1528900089083;
 Wed, 13 Jun 2018 07:28:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 07:27:28 -0700 (PDT)
In-Reply-To: <CAAtXAHdF_AEcohGW=yoUgoe1OWcxLeCYgp2u3pjsmUn=-z-_bg@mail.gmail.com>
References: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr> <CAAtXAHdF_AEcohGW=yoUgoe1OWcxLeCYgp2u3pjsmUn=-z-_bg@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 13 Jun 2018 09:27:28 -0500
X-Gmail-Original-Message-ID: <CANk1AXTWfgaJJvni3e8t9ViOs0GccV=zkc1kX-Yi4jhSwWneVQ@mail.gmail.com>
Message-ID: <CANk1AXTWfgaJJvni3e8t9ViOs0GccV=zkc1kX-Yi4jhSwWneVQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:42 AM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:
> Hi Christophe,
>
> good catch!

Yes, thanks!

>
> On Mon, Jun 11, 2018 at 12:20 PM, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> If 'fpga_mgr_create()' fails, we should release some resources, as done
>> in the other error handling path of the function.
>>
>> Fixes: 7085e2a94f7d ("fpga: manager: change api, don't use drvdata")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

>> ---
>>  drivers/fpga/altera-cvp.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index dd4edd8f22ce..7fa793672a7a 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -455,8 +455,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>
>>         mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
>>                               &altera_cvp_ops, conf);
>> -       if (!mgr)
>> -               return -ENOMEM;
>> +       if (!mgr) {
>> +               ret = -ENOMEM;
>> +               goto err_unmap;
>> +       }
>>
>>         pci_set_drvdata(pdev, mgr);
>>
>> --
>> 2.17.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
>
> Moritz
