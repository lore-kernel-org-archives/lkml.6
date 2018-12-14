Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4075820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4075820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeLNKwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:52:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeLNKwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:52:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CAE23154852;
        Fri, 14 Dec 2018 10:52:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 965A726FB4;
        Fri, 14 Dec 2018 10:52:18 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        Edward Cree <ecree@solarflare.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH net-next v3 0/4] net: mitigate retpoline overhead
Date:   Fri, 14 Dec 2018 11:51:56 +0100
Message-Id: <cover.1544784419.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 14 Dec 2018 10:52:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spectre v2 counter-measures, aka retpolines, are a source of measurable
overhead[1]. We can partially address that when the function pointer refers to
a builtin symbol resorting to a list of tests vs well-known builtin function and
direct calls.

Experimental results show that replacing a single indirect call via
retpoline with several branches and a direct call gives performance gains
even when multiple branches are added - 5 or more, as reported in [2].

This may lead to some uglification around the indirect calls. In netconf 2018
Eric Dumazet described a technique to hide the most relevant part of the needed
boilerplate with some macro help.

This series is a [re-]implementation of such idea, exposing the introduced
helpers in a new header file. They are later leveraged to avoid the indirect
call overhead in the GRO path, when possible.

Overall this gives > 10% performance improvement for UDP GRO benchmark and
smaller but measurable for TCP syn flood.

The added infra can be used in follow-up patches to cope with retpoline overhead
in other points of the networking stack (e.g. at the qdisc layer) and possibly
even in other subsystems.

v2  -> v3:
 - fix build error with CONFIG_IPV6=m

v1  -> v2:
 - list explicitly the builtin function names in INDIRECT_CALL_*(),
   as suggested by Ed Cree
 - expand the recipients list

rfc -> v1:
 - use branch prediction hints, as suggested by Eric

[1] http://vger.kernel.org/netconf2018_files/PaoloAbeni_netconf2018.pdf
[2] https://linuxplumbersconf.org/event/2/contributions/99/attachments/98/117/lpc18_paper_af_xdp_perf-v2.pdf

Paolo Abeni (4):
  indirect call wrappers: helpers to speed-up indirect calls of builtin
  net: use indirect call wrappers at GRO network layer
  net: use indirect call wrappers at GRO transport layer
  udp: use indirect call wrappers for GRO socket lookup

 include/linux/indirect_call_wrapper.h | 51 +++++++++++++++++++++++++++
 include/net/inet_common.h             |  9 +++++
 net/core/dev.c                        | 15 ++++++--
 net/ipv4/af_inet.c                    | 13 +++++--
 net/ipv4/tcp_offload.c                |  6 ++--
 net/ipv4/udp_offload.c                | 15 +++++---
 net/ipv6/ip6_offload.c                | 35 +++++++++++++++---
 net/ipv6/tcpv6_offload.c              |  7 ++--
 net/ipv6/udp_offload.c                |  7 ++--
 9 files changed, 136 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/indirect_call_wrapper.h

-- 
2.19.2

