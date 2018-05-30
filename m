Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeE3L2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:28:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60969 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752510AbeE3LHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:06 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Xiong Zhou" <xzhou@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.897877604@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 084/153] bridge: check brport attr show in brport_show
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 1b12580af1d0677c3c3a19e35bfe5d59b03f737f upstream.

Now br_sysfs_if file flush doesn't have attr show. To read it will
cause kernel panic after users chmod u+r this file.

Xiong found this issue when running the commands:

  ip link add br0 type bridge
  ip link add type veth
  ip link set veth0 master br0
  chmod u+r /sys/devices/virtual/net/veth0/brport/flush
  timeout 3 cat /sys/devices/virtual/net/veth0/brport/flush

kernel crashed with NULL a pointer dereference call trace.

This patch is to fix it by return -EINVAL when brport_attr->show
is null, just the same as the check for brport_attr->store in
brport_store().

Fixes: 9cf637473c85 ("bridge: add sysfs hook to flush forwarding table")
Reported-by: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/br_sysfs_if.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -196,6 +196,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute * brport_attr = to_brport_attr(attr);
 	struct net_bridge_port * p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
