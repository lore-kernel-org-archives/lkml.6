Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D42082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8D42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLDJpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:45:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:45:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 834AEAD2C;
        Tue,  4 Dec 2018 09:44:58 +0000 (UTC)
Date:   Tue, 4 Dec 2018 10:44:54 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@linuxdriverproject.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michal Hocko <mhocko@suse.com>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFCv2 3/4] mm/memory_hotplug: Introduce and use more
 memory types
Message-ID: <20181204104454.522a3ba2@naga.suse.cz>
In-Reply-To: <20181130175922.10425-4-david@redhat.com>
References: <20181130175922.10425-1-david@redhat.com>
        <20181130175922.10425-4-david@redhat.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 18:59:21 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's introduce new types for different kinds of memory blocks and use
> them in existing code. As I don't see an easy way to split this up,
> do it in one hunk for now.
> 
> acpi:
>  Use DIMM or DIMM_UNREMOVABLE depending on hotremove support in the kernel.
>  Properly change the type when trying to add memory that was already
>  detected and used during boot (so this memory will correctly end up as
>  "acpi" in user space).
> 
> pseries:
>  Use DIMM or DIMM_UNREMOVABLE depending on hotremove support in the kernel.
>  As far as I see, handling like in the acpi case for existing blocks is
>  not required.
> 
> probed memory from user space:
>  Use DIMM_UNREMOVABLE as there is no interface to get rid of this code
>  again.
> 
> hv_balloon,xen/balloon:
>  Use BALLOON. As simple as that :)
> 
> s390x/sclp:
>  Use a dedicated type S390X_STANDBY as this type of memory and it's
>  semantics are very s390x specific.
> 
> powernv/memtrace:
>  Only allow to use BOOT memory for memtrace. I consider this code in
>  general dangerous, but we have to keep it working ... most probably just
>  a debug feature.

I don't think it should be arbitrarily restricted like that.

Thanks

Michal
