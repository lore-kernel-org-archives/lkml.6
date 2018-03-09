Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeCIDXL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:23:11 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:43862 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeCIDXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:23:09 -0500
X-Google-Smtp-Source: AG47ELsHSVCsBgago1XBDVK3Vf43MmYUwyw0b3Hjq8Loo+gTbdBbum/Rf60JPp3ZKt2lxEpWIGSwY9b/DiMg45QrwJk=
MIME-Version: 1.0
In-Reply-To: <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com> <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Lei YU <mine260309@gmail.com>
Date: Fri, 9 Mar 2018 11:23:08 +0800
Message-ID: <CAARXrtnQn-rbUc_Ykdn5dpK9fO+jMYFR=ocmkQweBxKQY4L2rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Prevent reset if clock is enabled
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static int aspeed_clk_enable(struct clk_hw *hw)
>  {
>         struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> @@ -215,6 +227,11 @@ static int aspeed_clk_enable(struct clk_hw *hw)
>
>         spin_lock_irqsave(gate->lock, flags);
>
> +       if (aspeed_clk_is_enabled(hw)) {
> +               spin_unlock_irqrestore(gate->lock, flags);
> +               return 0;
> +       }
> +

I think this piece of code can be run before spin_lock_irqsave(), so it is
able to just return without spin_unlock_irqrestore()?
