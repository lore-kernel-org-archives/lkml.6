Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6337BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BD1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeK0QfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:35:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35122 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeK0Qe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:34:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so19064241otj.2;
        Mon, 26 Nov 2018 21:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VAsT/7SuTaT9Eh1kU37qB6B2ByxxSbGwbS0JlpneL0=;
        b=ed3R9XcpRmrQcgKrrUr/qBxCAkmPUM6yZDBmWBW2BboAub3FH58xqCBk1qyxzJIBxV
         AlbdH9Ao5pnbmyCjfrJ7TM1pzzCtLdB4HuhsU6/Ir0jwOqGdMR/loJTAA33uuVtulchL
         T/605qOb2rRrIdxLNMyiV75ssslJBdUV8ZpWjAOnypL64izj9G7HYLe1SFqNDUk+F/m5
         sjMgZTDvNz+jQf1htXVuYU4am9Y/nAYbJmEbhMUiTuQB6mdybZ2HLSTA/VhFVA9rH2NM
         6BBtOB3NfSzQQfvvIXFZUvOtA4hqRbGlSjYgjc0Xy3fJfiuvkTooIN5BqAwNtNF4va2k
         3dOg==
X-Gm-Message-State: AA+aEWateElL+cUaowWRzmhNWSC6RdgO28yafaDXqyXZpZodXwCFthjx
        vD6AwiLyCrEkzI/kchIDqf7JpRKPzLMYLDi/TmhXCg==
X-Google-Smtp-Source: AFSGD/VGtamfz4F1xPPKviy/zU1SazfY85vkv89Ht5yeVM0+8HuCaWP1smjmbnkHzFZ3FVSmrDZwk37pYehuxIWHvmw=
X-Received: by 2002:a9d:4a87:: with SMTP id i7mr17732904otf.178.1543297096977;
 Mon, 26 Nov 2018 21:38:16 -0800 (PST)
MIME-Version: 1.0
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com> <20181126143941.GB12116@lunn.ch>
In-Reply-To: <20181126143941.GB12116@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 27 Nov 2018 11:08:06 +0530
Message-ID: <CAFcVECK_Xjz7K5gJsB7ooANp0ngp6X7eub5-CHMbe21vjE50ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sai.pavan.boddu@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

<snip>
> > +#define MACB_IDLE_MASK               (1 << MACB_IDLE_OFFSET)
>
> I think you could use the MACB_BIT() macro here.
>
> But otherwise,
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Thanks, will fix this in next series.

Regards,
Harini
