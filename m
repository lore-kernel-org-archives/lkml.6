Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeBEQAI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:00:08 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40166 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:00:00 -0500
X-Google-Smtp-Source: AH8x227DoqX2J6U4bdBtjqfqHDXU34waFdMvo52Hirr5OEEeL31lyN0TXnptI+faZTvMRl7PXjVPdg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net 0/1 v2] rtnetlink: require unique netns identifier
Date: Mon,  5 Feb 2018 16:55:49 +0100
Message-Id: <20180205155550.21432-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
it is possible for userspace to send us requests with three different
properties to identify a target network namespace. This affects at least
RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
network namespace which is confusing. For legacy reasons the kernel will
pick the IFLA_NET_NS_PID property first and then look for the
IFLA_NET_NS_FD property but there is no reason to extend this type of
behavior to network namespace ids. The regression potential is quite
minimal since the rtnetlink requests in question either won't allow
IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.

We obviously cannot prevent users from passing both IFLA_NET_NS_PID and
IFLA_NET_NS_FD since we have supported this somehow for a long time. So
the check I'm proposing is to only fail when both IFLA_IF_NETNSID, and
IFLA_NET_NS_PID or IFLA_NET_NS_FD are passed and they refer to different
network namespaces.

Thanks!
Christian

ChangeLog v1->v2:
* return errno when the specified network namespace id is invalid
* fill in struct netlink_ext_ack if the network namespace id is invalid
* rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
  indicate that a request without any network namespace identifying attributes
  is also considered valid.

ChangeLog v0->v1:
* report a descriptive error to userspace via struct netlink_ext_ack
* do not fail when multiple properties specifiy the same network namespace

Christian Brauner (1):
  rtnetlink: require unique netns identifier

 net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

-- 
2.14.1
