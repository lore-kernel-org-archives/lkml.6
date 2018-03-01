Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeCAHBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:01:35 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40447 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966327AbeCAHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:01:33 -0500
X-Google-Smtp-Source: AG47ELu7Hwacx4iphUdcOl1chQcVS/PtgAEhNhIKBoypFAiKFDILRgjIJYH6PNV2cKOLizWxtF39SKxrAprDEvxBZJQ=
MIME-Version: 1.0
In-Reply-To: <87woyw8pxe.fsf@concordia.ellerman.id.au>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
 <87woyw8pxe.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 1 Mar 2018 08:01:12 +0100
X-Google-Sender-Auth: EwlUWi4YIPmWHRWA7-6vYq6k3i0
Message-ID: <CA+7wUsxsZrjHY8=TSUiMEgGMm72XyQRW47b7oqNjFGeFKLMd+w@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2171seB028646

On Thu, Mar 1, 2018 at 3:55 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Mathieu Malaterre <malat@debian.org> writes:
>
>> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
>> array feature_properties is defined as an empty array, which in turn
>> triggers the following warning (treated as error on W=1):
>>
>>   CC      arch/powerpc/kernel/prom.o
>> arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
>> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>>   for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>                 ^
>> cc1: all warnings being treated as errors
>
> Ugh, that's annoying.
>
> This seems to work?
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4dffef947b8a..5215119e249c 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -291,11 +291,11 @@ static inline void identical_pvr_fixup(unsigned long node)
>
>  static void __init check_cpu_feature_properties(unsigned long node)
>  {
> -       unsigned long i;
>         struct feature_property *fp = feature_properties;
>         const __be32 *prop;
> +       int i;
>
> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +       for (i = 0; i < (int)ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 prop = of_get_flat_dt_prop(node, fp->name, NULL);
>                 if (prop && be32_to_cpup(prop) >= fp->min_value) {
>                         cur_cpu_spec->cpu_features |= fp->cpu_feature;
>

Indeed that looks like the less invasive solution, I'll re-submit.

Should I resubmit the entire patch series (21 indep patches) or
re-submit only the 3 patches that were discussed (as part of a
different series) ?

Thanks
