Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F43A208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONDWY5wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F43A208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeFUEWY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:22:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33490 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeFUEWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:22:21 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so1396005ita.0;
        Wed, 20 Jun 2018 21:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nroC2DhC+7k64PkTneFeT+5OJJfb7IxRVtZ3Y/zM+8c=;
        b=ONDWY5wt49aD4PPnjiTYwb3Ughed05l/mNqOTngKrk5adjmSW55rL5+2+p+YTdiU4/
         fh6d49sJ3dlI6GkKrfhaTupEEmquKpgtT8vwC/DDPXaboV4Etk7S2nYIDrZtPML6wwgi
         eP8db+RB8zNBvwZrrEPKqyRWyPTr+/F0uMdrWTUQASeYprcBTZxTqOPDacZYLs2MmLmE
         x5GwlgfjVWHMeVuE07zGh6J9uW9/T4ECHZVsfFKAGd0N3fTEEnLplv2mxV5t5P5r2T8c
         lESujqdYRr3uBv2rTiUhSyZrysN9ao4bV3mzFrWOSAm0qAa45jNZmasLJRBx6gxg+3eQ
         8qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nroC2DhC+7k64PkTneFeT+5OJJfb7IxRVtZ3Y/zM+8c=;
        b=suH+zDAMhT2r7wppNvqwcD9TNqxnJCVKzonSSeMam4ZsD1sjSoSfPWTNcs7PjwCkLw
         mUH/4VWMQ4rwBeheuDbwAFXR0UIprYPkzhKgzsVG78vNgEE3K47hyjncVpPBNlqWc+EV
         9Dssp8pvE5jsxuR8EksydFfNjQMS3JzPUyEPvrYcQ57ksfsU7IxSsaWEMxChh+sfjcrq
         1SpQV0cCHg9XxzEAZizC59K2zfFEmoly+8mgu+gnLlhWfnFqgRzJs4XcMNOW5BZ4o0QA
         qETOP3HPB8hgBrMsBzZt4cY7X7UfJlAiiiUvzSJbsN9b5Wz7SQ8E6wnCD6u3RNebnR4j
         Z15A==
X-Gm-Message-State: APt69E1ZfLJWZK5pdv4jdz+TTHkeJryY6FNlIKwjpP+ieQNW3oofUHuU
        e5ngQ61l4IixhGsa36h7siihJsr88++FR7xoKdw=
X-Google-Smtp-Source: ADUXVKKuLGeVoxeeRyUe6vTn9fAYclBKqXAK8bkEpEfs29OxToBblITuAJoouLlN3X6/NTN4MEkWTXcMMYp3I7XE678=
X-Received: by 2002:a02:938a:: with SMTP id z10-v6mr19863878jah.44.1529554940834;
 Wed, 20 Jun 2018 21:22:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8384:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 21:22:20
 -0700 (PDT)
In-Reply-To: <20180620203500.28309-1-nick@shmanahar.org>
References: <CAOMZO5BTMRJmrjM7X3-7Qi1wuciOnLZhAUuWN27Dtoc0cZXVSA@mail.gmail.com>
 <20180620203500.28309-1-nick@shmanahar.org>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 20 Jun 2018 21:22:20 -0700
Message-ID: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
To:     Nick Dyer <nick@shmanahar.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 1:35 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
>
> The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
> from the old vendor kernel.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Cc: <stable@vger.kernel.org> # 4.15+
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes in v4:
> - Add reviewed by Fabio
> Changes in v3:
> - Update commit message to add source of 0x4 value, fixes tag and CC stable
> Changes in v2:
> - Use hex, only alter IRQ line config

Tested on an RDU1 with Synaptics touchscreen successfully.  No
interrupt store any longer...

Tested-by: Chris Healy <cphealy@gmail.com>
