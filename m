Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx2HtpcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9247560763
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeFFR5w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:57:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35750 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeFFR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:57:51 -0400
X-Google-Smtp-Source: ADUXVKJIIZJAhpFc0R3qFdU/6kmtyzq0KCvLG8OOU1NZkfsmMNLz0sZbyVaNie+HPYQG0M0k6Ne7e4n995v/FjeZbmQ=
MIME-Version: 1.0
In-Reply-To: <20180526193523.3896-1-mattst88@gmail.com>
References: <20180526193523.3896-1-mattst88@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 20:57:49 +0300
Message-ID: <CAHp75VcKD=NoAPU99ZoGeTL9m8y58kU-ev-UmzVcd85QVhhB8A@mail.gmail.com>
Subject: Re: [PATCH] parport: Add support for the WCH384 4S multi-IO card
To: Matt Turner <mattst88@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergej Pupykin <ml@sergej.pp.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 10:35 PM, Matt Turner <mattst88@gmail.com> wrote:

> It looks like CH355_4S is similarly missing, but I don't have hardware
> to test.
>
> This commit makes me wonder if I'm missing something -- how could
> anything have worked after commit 72a3c0e4e662 without support in
> parport_serial?

I guess that commit actually worked and the culprit would be the
following one which changes logic of black list application.

7d8905d06405 serial: 8250_pci: Enable device after we check black list

I will send a patch to remove stalled entries from blacklist.

>
>  drivers/parport/parport_serial.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
> index e15b4845f7c6..2c166d5a0d91 100644
> --- a/drivers/parport/parport_serial.c
> +++ b/drivers/parport/parport_serial.c
> @@ -65,6 +65,7 @@ enum parport_pc_pci_cards {
>         wch_ch353_1s1p,
>         wch_ch353_2s1p,
>         wch_ch382_2s1p,
> +       wch_ch384_4,
>         sunix_2s1p,
>  };
>
> @@ -153,6 +154,7 @@ static struct parport_pc_pci cards[] = {
>         /* wch_ch353_1s1p*/             { 1, { { 1, -1}, } },
>         /* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
>         /* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
> +       /* wch_ch384_4 */               { 1, { { 4, -1}, } },
>         /* sunix_2s1p */                { 1, { { 3, -1 }, } },
>  };
>
> @@ -260,6 +262,7 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
>         { 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
>         { 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
>         { 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
> +       { 0x1c00, 0x3470, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch384_4},
>
>         /*
>          * More SUNIX variations. At least one of these has part number
> @@ -504,6 +507,13 @@ static struct pciserial_board pci_parport_serial_boards[] = {
>                 .uart_offset    = 8,
>                 .first_offset   = 0xC0,
>         },
> +       [wch_ch384_4] = {
> +               .flags          = FL_BASE0,
> +               .num_ports      = 4,
> +               .base_baud      = 115200,
> +               .uart_offset    = 8,
> +               .first_offset   = 0xC0,
> +       },
>         [sunix_2s1p] = {
>                 .flags          = FL_BASE0|FL_BASE_BARS,
>                 .num_ports      = 2,
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
