Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeC2CA3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:00:29 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59885 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC2CA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:00:28 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2T20PvN014892
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AIpwx49o3qsWe7UlEaIe10criw8bulnFdAVJNNQJTBhCWZyiOi/vxOxndHk8rpqvWpdaGqiyfo4Nu3pqcIxfj32wNH0=
MIME-Version: 1.0
In-Reply-To: <20180329085809.78af08ff@canb.auug.org.au>
References: <20180329085809.78af08ff@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 29 Mar 2018 10:59:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRbEacK7Y9+yYjLEDVOu7iz8BJetaFd82NMw2cEnbaJg@mail.gmail.com>
Message-ID: <CAK7LNARRbEacK7Y9+yYjLEDVOu7iz8BJetaFd82NMw2cEnbaJg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

2018-03-29 6:58 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> net/ipv4/netfilter/nf_nat_snmp_basic_main.c:57:10: fatal err
> or: nf_nat_snmp_basic.asn1.h: No such file or directory
>  #include "nf_nat_snmp_basic.asn1.h"
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Presuambly caused by commit
>
>   9ee1b1bb8743 ("kbuild: rename *-asn1.[ch] to *.asn1.[ch]")
>
> though I am not sure why it didn't fail yesterday.
>
> I reverted that commit (and the following one because of a conflict)
> for today.
>
> --
> Cheers,
> Stephen Rothwell


Thanks for the report.

I think my patch is just a coincidence.

The netfilter Makefile seems weird.

I queued up the following fix-up to my kbuild tree.
Hopefully linux-next will be OK tomorrow.






commit 28913ee8191adf4bbc01cbfb9ee18cca782ab141
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu Mar 29 09:24:28 2018 +0900

    netfilter: nf_nat_snmp_basic: add correct dependency to Makefile

    nf_nat_snmp_basic_main.c includes a generated header, but the
    necessary dependency is missing in Makefile. This could cause
    build error in parallel building.

    Remove a weird line, and add a correct one.

    Fixes: cc2d58634e0f ("netfilter: nf_nat_snmp_basic: use asn1
decoder library")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index 2dad20e..9bd19cd 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_NF_NAT_H323) += nf_nat_h323.o
 obj-$(CONFIG_NF_NAT_PPTP) += nf_nat_pptp.o

 nf_nat_snmp_basic-y := nf_nat_snmp_basic-asn1.o nf_nat_snmp_basic_main.o
-nf_nat_snmp_basic-y : nf_nat_snmp_basic-asn1.h nf_nat_snmp_basic-asn1.c
+$(obj)/nf_nat_snmp_basic_main.o: $(obj)/nf_nat_snmp_basic-asn1.h
 obj-$(CONFIG_NF_NAT_SNMP_BASIC) += nf_nat_snmp_basic.o
 clean-files := nf_nat_snmp_basic-asn1.c nf_nat_snmp_basic-asn1.h



-- 
Best Regards
Masahiro Yamada
