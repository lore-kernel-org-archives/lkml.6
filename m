Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FD120834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdmjvX5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FD120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeH3SWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbeH3SWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:22:03 -0400
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com [209.85.216.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585FD2073D;
        Thu, 30 Aug 2018 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638781;
        bh=YrpgFeOoYDoevfm75XcmNefTm+qzHzh0qg0/QUJ80ys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PdmjvX5TPRF7iCjvkkul0nreQJUkgoa5BdBUHQvLoIVwFxgDYKyhv2psZQwfYBTBg
         uU/D4Kp/QisZx4qUus2UtIUKuqsbwcYrKEoG/VnF//qBWAmcKH2CxS9lqjjtK9HkWe
         CASVnlmZH/7IWxMFPFCQzrhG6L+p6BJgC4XUrLe8=
Received: by mail-qt0-f182.google.com with SMTP id g53-v6so10015954qtg.10;
        Thu, 30 Aug 2018 07:19:41 -0700 (PDT)
X-Gm-Message-State: APzg51AGulvo8b+9Ntnoq1dnGrfPjQxxpmjOfA+d+HAe719gwujFsiQb
        1S2tHJJAAnLiTYHZ/odr/HbQNIuJ47KC6NOJ7w==
X-Google-Smtp-Source: ANB0VdaAFQhTJZko+BCRfpr3orwFaM+CJb+thCnvGy7zL0PpiJBac6TIS/KUaZDPXX+c/IB+V7hjcfEDV5tADPZLEe4=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr12079322qtd.101.1535638780621;
 Thu, 30 Aug 2018 07:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Aug 2018 09:19:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+UDvL9+3RT8wKXyobXJx14MmcS4X0B1hVghQHXttGAmQ@mail.gmail.com>
Message-ID: <CAL_Jsq+UDvL9+3RT8wKXyobXJx14MmcS4X0B1hVghQHXttGAmQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
To:     John Garry <john.garry@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>,
        kurt@linutronix.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 4:10 AM John Garry <john.garry@huawei.com> wrote:
>
> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
> check was added for the UART driver being probed prior to the parent IRQ
> controller.
>
> Unfortunately this breaks certain boards which have no interrupt support,
> like Huawei D03.
>
> Indeed, the 8250 DT bindings state that interrupts should be supported -
> not must.
>
> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
> does relay whether the IRQ host controller domain is not ready, i.e.
> defer probe, instead of assuming it.

Good, one less user of irq_of_parse_and_map().

Reviewed-by: Rob Herring <robh@kernel.org>
