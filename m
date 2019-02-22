Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E10A20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfBVCLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:11:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBVCLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB8F53097074;
        Fri, 22 Feb 2019 02:11:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-136.pek2.redhat.com [10.72.12.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DBB25C22B;
        Fri, 22 Feb 2019 02:11:04 +0000 (UTC)
Date:   Fri, 22 Feb 2019 10:11:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
References: <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221171321.GD12997@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 22 Feb 2019 02:11:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/19 at 06:13pm, Borislav Petkov wrote:
> On Wed, Feb 20, 2019 at 05:41:46PM +0800, Dave Young wrote:
> > Previously Joerg posted below patch, maybe he has some idea. Joerg?
> 
> Isn't it clear from the commit message?

Then, does it answered your question?

256M is set as a default value in the patch, but it is not a predict to
satisfy all use cases, from the description it is also possible that some
people run out of the 256M and the ,low and ,high format is still
necessary to exist even if we make crashkernel=X do the allocation
automatically in high in case failed in low area.

crashkernel=X:  allocate in low first, if not possible, then allocate in
high

In case people have a lot of devices need more swiotlb, then he manually
set the ,high with ,low together.

What's your suggestion then?  remove ,low and ,high and increase default
256M in case we get failure bug report?
