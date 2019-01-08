Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C207C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E982070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfAHIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:50:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHIuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:50:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EB4B8762F;
        Tue,  8 Jan 2019 08:50:15 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 200995C20D;
        Tue,  8 Jan 2019 08:50:06 +0000 (UTC)
Date:   Tue, 8 Jan 2019 16:50:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of
 bottom-up after parsing hotplug attr
Message-ID: <20190108085002.GA18718@MiWiFi-R3L-srv>
References: <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx>
 <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx>
 <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
 <20190104150929.GA32252@rapoport-lnx>
 <20190105034450.GE30750@MiWiFi-R3L-srv>
 <20190106062733.GA3728@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106062733.GA3728@rapoport-lnx>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 08 Jan 2019 08:50:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/19 at 08:27am, Mike Rapoport wrote:
> I do not suggest to discard the bottom-up method, I merely suggest to allow
> it to use [0, kernel_start).

Sorry for late reply.

I misunderstood it, sorry.

> > This bottom-up way is taken on many ARCHes, it works well on system if
> > KASLR is not enabled. Below is the searching result in the current linux
> > kernel, we can see that all ARCHes have this mechanism, except of
> > arm/arm64. But now only arm64/mips/x86 have KASLR.
> > 
> > W/o KASLR, allocating memblock region above kernle end when hotplug info
> > is not parsed, looks very reasonable. Since kernel is usually put at
> > lower address, e.g on x86, it's 16M. My thought is that we need do
> > memblock allocation around kernel before hotplug info parsed. That is
> > for system w/o KASLR, we will keep the current bottom-up way; for system
> > with KASLR, we should allocate memblock region top-down just below
> > kernel start.
> 
> I completely agree. I was thinking about making
> memblock_find_in_range_node() to do something like
> 
> if (memblock_bottom_up()) {
> 	bottom_up_start = max(start, kernel_end);

In this way, if start < kernel_end, it will still succeed to find a
region in bottom-up way after kernel end.

I am still reading code. Just noticed Pingfan sent a RFC patchset to put
SRAT parsing earlier, not sure if he has tested it in numa system with
acpi. I doubt that really works.

Thanks
Baoquan

> 	ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> 					      size, align, nid, flags);



> 	if (ret)
> 		return ret;
> 
> 	bottom_up_start = max(start, 0);
> 	end = kernel_start;
> 
> 	ret = __memblock_find_range_top_down(bottom_up_start, end,
> 					     size, align, nid, flags);
> 	if (ret)
> 		return ret;
> }
