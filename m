Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A575C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388C420879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPgGrCbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeL1PLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:11:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43203 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeL1PLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:11:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so10175220pgk.10;
        Fri, 28 Dec 2018 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XI2WVwqKlqLXYSxDN0ff8vz5ETvbH2FvKrW546WUppY=;
        b=LPgGrCbKughYOV33vPrAx27RGITI7WUVObwe4d9vc+NFRKyxBg6bNK0zliXEehylDO
         CQztcbxyUDYly18OHRILnhCfvNMpbpAr3n74tIasyxCytOlxy2mK/So3Wxcj31j7eFlp
         v9kx35XMmpLW7Ej6MVVOsfk0pjLXKgC/MnBh5fZ4/GyU+8N0VRbfGYTVOOOZZtiI+Sbh
         dI3EQUMoomcdi5h6eQAD7SScjtE9efBxa4gu/xQ7NAS3qntiNKhqON4WbdtIPaVHavlF
         RyoXBy/BygrcMqkGrVA9JrXq4dga/APZWrf85RZoK549gUf7ccoAcy/2lbwiRloyIuFB
         Z2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=XI2WVwqKlqLXYSxDN0ff8vz5ETvbH2FvKrW546WUppY=;
        b=lEXTaWN7ogcriywOJnNk2IIcubuaG4ll/uIRY6nhnBt337nMQWjlaUOazJIQsigHEL
         9rUiu4kJEU1qSvlwxsqwk/AJwKeDqEAuEAHLGUe2qjBt6M5TIqHJozBmW+Rg6gKZR7UO
         1QkKVst8etv/SvaE0TkVFZhN6FfURMcKSytA3F8scB5gFqaWSwyERd+YhqM4x/1etof7
         CPwFiyMmmqnzYakrNw5aqaSvo+zVxLWkqCNDcdXRslN9HFD8j2bUFg/YMca+Y/iCllUD
         FHntEgRlOFnRVNRAbawJchlVzgFGawXeyeLzRE9eOslTyuhamt3mGsuJxO9NOkoNDqmI
         xFlA==
X-Gm-Message-State: AJcUukcLSBKvYad8fxaNhfnZwNUDD6NsxhzokmjVUVdYmP7jZ80lbVaq
        bMD1HFf9LAgkerWqYIUwghg=
X-Google-Smtp-Source: ALg8bN7hZ0jrVxagyitQGtdxmhfAgQOrpfVtZsw8X0Br93ZkMtblDdv65PcP4HG5fz2E1NtpEyyY+Q==
X-Received: by 2002:a63:4611:: with SMTP id t17mr26429412pga.119.1546009862638;
        Fri, 28 Dec 2018 07:11:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm81917777pfh.166.2018.12.28.07.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:11:02 -0800 (PST)
Date:   Fri, 28 Dec 2018 07:11:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony_Ao@wiwynn.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matt_Chen@wiwynn.com,
        vijaykhemka@fb.com
Subject: Re: [PATCH] hwmon: (tmp421) Correct the misspelling of the tmp442
 compatible attribute in OF device ID table
Message-ID: <20181228151100.GA22978@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 02:03:22AM +0000, Tony_Ao@wiwynn.com wrote:
> Hi there,
> 
> Correct a typo in OF device ID table.
> The last one should be 'ti,tmp442'.
> 

Good catch. Unfortunately, the patch is corrupted and does not apply
(tabs replaced with spaces). Please resend and make sure that your
mailer leaves it alone (possibly use git send-email).

Also, please drop the "confidential" trailer.

Thanks,
Guenter

> Signed-off-by: Cheng-Min Ao <tony_ao@wiwynn.com>
> Signed-off-by: Yu-Hsiang Chen <matt_chen@wiwynn.com>
> ---
> drivers/hwmon/tmp421.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 8844c95..7053be5 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -88,7 +88,7 @@
>                 .data = (void *)2
>         },
>         {
> -               .compatible = "ti,tmp422",
> +               .compatible = "ti,tmp442",
>                 .data = (void *)3
>         },
>         { },
> --
> 1.9.1
> 
> Regards,
> Tony
> 
> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient. 
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
