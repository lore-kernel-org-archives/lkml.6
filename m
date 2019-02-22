Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872BCC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D63B2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBVPmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBVPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 895E3A70C;
        Fri, 22 Feb 2019 15:42:04 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C42495C1A1;
        Fri, 22 Feb 2019 15:42:03 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] libnvdimm/pfn: Fix 'start_pad' implementation
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
        <155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49ftsgsnzp.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4h9s1jYROGqkMfKk0MNBUedP=vQ1nJObLRwFiTB405nOg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 22 Feb 2019 10:42:02 -0500
In-Reply-To: <CAPcyv4h9s1jYROGqkMfKk0MNBUedP=vQ1nJObLRwFiTB405nOg@mail.gmail.com>
        (Dan Williams's message of "Thu, 21 Feb 2019 19:58:51 -0800")
Message-ID: <x49imxbx22d.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 22 Feb 2019 15:42:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

>> > However, to fix this situation a non-backwards compatible change
>> > needs to be made to the interpretation of the nd_pfn info-block.
>> > ->start_pad needs to be accounted in ->map.map_offset (formerly
>> > ->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
>> > adjusted to the section aligned resource base used to establish
>> > ->map.map formerly (formerly ->virt_addr).
>> >
>> > The guiding principles of the info-block compatibility fixup is to
>> > maintain the interpretation of ->data_offset for implementations like
>> > the EFI driver that only care about data_access not dax, but cause older
>> > Linux implementations that care about the mode and dax to fail to parse
>> > the new info-block.
>>
>> What if the core mm grew support for hotplug on sub-section boundaries?
>> Would't that fix this problem (and others)?
>
> Yes, I think it would, and I had patches along these lines [2]. Last
> time I looked at this I was asked by core-mm folks to await some
> general refactoring of hotplug [3], and I wasn't proud about some of
> the hacks I used to make it work. In general I'm less confident about
> being able to get sub-section-hotplug over the goal line (core-mm
> resistance to hotplug complexity) vs the local hacks in nvdimm to deal
> with this breakage.

You first posted that patch series in December of 2016.  How long do we
wait for this refactoring to happen?

Meanwhile, we've been kicking this can down the road for far too long.
Simple namespace creation fails to work.  For example:

# ndctl create-namespace -m fsdax -s 128m
  Error: '--size=' must align to interleave-width: 6 and alignment: 2097152
  did you intend --size=132M?

failed to create namespace: Invalid argument

ok, I can't actually create a small, section-aligned namespace.  Let's
bump it up:

# ndctl create-namespace -m fsdax -s 132m
{
  "dev":"namespace1.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"126.00 MiB (132.12 MB)",
  "uuid":"2a5f8fe0-69e2-46bf-98bc-0f5667cd810a",
  "raw_uuid":"f7324317-5cd2-491e-8cd1-ad03770593f2",
  "sector_size":512,
  "blockdev":"pmem1",
  "numa_node":1
}

Great!  Now let's create another one.

# ndctl create-namespace -m fsdax -s 132m
libndctl: ndctl_pfn_enable: pfn1.1: failed to enable
  Error: namespace1.2: failed to enable

failed to create namespace: No such device or address

(along with a kernel warning spew)

And at this point, all further ndctl create-namespace commands fail.
Lovely.  This is a wart that was acceptable only because a fix was
coming.  2+ years later, and we're still adding hacks to work around it
(and there have been *several* hacks).

> Local hacks are always a sad choice, but I think leaving these
> configurations stranded for another kernel cycle is not tenable. It
> wasn't until the github issue did I realize that the problem was
> happening in the wild on NVDIMM-N platforms.

I understand the desire for expediency.  At some point, though, we have
to address the root of the problem.

-Jeff

>
> [2]: https://lore.kernel.org/lkml/148964440651.19438.2288075389153762985.stgit@dwillia2-desk3.amr.corp.intel.com/
> [3]: https://lore.kernel.org/lkml/20170319163531.GA25835@dhcp22.suse.cz/
>
>>
>> -Jeff
>>
>> [1] https://github.com/pmem/ndctl/issues/76
