Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971396AbeEXURR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:17:17 -0400
Received: from relay2.sgi.com ([192.48.180.65]:52955 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967864AbeEXURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:17:16 -0400
Message-Id: <20180524201711.437084301@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 24 May 2018 15:17:11 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Update support for the UV kernel to accommodate Intel BIOS changes in
NVDIMM alignment, which caused UV BIOS to align the memory boundaries
on different blocks than the previous UV standard of 2GB.

Background: Since 2009 the UV arch dependent support has used 2GB as the
memory block size mainly to reduce the number of physical memory blocks
when a 16TB memory capable machine was introduced.  This significantly
reduced the time to initialize memory during system startup, and
has worked fine until Intel added PMEM NVDIMM's to the architecture.
This has caused the alignment boundary to be reduced to whatever is
needed to accommodate these new devices.

There are no other changes suggested by this patch set.  Basically the
previous strict boundary of 2GB has been relaxed to allow the arch
dependent code to adjust this memory block size depending on the
system requirements of the running environment.

* Patch 1
  Add a function for any arch dependent call to "adjust" this fixed
  memory block size.

* Patch 2
  Add a function to check what the minimum memory block size that can
  be used to accommodate where BIOS has set the boundaries for all of
  memory placement within node ranges.

* Patch 3
  Add a UV specific kernel arg to adjust for other memory block size
  adjustments that may be required with future new DIMM restrictions.
  Note that it can be raised (to 64GB) as well as lowered.  This should
  allow potential testing when the number of physical address bits are
  raised from the current 46 bit limit to 52 bits.

Note that an option I did consider was to make Patch 3 a more generic
function for all arches to use (IOW, with or without CONFIG_X86_UV set).
Opinions welcome about this.

-- 
