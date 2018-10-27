Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBBCC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A320848
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1A320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeJ1Hhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 03:37:53 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:55892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728683AbeJ1Hhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 03:37:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D400418029592;
        Sat, 27 Oct 2018 22:55:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: legs98_85f463785ed20
X-Filterd-Recvd-Size: 2390
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Oct 2018 22:55:20 +0000 (UTC)
Message-ID: <989035104a2af28816a3c1b9aeb40d54ee88644a.camel@perches.com>
Subject: Re: [PATCH] arch/x86/boot/memory.c: Touched up coding-style issues
From:   Joe Perches <joe@perches.com>
To:     Jordan Borgner <mail@jordan-borgner.de>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com
Date:   Sat, 27 Oct 2018 15:55:19 -0700
In-Reply-To: <20181027223231.pyigrae7mhl2xil2@JordanDesktop>
References: <20181027223231.pyigrae7mhl2xil2@JordanDesktop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-27 at 23:32 +0100, Jordan Borgner wrote:
> Added missing parentheses to sizeof() function in detect_memory_e820().
> 
> Removed unnecessary braces in detect_memory_e801().
> 
> Replaced three if-statements with a ternary if-statement and 
> removed an unnecessary integer variable in detect_memory().
> 
> This is my first patch I hope it is okay.

Hello Jordan.

While the first bit is generally OK, given some individual
maintainer preferences, it may not also be applied.

Whitespace only changes without logical fixes/upgrades are
generally discouraged outside of drivers/staging.

This bit below though changes behavior.

> @@ -121,16 +120,7 @@ static int detect_memory_88(void)
>  
>  int detect_memory(void)
>  {
> -       int err = -1;
> -
> -       if (detect_memory_e820() > 0)
> -               err = 0;
> -
> -       if (!detect_memory_e801())
> -               err = 0;
> -
> -       if (!detect_memory_88())
> -               err = 0;
> -
> -       return err;
> +       return (detect_memory_e820() > 0 ||
> +               !detect_memory_e801()    ||
> +               !detect_memory_88()) ? 0 : -1;
>  }


For instance:

If the first detect_memory_e820 > 0 is true,
the other detect_memory_<e801|88> calls will
not be done.

The original will always perform all three tests.


Regardless, please try to make your first patches
to the linux kernel somewhere in drivers/staging
so get comfortable with the general mechanisms and
styles of kernel patching.


