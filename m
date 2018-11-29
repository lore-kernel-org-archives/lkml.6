Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4723C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BAF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BAF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK2VnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:43:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42298 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeK2VnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:43:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so1274996otk.9;
        Thu, 29 Nov 2018 02:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1GTXlEQCcTQ31vfySIF+9crgTEQwA8rc1qwylhj7GM=;
        b=jVTsgjkd2QBK697cSojL/d37TWmBTWi/nfM2hRmiLtJPyCzGdzyW1ZjLR9m/pZ0GHs
         ykONpbShj+hzzph62qr79JSIQ+yom2RZbTIq19ekcJg15vRjup8+VtfsP1YgM3ZQz4AX
         zeJ28T/xPrUXfyfjsI6TftkYkyaXlIOBK5oOrrmi0D6iZohgUTGc7vzRioPCKbGJ12a7
         5jDUs2S2Hdi75cT2qsdBnxtozQlxc6h/6pHooYLsqlSS9en8sADyDhst4FIAUchiunue
         HpkHOBb/lVF0nKu91QxVHuw9M2VDlsu92FYfe91ShRPLYXXMgQU3JcKyIm3yIfV/tLx/
         hzEA==
X-Gm-Message-State: AA+aEWZGscKEDXhbp2Cm1OnKxMAkD7BYAOtHDsy1CSDzTPusteDCIXqd
        bzQ6nB1J6BInqD4JNLLmll+4TsiARCIEew4A56w=
X-Google-Smtp-Source: AFSGD/W6KI7Uh+guIHISJkznAuPLWE0d0PKtxKATm+GqRHjDpaj1+TnS75z0LUU/S4V47UCGDTfYwaeBM4n9lPSYR8E=
X-Received: by 2002:a9d:3662:: with SMTP id w89mr585055otb.55.1543487904097;
 Thu, 29 Nov 2018 02:38:24 -0800 (PST)
MIME-Version: 1.0
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com> <b838b826-9395-fbe9-1b4c-34be574b33cf@microchip.com>
In-Reply-To: <b838b826-9395-fbe9-1b4c-34be574b33cf@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Thu, 29 Nov 2018 16:08:13 +0530
Message-ID: <CAFcVECKw0utBH6-owf-0C1M07Tr2tH3Gu=X7cp04XuvXWHoJiA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,
On Thu, Nov 29, 2018 at 3:51 PM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 23.11.2018 11:59, Harini Katakam wrote:
<snip>
> > -             if (status & MACB_BIT(RXUBR)) {
> > +             if ((bp->errata & MACB_ERRATA_RXLOCKUP) &&
> > +                 (status & MACB_BIT(RXUBR))) {
>
> Just asking, did you manage to test this on other platforms that haven't
> this issue?
> SAMA5D2 datasheet [1] states this:
> "When in packet buffer full store and forward mode, only good received
> frames are written out of the DMA, so no
>  fragments will exist in the AHB buffers due to MAC receiver errors. There
> is still the possibility of fragments due to
>  DMA errors, for example used bit read on the second buffer of a
> multibuffer frame."
>
> But it is true that nowhere is presented that this must be special treated.
>

Yes, I tested it on ZynqMP which does NOT have this errata - did perf and
ping flood and dint see any issues.
Just FYI, the errata in the IP version in Zynq causes an RX lock up under
high stress (when there is obviously multiple RXUBR interrupts). The RX reset
is a pre-emptive workaround to *mostly* avoid the issue.
Please see Answer record 52028 in
https://www.xilinx.com/support/documentation/errata/en247.pdf

> Moreover, if you do this only for MACB_ERRATA_RXLOCKUP and still have RXUBR
> interrupt enabled every time it would not make sense to still enable it.
> Or, if you want it enabled every time, you should clear it no matter the
> MACB_ERRATA_RXLOCKUP is set or not, with something like this:
>
>                         if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>
>                                 queue_writel(queue, ISR, MACB_BIT(RXUBR));
>
>
Thanks for pointing this out - yes i'll move the WTC code outside the check.

Regards,
Harini
