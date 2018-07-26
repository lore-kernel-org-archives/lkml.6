Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E35EC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065D120891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hN9zRJJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065D120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeGZDqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33032 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbeGZDqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so342494edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=8OwQ3Xmo1Hyis0oZJnVT5F94c0nQypAJgT8vpiaO930=;
        b=hN9zRJJzzazAxEhgBRJFBv/9TRVWJ5RIYN0RH/rSIyi2s+QAAAK2HsbOHtylF1iUjD
         1KdfmPK+S6w2L/BaX+pBo28CSf7vFyPevWjrt9yoD9ZWf5CVDUQ/RDRVdymO+FWt8hEZ
         o8Ntqz7pUWLA3nqNqfZEpIRYdY2Y6wZ4n/yLjLr4/J1oabH+AOO8tswHp1gcgBG4Aigu
         6d058PbuJQ20oPzBtnEvMePSPV7oY7b77F2IZ87aeAMJ8KsFfGtChwB/i3/rLuv+WvYR
         0Cd+84SAEfa9+zUlF5562/IJMAyL8nHMaMxV+Etq2VbQifGxz1YUR7AB5oTao6B1Hl7a
         LFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8OwQ3Xmo1Hyis0oZJnVT5F94c0nQypAJgT8vpiaO930=;
        b=RC9iukpDEy5KjmMHJoSiNPKH2f+AEHJd5twXBRywsbbz3kOqvqMJSsKjXCcxexC88x
         yo3XqAjKN5JdT6GuXi0gltkBlp/UyVmrrNp/RwLrRn6h4wyIWCUmoDCrAlDtXqwk+xa0
         Dea9Y4q8NsVh33n/M3unVgZ5jtgAXh86+0iPR+Paf5o9ojTniCJDEPg0Pznh1edgu48f
         XPJjRUqq/gzi0dI/LWQXHwSXeI6VGRXmz6AL8H25RE4gjG0J79n8iCHwd9VdEluddRXt
         aSw4hC5+vyuMek3PoDb8uBFcb26kvytZFAEm9KDYEC3Ots12cNrFCJfwA0K/+T6KtJmn
         OFsw==
X-Gm-Message-State: AOUpUlEwK2iDhmwFb68n9T7G7JDuHmBT6blHQ2rsYFt30rcG0hRFkuJv
        XajTFvzkbQ5AeUxGRj3vAgsqaM6PBAUn7A==
X-Google-Smtp-Source: AAOMgpdsUQxJ8qlbsqC5Uty4W1hRZjrpkWC+d94aGQ+iEh72MiEYVJ7f0VQS/9G0emFG0vwPKOZESQ==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr518405edb.174.1532572306254;
        Wed, 25 Jul 2018 19:31:46 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:45 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Eric Paris <eparis@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paul Moore <paul@paul-moore.com>, coreteam@netfilter.org,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [PATCH 00/18] xfrm: Add compat layer
Date:   Thu, 26 Jul 2018 03:31:26 +0100
Message-Id: <20180726023144.31066-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some historical mistake, xfrm User ABI differ between native and
compatible applications. The difference is in structures paddings and in
the result in the size of netlink messages.
As it's already visible ABI, it cannot be adjusted by packing structures.

Possibility for compatible application to manage xfrm tunnels was
disabled by: the commmit 19d7df69fdb2 ("xfrm: Refuse to insert 32 bit
userspace socket policies on 64 bit systems") and the commit 74005991b78a
("xfrm: Do not parse 32bits compiled xfrm netlink msg on 64bits host").

By some wonderful reasons and brilliant architecture decisions for
creating userspace, on Arista switches we still use 32-bit userspace
with 64-bit kernel. There is slow movement to full 64-bit build, but
it's not yet here. As the switches need support for ipsec tunnels, the
local kernel has reverted mentioned patches that disable xfrm for
compat apps. On the top of that there is a bunch of disgraceful hacks
in userspace to work around the size check for netlink messages
and all that jazz.

It looks like, we're not the only desirable users of compatible xfrm,
there were a couple of attempts to make it work:
https://lkml.org/lkml/2017/1/20/733
https://patchwork.ozlabs.org/patch/44600/
http://netdev.vger.kernel.narkive.com/2Gesykj6/patch-net-next-xfrm-correctly-parse-netlink-msg-from-32bits-ip-command-on-64bits-host

All the discussions end in the conclusion that xfrm should have a full
compatible layer to correctly work with 32-bit applications on 64-bit
kernels:
https://lkml.org/lkml/2017/1/23/413
https://patchwork.ozlabs.org/patch/433279/

In some recent lkml discussion, Linus said that it's worth to fix this
problem and not giving people an excuse to stay on 32-bit kernel:
https://lkml.org/lkml/2018/2/13/752

So, here I add a compatible layer to xfrm.
As xfrm uses netlink notifications, kernel should send them in ABI
format that an application will parse. The proposed solution is
to save the ABI of bind() syscall. The realization detail is
to create kernel-hidden, non visible to userspace netlink groups
for compat applications.

The first two patches simplify ifdeffery, and while I've already submitted
them a while ago, I'm resending them for completeness:
https://lore.kernel.org/lkml/20180717005004.25984-1-dima@arista.com/T/#u

There is also an exhaustive selftest for ipsec tunnels and to check
that kernel parses correctly the structures those differ in size.
It doesn't depend on any library and compat version can be easy
build with: make CFLAGS=-m32 net/ipsec

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org

Dmitry Safonov (18):
  x86/compat: Adjust in_compat_syscall() to generic code under !COMPAT
  compat: Cleanup in_compat_syscall() callers
  selftest/net/xfrm: Add test for ipsec tunnel
  net/xfrm: Add _packed types for compat users
  net/xfrm: Parse userspi_info{,_packed} depending on syscall
  netlink: Do not subscribe to non-existent groups
  netlink: Pass groups pointer to .bind()
  xfrm: Add in-kernel groups for compat notifications
  xfrm: Dump usersa_info in compat/native formats
  xfrm: Send state notifications in compat format too
  xfrm: Add compat support for xfrm_user_expire messages
  xfrm: Add compat support for xfrm_userpolicy_info messages
  xfrm: Add compat support for xfrm_user_acquire messages
  xfrm: Add compat support for xfrm_user_polexpire messages
  xfrm: Check compat acquire listeners in xfrm_is_alive()
  xfrm: Notify compat listeners about policy flush
  xfrm: Notify compat listeners about state flush
  xfrm: Enable compat syscalls

 MAINTAINERS                            |    1 +
 arch/x86/include/asm/compat.h          |    9 +-
 arch/x86/include/asm/ftrace.h          |    4 +-
 arch/x86/kernel/process_64.c           |    4 +-
 arch/x86/kernel/sys_x86_64.c           |   11 +-
 arch/x86/mm/hugetlbpage.c              |    4 +-
 arch/x86/mm/mmap.c                     |    2 +-
 drivers/firmware/efi/efivars.c         |   16 +-
 include/linux/compat.h                 |    4 +-
 include/linux/netlink.h                |    2 +-
 include/net/xfrm.h                     |   14 -
 kernel/audit.c                         |    2 +-
 kernel/time/time.c                     |    2 +-
 net/core/rtnetlink.c                   |   14 +-
 net/core/sock_diag.c                   |   25 +-
 net/netfilter/nfnetlink.c              |   24 +-
 net/netlink/af_netlink.c               |   28 +-
 net/netlink/af_netlink.h               |    4 +-
 net/netlink/genetlink.c                |   26 +-
 net/xfrm/xfrm_state.c                  |    5 -
 net/xfrm/xfrm_user.c                   |  690 ++++++++---
 tools/testing/selftests/net/.gitignore |    1 +
 tools/testing/selftests/net/Makefile   |    1 +
 tools/testing/selftests/net/ipsec.c    | 1987 ++++++++++++++++++++++++++++++++
 24 files changed, 2612 insertions(+), 268 deletions(-)
 create mode 100644 tools/testing/selftests/net/ipsec.c

-- 
2.13.6

