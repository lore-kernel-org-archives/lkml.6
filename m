Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6892CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB132087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ6DTLvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB132087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:23:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43666 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:23:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so5705928qtq.10;
        Wed, 10 Oct 2018 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/EnjvXLxxC1lxpX4Cdw8vk+DMf5R6lISvqYhGxnS2gk=;
        b=tJ6DTLvcOWUXqZB2bzQpA86Pkfd25Oktlhr4PRydmqmQGF/1ghqPQa8XfyC2FylODD
         0sV3PIbNPTQXFIvBXHQg31zj7A4mUHbpwRUNtqXGvnOkCkpPGmNa+fPoKTJ+kkaGhsSk
         6EbCQ5UrywgzgkyYCUUs5y2jUSDCPf1cJCu/eV6kh1JAXVVXX4BjP6DDC4YRgVLIelBz
         +yIjlCrGobgwfgGUFF13i5QfL7CK20jgvmPwPnLLt0Kw066yj6IFqGAzrCDaSdlFwHWn
         vJkipRwCRFbKGo/ntzEoT/JUJ33S3hmyaV0LnqR/6JL6zSVJf/MALJENza45mFABur/m
         f5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/EnjvXLxxC1lxpX4Cdw8vk+DMf5R6lISvqYhGxnS2gk=;
        b=ipZLV/R6WziTDXl7OpqD/eDomWz4JtiMk3XE66J0Zljw4JLlM0rHI84hgwR78T1NDm
         luR5KXIVArL5jGeUyX0RZmgh42mRTV61yME8/VXFcd68mUiFMlLxF2W1zE3rz265XvHc
         eOtGAR5Kus7GDq/qoQRHxJi/c7cj5GzXBD0Csdr1I26LrII9Y4+l18u3KCcIpTfC16Tv
         xMWqKPJtis7op/bmHTMcEfaWpeykQ1ev11DlvNVu7p/YFHFtV/jqWkT4GkGpvZRa/PST
         rDVjqGTE9EwkxyR40l7L3K5TFaoh2pbx8bqc4KftBloXq96c6wXovVz2cXxSshRYuiFr
         qAtA==
X-Gm-Message-State: ABuFfohi4OwF5m3SebUdCfDHyIOCzH0JJ1h/+3M9xMGdB4cyHcsZRtFc
        Kay75HjsBd4dAAkZr5P1Srj/6B7NmSB0Q3KUsI0=
X-Google-Smtp-Source: ACcGV63GVxwvu72BprO+Piw4o7RZb5f4a21GngHOqJwfNiGIebElJDVi14rl06cCqwB8TVZgKS/qUOdlsXjctL2+U3Y=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr4100106qtl.343.1539180082528;
 Wed, 10 Oct 2018 07:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:01:07
 -0700 (PDT)
In-Reply-To: <20181010134317.8466-2-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-2-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 16:01:07 +0200
X-Google-Sender-Auth: L1yb19fsh4uahDeU0X4khboklD0
Message-ID: <CAK8P3a1vSqKk4jRoz-YOnLKP6uL7sPRLj9=BVz92mnjNjbJ3Tg@mail.gmail.com>
Subject: Re: [PATCH 1/3] eeprom: at25: Drop obsolete cast in at25_ee_write()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
> dependency") changed the type of "off" from "loff_t" to "unsigned int",
> there is no longer a need to cast it to "unsigned".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/misc/eeprom/at25.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 840afb398f9e4c88..7707d3fb49b526d9 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -160,7 +160,7 @@ static int at25_ee_write(void *priv, unsigned int off,
> void *val, size_t count)
>  	do {
>  		unsigned long	timeout, retries;
>  		unsigned	segment;
> -		unsigned	offset = (unsigned) off;
> +		unsigned	offset = off;
>  		u8		*cp = bounce;
>  		int		sr;
>  		u8		instr;
> --

This looks correct, but why not remove the extra variable completely
and rename 'off' to 'offset'?

      Arnd
