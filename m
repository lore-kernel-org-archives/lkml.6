Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4252146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBTRpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:45:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfBTRpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:45:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 659AB19C65B;
        Wed, 20 Feb 2019 17:45:33 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 504C360149;
        Wed, 20 Feb 2019 17:45:32 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/7] libnvdimm/pfn: Fix section-alignment padding
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAPcyv4j9uEn9j=Y0Vo3oQJaXo-d-Xf=2-=0ucufhcXWeYOb0Yg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Feb 2019 12:45:31 -0500
In-Reply-To: <CAPcyv4j9uEn9j=Y0Vo3oQJaXo-d-Xf=2-=0ucufhcXWeYOb0Yg@mail.gmail.com>
        (Dan Williams's message of "Wed, 20 Feb 2019 09:11:04 -0800")
Message-ID: <x49pnrm2w1w.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 17:45:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Feb 12, 2019 at 1:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Lately Linux has encountered platforms that collide Persistent Memory
>> regions between each other, specifically cases where ->start_pad needed
>> to be non-zero. This lead to commit ae86cbfef381 "libnvdimm, pfn: Pad
>> pfn namespaces relative to other regions". That commit allowed
>> namespaces to be mapped with devm_memremap_pages(). However dax
>> operations on those configurations currently fail if attempted within the
>> ->start_pad range because pmem_device->data_offset was still relative to
>> raw resource base not relative to the section aligned resource range
>> mapped by devm_memremap_pages().
>>
>> Luckily __bdev_dax_supported() caught these failures and simply disabled
>> dax. However, to fix this situation a non-backwards compatible change
>> needs to be made to the interpretation of the nd_pfn info-block.
>> ->start_pad needs to be accounted in ->map.map_offset (formerly
>> ->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
>> adjusted to the section aligned resource base used to establish
>> ->map.map formerly (formerly ->virt_addr).
>>
>> See patch 7 "libnvdimm/pfn: Fix 'start_pad' implementation" for more
>> details, and the ndctl patch series "Improve support + testing for
>> labels + info-blocks" for the corresponding regression test.
>
> Hello valued reviewers, can I plead for a sanity check of at least
> "libnvdimm/pfn: Introduce super-block minimum version requirements"
> and "libnvdimm/pfn: Fix 'start_pad' implementation"? In particular
> Jeff / Johannes this has end user / distro impact in that users may
> lose access to namespaces that are upgraded to v1.3 info-blocks and
> then boot an old kernel. I did not see a way around that sharp edge.

Yes, I'll take a look.

Cheers,
Jeff
