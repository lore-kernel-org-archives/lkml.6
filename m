Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524077599; cv=none;
        d=google.com; s=arc-20160816;
        b=MAtK2m8OTSaJK51Ej2cSqpOyV6YPD6/rSB2Ai3u8FXBmhzA2TgpYZp9dLIpNhQxn3f
         7MGSwX696BfAXBfDBIh7/yjtshnTmERRrRpGs1j4+iqRTbNXXXnNwjqcY6y2ARZ/rfrP
         ifWzjrrUxuQKkL4hRI9tu7134wesRBp/khBDJ4T/Pl+2zYWyiBsCmMGVBPzx4kY6GU4/
         Yr9+e7yRYfx14jK9IDfS0H7zGn7CVBTAUfMvhZQXAdbBAsIzPFG/ukSN4pNGVq3FClV+
         FYpePsRDYlfJQxrQzOp3VKxhgNr7DAZw0p5jli515i2UMEboI1Fq75aPPM2vJqO6Uxyz
         bqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=7RbYRjt69tDEpy+vWZXzyqltjJ/uyZiyhZDraggalvg=;
        b=NiK1g18eEmT9/29CvKi/1jcRqc61lVeFQDO6Sk0X5gIFTbyFbeYtUTY4bMezVNQ6AP
         F+lHcFG8vEM/qdjE5uuubMY17agj5/4BZ/wBkHcQRP9bHZjQeslZmBmd2bJPhTLCnfXk
         t1fXskNYX3ngBNJd/FoOc37wQK/WpJL8t+Qb4kH0QZ1EmN2djOFjtPSYqKP1Yr0AeH0r
         Fia/t0ar/bl4wE0GHPcxluTZ19Xx6hSZa5BRxqgrR5R9WHSqTQ/yFMbQYKqZxATcAwHN
         yyGHO7cZkJuK5CfTC9zZlp1CiofKgONGThWLe2wZ527qCqLrm/ddEQf/V8kkyqQ+1/lk
         45/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gBtFM6M2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gBtFM6M2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48v1t8uDLx8x9iExEZdSV70Stoxh6OPe3BFcQ9AMr7QyfHDmI7KMTL8VLbGhoPCN0PtEixPMQ==
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
Subject: [PATCH 0/6] arm64: untag user pointers passed to the kernel
Date: Wed, 18 Apr 2018 20:53:09 +0200
Message-Id: <cover.1524077494.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111192269135822?=
X-GMAIL-MSGID: =?utf-8?q?1598111192269135822?=
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
2.17.0.484.g0c8726318c-goog
