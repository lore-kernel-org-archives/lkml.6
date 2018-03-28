Return-Path: <kernel-hardening-return-12809-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/ofhPsaCLolpn4yHm1XFZRNCV85AfNSd61McZzDZDxrGwLnqMXiMUQV7MFt8+SG7n9wCb+
ARC-Seal: i=1; a=rsa-sha256; t=1522270664; cv=none;
        d=google.com; s=arc-20160816;
        b=ZBf21zQ9QGr5gM9kCGWs9VNu4dGzmsS99y38uttnMENr/zf45ODAMZTK6XwzesdL9F
         zjBAXMS7YQJ6NFzhtGIjPB3lmWgCsfEvr+aB5bdeu1/vZ6u8M/yyv7c/cDT91rB7/3G1
         DxY5/LfffZbt/HdR8l95OkO2StJwVuQCxp5WbOFGTFlx8fwkVpkfd+98rzLUZOMGGnI0
         +FAd4uuzIB0B7ICJWTs/Rz/PPudY4hD3d1vrMMtKHu0FPyBj2wm2lEhS0hIyr9iOQzWx
         nNKocPc0cNuI9EheuLekBBjP0iaFd+51PqZar/sx4eEHqAl74q6ckn9IlbCiwrwD4RV6
         0aJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=91OTFOqFufCTotqonWnUQCg8nkkDYe/Zvs5ROPnsIi8=;
        b=m6yKKIMa4RwuQ59bhwCJJMNiNCqLN5HzoB2HJQbnsSVL+d9TJ1Nwn860+Z0fZafuWw
         V1EZl36owIpqV5+40NpLTzBtU7tdJwZNHOd77LpI6TCjg9SQVq/vFkt4p0gzA7AnfSEd
         oJn36dzQGDYnqz/mBo2XLJBtWMuowt3ZY4ytLxOgI0T/eyv7RdjVI54FLKaa4d+w/Q0I
         3/fWGa0wpXwEpfznteM6wrDVnL85D2TADCuAHqU+RRNYywfOaMzQtLeLplAcmTk8vjOD
         PpnqnEIpptOzZTAYPk232/tUeLT+f4BfFgmUd57JJMUpScbwkB1lpSGFNEZIvJ3JUYl1
         0HeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12809-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12809-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12809-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12809-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180328205138.301218351@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:38 +0200
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
Subject: [patch 0/8] rslib: Cleanup and VLA removal
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216484886397732?=
X-GMAIL-MSGID: =?utf-8?q?1596216484886397732?=
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

Thanks,

	tglx

8<---------------
 drivers/md/dm-verity-fec.c      |    7 +
 drivers/mtd/nand/cafe_nand.c    |    7 -
 drivers/mtd/nand/diskonchip.c   |   72 ++++++--------
 include/linux/rslib.h           |   46 ++++-----
 lib/reed_solomon/decode_rs.c    |   34 +++---
 lib/reed_solomon/encode_rs.c    |   15 --
 lib/reed_solomon/reed_solomon.c |  203 +++++++++++++++++++++++-----------------
 7 files changed, 209 insertions(+), 175 deletions(-)
