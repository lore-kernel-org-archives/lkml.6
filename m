Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA69C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63920645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A63920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeICI5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:57:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36369 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:57:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so10326507wmj.1;
        Sun, 02 Sep 2018 21:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yjW5BnLnD8Pl4Pzcea+N4HMJEVQUQmk2YMUHH+3N+24=;
        b=dULs5gh6wTsQdgqSk6RyT4ZD8IoQfx+ovYCNREHNFEQs5aXuvRymHzUjhbH89E1FNA
         aacovp9WZM/b0XNih5MgwFJwpsfTIu8LcSkbVM4emHIF94Ic/dmLTyG9xHGYL1bZkq+2
         QD3i0sO1epj4S5NsZltubbVe8I9/drLb0hRt+P8utpTucIId7JTAcpp7XDiLGqxC3GFW
         5Thb/Yi3YiP8PYk0QFg5Lp4OTJBhTu+7pX2hJwCplbuQNYPbv26lCI8Be646qkIL5Dfd
         5sUVhNN1avKEver7bzXpMNL01NQ5qsTUt6qXNkefO4CoQTl77FZ+NKEfCy7AARXPds6E
         E/dA==
X-Gm-Message-State: APzg51ChTgPfYsAE6C8qj1cb5Et0I2bZZu7edb14gdGqPvKLBTF7JP3K
        30xTYdDQYH94fcnuMK8CfvmiEHuUrVg=
X-Google-Smtp-Source: ANB0Vda25IzPXUhlDpcry4+w3dZa2FUMTML2gSI+u2PtMkDG0jdDWq7aGRc7z38Uhpp4dbtYOE547w==
X-Received: by 2002:a1c:1c92:: with SMTP id c140-v6mr3714899wmc.155.1535949518842;
        Sun, 02 Sep 2018 21:38:38 -0700 (PDT)
Received: from localhost.localdomain ([88.128.81.0])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22453364wrj.28.2018.09.02.21.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 21:38:37 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v1 0/5]  rtnetlink: add IFA_IF_NETNSID for RTM_GETADDR
Date:   Mon,  3 Sep 2018 06:37:12 +0200
Message-Id: <20180903043717.20136-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

# v1 introduction:
The only functional change is the export of rtnl_get_net_ns_capable()
which is needed in case ipv6 is built as a module.

Note, I did not change the property name to IFA_TARGET_NSID as there was
no clear agreement what would be preferred. My personal preference is to
keep the IFA_IF_NETNSID name because it aligns naturally with the
IFLA_IF_NETNSID property for RTM_*LINK requests. Jiri seems to prefer
this name too.
However, if there is agreement that another property name makes more
sense I'm happy to send a v2 that changes this.

## Performance:
To test this patchset I performed 1 million getifaddrs() requests
against a network namespace containing 5 interfaces (lo, eth{0-4}). The
first test used a network namespace aware getifaddrs() implementation I
wrote and the second test used the traditional setns() + getifaddrs()
method. The results show that this patchsets allows userspace to cut
retrieval time in half:
1. netns_getifaddrs():      82 microseconds
2. setns() + getifaddrs(): 162 microseconds

# v0 introduction:
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

## Security:
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
 net/core/rtnetlink.c         | 19 +++++++---
 net/ipv4/devinet.c           | 38 +++++++++++++++-----
 net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
 5 files changed, 101 insertions(+), 28 deletions(-)

-- 
2.17.1

