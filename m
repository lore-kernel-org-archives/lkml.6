Return-Path: <kernel-hardening-return-12560-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvOC0pylDYm8TbRSdwhUVSp8EnHD/mePNWCCE0+GtXLuT64SpTN8i/sSfmbxaFstg/UOt34
ARC-Seal: i=1; a=rsa-sha256; t=1520977949; cv=none;
        d=google.com; s=arc-20160816;
        b=b2oTO+Ew56dI7b1NCq5WhB7x1SIsFBhaek1D4y73nRuCiTYi11iieem0iw0oj2C6Y2
         XwjkKcZbhUV9kuatf63CEjmFExy9SKQ/LeWDGA+93SDEgi586WxQ5+UZny4R7b1jGvNR
         I9YavNgqnwqGNZAdJnXmxFm8iIcsqjwE38/2MhEkI+ocswQ6FGCsyr8PyFfAbX4j/9hg
         AxjyrpJJHpVxfxA1DkCyFj8i+qJC0VE0kBxqVC6epdlWN7B1izvHcuxbVvDhscson8ao
         ouGSbNwfsUBL1pzOkM2/U5JQRBtz5536RIRyinuXvFNOBGdV/65afYKFSmowKoD/VQcc
         ynFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=kiTa+sqX01HsdMRDsVTIe6T4viY4zVcXQt2GbbE8s8Y=;
        b=QsXMGVUem7OAcePmGh5DPYqfGscuf1T3ccc/FXQG6/VN4m+630p8gtJUPh5B9Ij3do
         TZagHFnsXPo16hz4O2o0lXzoHo3nIkQ2Yhn2DH0RumqerBthobylqL2JYI4wc3it94Fs
         HVKbT8TGV9Qp5d6CikGlnqonddi3rh2qmjVyo/UccJpkQo21lZpPesFHiIb44qD77GsC
         GZEYY+jzzkASuJ4Pv20lbaSGJoBFDFnn4X71e1i0lvVIY62CfnRkxEwJimAWRxriEeg7
         B5E59gGgPetroQFpv3RlJLdDFMBgzX65NLhxqqXw0u1kk4jxgPjC4dkKYRskTzDdDs1G
         c2fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12560-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12560-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12560-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12560-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <rppt@linux.vnet.ibm.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 8/8] Documentation for Pmalloc
Date: Tue, 13 Mar 2018 23:45:54 +0200
Message-ID: <20180313214554.28521-9-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180313214554.28521-1-igor.stoppa@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860974339708712?=
X-GMAIL-MSGID: =?utf-8?q?1594860974339708712?=
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
index 000000000000..10e01187d049
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,111 @@
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
+read-only in spirit.
+It protects data from both accidental and malicious overwrites.
+
+Example: A policy that is loaded from userspace.
+
+
+Concept
+-------
+
+pmalloc builds on top of :ref:`genalloc <genalloc>`, using the same
+concept of memory pools.
+
+The value added by pmalloc is that now the memory contained in a pool can
+become read-only, for the rest of the life of the pool.
+
+Different kernel drivers and threads can use different pools, for finer
+control of what becomes read_only and when.
+And for improved lockless concurrency.
+
+
+Caveats
+-------
+
+- To facilitate the conversion of existing code to pmalloc pools, several
+  helper functions are provided, mirroring their k/vmalloc counterparts.
+  In particular, pfree(), which is mostly meant for error paths, when one
+  or more previous allocations must be rolled back.
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
+#. [optional] pre-allocate some memory in the pool
+
+   :c:func:`pmalloc_prealloc`
+
+#. issue one or more allocation requests to the pool with locking as needed
+
+   :c:func:`pmalloc`
+
+   :c:func:`pzalloc`
+
+#. initialize the memory obtained with desired values
+
+#. [optional] iterate over points 3 & 4 as needed
+
+#. write-protect the pool
+
+   :c::func:`pmalloc_protect_pool`
+
+#. use in read-only mode the handles obtained through the allocations
+
+#. [optional] release all the memory allocated
+
+   :c:func:`pfree`
+
+#. [optional, but depends on point 8] destroy the pool
+   :c:func:`pmalloc_destroy_pool`
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
+.. kernel-doc:: mm/pmalloc.c
-- 
2.14.1
