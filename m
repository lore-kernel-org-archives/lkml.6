Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741EF20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741EF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeKJWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:14:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbeKJWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:14:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0559F30026C9;
        Sat, 10 Nov 2018 12:29:10 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F17960C44;
        Sat, 10 Nov 2018 12:29:08 +0000 (UTC)
Date:   Sat, 10 Nov 2018 20:29:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181110122905.GA2653@MiWiFi-R3L-srv>
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com>
 <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 10 Nov 2018 12:29:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 at 03:28pm, Kirill A. Shutemov wrote:
> On 5-level paging LDT remap area is placed in the middle of
> KASLR randomization region and it can overlap with direct mapping,
> vmalloc or vmap area.
             ~~~
		We usually call it vmemmap.
> 
> Let's move LDT just before direct mapping which makes it safe for KASLR.
> This also allows us to unify layout between 4- and 5-level paging.
...

> diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
> index 702898633b00..75bff98928a8 100644
> --- a/Documentation/x86/x86_64/mm.txt
> +++ b/Documentation/x86/x86_64/mm.txt
> @@ -34,23 +34,24 @@ __________________|____________|__________________|_________|___________________
>  ____________________________________________________________|___________________________________________________________
>                    |            |                  |         |
>   ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> - ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> - ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> + ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI
> + ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> + ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole

Hi Kirill,

Thanks for this fix. One small concern is whether we can put LDT
remap in other place, e.g shrink KASAN area and save one pgd size for
it, Just from Redhat's enterprise relase point of view, we don't
enable CONFIG_KASAN, and LDT is rarely used for server, now cutting one
block from the direct mapping area and moving it up one pgd slot seems a
little too abrupt. Does KASAN really cost 16 TB in 4-level and 8 PB in
5-level? After all the direct mapping is the core mapping and has been
there always, LDT remap is kind of not so core and important mapping.
Just a very perceptual feeling.

Other than this, this patch looks good to me.

Thanks
Baoquan
