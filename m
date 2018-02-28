Return-Path: <kernel-hardening-return-12053-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuP4qGrTi9x1dfH/695slJqUai1MIko6B1pJgeRMmYkH976uT7frjfAjitmrLaj4dHShuHc
ARC-Seal: i=1; a=rsa-sha256; t=1519848722; cv=none;
        d=google.com; s=arc-20160816;
        b=AJeLJnKKdbs5Qi3yz7ARm8BnOIZ07KY9qBchyfcubQTPtvFzVOQVdzTU5cvBiVt3AT
         G045tKSDyFuFR5vPIolPp9dkVIV4wPskNdZ4pWBFrD05vc2LsNb1W8lYg5KBhC/XEPiQ
         eLNRx8LTFfPAzbCoTVM1mg2JTIDBi4ea1X0eKalSPGIEZ90Z+Z7e2y5DlhhMg/i5tvaO
         Qiictug5LgvwbBesN+qT3Zpgxafn8Q7UbaHoHcjp0H5+qH/OjjrdI7NTHC/1JAOu8Qjr
         IW6cR92TvTBqkTSEFAh/lIJQXydqoofXqYnRng1j8I8fc7nwenEYpBO5NwgHnCd5yiV6
         oEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=NpEJXfEcJyWsZ845QTN2GifRtdyfS/RSZltYKrw3COM=;
        b=jnbDbsigFJmVcaw+aQkddh5hrhpZBVFlxfvi7NJFhDQ3xumSl/NgV0yKBwD1WHJaqQ
         AacnPhN7lKNhIpatbbT0bcs/0Bz1pGetkoyWitoJ9MJo0vYNbbWW3mulsuZQQ3prIEMr
         +vtGYwLO0+LRyO/fkBf7VcTKocDpKNfFD6AVoNgE+XBi2/SUdlPakp5ynJXfmHnkLJGf
         U996Mm2PnM3DIyVg3LGz0RdDPqw4UcbE1hceL9my9etSAUonw5UscQN8x4hg5vYEoiiT
         VOwl+H1KHhugRZi162Y59cZ3Rb8udnhFM/jvyJeWYrtfbtgp21VUgWrs7X6v04QEU4Sw
         R2wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12053-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12053-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12053-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12053-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 7/7] Documentation for Pmalloc
Date: Wed, 28 Feb 2018 22:06:20 +0200
Message-ID: <20180228200620.30026-8-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228200620.30026-1-igor.stoppa@huawei.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676894350547582?=
X-GMAIL-MSGID: =?utf-8?q?1593676894350547582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 111 +++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/core-api/pmalloc.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c670a8031786..8f5de42d6571 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -25,6 +25,7 @@ Core utilities
    genalloc
    errseq
    printk-formats
+   pmalloc
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
new file mode 100644
index 000000000000..8fb9c9d3171b
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,111 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Protectable memory allocator
+============================
+
+Purpose
+-------
+
+The pmalloc library is meant to provide R/O status to data that, for some
+reason, could neither be declared as constant, nor could it take advantage
+of the qualifier __ro_after_init, but is write-once and read-only in spirit.
+It protects data from both accidental and malicious overwrites.
+
+Example: A policy that is loaded from userspace.
+
+
+Concept
+-------
+
+pmalloc builds on top of genalloc, using the same concept of memory pools.
+
+The value added by pmalloc is that now the memory contained in a pool can
+become R/O, for the rest of the life of the pool.
+
+Different kernel drivers and threads can use different pools, for finer
+control of what becomes R/O and when. And for improved lockless concurrency.
+
+
+Caveats
+-------
+
+- Memory freed while a pool is not yet protected will be reused.
+
+- Once a pool is protected, it's not possible to allocate any more memory
+  from it.
+
+- Memory "freed" from a protected pool indicates that such memory is not
+  in use anymore by the requester; however, it will not become available
+  for further use, until the pool is destroyed.
+
+- pmalloc does not provide locking support with respect to allocating vs
+  protecting an individual pool, for performance reasons.
+  It is recommended not to share the same pool between unrelated functions.
+  Should sharing be a necessity, the user of the shared pool is expected
+  to implement locking for that pool.
+
+- pmalloc uses genalloc to optimize the use of the space it allocates
+  through vmalloc. Some more TLB entries will be used, however less than
+  in the case of using vmalloc directly. The exact number depends on the
+  size of each allocation request and possible slack.
+
+- Considering that not much data is supposed to be dynamically allocated
+  and then marked as read-only, it shouldn't be an issue that the address
+  range for pmalloc is limited, on 32-bit systems.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need to
+  perform cross-processor synchronizations of page tables.
+
+- To facilitate the conversion of existing code to pmalloc pools, several
+  helper functions are provided, mirroring their kmalloc counterparts.
+
+
+Use
+---
+
+The typical sequence, when using pmalloc, is:
+
+1. create a pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_create_pool
+
+2. [optional] pre-allocate some memory in the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_prealloc
+
+3. issue one or more allocation requests to the pool with locking as needed
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pzalloc
+
+4. initialize the memory obtained with desired values
+
+5. [optional] iterate over points 3 & 4 as needed
+
+6. write-protect the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_protect_pool
+
+7. use in read-only mode the handles obtained through the allocations
+
+8. [optional] release all the memory allocated
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pfree
+
+9. [optional, but depends on point 8] destroy the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_destroy_pool
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
-- 
2.14.1
