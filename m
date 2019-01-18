Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2459C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D312087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfARW4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:56:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46464 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfARW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:56:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so10225900oif.13;
        Fri, 18 Jan 2019 14:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auZQbowt5s5QjzxAiRB8oW0KegrxKItGnAZm7hbf3L8=;
        b=dT4LxWLCnA1dVJbGh1Ju4VNfA3ilwRkwgOgxcOIh2oWgkBhdiaT9vwxnAmZ+ricxje
         DWaTnhSbV3u5HDVC79wJ8x20vbKfHDJcQpIYGHC/cICcpZkerslsGgBzd9GuOotfcajw
         ECeq1ak81j8VXoFlbWyBybd60/ul8PtuawUs1y8LBY17RYphknPFlrqYf8weRY7KPBIM
         zfutkajcCYVt2jcrkKcIasVInsK8FTaXP+5xUMgiq9ASAss5oUl3L4sDAjqOsjAQ1xsl
         NEzAaj2e3sJ5Z4s7Z6HzKE4RjK7Fuh+4QThrFr/CtFPevcqmbWCMTc76uOv8saYDDSkf
         ueBg==
X-Gm-Message-State: AJcUukfjSd0h9oPveT99P9AuEyGzjC2+YLLzkXM486QdnfbOdSv8r1/L
        sw/q4QB3jGnRNlIgoLSlvFHmFw5A
X-Google-Smtp-Source: ALg8bN48VliRCbH2KT+gY//hFWS/gpHoukX23B8FZvGeLz0v6pbzPTDYc8l5zwdzDcZOQXNSO2J1qg==
X-Received: by 2002:aca:ab53:: with SMTP id u80mr1298691oie.261.1547852175561;
        Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id q131sm2840267oih.1.2019.01.18.14.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id r62so10291218oie.1;
        Fri, 18 Jan 2019 14:56:15 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr1775720oix.213.1547852174889;
 Fri, 18 Jan 2019 14:56:14 -0800 (PST)
MIME-Version: 1.0
References: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 18 Jan 2019 16:56:03 -0600
X-Gmail-Original-Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: avoid race in clearing QMan interrupt
To:     madalin.bucur@nxp.com
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:43 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> By clearing all interrupt sources, not only those that
> already occurred, the existing code may acknowledge by
> mistake interrupts that occurred after the code checks
> for them.
>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Applied for fix.  Thanks.  Suggest to forward it to
stable@vger.kernel.org after merged into Linus' tree.  It would be
better to add "Cc: stable@vger.kernel.org" in the commit message for
similar patches next time.

Regards,
Leo

> ---
>  drivers/soc/fsl/qbman/qman.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 52c153cd795a..636f83f781f5 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1143,18 +1143,19 @@ static void qm_mr_process_task(struct work_struct *work);
>  static irqreturn_t portal_isr(int irq, void *ptr)
>  {
>         struct qman_portal *p = ptr;
> -
> -       u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
>         u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
> +       u32 clear = 0;
>
>         if (unlikely(!is))
>                 return IRQ_NONE;
>
>         /* DQRR-handling if it's interrupt-driven */
> -       if (is & QM_PIRQ_DQRI)
> +       if (is & QM_PIRQ_DQRI) {
>                 __poll_portal_fast(p, QMAN_POLL_LIMIT);
> +               clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
> +       }
>         /* Handling of anything else that's interrupt-driven */
> -       clear |= __poll_portal_slow(p, is);
> +       clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
>         qm_out(&p->p, QM_REG_ISR, clear);
>         return IRQ_HANDLED;
>  }
> --
> 2.1.0
>
