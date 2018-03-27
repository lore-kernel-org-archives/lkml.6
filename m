Return-Path: <kernel-hardening-return-12772-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48RVb+a0aDc8C4C1HguJDboNEhSehTpOR6+fsk+zZQ9OeUzRhVNDCGxossxuJbFGz66s2xA
ARC-Seal: i=1; a=rsa-sha256; t=1522165369; cv=none;
        d=google.com; s=arc-20160816;
        b=zU/Lf5OAfVAxPjYL1vhYODkgxAcDNBAI1uO3beXIIclfa6bkRXoqZuiFI1oyyAVRCF
         qUxWZdLZ9Bjf06oaesuU+241wTJkJFQSgbRJ1uWYagHGDCTZ5tribbEAHK0Llzd3QYjS
         fuzdrJ5/9KxEtI+aMcSvsEJG7W2mozaww+bDitjaEkOz9YDuo73+0S09tPZVYXlYxdFR
         z4ik9Mgb6IXD7ykG8ncJ9UJ15zRFwA/Pc98EAeV51irQuZWOzojPDQLg+7kJalmkouW5
         q0nVo/g2uocMya9x9d4u4K5vk5wn4lRJOeEROa6jsHb9xnYvfyXwDBWFLHK53iSv3vJx
         vyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OqDmA1Fq5k4lm07oLpqfexf0+IOxtwlLE2Pn0Bzo5uQ=;
        b=x0lYFoN0Qnwsd4NixqIq/7U5JK5lMhdB7oRrJLwIc5HxtyRh1MYhNthu3udA3V9B/9
         ZJUsegMJ9gUZ3en7cJ9Jaf41WxIIPCNAdWiZ3RBqWWIyCByjT+bIfOtMae4sR6mHOnT4
         Qnkaj62XQpIeHQe6yB4NEXoMC+HhC3jgyEQ0bzNhgAcTVJc9NUtYGFCDPR1+tBOkBPA6
         In38ezjUNkWuKZw13Mj8oC7H3l7Xb6Mvot7J75/Up6SKat3NTyzwnmjQe1mWvAerqRc8
         d8gn4ptGS/wrQEUTxonUth4mPqsZz1s+ZA/xOYdzg5qyEXRWYjKadmge7/ahEpwET7uE
         lpFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12772-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12772-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12772-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12772-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 6/6] Documentation for Pmalloc
Date: Tue, 27 Mar 2018 18:37:42 +0300
Message-ID: <20180327153742.17328-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596106074244469428?=
X-GMAIL-MSGID: =?utf-8?q?1596106074244469428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 107 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
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
index 000000000000..c14907485137
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _pmalloc:
+
+Protectable memory allocator
+============================
+
+Purpose
+-------
+
+The pmalloc library is meant to provide read-only status to data that,
+for some reason, could neither be declared as constant, nor could it take
+advantage of the qualifier __ro_after_init, but is write-once and
+read-only in spirit. At least as long as it doesn't get teared down.
+It protects data from both accidental and malicious overwrites.
+
+Example: A policy that is loaded from userspace.
+
+
+Concept
+-------
+
+The MMU available in the system can be used to write protect memory pages.
+Unfortunately this feature cannot be used as-it-is, to protect sensitive
+data, because this potentially read-only data is typically interleaved
+with other data, which must stay writeable.
+
+pmalloc introduces the concept of protectable memory pools.
+A pool contains a list of areas of virtually contiguous pages of
+memory. An area is the minimum amount of memory that pmalloc allows to
+protect, because the user might have allocated a memory range that
+crosses the boundary between pages.
+
+When an allocation is performed, if there is not enough memory already
+available in the pool, a new area of suitable size is grabbed.
+The size chosen is the largest between the roundup (to PAGE_SIZE) of
+the request from pmalloc and friends and the refill parameter specified
+when creating the pool.
+
+When a pool is created, it is possible to specify two parameters:
+- refill size: the minimum size of the memory area to allocate when needed
+- align_order: the default alignment to use when reserving memory
+
+To facilitate the conversion of existing code to pmalloc pools, several
+helper functions are provided, mirroring their k/vmalloc counterparts.
+However one is missing. There is no pfree() because the memory protected
+by a pool will be released exclusively when the pool is destroyed.
+
+
+
+Caveats
+-------
+
+- When a pool is protected, whatever memory would be still available in
+  the current vmap_area (from which allocations are performed) is
+  relinquished.
+
+- As already explained, freeing of memory is not supported. Pages will be
+  returned to the system upon destruction of the memory pool that they
+  belong to.
+
+- The address range available for vmalloc (and thus for pmalloc too) is
+  limited, on 32-bit systems. However it shouldn't be an issue, since not
+  much data is expected tobe dynamically allocated and turned into
+  read-only.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need
+  to perform cross-processor synchronizations of page tables.
+  Loading of kernel modules is an exception to this, but it's not expected
+  to happen with such high frequency to become a problem.
+
+
+Use
+---
+
+The typical sequence, when using pmalloc, is:
+
+#. create a pool
+
+   :c:func:`pmalloc_create_pool`
+
+#. issue one or more allocation requests to the pool
+
+   :c:func:`pmalloc`
+
+   or
+
+   :c:func:`pzalloc`
+
+#. initialize the memory obtained, with the desired values
+
+#. write-protect the memory so far allocated
+
+   :c::func:`pmalloc_protect_pool`
+
+#. iterate over the last 3 points as needed
+
+#. [optional] destroy the pool
+
+   :c:func:`pmalloc_destroy_pool`
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
+.. kernel-doc:: mm/pmalloc.c
-- 
2.14.1
