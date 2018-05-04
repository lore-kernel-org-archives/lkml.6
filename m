Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEDAQG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:31649 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeEDAQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="36712293"
Subject: [PATCH v3 0/9] Series short description
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Tony Luck <tony.luck@intel.com>,
        Mika =?utf-8?b?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Mike Snitzer <snitzer@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:05 -0700
Message-ID: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:

* Fix source address increment in mcsafe_handle_tail() (Mika)

* Extend the unit test to inject simulated write faults and validate
  that data is properly transferred.

* Rename MCSAFE_DEBUG to MCSAFE_TEST

[1]: https://lists.01.org/pipermail/linux-nvdimm/2018-May/015583.html

---

Currently memcpy_mcsafe() is only deployed in the pmem driver when
reading through a /dev/pmemX block device. However, a filesystem in dax
mode mounted on a /dev/pmemX block device will bypass the block layer
and the driver for reads. The filesystem-dax (fsdax) read case uses
dax_direct_access() and copy_to_iter() to bypass the block layer.

The result of the bypass is that the kernel treats machine checks during
read as system fatal (reboot) when they could simply be flagged as an
I/O error, similar to performing reads through the pmem driver. Prevent
this fatal condition by deploying memcpy_mcsafe() in the fsdax read
path.

The main differences between this copy_to_user_mcsafe() and
copy_user_generic_unrolled() are:

* Typical tail/residue handling after a fault retries the copy
  byte-by-byte until the fault happens again. Re-triggering machine
  checks is potentially fatal so the implementation uses source alignment
  and poison alignment assumptions to avoid re-triggering machine
  checks.

* SMAP coordination is handled external to the assembly with
  __uaccess_begin() and __uaccess_end().

* ITER_KVEC and ITER_BVEC can now end prematurely with an error.

The new MCSAFE_TEST facility is proposed as a way to unit test the
exception handling without requiring an ACPI EINJ capable platform.

---

Dan Williams (9):
      x86, memcpy_mcsafe: remove loop unrolling
      x86, memcpy_mcsafe: add labels for write fault handling
      x86, memcpy_mcsafe: return bytes remaining
      x86, memcpy_mcsafe: add write-protection-fault handling
      x86, memcpy_mcsafe: define copy_to_iter_mcsafe()
      dax: introduce a ->copy_to_iter dax operation
      dax: report bytes remaining in dax_iomap_actor()
      pmem: switch to copy_to_iter_mcsafe()
      x86, nfit_test: unit test for memcpy_mcsafe()


 arch/x86/Kconfig                   |    1 
 arch/x86/Kconfig.debug             |    3 +
 arch/x86/include/asm/mcsafe_test.h |   75 ++++++++++++++++++++++++
 arch/x86/include/asm/string_64.h   |   10 ++-
 arch/x86/include/asm/uaccess_64.h  |   14 +++++
 arch/x86/lib/memcpy_64.S           |  112 +++++++++++++++++-------------------
 arch/x86/lib/usercopy_64.c         |   21 +++++++
 drivers/dax/super.c                |   10 +++
 drivers/md/dm-linear.c             |   16 +++++
 drivers/md/dm-log-writes.c         |   15 +++++
 drivers/md/dm-stripe.c             |   21 +++++++
 drivers/md/dm.c                    |   25 ++++++++
 drivers/nvdimm/claim.c             |    3 +
 drivers/nvdimm/pmem.c              |   13 +++-
 drivers/s390/block/dcssblk.c       |    7 ++
 fs/dax.c                           |   21 ++++---
 include/linux/dax.h                |    5 ++
 include/linux/device-mapper.h      |    5 +-
 include/linux/string.h             |    4 +
 include/linux/uio.h                |   15 +++++
 lib/iov_iter.c                     |   61 ++++++++++++++++++++
 tools/testing/nvdimm/test/nfit.c   |  104 +++++++++++++++++++++++++++++++++
 22 files changed, 482 insertions(+), 79 deletions(-)
 create mode 100644 arch/x86/include/asm/mcsafe_test.h
