Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81991C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B7721946
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B7721946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeHGXa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:30:28 -0400
Received: from baldur.buserror.net ([165.227.176.147]:53104 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHGXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:30:27 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fn9Im-0006Ck-77; Tue, 07 Aug 2018 16:14:00 -0500
Message-ID: <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org,
        mark.rutland@arm.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com
Date:   Tue, 07 Aug 2018 16:13:58 -0500
In-Reply-To: <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: Bharat.Bhushan@nxp.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org, mark.rutland@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com, joe@perches.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 15:18 +0530, Bharat Bhushan wrote:
> MPIC on NXP (Freescale) P2020 supports following irq
> ranges:
>   > 0 - 11      (External interrupt)
>   > 16 - 79     (Internal interrupt)
>   > 176 - 183   (Messaging interrupt)
>   > 224 - 231   (Shared message signaled interrupt)

Why don't you convert to the 4-cell interrupt specifiers that make dealing
with these ranges less error-prone?

> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index 1006950..49ff348 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
>  			MPIC_BIG_ENDIAN |
>  			MPIC_SINGLE_DEST_CPU,
>  			0, 256, " OpenPIC  ");
> +	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
> +		mpic = mpic_alloc(NULL, 0,
> +		  MPIC_BIG_ENDIAN |
> +		  MPIC_SINGLE_DEST_CPU,
> +		  0, 0, " OpenPIC  ");
>  	} else {
>  		mpic = mpic_alloc(NULL, 0,
>  		  MPIC_BIG_ENDIAN |

I don't think we want to grow a list of every single revision of every board
in these platform files.

-Scott

