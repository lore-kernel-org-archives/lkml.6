Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2DC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B455020989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nch3nSoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeLTChc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:37:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:37:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so129829pgl.6;
        Wed, 19 Dec 2018 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHY9CFg0MGRqu3NkeXbhXlFw179ui82AY5bhUgLHPZM=;
        b=nch3nSoINbw9Lz+d3Hd0yYu32jgxhvJ30r9ue719ZeaCNZVTl3BeiyFXD9SwkSTZQ2
         o4Wjc+56dfHH6EOnUNajRw9HtkdlBv4qaqgZGKdvaddUC1HXqgLmspbQ3BcAPB4oNZzk
         yrEytiE5ODmC9dWfcsotUDlk10k81ofca9QCCZdIIcPRzt84gQMNFMgz0wf+XOgV8jsD
         2y9XbzkbceUTI6r/6S9j60iEmFyeq4F08vSwawU8lFWjmofeqcU41m7SstzX+lEtf7af
         amh8/BOq1wTUChwsTIzDhLr0wH9+dE3pZXPtceB2yWxTrFN1a7D7MvOwDPqtbczhFdtJ
         qLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHY9CFg0MGRqu3NkeXbhXlFw179ui82AY5bhUgLHPZM=;
        b=a+VFEeH28NKF46ZlSHU1hprlgpkV0AdTE7ktO9udteiEXo1NMqe90bPxwEes5/EOKJ
         HM2s6mi+bNVKWWXtT31xiJEJCk4LiEp3t9tgGb4hjw9vusD+f0DfAiif10yO/xbKDTRB
         kPHvdosJ+gqCwRR9DXvWV/0F05N0IBAABZ3405OP9EKs4Na9F5SIs55LcCCPsHOlPImz
         8A+pOtrWY+7dSzuTmaGhPLgyxqWX6i8z6hLYNFwZ2KZU5LVO95sbvw57mc2hh42Jc4Z9
         WFrf3x5jOBEVSk6RGI5TqcboZlyBU0fCmPFqHynYLEoTxVGdUbeEhYXyRd2ErvgYKldi
         v+vg==
X-Gm-Message-State: AA+aEWaqtNjTowEHxBiuAUZUaUxpYU6qdoBOw7bfhDNwEV765yd6gcF8
        +2nrkdA4GUkSqKuTfaz5PnY=
X-Google-Smtp-Source: AFSGD/U/6H3IOsaeVORBns4r17llJY7KoOlFsTCXeSiPk2qO2WShAsDbR1YEtyKyyqROZBUkYJDzIQ==
X-Received: by 2002:a62:de06:: with SMTP id h6mr23431245pfg.158.1545273450996;
        Wed, 19 Dec 2018 18:37:30 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm27295322pgl.88.2018.12.19.18.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 18:37:29 -0800 (PST)
Date:   Wed, 19 Dec 2018 18:37:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: dt-bindings: watchdog: renesas-wdt: Document r8a774c0 support
Message-ID: <20181220023728.GA10247@roeck-us.net>
References: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:18:53PM +0000, Fabrizio Castro wrote:
> RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index a8ee29f..ef2b97b 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -9,6 +9,7 @@ Required properties:
>  		 - "renesas,r8a7744-wdt" (RZ/G1N)
>  		 - "renesas,r8a7745-wdt" (RZ/G1E)
>  		 - "renesas,r8a774a1-wdt" (RZ/G2M)
> +		 - "renesas,r8a774c0-wdt" (RZ/G2E)
>  	         - "renesas,r8a7790-wdt" (R-Car H2)
>  	         - "renesas,r8a7791-wdt" (R-Car M2-W)
>  	         - "renesas,r8a7792-wdt" (R-Car V2H)
