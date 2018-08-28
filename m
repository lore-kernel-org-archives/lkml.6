Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C72087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C72087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeH2DNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:13:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2DNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:13:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so1426872pgp.11;
        Tue, 28 Aug 2018 16:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LYU2OVDgX1SvfjVQEfW+DFMHPbqfV4kObUnyaSgIkPY=;
        b=T7pXsiCnEVzrly2XCm8hl3A0VmWOpfOwUCTgXgWJgIo0Dq0zy4L+jb+q6cKCslnzaM
         tomn8+L5Ua/L9DZ4BOLrAkr1w/aewfJDCMZYExoR5nU2zZvw/t/Ox4eZp405IPb+Xdyt
         v6VKyGNwhhl5+3nvWl4jPQ/QLfzwsaXpjaAm3I/rI35XOU3/AExFx7uUqmQ4qTPABmPM
         ej158myNE0GJ2TqRohlFdwT35AV8mQ9ehc7ROi6cBskamqGb0CF75XHD13Nb5R16wUeI
         PKU1cYO5eOHR6iNXeHC83WC6LT+3JAfWdci2cyG5OtcvWCW0O6OufuV4zOTpm0HiU17N
         +Jpg==
X-Gm-Message-State: APzg51C+T01TSEjynwYACEE8DvCoIIbQQ/KAZQdxy+EMPr/aiwytdzm5
        R8W2qOUnCcNkNMubw61/MwrUSvpU/us=
X-Google-Smtp-Source: ANB0VdbdZs3KueJZdotyGkbdfrLiuH1DlRF2IYSkEggvmgkBgvCfmClBT28hB8KWF3AZeDJzU2z7xw==
X-Received: by 2002:a63:ed4f:: with SMTP id m15-v6mr3417700pgk.147.1535498389099;
        Tue, 28 Aug 2018 16:19:49 -0700 (PDT)
Received: from localhost.localdomain ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id q6-v6sm4217354pgq.19.2018.08.28.16.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:19:48 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for RTM_GETADDR
Date:   Wed, 29 Aug 2018 01:18:54 +0200
Message-Id: <20180828231859.29758-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

A while back we introduced and enabled IFLA_IF_NETNSID in
RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
to signficant performance increases since it allows userspace to avoid
taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
interfaces from the netns associated with the netns_fd. Especially when a
lot of network namespaces are in use, using setns() becomes increasingly
problematic when performance matters.
Usually, RTML_GETLINK requests are followed by RTM_GETADDR requests (cf.
getifaddrs() style functions and friends). But currently, RTM_GETADDR
requests do not support a similar property like IFLA_IF_NETNSID for
RTM_*LINK requests.
This is problematic since userspace can retrieve interfaces from another
network namespace by sending a IFLA_IF_NETNSID property along but
RTM_GETLINK request but is still forced to use the legacy setns() style of
retrieving interfaces in RTM_GETADDR requests.

The goal of this series is to make it possible to perform RTM_GETADDR
requests on different network namespaces. To this end a new IFA_IF_NETNSID
property for RTM_*ADDR requests is introduced. It can be used to send a
network namespace identifier along in RTM_*ADDR requests.  The network
namespace identifier will be used to retrieve the target network namespace
in which the request is supposed to be fulfilled.  This aligns the behavior
of RTM_*ADDR requests with the behavior of RTM_*LINK requests.

Security:
- The caller must have assigned a valid network namespace identifier for
  the target network namespace.
- The caller must have CAP_NET_ADMIN in the owning user namespace of the
  target network namespace.

Thanks!
Christian

[1]: commit 7973bfd8758d ("rtnetlink: remove check for IFLA_IF_NETNSID")
[2]: commit 5bb8ed075428 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK")
[3]: commit b61ad68a9fe8 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK")
[4]: commit c310bfcb6e1b ("rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK")
[5]: commit 7c4f63ba8243 ("rtnetlink: enable IFLA_IF_NETNSID in do_setlink()")

Christian Brauner (5):
  rtnetlink: add rtnl_get_net_ns_capable()
  if_addr: add IFA_IF_NETNSID
  ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
  ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
  rtnetlink: move type calculation out of loop

 include/net/rtnetlink.h      |  1 +
 include/uapi/linux/if_addr.h |  1 +
 net/core/rtnetlink.c         | 15 +++++---
 net/ipv4/devinet.c           | 38 +++++++++++++++-----
 net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
 5 files changed, 97 insertions(+), 28 deletions(-)

-- 
2.17.1

