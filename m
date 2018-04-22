Return-Path: <kernel-hardening-return-13081-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqIQ9aK4NK1W+Jgwf8ZetkmcArljBkNj2YjZ+ARX3NagdMa0I0KX+ObzF9EkIJQmlpjv/iG
ARC-Seal: i=1; a=rsa-sha256; t=1524414752; cv=none;
        d=google.com; s=arc-20160816;
        b=c0ov+K0nqvXuiaOk9LEbOKeML5mje+YaDi379a6T0vy0hHyDM7lpR6u2xPLCTzZqwL
         fOLPDujvdJpJE6G5rEIxu+uIHdkOQ1t2OaB/cexYbj5zasgBsjxlkQ2BsGfCErIz1DBi
         ecGctAC2ib0XjnK1gWYAeYx7kDf4G6ds5fUYDykep4zvOyOfZmQpMW6gf3b4HhJrKiyF
         UrxRUqB1AOVy2urFI5mdj62MqVBvB9pdny7qLeeegcw2ZgnNpRixGDwlpCvXVrQls5R2
         ZF8QL67U1Jq5MEvMlXdLsu5OvnhzDI8o5rpznH3b3jwzn3tuV2ZNK54C21RcBorkdMHI
         pQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Krv/D7SloV2cYwVf2ix4WpJsC7yVJXf32Y28QHwQ1ig=;
        b=03viKnbOS+tNRdgFdbDdchXIa2mdhnJOaGjy7n11Vd4gvGkwKwhU+pD7hAFJYPHl39
         ZsNlnaX/nXtxQE26yHsFkMiT3SLzfshb7kxQICsMomwX7cr8wSC6OvhgFJMk7no5JdXw
         i4xGNQg73LxL9xULiKV6gvm/ksmxW7RfgaPlVmjOzfF/SaOZzKxN5rzNVDyqnW/Rwsht
         uT7zkuh03vopjuEErrbOrWPJwZUV/Nbaaf9admncTnzeKQrifBoCAV4nKnD5qY74Zs6w
         tC1jX9BxmNSd/ha/YJk6AJYY4PL8sd6SjFsjMJJ9ywoyMu8URtzZKid8DDffPympJYtu
         4prQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13081-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13081-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13081-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13081-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162345.004292133@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:45 +0200
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
Subject: [patch V3 00/10] rslib: Cleanup and VLA removal
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464722856567628?=
X-GMAIL-MSGID: =?utf-8?q?1598464722856567628?=
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

Changes since V2:

   Provide a gfp aware variant of init_rs and use it in the alloc callback
   of the dm/verity_fec rs_pool mempool allocations

   Picked up Reviewed/Acked-by tags and fixed the subject line for the MTD
   specific patch.

Changes since V1:

   Simplify error path in the diskonchip code and use the proper
   function to free the decoder.

As this spawns multiple subsystems it should either go through Andrews tree
or Kees can route it with his other hardening stuff.

Thanks,

        tglx

8<---------------
 drivers/md/dm-verity-fec.c        |    2 
 drivers/mtd/nand/raw/cafe_nand.c  |    7 -
 drivers/mtd/nand/raw/diskonchip.c |   67 +++++-----
 include/linux/rslib.h             |   71 +++++++----
 lib/reed_solomon/decode_rs.c      |   34 ++---
 lib/reed_solomon/encode_rs.c      |   15 --
 lib/reed_solomon/reed_solomon.c   |  233 ++++++++++++++++++++++----------------
 7 files changed, 237 insertions(+), 192 deletions(-)
