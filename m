Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB46ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6758C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJZQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:37:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40010 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbeJZQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:37:30 -0400
X-UUID: a3b009def0ae443e84f16d830024f0b0-20181026
X-UUID: a3b009def0ae443e84f16d830024f0b0-20181026
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 426055461; Fri, 26 Oct 2018 16:01:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 26 Oct 2018 16:01:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 26 Oct 2018 16:01:07 +0800
Message-ID: <1540540867.21297.2.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joe Perches <joe@perches.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Oct 2018 16:01:07 +0800
In-Reply-To: <e0cd65fdd6afc17b2be9b3ac64d50b95b2c2f32e.camel@perches.com>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
         <e0cd65fdd6afc17b2be9b3ac64d50b95b2c2f32e.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 11:44 -0700, Joe Perches wrote:
> On Fri, 2018-10-26 at 02:34 +0800, miles.chen@mediatek.com wrote:
> > From: Miles Chen <miles.chen@mediatek.com>
> > 
> > The kbuf used by page owner is allocated by kmalloc(),
> > which means it can use only normal memory and there might
> > be a "out of memory" issue when we're out of normal memory.
> > 
> > Use vmalloc() so we can also allocate kbuf from highmem
> > on 32bit kernel.
> 
> If this is really necessary, using kvmalloc/kvfree would
> be better as the vmalloc space is also limited.

thanks for the advise.
kvmalloc/kvfree is better here.

> 
> > diff --git a/mm/page_owner.c b/mm/page_owner.c
> []
> > @@ -1,7 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/debugfs.h>
> >  #include <linux/mm.h>
> > -#include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/bootmem.h>
> >  #include <linux/stacktrace.h>
> > @@ -10,6 +9,7 @@
> >  #include <linux/migrate.h>
> >  #include <linux/stackdepot.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
> >  		.skip = 0
> >  	};
> >  
> > -	kbuf = kmalloc(count, GFP_KERNEL);
> > +	kbuf = vmalloc(count);
> >  	if (!kbuf)
> >  		return -ENOMEM;
> >  
> > @@ -397,11 +397,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
> >  	if (copy_to_user(buf, kbuf, ret))
> >  		ret = -EFAULT;
> >  
> > -	kfree(kbuf);
> > +	vfree(kbuf);
> >  	return ret;
> >  
> >  err:
> > -	kfree(kbuf);
> > +	vfree(kbuf);
> >  	return -ENOMEM;
> >  }
> >  
> 


