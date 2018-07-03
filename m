Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4D5224F7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJi+ue0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4D5224F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeGCTZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:25:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42908 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:25:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so2496841lff.9;
        Tue, 03 Jul 2018 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A4saPhhZrBRZq7wajUxDZmhVWGCe7sbok4ayO1CiSrQ=;
        b=eJi+ue0Hvy+50EDhwCI8ESKkpmCM3hhP+LgrFPCA4JHpMNEIt6ZeQJW1wAiW5Ak72i
         NmADM7spfSt89s/SIVexnMfw46toofFlwgqBMYT2bluQ0Bw+JU1OXQn2q9cXLxERyeZZ
         KHJPcGX6Xi2FZNPMW6LdBVrIjrNYYBxdXJOfipj+534/xxarUqFQJAhRsFYPzvGAVxL6
         asZYCNe1YlTIjswivuL0fNLIcXR/bwvJ70BTbB2TaZi6PTOKmC0Pj//WMz0wYZTFfc2k
         zWY/6ZA3yx9Pzwj3OAhHrKI02Y3jbIZ9jlDjQ8vx4LHG19qxY9drMLIfKERVWBp3ylFj
         O8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A4saPhhZrBRZq7wajUxDZmhVWGCe7sbok4ayO1CiSrQ=;
        b=E60sLzgD5uURyJ/68fdsZPwHvZlJGDAqXsYuGfgzzronPa8dIcLp3pn0BwRi8ZR2c3
         0MCXmDEJ3153K5aOSkuvEpW9cW1bexAoISt7gtZng33iiacVHInXXiUMAeQOGYNFGyNd
         JFdM1j8rS04CE1zZ8iRbicBrMoNi3RvxPbo8lVQfQXM7UhjDj2U1t29qQyYRwkVUyVXP
         ezjPeHEyr4qADe+ucaveoH+fZC6ASdsmrzKSlsD0g2oF79UWufNHo4r7Du+q5b5ZD2ww
         CqG8/G5hAT7C2lcxgqNTIFbyHYh4VROy3DB+YQxSl6+jN2c7dxhZpPMv+jjZ4+KRsCju
         +bOg==
X-Gm-Message-State: APt69E1yx4WAgt4kqcG+Ym2+UflLu6ttwZEESElz2dN5mYL+z7vY46Li
        m5KHa0ArsoZyp7Erg71ErPGWCu8thiub4ZMekTw=
X-Google-Smtp-Source: AAOMgpcC3SMq31opUQ3LOo8F08eF/jhtOztmRjvhBtkq2Q5cmXwvMcBlFhSb7Dur8iYwjwiH9XdIFlmtlaphRjRKWXY=
X-Received: by 2002:a19:c218:: with SMTP id l24-v6mr752333lfc.55.1530645940053;
 Tue, 03 Jul 2018 12:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:25:39 -0700 (PDT)
In-Reply-To: <20180703073249.29522-1-colin.king@canonical.com>
References: <20180703073249.29522-1-colin.king@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 21:25:39 +0200
X-Google-Sender-Auth: SrSmaRv1ERrdZQmWFOBGnE4N6K4
Message-ID: <CAK8P3a3vfiSzeAqROx-D0+f0bMgb6bLLCp-Y+bCRBtnBwg94zA@mail.gmail.com>
Subject: Re: [PATCH] misc: ti-st: remove redundant variable 'type'
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavan Savoy <pavan_savoy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:32 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable type is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> warning: variable 'type' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>


It seems that version of the code dates back to 2011 with
5c88b02196a9 ("drivers:misc: ti-st: register with channel IDs").
I don't understand that patch, but if nobody has noticed a problem
in seven years, it's probably harmless.

> ---
>  drivers/misc/ti-st/st_kim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
> index 5ec3f5a43718..28fba5b3625e 100644
> --- a/drivers/misc/ti-st/st_kim.c
> +++ b/drivers/misc/ti-st/st_kim.c
> @@ -138,7 +138,7 @@ static void kim_int_recv(struct kim_data_s *kim_gdata,
>         const unsigned char *data, long count)
>  {
>         const unsigned char *ptr;
> -       int len = 0, type = 0;
> +       int len = 0;
>         unsigned char *plen;
>
>         pr_debug("%s", __func__);
> @@ -183,7 +183,6 @@ static void kim_int_recv(struct kim_data_s *kim_gdata,
>                 case 0x04:
>                         kim_gdata->rx_state = ST_W4_HEADER;
>                         kim_gdata->rx_count = 2;
> -                       type = *ptr;
>                         break;
>                 default:
>                         pr_info("unknown packet");
> --
> 2.17.1
>
