Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5086C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308A321A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308A321A00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeHKXUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:20:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47078 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHKXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:20:52 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 89F961435F3F6;
        Sat, 11 Aug 2018 11:20:19 -0700 (PDT)
Date:   Sat, 11 Aug 2018 11:20:14 -0700 (PDT)
Message-Id: <20180811.112014.1000535824675753364.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 11 Aug 2018 11:20:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Last bit of straggler fixes...

1) Fix btf library licensing to LGPL, from Martin KaFai lau.

2) Fix error handling in bpf sockmap code, from Daniel Borkmann.

3) XDP cpumap teardown handling wrt. execution contexts, from
   Jesper Dangaard Brouer.

4) Fix loss of runtime PM on failed vlan add/del, from Ivan
   Khoronzhuk.

5) xen-netfront caches skb_shinfo(skb) across a __pskb_pull_tail()
   call, which potentially changes the skb's data buffer, and thus
   skb_shinfo().  Fix from Juergen Gross.

Please pull, thanks a lot!

The following changes since commit 112cbae26d18e75098d95cc234cfa5059de8d479:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2018-08-09 10:00:15 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to d472b3a6cf63cd31cae1ed61930f07e6cd6671b5:

  xen/netfront: don't cache skb_shinfo() (2018-08-11 09:41:58 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'sockmap-fixes'

Daniel Borkmann (4):
      bpf, sockmap: fix bpf_tcp_sendmsg sock error handling
      bpf, sockmap: fix leak in bpf_tcp_sendmsg wait for mem path
      bpf, sockmap: fix cork timeout for select due to epipe
      Merge branch 'bpf-fix-cpu-and-devmap-teardown'

David S. Miller (2):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'cpsw-runtime-pm-fix'

Ivan Khoronzhuk (2):
      net: ethernet: ti: cpsw: clear all entries when delete vid
      net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan

Jesper Dangaard Brouer (3):
      xdp: fix bug in cpumap teardown code path
      samples/bpf: xdp_redirect_cpu adjustment to reproduce teardown race easier
      xdp: fix bug in devmap teardown code path

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()

Martin KaFai Lau (1):
      bpf: btf: Change tools/lib/bpf/btf to LGPL

 drivers/net/ethernet/ti/cpsw.c             | 25 +++++++++++--------------
 drivers/net/ethernet/ti/cpsw_ale.c         |  2 +-
 drivers/net/xen-netfront.c                 |  8 ++++----
 kernel/bpf/cpumap.c                        | 15 +++++++++------
 kernel/bpf/devmap.c                        | 14 +++++++++-----
 kernel/bpf/sockmap.c                       |  9 ++++++---
 samples/bpf/xdp_redirect_cpu_kern.c        |  2 +-
 samples/bpf/xdp_redirect_cpu_user.c        |  4 ++--
 tools/lib/bpf/btf.c                        |  2 +-
 tools/lib/bpf/btf.h                        |  2 +-
 tools/testing/selftests/bpf/test_sockmap.c |  2 +-
 11 files changed, 46 insertions(+), 39 deletions(-)
