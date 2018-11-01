Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbTCPboe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF2F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeKBDiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeKBDiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:38:24 -0400
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com [209.85.161.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D739D2082E;
        Thu,  1 Nov 2018 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541097257;
        bh=Uzzo0MFcVufgQmhrt6+ec9emDG+VhsnzJW6X8mjPahw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbTCPboefwWLQKRPVy5TvS7rp6WQWdsaIGTB/pXAlTmX9XkVl824JLnp1rXlI62Ul
         I7YsM5BtWBlRPiF9F3iqGTCqJp2YnyXxJr1c6JGx4yGVfa21+eHbjg7qaJljvZRUQP
         lKuhwD/qo5CH42mr9PHSPBk7zkIjdMufjRsa1/vE=
Received: by mail-yw1-f50.google.com with SMTP id j75-v6so8294484ywj.10;
        Thu, 01 Nov 2018 11:34:16 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLZSXQhTeQfus3wUZHAJljZfxHpd9ngpQ2EidVBkFqU7RhuIaha
        dxlfd8i5axPuzh9uUm5jsgoMSk7obiq+jDsOm/E=
X-Google-Smtp-Source: AJdET5cIi819tSGBJKcQHJ2xzOkfN2cueR1llyhBEayY6tsRkgmEgRGgKFBghEU4WhHxSEM/PicRkktRwrxkFK2PLlo=
X-Received: by 2002:a81:68c6:: with SMTP id d189-v6mr8414924ywc.489.1541097256149;
 Thu, 01 Nov 2018 11:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl> <1540367583-5413-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1540367583-5413-1-git-send-email-mike.looijmans@topic.nl>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 1 Nov 2018 13:33:39 -0500
X-Gmail-Original-Message-ID: <CANk1AXRS=K65arg+JGmWsnpi1qoRm7ccQCsjo1C=d-85YGjeOQ@mail.gmail.com>
Message-ID: <CANk1AXRS=K65arg+JGmWsnpi1qoRm7ccQCsjo1C=d-85YGjeOQ@mail.gmail.com>
Subject: Re: [PATCH v2] zynq-fpga: Only route PR via PCAP when required
To:     mike.looijmans@topic.nl
Cc:     linux-fpga@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:53 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:

Hi Mike,

>
> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> it impossible to use the ICAP interface for partial reconfiguration.
>
> This patch changes the driver to only activate PR over PCAP while the
> device is actively being accessed by the driver for programming.
>
> This allows both PCAP and ICAP interfaces to be used for PR.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks for submitting!

Alan

> ---
> v2: Move the register setting in between the clock enable/disable
>
>  drivers/fpga/zynq-fpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 3110e00..ff3a427 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -501,6 +501,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>         if (err)
>                 return err;
>
> +       /* Release 'PR' control back to the ICAP */
> +       zynq_fpga_write(priv, CTRL_OFFSET,
> +               zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> +
>         err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
>                                      intr_status & IXR_PCFG_DONE_MASK,
>                                      INIT_POLL_DELAY,
> --
> 1.9.1
>
