Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C0CC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505C3218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548520181;
	bh=UbHiP4GwMMDVLUiMG3jJskP224BF39q2MwpcBsJbH8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=COGYtlAq2uinqpX+7s87PD/ySzwHJ6YK+Km4j4jvhccmOKASvRySCSwJLMbSSFxA3
	 s4cHoy4yN+Ob56dFI/r8z/0tO+8n8V3sOmQOIH9qicgjvamzc/vHEmdq9Mf+O5o/ip
	 tcsQbKWbA7P/wLZzPs4WVKEaGRgaWrZXjVO1vL6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfAZQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAZQ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:29:40 -0500
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A3D218B0;
        Sat, 26 Jan 2019 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548520179;
        bh=UbHiP4GwMMDVLUiMG3jJskP224BF39q2MwpcBsJbH8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sZH8Zme4vJEU5aLvnZ453k1lIMXdEiDrIC9tAYchNsDsmSbXWnmtvlGjxvcsfoHro
         5/kDklpEJhuEMw2RePgYPvWVT3X58OpEKkwb/xOduZOvoIBY6RkZnXYCTOFfem8HLG
         sBtYszj4rdnOwigVXpT6cdldnxDcCdi2a85QUXDg=
Received: by mail-yw1-f46.google.com with SMTP id g194so5139297ywe.7;
        Sat, 26 Jan 2019 08:29:39 -0800 (PST)
X-Gm-Message-State: AJcUukfHjELxh2NKJ+m2h09JfJ30Bv4ovAxLMe2opUKSE4NmhOhEMYWZ
        ih6nGDROt0oBdQ6iUVn7CZ/bxhH3UnFCMnLCfAY=
X-Google-Smtp-Source: ALg8bN7ViPWN2Q2zHu64NO9YY8jNwaIsWH4r/26b7wuK8jnofHZfDkEA1tJbnKWGxswGiDQsqlR+WHmyTq7B9FmkmAc=
X-Received: by 2002:a81:5984:: with SMTP id n126mr14692794ywb.433.1548520178606;
 Sat, 26 Jan 2019 08:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20190124204554.5438-1-atull@kernel.org> <20190124204554.5438-2-atull@kernel.org>
In-Reply-To: <20190124204554.5438-2-atull@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Sat, 26 Jan 2019 10:29:02 -0600
X-Gmail-Original-Message-ID: <CANk1AXQEkdPp0zB78LCOBWUnKRndB4Vv2aZ2AqU=M3jmJLSK+A@mail.gmail.com>
Message-ID: <CANk1AXQEkdPp0zB78LCOBWUnKRndB4Vv2aZ2AqU=M3jmJLSK+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] fpga: stratix10-soc: fix wrong of_node_put() in init function
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 2:46 PM Alan Tull <atull@kernel.org> wrote:
>
> From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> After finding a "firmware" dt node stratix10 tries to match it's
> compatible string with it. To do so it's calling of_find_matching_node()
> which already takes care of decreasing the refcount on the "firmware"
> node. We are then incorrectly decreasing the refcount on that node
> again.
>
> This patch removes the unwarranted call to of_node_put().
>
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index a1a09e0..e75dbe5 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -509,13 +509,11 @@ static int __init s10_init(void)
>
>         np = of_find_matching_node(fw_np, s10_of_match);
>         if (!np) {
> -               of_node_put(fw_np);
>                 return -ENODEV;
>         }

This leaves unnecessary braces around a single statement.  I had said
in the code review that I was going to clean that up.  Arg!  I'll
resubmit this patch.

Alan

>
>         of_node_put(np);
>         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> -       of_node_put(fw_np);
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>
