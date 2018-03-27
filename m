Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169867; cv=none;
        d=google.com; s=arc-20160816;
        b=m7jFOzha2lrJ1KjKLN1Qw0JTvtpKltpqvsxiGt0cxDMp4VyBV/sVAV5OvYmVktjFKa
         HYCmyuvh8QbMzFWBvSGp1wlm9RcAT4sqNhK6VX2Sf59em3dqwX++UdIo/3b8vpdZGfMY
         mo6B4xDt6tAe5aSeYvOIDaOch8sO9l45lQu4UknpH3QBJn/jZNMQ8UWeBtHSBozRhamI
         3Y41roEP7X9N79w9CX3rChdnLZL57GRJROlM1V0zLVtE6nQYdJPkO8al6sc6eJSO4gJ/
         wfpugYC+4/UaOeJ2F/s886DIdpcCVC+LFu6THqWjINXsqcj69jVTcv2eksIHSuZxNWlj
         6CLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=2unNROHG+8feIGotHXszhTuGPmpRY6bXBkim4UFPTaQ=;
        b=lkaF2cF5YsViKAD2P3WrJSQV11FU3alLFRu2oKDXWD+awaTxDlQRGj8s1m47TB3EOO
         xwoOEIRsqyQsCjrV+Tz4eP3CGNAtbg2xn+HsdpRP9GW9VLo8fh2lzwSU8Ggnx1FaKmHh
         dDxJXdTRLTmvV8g9ClH1AUticEYpJRRJBNRub9yDdAWRZ+YXGVdw8dGU34wWoRQyRbB5
         314CPAABZchHWfjOuOkevxuRx0mTq/ZUspjk3laGpJYngdOU/qqbsUd4Bga/OxL2p7Sn
         qigb16ipSEc3UCx2Md4VfmyPirtqJDeWxqT2xbTxo2zrpGAq2m3+PUezwTDdbJNCZrrx
         QR5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SXjhznol;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SXjhznol;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+SqilrH2teukLBq3OM04gQK/o6scnPl5VTqxM3lBxwZh4twkUP46cBr9jr5WdaxdB1/7zZTw==
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
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [RFC PATCH v2 0/6] arm64: untag user pointers passed to the kernel
Date: Tue, 27 Mar 2018 18:57:36 +0200
Message-Id: <cover.1522169685.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596110790501719687?=
X-GMAIL-MSGID: =?utf-8?q?1596110790501719687?=
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

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped “mm, arm64: untag user addresses in memory syscalls”.
- Rebased onto 3eb2ce82 (4.16-rc7).

Andrey Konovalov (6):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in copy_from_user and others
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arm64: update Documentation/arm64/tagged-pointers.txt

 Documentation/arm64/tagged-pointers.txt |  5 +++--
 arch/arm64/include/asm/uaccess.h        |  9 +++++++--
 include/linux/uaccess.h                 |  4 ++++
 lib/strncpy_from_user.c                 |  2 ++
 lib/strnlen_user.c                      |  2 ++
 mm/gup.c                                | 12 ++++++++++++
 6 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.17.0.rc0.231.g781580f067-goog
