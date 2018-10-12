Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A7C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE14D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR1ByF10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE14D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJMDDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:03:09 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A1021470;
        Fri, 12 Oct 2018 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539372549;
        bh=KuMgXPH8usKv6hTV9oS+/nn9FCAXBOXou6iPLt7BfGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AR1ByF10kSRYgNFZc9owNvKpxtLrOtiZJDjT1gUfYi2TtiOC5G8R99UL8IVTudifN
         IhJnKdMcI1EpyYJiX2rV0ZbaJA+euG/Cn2/h+9TB5UlnvwhTXW8F8PNMJGoE38JSF0
         04li67/k50xK3G/gyUOiBgSDuwkvD5gtmPAMm9jI=
Received: by mail-qt1-f181.google.com with SMTP id e10-v6so15028325qtq.12;
        Fri, 12 Oct 2018 12:29:09 -0700 (PDT)
X-Gm-Message-State: ABuFfoiBDWqxPeFEaax5qHb0xa+seFbU8P3OfaLWkCFHtB/NMkx1x+zS
        agB4DlU05wbNunrcq4P8GoIX1BiY0k/ZbeXg4g==
X-Google-Smtp-Source: ACcGV6080hVJQX2aOGRUVzh5vi2PXdKLmQr1TmGQ1F20zkGVJb2wI9xEI3Up32578oqRp6OMcaGlPHtyq1sJkFv9MCc=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr6887176qtj.76.1539372548638;
 Fri, 12 Oct 2018 12:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <1bc1488a4cbf21fafc64269958ba3ed04e0a3c1c.1539322989.git.michal.simek@xilinx.com>
In-Reply-To: <1bc1488a4cbf21fafc64269958ba3ed04e0a3c1c.1539322989.git.michal.simek@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Oct 2018 14:28:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKTGmrQx+siHQprMAvX1M-p08Qkv0nEwAARK3NJz-wobg@mail.gmail.com>
Message-ID: <CAL_JsqKTGmrQx+siHQprMAvX1M-p08Qkv0nEwAARK3NJz-wobg@mail.gmail.com>
Subject: Re: [PATCH v2] of: base: Change logic in of_alias_get_alias_list()
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:43 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Check compatible string first before setting up bit in bitmap to also
> cover cases that allocated bitfield is not big enough.
> Show warning about it but let driver to continue to work with allocated
> bitfield to keep at least some devices (included console which
> is commonly close to serial0) to work.
>
> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
>  - Use EOVERFLOW instead of EINVAL - Rob

Reviewed-by: Rob Herring <robh@kernel.org>
