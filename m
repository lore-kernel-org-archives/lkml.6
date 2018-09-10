Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFC2206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFC2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeIJSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:05:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44250 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeIJSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:05:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id 125-v6so259083vke.11;
        Mon, 10 Sep 2018 06:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDg+dlr9c5bFJibqiT+fXGWyD22f9cgMHfDNhWtyXOU=;
        b=I3KfbGyFejQ3520ts1We47c7stqyqVEWTUM7G+qi3aMOxsmBT4nmP3PUXvqWqltWBn
         Jvj76CnnZDee2GC3XsVdEYeAChdJAt5xH+OCqUaoYsBBsnBJif6zwSg2ZWVLVLABzX97
         7igcnnnu8/M9SjhFvqYfIy4IOswFyzZgxgGkJcu9BxrYBvegjqF+KiWl5OUlShoNuvYY
         w5Ue7E4u+s9WKtPKkC/IcYE2v3Ibo8HZm9xiKrInN6OgwvKl+ZHi+NCWx1Nw30bnpead
         GpYQAbYZ95dCDlFOp1nSykayr/S0oSgwNr1a9d7GO+QbJ8T/7rUsFj8OhSkzc1d75JFp
         o66w==
X-Gm-Message-State: APzg51BNe1GaPcr9k3/6T2JHzc4Mn3qcL8ejW3YXi+a0grEPLtirfDkb
        dbMGn9KcDV+ZAzTuj5d0Kd55rvEjA9SHb+EMtpn/03/d
X-Google-Smtp-Source: ANB0VdZbCz7q2FOlgSG4tyQMaftLcJLlp7LbivoIun+RXF2kJKZyLYiz6bo63NtTR8EFEFcxsyiuJLhSQuLHw/UjgAk=
X-Received: by 2002:a1f:1246:: with SMTP id 67-v6mr6325456vks.82.1536585087190;
 Mon, 10 Sep 2018 06:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1535714796-2211-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1535714796-2211-1-git-send-email-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Sep 2018 15:11:15 +0200
Message-ID: <CAMuHMdWCjHEZsHHq4+tEK2o-Qj3OuGpFZBFiRxHgjRqMJT0PPw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: Fix UART34567 clock rate
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Fri, Aug 31, 2018 at 1:26 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> The clock for UARTs 0 through 2 is UART012, the clock for UARTs 3 through
> 7 is UART34567.
> For UART012, we stop the clock driver from changing the clock rate. This
> is because the Synopsys UART driver simply sets the reference clock to 16x
> the baud rate, but doesn't check if the actual rate is within the required
> tolerance. The RZ/N1 clock divider can't provide this (we have to rely on
> the UART's internal divider to set the correct clock rate), so you end up
> with a clock rate that is way off what you wanted.
>
> In addition, since the clock is shared between multiple UARTs, you don't
> want the driver trying to change the clock rate as it may affect the other
> UARTs (which may not have been configured yet, so you don't know what baud
> rate they will use). Normally, the clock rate is set early on before Linux
> to some very high rate that supports all of the clock rates you want.
>
> This change stops the UART34567 clock rate from changing for the same
> reasons.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in clk-renesas-for-v4.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
