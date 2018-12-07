Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7856BC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D520989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3D520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLGOXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:23:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44900 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLGOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:23:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so4574935qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBi8OMzz9PhXEeDMdOvhtSmgrBsqnPU60l5oPu5aQ40=;
        b=BUbM4esOw8cnpOqCFurO1O5VziNWW6iII4kETYxILeUq0h9HrzVGXAsa62iyh4RAu/
         CafWpjmU13G/JmgV1qUY18K4ehP8ITCvT4L4C6rsZ4sWVuEKoG0r74tSo6IF7OCOqna3
         wmY9ykiyGMsnwVnpRoCko83lQ60b8t9XpOOynd5mI+9r0pnrCMgt/eTA0W4NSXmDGrak
         otYeI3bP6UrR7MxgfTPRENNrQD1BtyB0X1BYWDSlIsa9rhV3cwrjJX7DYmWS1ifW/ySi
         +zXbPq6Rq+h6xl7KmnEFbCRJTgahxhQcTRsKPj4r5/8NMA2//iCbM38fwbqabSVGMvI2
         UyMA==
X-Gm-Message-State: AA+aEWZJY1DVgV8otIubF+y39vVxYSvkZw/L/Eu6iYvv0DQizGJhqJhj
        NA3FVaEVoAoBerorBvp4Vqhr8uUfPQCdYu3Nq5jiVQ==
X-Google-Smtp-Source: AFSGD/W8dVksIjqCIvq1LtDsJBKCNEqdYcK0/3tZ/hpAa36kmCh+E0bq0wticlcwH62AWpwSpQZvQQHDT8cq1cT2zEE=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr2173615qtl.343.1544192621644;
 Fri, 07 Dec 2018 06:23:41 -0800 (PST)
MIME-Version: 1.0
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 7 Dec 2018 15:23:29 +0100
Message-ID: <CAO-hwJJDhtNqy6gc9OJ+rHnJimrQeAoxxkay5XnfXjxMtvEufQ@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
To:     bianpan2016@163.com
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 1:52 AM Pan Bian <bianpan2016@163.com> wrote:
>
> The memory chunk allocated by hid_allocate_device() should be released
> by hid_destroy_device(), not kfree().
>
> Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index cd23903..e918d78 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>  err_hid_device:
>         kfree(hid_data);
>  err_hid_data:
> -       kfree(hid);
> +       hid_destroy_device(hid);

Looks good to me. Srinivas, any comments?
FWIW:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Jiri, do you think we should send this one as 4.20/fixes material or
wait for 4.21?

Cheers,
Benjamin

>         return rv;
>  }
>
> --
> 2.7.4
>
>
