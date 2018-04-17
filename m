Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeDQH5d convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:57:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38265 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeDQH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:57:31 -0400
X-Google-Smtp-Source: AIpwx49vbQVst9eNAaFc8baibHOSzcBsPI+lvj6IKEl8F1msj9lIbluAiHAjmKXsQ4jnYfBEWIFEPQ==
MIME-Version: 1.0
In-Reply-To: <20180417075233.f2z6wxcazwqheoib@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-9-mylene.josserand@bootlin.com> <20180417075233.f2z6wxcazwqheoib@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 17 Apr 2018 15:57:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
Message-ID: <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 3:52 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Mon, Apr 16, 2018 at 11:50:29PM +0200, Mylène Josserand wrote:
>> To prepare the support of sun8i-a83t, add a field in the smp_data
>> structure to know if we are on sun9i-a80 or sun8i-a83t.
>>
>> Add also a global variable to retrieve which architecture we are
>> having.
>>
>> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
>> ---
>>  arch/arm/mach-sunxi/mc_smp.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
>> index 03f021d0c73e..9d57ea27dacc 100644
>> --- a/arch/arm/mach-sunxi/mc_smp.c
>> +++ b/arch/arm/mach-sunxi/mc_smp.c
>> @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
>>
>>  extern void sunxi_mc_smp_secondary_startup(void);
>>  extern void sunxi_mc_smp_resume(void);
>> +static int is_sun8i;
>>
>>  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
>>  {
>> @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
>>  struct sunxi_mc_smp_data {
>>       const char *enable_method;
>>       int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
>> +     int is_sun8i;
>>  };
>>
>>  static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
>> @@ -664,6 +666,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
>>       {
>>               .enable_method  = "allwinner,sun9i-a80-smp",
>>               .get_smp_nodes  = sun9i_a80_get_smp_nodes,
>> +             .is_sun8i       = false,
>
> I'm still not convinced about the name of that flag. sun8i doesn't
> mean anything, really. What you want to discriminate against it what
> you're writing in your commit log: if it is an A80 or an A83t. The
> A33, H3, A23, you name it are also part of the sun8i family, yet they
> are completely irrelevant to this file.
>
> Also, false is the default value, you can leave it out.
>
>>       },
>>  };
>>
>> @@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
>>                       break;
>>       }
>>
>> +     is_sun8i = sunxi_mc_smp_data[i].is_sun8i;
>> +
>
> Do we really need to cache it? Can't we just have a pointer to the SMP
> data structure and use that instead?

I recommended that. We don't need any of the other fields in the SMP
data structure once we're past the init phase. This saves a dereference
or two.

ChenYu
