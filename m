Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C60C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7186B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeIEAUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46849 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeIEAUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so5145523wrc.13;
        Tue, 04 Sep 2018 12:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YU5inJWMmbMCXdTNDIqzPqfvHUAU455LE3LFjnsKARE=;
        b=HyjH++wisgJo3o4cOHrV6ah8ifzyk3SE5XMEGa7cOtIdntPHMU4RYJkGZYDxvIeUWA
         IKSGMR9CNwhn7h8ru0LOQFPvEYjF5nlBcc38hZFjAr5mMqH8f2gCphkT1X3Wi0HybCii
         UDtV7YxSWlLdP3bmkGWBoirT4tGbRMnYnDwA/QowHP49PnYmSA+nJsjNZFCN3mCVgnu1
         oRoZuvreMMVesqwQNwyhXPJ4lgeZmLEkStqJMboeIAGBBOvFr5GfzZlv5Aj9ypgvwPuq
         6geMlxOsoW+EjTG3rBf114D/aoIkbNQ06jxElw217JTrU8ezeXQb2yA1JwXBIHt+vaOM
         2wjQ==
X-Gm-Message-State: APzg51AS1N9cKV7bq9DHIgviIBq5xaCeisV5n76h8B6WIwh9wS7YJH4s
        KZwRVFrKpXUaCFrNs4b70okNIokyGtA9fA==
X-Google-Smtp-Source: ANB0VdbWRkPWqhS9BIFroJVwbH0HrmHWATWOHA1y3IH3MLQXBhn2B0CUj/NoiwasnJxY5REW4aDdHQ==
X-Received: by 2002:adf:e1c5:: with SMTP id l5-v6mr23810562wri.36.1536090848465;
        Tue, 04 Sep 2018 12:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:07 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 0/9] rtnetlink: add IFA_TARGET_NETNSID for RTM_GETADDR
Date:   Tue,  4 Sep 2018 21:53:46 +0200
Message-Id: <20180904195355.4695-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

# v2 introduction:
This iteration should mainly addresses the suggestion to use
IFA_TARGET_NETNSID as the property name. Additionally, an an alias for
the already existing IFLA_IF_NETNSID property is added.

Note that two additional cleanup patches (8\9 and 9\9) were added to
address concerns raised that passing more than 6 arguments to a function
will cause additional variables to be pushed onto the stack instead of
being placed into registers. The way I addressed this is by introducing
two new struct inet{6}_fill_args that are used to pass common
information down to inet{6}_fill_if*() functions shortening all those
functions to three pointer arguments.
If this is something more people than Kirill find useful they can be
kept if not they can simply be dropped in later iterations of this
series or when merging.

Here is a short overview:
1. Rename from IFA_IF_NETNSID to IFA_TARGET_NETNSID.
2. Add IFLA_TARGET_NETNSID as an alias for IFA_IFLA_NETNSID and switch
   all occurrences over to the new alias.
3. Add inet4_fill_args struct to avoid passing more than 6 arguments in
   inet_fill_if*() functions.
4. Add inet6_fill_args struct to avoid passing more than 6 arguments in
   inet_fill_if*() functions.

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

Christian Brauner (9):
  rtnetlink: add rtnl_get_net_ns_capable()
  if_addr: add IFA_TARGET_NETNSID
  ipv4: enable IFA_TARGET_NETNSID for RTM_GETADDR
  ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR
  rtnetlink: move type calculation out of loop
  if_link: add IFLA_TARGET_NETNSID alias
  rtnetlink: s/IFLA_IF_NETNSID/IFLA_TARGET_NETNSID/g
  ipv4: add inet_fill_args
  ipv6: add inet6_fill_args

 include/net/rtnetlink.h            |   1 +
 include/uapi/linux/if_addr.h       |   1 +
 include/uapi/linux/if_link.h       |   1 +
 net/core/rtnetlink.c               |  51 +++++++-----
 net/ipv4/devinet.c                 |  62 +++++++++++---
 net/ipv6/addrconf.c                | 126 ++++++++++++++++++++++-------
 tools/include/uapi/linux/if_link.h |   1 +
 7 files changed, 180 insertions(+), 63 deletions(-)

-- 
2.17.1

