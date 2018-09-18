Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCACEECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3F420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PeiUysKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3F420C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeIRGlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:41:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45279 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeIRGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:41:23 -0400
Received: by mail-qt0-f194.google.com with SMTP id g44-v6so212720qtb.12;
        Mon, 17 Sep 2018 18:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtbpE7kHQMgu33Pd/EEVA/FMbHiUtU2dDouAFF85bPE=;
        b=PeiUysKZ3ZbvsMtZrFaBxl7I64NapyjMC7oh73eF1tGMbXNShdk2hk45RsTaTyQ3tt
         mDKOVualCLDc/Q/GzrtxdEWr3P7N8SxuEIIznk9OEpqOLTn1JukCE3v7QdzC7V96N/U0
         vBmxp49CX6+GwEpwEU9rRPtU3spqzuU6fJl7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtbpE7kHQMgu33Pd/EEVA/FMbHiUtU2dDouAFF85bPE=;
        b=KOzpAJ2UFklepWDcHSHOVhNdxaFDwfaaw6VSCknSx+jBnEPAMPkMIW0SGqdnboBCww
         fu0NGPrr6RGR99wzbXZ3/Y6uiv380X0O3FT9Y3SKXmGA8ZSNlAAMNO0/nbJrRnWroUyQ
         7dS5OW1ucDNEcXARaBhVZIUxPdT0Y2g+sBfl3L2YRPB1Jhj/25PLP5LGXUWTrHMm+BQR
         uqKC3bS2UcddCdQePaAiSag4Nnev9uruMeQTXingyEbwHNVAQW+X/i9xzWspTHuBtRVw
         g1r1eTu75m5k7lTv9VblzScHngmfPGRP/AFKOa94Hn5ILQO2segSJSpJO+oF08AJzCFz
         ywZw==
X-Gm-Message-State: APzg51A3r04tFTJIpI7rxKnZ8XXOo9hzy/tD5uZhn9cnRbom81fj2uXd
        AxX+6pchaLJ/5it5uLfeEHD+VB+vVqGU2E32ecd3ig==
X-Google-Smtp-Source: ANB0Vdapq0YkvHJUouihT+p0PTlDec8CjjvMGYcfHx0vLw4qOfXxGNU/EfOM3t3z2Jt62twvTT+UrSukMfHoGeQLPuU=
X-Received: by 2002:ac8:35d9:: with SMTP id l25-v6mr20104641qtb.84.1537233083439;
 Mon, 17 Sep 2018 18:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 18 Sep 2018 10:41:12 +0930
Message-ID: <CACPK8XchoryZ_RS8f4n=-GoT-Ak+dXuC3cgqLmxK9C=gySEJFQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 at 13:00, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") moved interrupt acknowledgment to the end of the interrupt
> handler. In part this was done because the AST2500 datasheet says:
>
>  I2CD10 Interrupt Status Register
>    bit 2 Receive Done Interrupt status
>          S/W needs to clear this status bit to allow next data receiving.
>
> Acknowledging Receive Done before receive data was handled resulted in
> receive errors on high speed I2C busses.
>
> However, interrupt acknowledgment was not only moved to the end of the
> interrupt handler for Receive Done Interrupt status, but for all interrupt
> status bits. This could result in race conditions if a second interrupt was
> received during interrupt handling and not handled but still acknowledged
> at the end of the interrupt handler.
>
> Acknowledge only "Receive Done Interrupt status" late in the interrupt
> handler to solve the problem.
>
> Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks for getting to the bottom of this Guenter. I gave it a spin on
Romulus (ast2500) and Palmetto (ast2400) without issue.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
