Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA617C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211120828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeL3WpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 17:45:22 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34502 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeL3WpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 17:45:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 42EE12280E;
        Sun, 30 Dec 2018 17:45:18 -0500 (EST)
Date:   Mon, 31 Dec 2018 09:45:16 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     James Bottomley <jejb@linux.vnet.ibm.com>
cc:     LEROY Christophe <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
In-Reply-To: <alpine.LNX.2.21.1812310839050.444@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1812310933450.444@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>         <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>         <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>        
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>         <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>         <alpine.LNX.2.21.1812291327380.152@nippy.intranet>         <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>        
 <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>         <20181230185002.Horde.AdSknvcs4hP1Kh_T_Cos6w8@messagerie.si.c-s.fr> <1546193203.2844.9.camel@linux.vnet.ibm.com> <alpine.LNX.2.21.1812310839050.444@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018, Finn Thain wrote:

> On Sun, 30 Dec 2018, James Bottomley wrote:
> 
> > 
> > That said, as has been pointed out, the current #ifdef has a failing 
> > corner case when both are modular (because the code should then be 
> > included).  The runtime macro that correctly expresses this is 
> > IS_REACHABLE(CONFIG_NVRAM).
> > 
> 
> No, in the case of CONFIG_NVRAM=m, the conditional code is deliberately 
> excluded. This is discussed in the patch description. The convention on 
> PPC32 is that device drivers drop support for NVRAM in this situation. 
> 
> I've adopted the PPC32 convention here because M68K drivers and PPC32 
> drivers have to co-exist (I'm thinking of valkyriefb, but there are other 
> examples).
> 

I agree with your comment in principle, that these drivers should be using 
IS_REACHABLE(CONFIG_NVRAM), not defined(CONFIG_NVRAM).

$ grep -lrw CONFIG_NVRAM drivers/
drivers/video/fbdev/matrox/matroxfb_base.c
drivers/video/fbdev/platinumfb.c
drivers/video/fbdev/controlfb.c
drivers/video/fbdev/valkyriefb.c
drivers/video/fbdev/imsttfb.c
drivers/scsi/atari_scsi.c
$ 

But I think this is not the fault of this patch; it's just a historical 
accident.

Having said that, I will rework this series to convert all of the above 
drivers to IS_REACHABLE(CONFIG_NVRAM). I think it would be an improvement.

Besides, it seems likely that some rework involving ppc_md will be needed 
too because as Arnd pointed out, it would be good to avoid two sets of 
nvram accessor methods.

-- 
