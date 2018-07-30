Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7884220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884220894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG3O1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731700AbeG3O1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6B98AF49;
        Mon, 30 Jul 2018 12:52:52 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 658D3A0BE8; Mon, 30 Jul 2018 14:52:52 +0200 (CEST)
Message-Id: <88ed576173e9cb218e3cb93e9fa20a770aa61b4c.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 02/17] ethtool: move to its own directory
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:52:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ethtool netlink interface, there is going to be a lot of new files
so that it seem more convenient to put them into a separate directory
net/ethtool. Start with moving current file with ioctl implementation
there and renaming it to ioctl.c.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/Makefile                            | 2 +-
 net/core/Makefile                       | 2 +-
 net/ethtool/Makefile                    | 3 +++
 net/{core/ethtool.c => ethtool/ioctl.c} | 0
 4 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 net/ethtool/Makefile
 rename net/{core/ethtool.c => ethtool/ioctl.c} (100%)

diff --git a/net/Makefile b/net/Makefile
index bdaf53925acd..6c68520e5eb9 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_NET)		+= $(tmp-y)
 
 # LLC has to be linked before the files in net/802/
 obj-$(CONFIG_LLC)		+= llc/
-obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/
+obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/ ethtool/
 obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
diff --git a/net/core/Makefile b/net/core/Makefile
index 80175e6a2eb8..55734d0a1603 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -8,7 +8,7 @@ obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_addr_lists.o dst.o netevent.o \
+obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
new file mode 100644
index 000000000000..3ebfab2bca66
--- /dev/null
+++ b/net/ethtool/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y		+= ioctl.o
diff --git a/net/core/ethtool.c b/net/ethtool/ioctl.c
similarity index 100%
rename from net/core/ethtool.c
rename to net/ethtool/ioctl.c
-- 
2.18.0

