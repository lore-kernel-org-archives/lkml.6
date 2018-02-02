Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBBIvi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:51:38 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54538 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBBIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:51:31 -0500
X-Google-Smtp-Source: AH8x224Ws/8SADp4gyOef6ppkrmEBVXoyQENJrDYu+l9wjV6V3ajOrfjOZpcBJUi5TsL+W8141Craw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC net 0/1] rtnetlink: require unique netns identifier
Date: Fri,  2 Feb 2018 09:51:14 +0100
Message-Id: <20180202085115.17229-1-christian.brauner@ubuntu.com>
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
support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place. But
maybe I'm missing a reason for allowing multiple properties in the request.

We obviously cannot prevent users from passing both IFLA_NET_NS_PID and
IFLA_NET_NS_FD since we have supported this somehow for a long time. So
the check I'm proposing is to only fail when both IFLA_IF_NETNSID, and
IFLA_NET_NS_PID or IFLA_NET_NS_FD are passed.

Thanks!
Christian

Christian Brauner (1):
  rtnetlink: require unique netns identifier

 net/core/rtnetlink.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.14.1
