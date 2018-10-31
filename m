Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC69C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B322081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B322081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeKAAAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:00:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45964 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeKAAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:00:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id p144-v6so9967041oic.12;
        Wed, 31 Oct 2018 08:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibRZI6aIz4wh04r/1HxeYMbX3fZA+39uljlCWKlaFuI=;
        b=XUIRRvPERL6sAdYu/klltGrd9ChSd/Iy/oz22WjbgNUJsnKh0+/WAEjuEqlOvLGpBa
         UUk5y8dwoUWC1Dyoi0KZQXTdhhjSgQfyiQM7LLe3HN5i1PafB3/pNH6rwoqKE8oIbO/X
         8wlzgiknPEJVf4Q1Eq9lqlnvtaWPr71KOQElCbTN/TPfe96o7xUrVzFJfbxWQRe+9lmx
         LP1j/49mWRiOGER/lEePmEAzOH25D5ni2cUPjX4msDPPOPiJCzntkbybUP0+db3Gflpz
         /VbyfFeNv88Gk6aXXz8Krq77U1ZExqXX1L1bVzcppcx2VWyPKHtLa+ML32WqJB+e7/37
         ZMyQ==
X-Gm-Message-State: AGRZ1gJUcvn25AcVQRqirJrT6pjKR5YDcbjE5Zfcy3rJnpu5+d+yO3yp
        Higfqq8kTmn1HAqzGVJfQOjnmNG5t88yZvXMJRCI6g==
X-Google-Smtp-Source: AJdET5fD39toyDLlq3igsD1L0LGh/VWxsdx2FVulWhtMP9bs4/3qelq51MUQjI+tQ2ightK41/3GNu53H55BSoN5Xng=
X-Received: by 2002:aca:d694:: with SMTP id n142-v6mr828147oig.32.1540998118732;
 Wed, 31 Oct 2018 08:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com> <20181031145800.GI20889@lunn.ch>
In-Reply-To: <20181031145800.GI20889@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 31 Oct 2018 20:31:48 +0530
Message-ID: <CAFcVECLQ64oHwz6E4wPRC4LyNh-c1Z-Nw9GyKAm+h1_FsvjQvg@mail.gmail.com>
Subject: Re: [PATCH 4/4] net: macb: Add support for suspend/resume with full
 power down
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>, appanad@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
On Wed, Oct 31, 2018 at 8:28 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 31, 2018 at 09:10:23AM +0530, Harini Katakam wrote:
> > When macb device is suspended and system is powered down, the clocks
> > are removed and hence macb should be closed gracefully and restored
> > upon resume. This patch does the same by switching off the net device,
> > suspending phy and performing necessary cleanup of interrupts and BDs.
> > Upon resume, all these are reinitialized again.
> >
> > Reset of macb device is done only when GEM is not a wake device.
> > Even when gem is a wake device, tx queues can be stopped and ptp device
> > can be closed (tsu clock will be disabled in pm_runtime_suspend) as
> > wake event detection has no dependency on this.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> > ---
> > Notes:
> > I was unable to do a full macb_close/open in this patch as suggested
> > because it was freeing and allocating the full RX/TX buffers and
> > this time consuming, also leading to a crash when done continuously
> > in stress tests.
>
> Hi Harini
>
> Did you try stress testing just plain up/down, which will call
> macb_open/macb_close? It could be it is broken already, and
> suspend/resume just makes it more obvious it is broken.

Yes, I did. Plain up/down stress tests do not show any problems.

Regards,
Harini
