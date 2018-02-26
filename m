Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeBZOo2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:44:28 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36662 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbeBZOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:44:27 -0500
X-Google-Smtp-Source: AG47ELvr2l7q1R4F6iua8+9/Fiu/xqwxZ23OpHrhlrbNI/p7JTWosMQQ9tqha+TadGiq5/tPP1gWIg2Wzt2S1Sz87FA=
MIME-Version: 1.0
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:44:25 +0200
Message-ID: <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1QEidPX001766

On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=1):
>
>   CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>   for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 ^
> cc1: all warnings being treated as errors
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/kernel/prom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4dffef947b8a..6e8e4122820e 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -291,11 +291,10 @@ static inline void identical_pvr_fixup(unsigned long node)
>
>  static void __init check_cpu_feature_properties(unsigned long node)
>  {
> -       unsigned long i;
>         struct feature_property *fp = feature_properties;
>         const __be32 *prop;
>

Much simpler is just add

if (ARRAY_SIZE() == 0)
 return;

> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
>                 prop = of_get_flat_dt_prop(node, fp->name, NULL);
>                 if (prop && be32_to_cpup(prop) >= fp->min_value) {
>                         cur_cpu_spec->cpu_features |= fp->cpu_feature;
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
