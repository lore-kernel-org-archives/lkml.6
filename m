Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7242BC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311232064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311232064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJNRis convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:38:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3111 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeJNRis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:38:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42XxpW3cMxz9ttBy;
        Sun, 14 Oct 2018 11:58:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R2oq6wy3imXu; Sun, 14 Oct 2018 11:58:11 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42XxpW2nTkz9ttBx;
        Sun, 14 Oct 2018 11:58:11 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 561D44F4; Sun, 14 Oct 2018 11:58:10 +0200 (CEST)
Received: from 37.169.125.255 ([37.169.125.255]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 14 Oct 2018 11:58:10 +0200
Date:   Sun, 14 Oct 2018 11:58:10 +0200
Message-ID: <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aneesh.kumar@linux.vnet.ibm.com, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Jens Axboe <axboe@kernel.dk>,
        Geoff Levand <geoff@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in
 ioremap()
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
 <87d0sd19vm.fsf@concordia.ellerman.id.au>
 <87a7nh104q.fsf@concordia.ellerman.id.au>
In-Reply-To: <87a7nh104q.fsf@concordia.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> Set PAGE_KERNEL directly in the caller and do not rely on a
>>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>>
>>> As already done for PPC64, use pgprot_cache() helpers instead of
>>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Something in here is breaking my p5020ds (both 32-bit and 64-bit):
>
> Oh duh.
>
> That's because I didn't take patch 4.
>
> It didn't have any acks, but I guess I'll just merge it rather than
> breaking things.

Yes indeed. Maybe should I have followed it more carrefully to ensure  
it gets an ack.

Thanks
Christophe



