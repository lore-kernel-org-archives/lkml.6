Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE3C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F862087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="i5ma44n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F862087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLCVeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:34:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34909 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeLCVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:34:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so7041978pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1WtOL9nSQuxPk3Wfs9GcVm+k15ZzGEaYfW2GvjrFY/c=;
        b=i5ma44n44nj7PiV02VkCAMo/KuwZavthIuRgmFvAI663eIBSH15Ye66Wa850p9tO/P
         ShF6+HiIFTXzy05oSLnRws7oUvIPJPUSQ5+B1sRK5JBDJvTF1HSlB0VMv/8wdtECaDTf
         zZLJBQQWlZVw78nzgNhKRK7RTbsOLJhT7ZdTSWH3fb9KomJPKwFAgV80ESnHNby6GnS2
         6w5tkHqt3DZ+vwGNM2o6RS3gsAUxW31nuy2Xuvs5QQkHf5xIbD4th3oirgj7jWsdnrJe
         2HT1CF2isLWxQHJ/T0MGbFD7yUJDbKBCoPFdofzbabNSXJcOSHouKHMd1EmM5kvkSuIF
         AUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1WtOL9nSQuxPk3Wfs9GcVm+k15ZzGEaYfW2GvjrFY/c=;
        b=MgAGMJHan8Czutn43r8+G1nlG6ViBlDGLcy5D+yn1Igw8zekl/N6qaTqb1L38Ob4qh
         9rdIJDBcK2E7n1I4Io3+6j64LYaCydXylgC3mxrZaM/kJbqsooJS2sY8cvcmvsJ35aak
         FTzhx0P/al7svbfICRSEJC4g2VDYGBI1ILv5aWKSLOXB9LULYm/5foWNlxtGqp8yulHP
         NdW2zh1uUngu5MLSUMkl0t9rQTfbszVsubB5S+UxDz9UNUKBuVWGbkrGRs0WJjrenwdJ
         mRJuaKTMCUUAO57XaBweVdqfi09RPCbMYzal4f4Z3ZB+0hzgUVdqpEOCi5tiznkjABD1
         Ok0g==
X-Gm-Message-State: AA+aEWZ17NsSzoRllca9YGceKYqr/qG/+fRmk1FK+GsQxi2qhBXPO8Qk
        HtzeVuF2aWPwQ7rru5V/RMpE2AJ1T0mC4zGw
X-Google-Smtp-Source: AFSGD/WVkI5sy0evfckQg1YXuxp09TSY8Y7qKtRSeavSSL3fheO2DH4RhvOgdG2lo5/Q16svkNVmpQ==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr6148667pfb.55.1543872858947;
        Mon, 03 Dec 2018 13:34:18 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::1:a550])
        by smtp.gmail.com with ESMTPSA id q7sm16665737pgp.40.2018.12.03.13.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 13:34:18 -0800 (PST)
Date:   Mon, 3 Dec 2018 13:34:16 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org
Subject: Re: [PATCH] psi: fix reference to kernel commandline enable
Message-ID: <20181203213416.GA12627@cmpxchg.org>
References: <99058450a8c792cde07c7ced343bf1711c75b8f3.1543742330.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99058450a8c792cde07c7ced343bf1711c75b8f3.1543742330.git.baruch@tkos.co.il>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:18:50AM +0200, Baruch Siach wrote:
> The kernel commandline parameter named in CONFIG_PSI_DEFAULT_DISABLED
> help text contradicts the documentation in kernel-parameters.txt, and
> the code. Fix that.
> 
> Fixes: e0c274472d ("psi: make disabling/enabling easier for vendor kernels")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Doh, thanks Baruch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  init/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index cf5b5a0dcbc2..ed9352513c32 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -515,8 +515,8 @@ config PSI_DEFAULT_DISABLED
>  	depends on PSI
>  	help
>  	  If set, pressure stall information tracking will be disabled
> -	  per default but can be enabled through passing psi_enable=1
> -	  on the kernel commandline during boot.
> +	  per default but can be enabled through passing psi=1 on the
> +	  kernel commandline during boot.
>  
>  endmenu # "CPU/Task time and stats accounting"
