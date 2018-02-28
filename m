Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELsy6jlGAOmBWRAb5e/21YppIYu4lDjvHh2YUPQ+RS1mF+vZgQik9aOAf8e4feNlM1k7Du5V
ARC-Seal: i=1; a=rsa-sha256; t=1519842559; cv=none;
        d=google.com; s=arc-20160816;
        b=UvPJPQGpPPsfWJC9zIoOuBbVCbpObV9QKAH6mosFq3Ss2qxAex4Fn9S2rWjX6ujc8g
         rBthUNbk2T+X9gntHGOl+hr6maPCBR5N8J6LtHR+d0ohn10T+o6IZX9eCT3+DpU3sx5B
         L8Qf6wb9Kjs6w2b2LcmOK8UYeZK/Fe52Vp6l1c1Kg9shlsSqA6mY/BupPZXRfyM+tkwK
         ZT5wWJ+SArSFCXZj6QHbP3sdw5Ir12+XCR2oHn9R1lMqXdAyFnO0OAhVWf0/1xbiyyMv
         EMDXNwK9lTeqn1Jvp2vpoZCb27lS2uqTPONQ9ShM6G2zqcTrU8KVTqhen5Jy0DAW1K07
         J0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7moUHX3J4/0L6dZCoDIUvLelICVhrrepZgKgsg62xQM=;
        b=MbbGk3/u1cNEaiAJZSSgADGjMgVmxNhHwRqK0E2gCwrZyYmpT9rc4BXgRtnJS8+sPl
         /44xbe0VeeSrQbbw8ySp4PZFyCUKDPgNQhtaEtWMVUdBUmTnU9AtqL6dz4I2/w74/jRn
         +VpFnPfE2ppw5v9wRC+fst+bilAq9OdEjJRaWHB1XsyGLS0rWtxjJqTRfvD7wRpS4xbw
         /2opWisSxr/nExyvz2rx3Xfa+1kPavtmxoCH9N0H4NVsor/WCsHhtQNdAFqo2yRzgY9j
         OSg3MfwHtKLE93ApDwrXGcrmSlEvD/m//5faXSEybsN7KelITsUide3uZYdUGf9Spsgj
         +DEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RisWyX2n;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RisWyX2n;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, maran.wilson@oracle.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: [RFC PATCH v4 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date: Wed, 28 Feb 2018 10:27:56 -0800
Message-Id: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431489579630?=
X-GMAIL-MSGID: =?utf-8?q?1593670431489579630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sorry for the delay between this version and the last -- it was mostly
due to holidays and everyone being focused on security bug mitigation
issues. Here are the links to the previous email threads in case it is
helpful:

V3: https://lkml.org/lkml/2017/12/12/1230
V2: https://lkml.org/lkml/2017/12/7/1624
V1: https://lkml.org/lkml/2017/11/28/1280

Changes from v3:

 * Implemented Juergen's suggestion for refactoring and moving the PVH
   code so that CONFIG_XEN is no longer required for booting KVM guests
   via the PVH entry point.
   Functionally, nothing has changed from V3 really, but the patches
   look completely different now because of all the code movement and
   refactoring. Some of these patches can be combined, but I've left
   them very small in some cases to make the refactoring and code
   movement easier to review.
   My approach for refactoring has been to create a PVH entry layer that
   still has understanding and knowledge about Xen vs non-Xen guest types
   so that it can make run time decisions to handle either case, as
   opposed to going all the way and re-writing it to be a completely
   hypervisor agnostic and architecturally pure layer that is separate
   from guest type details. The latter seemed a bit overkill in this
   situation. And I've handled the complexity of having to support
   Qemu/KVM boot of kernels compiled with or without CONFIG_XEN via a
   pair of xen specific __weak routines that can be overridden in kernels
   that support Xen guests. Importantly, the __weak routines are for
   xen specific code only (not generic "guest type" specific code) so
   there is no clashing between xen version of the strong routine and,
   say, a KVM version of the same routine. But I'm sure there are many
   ways to skin this cat, so I'm open to alternate suggestions if there
   is a compelling reason for not using __weak in this situation.

Changes from v2:

 * All structures (including memory map table entries) are padded and
   aligned to an 8 byte boundary.

 * Removed the "packed" attributes and made changes to comments as
   suggested by Jan.

Changes from v1:

 * Adopted Paolo's suggestion for defining a v2 PVH ABI that includes the
   e820 map instead of using the second module entry to pass the table.

 * Cleaned things up a bit to reduce the number of xen vs non-xen special
   cases.

Maran Wilson (7):
      xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
      xen/pvh: Move PVH entry code out of Xen specific tree
      xen/pvh: Create a new file for Xen specific PVH code
      xen/pvh: Move Xen specific PVH VM initialization out of common code
      xen/pvh: Move Xen code for getting mem map via hcall out of common file
      xen/pvh: Add memory map pointer to hvm_start_info struct
      KVM: x86: Allow Qemu/KVM to use PVH entry point

 MAINTAINERS                            |   1 +
 arch/x86/Kbuild                        |   3 +
 arch/x86/Kconfig                       |   8 ++
 arch/x86/kernel/head_64.S              |   4 +-
 arch/x86/pvh-head.S                    | 161 +++++++++++++++++++++++
 arch/x86/pvh.c                         | 130 ++++++++++++++++++
 arch/x86/xen/Kconfig                   |   3 +-
 arch/x86/xen/Makefile                  |   1 -
 arch/x86/xen/enlighten_pvh.c           |  87 +++---------
 arch/x86/xen/xen-pvh.S                 | 161 -----------------------
 include/xen/interface/hvm/start_info.h |  50 ++++++-
 11 files changed, 374 insertions(+), 235 deletions(-)
