Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbeDBUWx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:22:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34548 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756412AbeDBUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:22:51 -0400
X-Google-Smtp-Source: AIpwx4//RxERT9nVwXjuHpoTcrXUgubv8CRhUuECWNFAGPOS7kQgmBnlDkxsQmccJ8DEC/DHHwPakQF/EdVBLbp40uY=
MIME-Version: 1.0
In-Reply-To: <1522693621-3124-1-git-send-email-agk@godking.net>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Apr 2018 23:22:50 +0300
Message-ID: <CAHp75Vc1KV3i6Jp-t=cD5DjYDMPHA0Zz77RkN0kmrvb1WLj6gA@mail.gmail.com>
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
To: Alexander Kappner <agk@godking.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:27 PM, Alexander Kappner <agk@godking.net> wrote:
> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
> properly reports both fan speeds.
> Because the P50 doesn't report the version of its EC controller, we need to
> identify it by BIOS version (N1).
>
> Signed-off-by: Alexander Kappner <agk@godking.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d5eaf3b1..ebdc300 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>           .ec = TPID(__id1, __id2),             \
>           .quirks = __quirks }
>
> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)     \

I would rather name it ..._QB() instead

Better of course to use three letters, though let's leave this when we
really have a need.

> +       { .vendor = PCI_VENDOR_ID_LENOVO,       \
> +         .bios = TPID(__id1, __id2),           \
> +         .ec = TPACPI_MATCH_ANY,               \
> +         .quirks = __quirks }
> +
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>         TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>         TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
> +       TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>  };
>
>  #undef TPACPI_FAN_QL
>  #undef TPACPI_FAN_QI
> +#undef TPACPI_FAN_QL_BIOS
>
>  static int __init fan_init(struct ibm_init_struct *iibm)
>  {
> --
> 2.1.4
>



-- 
With Best Regards,
Andy Shevchenko
