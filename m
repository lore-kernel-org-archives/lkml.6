Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A32077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="01rOIaVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8A32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeIELrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:47:33 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:43017 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIELrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:47:32 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w857IWUS032413;
        Wed, 5 Sep 2018 16:18:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w857IWUS032413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536131913;
        bh=Mw78XbclXOdYcao5JrM/G9zymOm8L1vbUjm6AzHk2+Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=01rOIaVS8unyWVhBmkgJ1wr8Es2JxXElAtqw4rkJDUHMrKiNNXStJIZRedvo6Fi3e
         s9mYAPJqR62iRRql3gxMu3BR+x4QXQkHm41fcvuYdHe8U3xSE/COCcDKkRk9H1vovx
         UpLCIZIszvcBBhAaV6Jpf85TG3O6PUf9wbvsNt00CzLlvZoKF/33I3HuJHHacw/9z4
         dYafeC9DxCJkhOY7jNFF4rjxFwAH2nMO3QQuQJgu7sSjg1QYi6U5C5X4Uo4DObKg6x
         HTNSsPeIcK/9TwbzHn15Bv70JokAd1x5F9r1lDPoXmy887ZcwlyZ5aNDurNmkVl738
         qXapg0aLeTuaQ==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id l143-v6so2326499vke.1;
        Wed, 05 Sep 2018 00:18:32 -0700 (PDT)
X-Gm-Message-State: APzg51D1HtC8Zw+zIL7eP3TsDFUXMpQt6TOHTYnYEK9uLAm2RBYEyuv5
        Ar4LiyyaEB2cDQtD7fDzruplCQZpWOMVkWY34/g=
X-Google-Smtp-Source: ANB0VdauOe6lLDmi/DWBFkuzRUI+374VVDYctLTHphmKL9P6ji4nFz2LfUxKq+PcGxePVty5afnE1CbNnFbPREe/JJg=
X-Received: by 2002:a1f:aa8a:: with SMTP id t132-v6mr18518236vke.80.1536131911670;
 Wed, 05 Sep 2018 00:18:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:17:51 -0700 (PDT)
In-Reply-To: <b82ada4b-25d1-5612-4405-d6a09eb59433@infradead.org>
References: <b82ada4b-25d1-5612-4405-d6a09eb59433@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Sep 2018 16:17:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATshpTJ5sDH7pMzBbhd-zF7Yskv6ptiysn1X+pHB1Z8Dw@mail.gmail.com>
Message-ID: <CAK7LNATshpTJ5sDH7pMzBbhd-zF7Yskv6ptiysn1X+pHB1Z8Dw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: modules_install: Warn if System.map file is not found
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

2018-09-01 7:33 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> If there is no System.map file for "make modules_install",
> scripts/depmod.sh will silently exit with success, having done
> nothing.  Since this is an unexpected situation, change it to
> report a Warning for the missing file.  The behavior is not
> changed except for the Warning message.
>
> The (previous) silent success and new Warning can be reproduced
> by:
> $ make mrproper; make defconfig
> $ make modules; make modules_install
>
> and since System.map is produced by "make vmlinux", the steps
> above omit producing the System.map file.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  scripts/depmod.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> --- lnx-419-rc1.orig/scripts/depmod.sh
> +++ lnx-419-rc1/scripts/depmod.sh
> @@ -11,6 +11,7 @@ DEPMOD=$1
>  KERNELRELEASE=$2
>
>  if ! test -r System.map ; then
> +       echo "Warning: modules_install: missing 'System.map' file"
>         exit 0
>  fi

Thanks for the patch.


For consistency, I'd like to suggest '>&2' for this warning too.


Also, could you add a little more info
about what happened (or what did not happen) then ?



For example,


Warning: modules_install: missing 'System.map' file.  Skipping depmod.





-- 
Best Regards
Masahiro Yamada
