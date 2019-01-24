Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B61C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAXCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXCRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:17:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 729BF83F4C;
        Thu, 24 Jan 2019 02:17:50 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D49655D6A6;
        Thu, 24 Jan 2019 02:17:46 +0000 (UTC)
Date:   Thu, 24 Jan 2019 10:17:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jbohac@suse.cz,
        adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        osandov@fb.com, Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190124021744.GB19177@MiWiFi-R3L-srv>
References: <20190102105408.7124-1-kasong@redhat.com>
 <20190123141432.GA19177@MiWiFi-R3L-srv>
 <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 24 Jan 2019 02:17:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/19 at 10:50pm, Kairui Song wrote:
> > >  int fix_aperture __initdata = 1;
> > >
> > > -#ifdef CONFIG_PROC_VMCORE
> > > +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
> > >  /*
> > >   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
> > >   * use the same range because it will remain configured in the northbridge.
> > > @@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
> > >   */
> > >  static unsigned long aperture_pfn_start, aperture_page_count;
> > >
> > > -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> > > +static int gart_mem_pfn_is_ram(unsigned long pfn)
> > >  {
> > >       return likely((pfn < aperture_pfn_start) ||
> > >                     (pfn >= aperture_pfn_start + aperture_page_count));
> > > @@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> >
> > Shouldn't this function name be changed? It's not only handling vmcore
> > stuff any more, but also kcore. And this function is not excluding, but
> > resgistering.
> >
> > Other than this, it looks good to me.
> >
> > Thanks
> > Baoquan
> >
> 
> Good suggestion, it's good to change this function name too to avoid
> any misleading. This patch hasn't got any other reviews recently, I'll
> update it shortly.

There's more.

These two are doing the same thing:
  register_mem_pfn_is_ram
  register_oldmem_pfn_is_ram

Need remove one of them and put it in a right place. Furthermore, may
need see if there's existing function which is used to register a
function to a hook.

Secondly, exclude_from_vmcore() is not excluding anthing, it's only
registering a function which is used to judge if oldmem/pfn is ram. Need
rename it.

Thanks
Baoquan
