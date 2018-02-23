Return-Path: <kernel-hardening-return-11925-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtmg0tmJL317Lu5TPkPQDUqsLgMech3oigVvMvLPY9OxkP8LGcct2xMYBi8iDcz+INyC2P/
ARC-Seal: i=1; a=rsa-sha256; t=1519397611; cv=none;
        d=google.com; s=arc-20160816;
        b=lG3MTRiKxjad+9unoDTDRLqwnT5qAScJDtQG9zKuDKNI2tmipbz65/i1B4uA1QlSTU
         A/DipVF+XQcWLGqaznnOx6g6pijzThl1MIxMKIioDdWbHaYZ2wDkRvqRb8nC3utK1jvF
         k040i31/8DD0aHQDODFSrTJxNedBhLCG+TpyTO0fr71leQ+e6BvS2Sy7NYFzBGxcRGNe
         MHamA8rF1FIbbdivVFGjU6pFMiPKcrVQ/f4VsfBfiGLrfYXg07UViTRUiv+a165qaF31
         pEEytnTnGxZ6RcPm5+ozdWP/GvUfS8dAvOpwKQ5UdohNExPAfhDgwt6u/SIF7zpQAsN4
         P1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=FO2mu7SE062xbe4rAXnF6NOaP7FAlRlh+YTUBVP6RIM=;
        b=BXA1qcKlROxf6OFkHltjuGvfoNYwDbPmIOZmovC7ctlPSGZLIl/GfGBF0Zjtp2gYWp
         io39VpkMOcwT51vVLKUCk9LGwjS3eU1TspCT1jH0f6hwZGOkLCpGCKRYeH/eBN1DMBu3
         h7c7/WwSSA3zPu7GW/okhN4Zsd0o3ur3UxwYnFKvf8kE1h8Sv2125p3usCFpCGT4rVEg
         V9gowq8O2x8fEf8Efo29kX+KXos/lxus3cSdk/bWjrTQ/KZ7P9Q8ktAHWVzsqlruRMk0
         B8KrH+u7KkTZBnvdQoaCAj5Se3fo6YiiCJMJHg16v2ii5OlSf7MBfFFSbP7IYxIxagh3
         xX7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11925-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11925-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11925-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11925-gregkh=linuxfoundation.org@lists.openwall.com
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
Date: Fri, 23 Feb 2018 16:48:07 +0200
Message-ID: <20180223144807.1180-8-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223144807.1180-1-igor.stoppa@huawei.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203869384416371?=
X-GMAIL-MSGID: =?utf-8?q?1593203869384416371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 +++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
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
index 000000000000..d9725870444e
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,114 @@
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
+- Before destroying a pool, all the memory allocated from it must be
+  released.
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
