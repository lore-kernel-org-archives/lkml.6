Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048292081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU7D7sPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048292081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLIEOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:14:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIEN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:13:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3643665plb.5;
        Sat, 08 Dec 2018 20:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oter4+QwiWoynhO7XJLwtHH9pRa3Zo/z27fW9AWKXZg=;
        b=oU7D7sPiSZkfcuVm3l//To5btkDGMY1rvTWf+jevZ8OLifdM76u3Fkk8zqmmINBmHM
         qd+GcSVY6jwYN/DUYhwimZ47/MFp8+S69LDiU66KVa7T4qDVpO9HmMpNQTVhDsc8uMrU
         jzw8c0T5EFWn/parGoeA03hA5NGk27/TIZmbgV0jby4DGARXXpkmeYwbSzr/BevqEvUk
         aPhqCi8873u33nA/Ysvdhh87IAzsKO7VnOKC0KPY/m7cl93sbDXxURoOfi8GKlJspYMm
         sv7wXrcMbDktWzQ7Fw8uFowW2uhHaXOb1nic9sYvmtvrYgBL1v0s2p8c452AsEnc4diM
         hOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oter4+QwiWoynhO7XJLwtHH9pRa3Zo/z27fW9AWKXZg=;
        b=lCg/t8EuIF26xwru07K99CHRXOT48UMWnMPqJTh9WuiQPAGohGfAyzogXA6c+Pk7/d
         L+h6ZLhDheiSeyoRCM9wQQ7MdhNpiBYhrZyvp4aHQuETCs1Wygw+9bOpnZnayPpf8lUL
         mRlyceExzuqrtezHQ2Z5mj+Xeiyl6xSqimZpJd3Q85FSb8AT8u9TTvdeRsh2VrRUTgtH
         nm0qrhKtb1yUhRg1v3nSLyeZoaVWyMdMxJ0KkH2gTMALE3G8y2n8bgLzQvtT8GuexEHB
         S340CJ/096MabsJM47Gb8l5bpFh29gNH0kimuy5NgnIDFqL+HucPSYhMyMzZRsp2wRnU
         K8nw==
X-Gm-Message-State: AA+aEWbQ2EvbP4TY9iIdTy5mXDpy5RovALuXmfNHEtfoSGnK5yN1Bwls
        19LwImagNYk3BsyJ0SEuC7A=
X-Google-Smtp-Source: AFSGD/Wcmke4yMOmcjfbwG+Ey9QD+/ex9pWGubRcBtSnTEycVnR07gqVpwS4DPsxZ54Iuy/65bRwEQ==
X-Received: by 2002:a17:902:9692:: with SMTP id n18mr7813043plp.333.1544328838517;
        Sat, 08 Dec 2018 20:13:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r8sm8839359pgr.48.2018.12.08.20.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:13:57 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:13:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yussuf Khalil <dev@pp3345.net>
Cc:     benjamin.tissoires@redhat.com, teika@gmx.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: synaptics - enable RMI on ThinkPad T560
Message-ID: <20181209041355.GA211094@dtor-ws>
References: <20181208214426.6628-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208214426.6628-1-dev@pp3345.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 10:44:26PM +0100, Yussuf Khalil wrote:
> Before commit 7fd6d98b89f3 ("i2c: i801: Allow ACPI AML access I/O
> ports not reserved for SMBus"), enabling RMI on the T560 would cause
> the touchpad to stop working after resuming from suspend. Now that
> this issue is fixed, RMI can be enabled safely and works fine.
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Yussuf Khalil <dev@pp3345.net>

Applied, thank you.

> ---
> Originally sent this patch in August. Resending because it has a 
> merge conflict with v4.20-rc5.
> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 2bd5bb11c8ba..7bdf8fc2c3b5 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -171,6 +171,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0046", /* X250 */
>  	"LEN004a", /* W541 */
>  	"LEN005b", /* P50 */
> +	"LEN005e", /* T560 */
>  	"LEN0071", /* T480 */
>  	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
>  	"LEN0073", /* X1 Carbon G5 (Elantech) */
> -- 
> 2.19.2
> 

-- 
Dmitry
