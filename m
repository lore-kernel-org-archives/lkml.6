Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06470C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBB020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBB020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLABnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:43:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42930 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLABnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:43:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so3236491qka.9;
        Fri, 30 Nov 2018 06:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkdH9Ov2psoGZwJfdFSUL/LkvD19bY8wJZSO8Uldte8=;
        b=ALtYF4z7Fi3VO6DcEPur5w7oAcX1YBRsUPoN3ehnD15AUx/zwagirMRALHYJl14dvH
         r9pNv8NseJDEuBiSiQiGcx8UAFXrt4t5INjIar8BmcJTHdJyquChJxH2T1sgaXPZBM8b
         kDz9qzxjxFqixjW1ZDMnvkfiDRiQcwnzKGI4FIAjnWy+yyVOwr26bmJd/yBgh1lHm1zQ
         RTnkjJ+5KpjFfFUX8NUJN+OR2Lx1DGANcvw6clDaE+NsuYNMfcBGE/YKVVgX6/XpkWxm
         YRFg1XpmL+DgU3ZYXNUK2OfY3neCJ6BsooZXMVE3XoPBJj72yytJefQ5uauRXEWxy1E5
         wXQQ==
X-Gm-Message-State: AA+aEWZU0gc4y4oW/IEYSSLawPAkgxKbdM+I/7LdFL88HOwunxCIo+uu
        3fRxCjnFR3y6iTY+8WzoVGEnJ+HfByntwY6s77Y=
X-Google-Smtp-Source: AFSGD/VEmZx8obg7f1lgSzKOLfsiBCgnYlxUrOPH/LNnHaXmdIMGDx4FNpuOix5LZzaP45IGjp1m9Jza5oLFuW5jbA4=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr5217187qkf.107.1543588427596;
 Fri, 30 Nov 2018 06:33:47 -0800 (PST)
MIME-Version: 1.0
References: <1543526968-56091-1-git-send-email-loic.pallardy@st.com> <1543526968-56091-5-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1543526968-56091-5-git-send-email-loic.pallardy@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 15:33:29 +0100
Message-ID: <CAK8P3a25Y3y1Zjtf18i6Tgt83npLvbCeBvcd-r1+u8ijp=X2Yw@mail.gmail.com>
Subject: Re: [PATCH 4/7] remoteproc: add warning on resource table cast
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:31 PM Loic Pallardy <loic.pallardy@st.com> wrote:
>
> Today resource table supports only 32bit address fields.
> This is not compliant with 64bit platform for which addresses
> are cast in 32bit.
> This patch adds warn messages when address cast is done.
>
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 18a1bbf820c9..61c954bd695e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -772,6 +772,10 @@ static int rproc_alloc_carveout(struct rproc *rproc,
>                 dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
>                         mem->da, &dma);
>         } else {
> +               /* Update device address as undefined by requester */
> +               if (sizeof(dma_addr_t) > sizeof(u32))
> +                       dev_warn(dev, "DMA address cast in 32bit to fit resource table format\n");
> +
>                 mem->da = (u32)dma;
>         }

I think this patch is wrong: sizeof(dma_addr_t) is defined to be large enough
to support any machine that the kernel can run on. If you build a kernel that
happens to work on an ARM32 platform with LPAE enabled, then this will
warn every time, even if you are running on a machine that only has a 32-bit
address space.

     Arnd
