Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeBGMx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:53:27 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33626 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbeBGMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:53:25 -0500
X-Google-Smtp-Source: AH8x224u23pMnlAO3oPlFJszTt/3qsT9iwPocMHzdmEpXlrAScxcMjYfIB5xRf43OK4QwXKcSj3Z3g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ktkhai@virtuozzo.com, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net 0/1 v4] rtnetlink: require unique netns identifier
Date: Wed,  7 Feb 2018 13:53:19 +0100
Message-Id: <20180207125320.9103-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
it is possible for userspace to send us requests with three different
properties to identify a target network namespace. This affects at least
RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
network namespace which is confusing and a potential security liability
given that pids might be recycled while the netlink request is served or
the process might do a setns() It also lets us indicate that network namespace
ids are the preferred way of interacting with network namespaces in rtnetlink
requests. The regression potential is quite minimal since the rtnetlink
requests in question either won't allow IFLA_IF_NETNSID requests before 4.16 is
out (RTM_{NEW,SET}LINK) or don't support IFLA_NET_NS_{PID,FD}
(RTM_{DEL,GET}LINK) in the first place.

Thanks!
Christian

---
ChangeLog v3->v4:
* Based on discussions with Eric and Jiri: disallow passing multiple network
  namespace identifying properties for all requests, i.e. always enforce
  uniqueness.
* disable passing IFLA_NET_NS_{FD,PID} for RTM_{DEL,GET}LINK completely since
  they never supported it
ChangeLog v2->v3:
* Specifying target network namespaces with pids or fds seems racy since the
  process might die and the pid get recycled or the process does a setns() in
  which case the tests would be invalid. So only check whether multiple
  properties are specified and report a helpful error in this case.
ChangeLog v1->v2:
* return errno when the specified network namespace id is invalid
* fill in struct netlink_ext_ack if the network namespace id is invalid
* rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
  indicate that a request without any network namespace identifying attributes
  is also considered valid.
ChangeLog v0->v1:
* report a descriptive error to userspace via struct netlink_ext_ack
* do not fail when multiple properties specifiy the same network namespace
---

Christian Brauner (1):
  rtnetlink: require unique netns identifier

 net/core/rtnetlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

-- 
2.14.1
