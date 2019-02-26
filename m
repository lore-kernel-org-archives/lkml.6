Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DBD2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfBZFL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:11:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBZFL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:11:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C858FF4C;
        Tue, 26 Feb 2019 05:11:27 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 831D827CC6;
        Tue, 26 Feb 2019 05:11:21 +0000 (UTC)
Date:   Tue, 26 Feb 2019 13:11:17 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Pingfan Liu <kernelfans@gmail.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190226051117.GA5085@dhcp-128-65.nay.redhat.com>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic>
 <20190225130452.GN14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225130452.GN14858@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 26 Feb 2019 05:11:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/19 at 09:05pm, Baoquan He wrote:
> On 02/25/19 at 10:45am, Borislav Petkov wrote:
> > On Mon, Feb 25, 2019 at 03:59:56PM +0800, Pingfan Liu wrote:
> > > crashkernel=x@y option may fail to reserve the required memory region if
> > > KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> > > skip the required region.
> > 
> > Lemme see if I understand this correctly: supplying crashkernel=X@Y
> > influences where KASLR would put the randomized kernel. And it should be
> > the other way around, IMHO. crashkernel= will have to "work" with KASLR
> > to find a suitable range and if the reservation at Y fails, then we tell
> > the user to try the more relaxed variant crashkernel=M.
> 
> Hmm, asking user to try crashkernel=M is an option. Users may want to
> specify a region for crashkernel reservation, Just I forget in what case
> they want crashkernel=x@y set. In crashkernel=x@y specified case, we may
> truly need to avoid the already specified region.
> 
> Not sure if Dave still remember it. If no need, removing it is also
> good.

I do not know the exact use cases, but long time ago the kernel is not
relocatable this might be a reason.  Even now, there could be some non
linux use cases, if the loaded binary is not relocatable then the param
is still useful.

Also this is a general param instead of x86 only, some other arches
still use it, and no crashkernel=X implemented.

Thanks
Dave
