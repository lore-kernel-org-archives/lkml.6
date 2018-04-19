Return-Path: <kernel-hardening-return-13051-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49XpZ2kx/qZfWNJbdhqRdaBoVijp34FPOq5E6YkEuKuOjHvpcVCbGiWiT1wUc6kL24OKObE
ARC-Seal: i=1; a=rsa-sha256; t=1524132647; cv=none;
        d=google.com; s=arc-20160816;
        b=rGuCzsMcHAeYf+TUBSU6a2sNgdThkwxlfss6ezoU1vtstbAUeE5ik2mKRw8GU32aUz
         eQ/WLxfN2Om1Y584Gj0ikW07up+6heg+VzqF25BW53kHKo3FpvQXGjiwBlzu0Je0W/fV
         VdxVXB7XlH0ASsMvUXkxMKAf7c4xPgQ1gwL36jrXJM0eW/hfiru9Gz0s+Qd+UAgpf72w
         wm6KpH/j7wLHwYCbv0N1mSD8ob2MgMREyyG2f3Q3Ix+ZvaxekV7Dt2A/aD/nLi7BZ5TT
         Tj/gcPyuu8GISn10mSFfmi1U6j5ShUnirCXyb8OdKm1prYUuqA4LxdmGNVWmeuoZg9u0
         QH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=NPN7+RYHAufAceInr0Btq9ljNFwiz+RrblPczx++tCo=;
        b=F8fkZtVwq3Fnga3vbUOezTdEKdqMr/+KhJFgiCAWKVkpH9nIoJfWy+OWBoLRxIMtwV
         RZdpRXXj0eKFzS9kB2esrWMnCWxwggf3n63Y7FBvvJHID5b6khTnAxPIWtBP9kZC2iHh
         NqGUsroAy8tBfUCEznfFgqEkVH9nv1faXxNvX9mEO/xtGjS6ukrfbD8OgubTcHEkVjXY
         7DMR+mZT1jhzy8XcKMiGSVUJFtPt5S6JSySqeP7x49znqexvXvogHvr4fJFdXfL45Xc9
         JdYZmvC0V8Gmxa1eNKEcLBrKQ0WfH7fsMTCS2fvVk+A268nuOyX7Z1LgR5WJfWs6Nf1J
         71Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13051-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13051-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13051-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13051-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180419100441.548834519@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:41 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch V2 0/8] rslib: Cleanup and VLA removal
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168914949440380?=
X-GMAIL-MSGID: =?utf-8?q?1598168914949440380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kees tried to get rid of the Variable Length Arrays in the Reed-Solomon
library by replacing them with fixed length arrays on stack. Though they
are rather large and Andrew did not fall in love with that solution.

This series addresses that in a different way by splitting the rs control
structure up, so that each invocation of rs_init() returns a new instance
in which the decoder buffers are allocated. The polynom tables which build
the base for the RS codecs are still shareable between the instances to
avoid large allocations and initializations of the same data over and over.

The usage sites have been audited and fixed up where necessary to
accomodate the decoder change which forbids parallel decoder invocation for
a particular rs control instance to prevent buffer corruption.

While at it the patch set tidies up the code and converts the related files
over to use SPDX license identifiers.

Changes since V1:

   Simplify error path in the diskonchip code and use the proper
   function to free the decoder.

As this spawns multiple subsystems it should either go through Andrews tree
or Kees can route it with his other hardening stuff.

Thanks,

        tglx

8<---------------
 drivers/md/dm-verity-fec.c        |    7 +
 drivers/mtd/nand/raw/cafe_nand.c  |    7 -
 drivers/mtd/nand/raw/diskonchip.c |   67 +++++-------
 include/linux/rslib.h             |   46 ++++----
 lib/reed_solomon/decode_rs.c      |   34 +++---
 lib/reed_solomon/encode_rs.c      |   15 --
 lib/reed_solomon/reed_solomon.c   |  203 ++++++++++++++++++++++----------------
 7 files changed, 205 insertions(+), 174 deletions(-)
