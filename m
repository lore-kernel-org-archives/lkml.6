Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A1220892
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A1220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLCDBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:01:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeLCDBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:01:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B1D1308339C;
        Mon,  3 Dec 2018 03:01:05 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94C016A6A6;
        Mon,  3 Dec 2018 03:01:03 +0000 (UTC)
Date:   Mon, 3 Dec 2018 11:01:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181203030100.GA22521@MiWiFi-R3L-srv>
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com>
 <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
 <20181110122905.GA2653@MiWiFi-R3L-srv>
 <20181123155831.ewkrq4r27rne75mz@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123155831.ewkrq4r27rne75mz@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 03 Dec 2018 03:01:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 11/23/18 at 06:58pm, Kirill A. Shutemov wrote:
> > Thanks for this fix. One small concern is whether we can put LDT
> > remap in other place, e.g shrink KASAN area and save one pgd size for
> > it, Just from Redhat's enterprise relase point of view, we don't
> > enable CONFIG_KASAN, and LDT is rarely used for server, now cutting one
> > block from the direct mapping area and moving it up one pgd slot seems a
> > little too abrupt. Does KASAN really cost 16 TB in 4-level and 8 PB in
> > 5-level? After all the direct mapping is the core mapping and has been
> > there always, LDT remap is kind of not so core and important mapping.
> > Just a very perceptual feeling.
> 
> KASAN requires one byte of shadow memory per 8 bytes of target memory, so,
> yeah, we need 16 TiB of virtual address space with 4-level paging.
> 
> With 5-level, we might save some address space as the limit for physical
> address space if 52-bit, not 55. I dedicated 55-bit address space because
> it was easier: just scale 4-level layout by factor of 9 and you'll get all
> nicely aligned without much thought (PGD translates to PGD, etc).
> 
> There is also complication with KASAN layout. We have to have the same
> KASAN_SHADOW_OFFSET between 4- and 5-level paging to make boot time
> switching between paging modes work. The offset cannot be changed at
> runtime: it used as parameter to compiler. That's the reason KASAN area
> alignment looks strange.

Thanks for explanation. KASAN area can't be touched as you said.

> 
> A possibly better solution would be to actually include LDT in KASLR:
> randomize the area along with direct mapping, vmalloc and vmemmap.
> But it's more complexity than I found reasonable for a fix.
> 
> Do you want to try this? :)

                                                           |
Seems the unused hole between vmemmap and KASAN can be used. e.g put LDT
remap in -20.5 TB place like below. And meanwhile 
____________________________________________________________|___________________________________________________________
                  |            |                  |         |
 ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
 ffff888000000000 | -120    TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
 ffffc88000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
 ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
 ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
 ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
 ffffeb0000000000 |  -21    TB | ffffebffffffffff |  0.5 TB | ... unused hole
 ffffeb0000000000 |  -20.5  TB | ffffebffffffffff |  0.5 TB | LDT remap for PTI 
 ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
__________________|____________|__________________|_________|____________________________________________________________

In non-KASLR case, only 0.5 TB left as hole between vmemmap and LDT.
Meanwhile since LDT remap only costs 128 KB at most at the beginning,
the left area can be seen as guard hole between it and KASAN.

And yes, in KASLR case, we have to take it with the old three regions
together to randomize.

It looks do-able, not sure if the test case is complicated or not, if
not hard, I can have a try. And I have some internal bugs, can focus on
this later. I saw you posted another patchset to fix xen issue, it may
not be needed any more if we take this way?

And not sure if other people have different idea.

Thanks
Baoquan
