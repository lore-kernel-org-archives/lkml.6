Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A9C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4683020843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4683020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeJ2LdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:33:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeJ2LdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:33:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 09D6E133FABE5;
        Sun, 28 Oct 2018 19:46:40 -0700 (PDT)
Date:   Sun, 28 Oct 2018 19:46:39 -0700 (PDT)
Message-Id: <20181028.194639.720600183842499774.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Oct 2018 19:46:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) GRO overflow entries are not unlinked properly, resulting in list poison
   pointers being dereferenced.

2) Fix bridge build with ipv6 disabled, from Nikolay Aleksandrov.

3) Direct packet access and other fixes in BPF from Daniel Borkmann.

4) gred_change_table_def() gets passed the wrong pointer, a pointer to
   a set of unparsed attributes instead of the attribute itself.  From
     Jakub Kicinski.

5) Allow macsec device to be brought up even if it's lowerdev is down,
   from Sabrina Dubroca.

Please pull, thanks a lot!

The following changes since commit 345671ea0f9258f410eb057b9ced9cefbbe5dc78:

  Merge branch 'akpm' (patches from Andrew) (2018-10-26 19:33:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 747569b0a7c537d680bc94a988be6caad9960488:

  net: diag: document swapped src/dst in udp_dump_one. (2018-10-28 19:27:21 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'pkt-access-fixes'

Daniel Borkmann (9):
      bpf: fix test suite to enable all unpriv program types
      bpf: disallow direct packet access for unpriv in cg_skb
      bpf: fix direct packet access for flow dissector progs
      bpf: fix cg_skb types to hint access type in may_access_direct_pkt_data
      bpf: fix direct packet write into pop/peek helpers
      bpf: fix leaking uninitialized memory on pop/peek helpers
      bpf: make direct packet write unclone more robust
      bpf: add bpf_jit_limit knob to restrict unpriv allocations
      bpf: fix wrong helper enablement in cgroup local storage

David S. Miller (3):
      Merge git://git.kernel.org/.../bpf/bpf
      net: Properly unlink GRO packets on overflow.
      Merge branch 'macsec-fixes'

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

Lorenzo Colitti (1):
      net: diag: document swapped src/dst in udp_dump_one.

Martin Lau (1):
      bpf, btf: fix a missing check bug in btf_parse

Naresh Kamboju (1):
      selftests/bpf: add config fragments BPF_STREAM_PARSER and XDP_SOCKETS

Nikolay Aleksandrov (1):
      net: bridge: remove ipv6 zero address check in mcast queries

Rasmus Villemoes (1):
      ptp: drop redundant kasprintf() to create worker name

Sabrina Dubroca (2):
      macsec: update operstate when lower device changes
      macsec: let the administrator set UP state even if lowerdev is down

Taehee Yoo (1):
      bpf: devmap: fix wrong interface selection in notifier_call

 Documentation/sysctl/net.txt                |  8 ++++++++
 drivers/net/macsec.c                        | 20 +++++++++++++++++---
 drivers/ptp/ptp_clock.c                     |  6 +-----
 include/linux/filter.h                      |  1 +
 kernel/bpf/btf.c                            | 58 +++++++++++++++++++++++++---------------------------------
 kernel/bpf/core.c                           | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/devmap.c                         |  3 +--
 kernel/bpf/helpers.c                        |  2 --
 kernel/bpf/queue_stack_maps.c               |  2 ++
 kernel/bpf/verifier.c                       | 13 ++++++++++---
 net/bridge/br_multicast.c                   |  3 +--
 net/core/dev.c                              |  2 +-
 net/core/filter.c                           | 21 +++++++++++++++++----
 net/core/sysctl_net_core.c                  | 10 ++++++++--
 net/ipv4/udp_diag.c                         |  1 +
 net/sched/sch_gred.c                        |  2 +-
 tools/testing/selftests/bpf/config          |  2 ++
 tools/testing/selftests/bpf/test_verifier.c | 15 +++++++++++++--
 18 files changed, 155 insertions(+), 63 deletions(-)
