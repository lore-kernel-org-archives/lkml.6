Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356949; cv=none;
        d=google.com; s=arc-20160816;
        b=QT10zi8s9m7bFDMwwH7e0dlqoxqakWRWZ2QOvamjT9hHcV9RsvsW1xM5jzLcYWRTQE
         +5eGZzjDHumYi8JmvS2xNvV8BjI8R4Soaj3kSg4df3SzmAvMj+ERhWeCXlHffnCx/c1c
         TulkWbpC3t2YFhZ2AaeZS3409osIETDL1uA6t+elWaH9YKRysDeAHSKQtXlQnUUwj357
         Xiq/ceCQR/9q6zQtpo2lFvFEz0+kLJ4Z+YCQbaJhlfLON4U/bvPtUopD2f5gqRmIJvWI
         NNjneWaMKLWZEDnKQsaB7+53sEYYcP6U92agrSoONsa963iIHl95vth1bE6WgTw24YZX
         nh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=3iyOCvdTtKCcNI/lruG5bBsgXD2YXzDb9B51QoQdONA=;
        b=jJo7UbjdBhaSAc4pSJakEhUa2WUJRDsM+AfLbM3e+7/s8pw8cVBUBTU4uJGr2rxCey
         8rlzqiPdXdPEaVgMrowl2oxJV49LGd2MC4AQxTfRYvfOqJkrkthQYuUTMp5B6KsduouO
         Jk6zOjK4Lz+bXNyBV5bT5DmAzQAc0Mb4Ex/jhwsDFwgkFg4XV6Sjquz3F5bNEO5Tzfdk
         2vYlWvtVMF1FwHWmYLO/MDl4v3wBL1MpY1FPLY6Fe8uKNWcD5SKKlbJvolYCaDOiJ4nx
         CEjge7vh/0QdEtI+bw28Wm0fQIReoyn1PGygXZ1nX7hRQGqinIFXOpo7OyYXfMIdpHA8
         a4jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HNL7tfGR;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HNL7tfGR;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpUMKviSo9q3U7HtXcB5vYNzMNA6xKRTvKqUylty4bgDSbMUK5dKwetBGk4P8N6EkBT4qoYFw==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 0/6] arm64: untag user pointers passed to the kernel
Date: Thu,  3 May 2018 16:15:38 +0200
Message-Id: <cover.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599452688673669320?=
X-GMAIL-MSGID: =?utf-8?q?1599452688673669320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

This patch makes a few of the kernel interfaces accept tagged user
pointers. The kernel is already able to handle user faults with tagged
pointers and has the untagged_addr macro, which this patchset reuses.

We're not trying to cover all possible ways the kernel accepts user
pointers in one patchset, so this one should be considered as a start.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped “mm, arm64: untag user addresses in memory syscalls”.
- Rebased onto 3eb2ce82 (4.16-rc7).

Andrey Konovalov (6):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arm64: update Documentation/arm64/tagged-pointers.txt

 Documentation/arm64/tagged-pointers.txt |  5 +++--
 arch/arm64/include/asm/uaccess.h        | 14 +++++++++-----
 include/linux/uaccess.h                 |  4 ++++
 lib/strncpy_from_user.c                 |  2 ++
 lib/strnlen_user.c                      |  2 ++
 mm/gup.c                                |  4 ++++
 6 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
