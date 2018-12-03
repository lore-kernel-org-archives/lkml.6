Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB095214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDRRlZaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB095214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLCSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:40:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35457 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeLCSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so12400832ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BZ9iVtgfumTNyGHYF7vOFWkRy7zAbgfZ8HuzTojYHSk=;
        b=PDRRlZazZ+MdMIGNdoqMqNlx8BKgWftSoAmgBH6yuz3hgveO4jVAWljN60ubGbkFYI
         wmzNDkSshsrivb0QuBoGZd5slCvxHcC/aRddP9UvQsvkjdO4Nz/+1Z1iD2Iyp1TUVn0o
         mCxUSLvrGzr2l0vtLpox3+pb+HikpUeiw9PbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BZ9iVtgfumTNyGHYF7vOFWkRy7zAbgfZ8HuzTojYHSk=;
        b=BvlVavvvZ1DmSeJ2s/IrHXnumVQZJa+vzhphyF7jEA0TdzYgWsyODurbhG7X63CSha
         lwmkIqUI7ER3HVkcCdwnfY7iAb1DYIBGNGA0bpMY+LFrTK3zeoKTj+yBzVvGLEdu41lA
         EKRmqJPax736NGu/889p/injcWDaGTZtcCg1t7voTUNpkIVX7lrk4I1SM5J1pEEZWCVC
         mQ0M1elTR6uXGYQd7qb5y2NbU8oAC1meLM5xntaXUtcYGpUz1K6VzMzlrCLCQA51nNTy
         tgi7jbf5LIeYaA3HtedXf25j6Y78+r2PlhQWs0iIKOL0sgKFuFRdeIHyBBj4irr/5/75
         tpag==
X-Gm-Message-State: AA+aEWbusBO6O26Xuqdy22mM5MNmL8Q6Dsbo3zcc02mNWVG6obtEwnqb
        ecVmGJwgXM4EM/6mpkeJKsZdxw==
X-Google-Smtp-Source: AFSGD/Xb1VoijAc0OsGPd1Go+8sTpCtBCVRb6ZGO6CzOLk1nMLUffOJ7ZFXwRrk546y9kWjWnSbnCA==
X-Received: by 2002:a2e:8702:: with SMTP id m2-v6mr10439499lji.132.1543862427864;
        Mon, 03 Dec 2018 10:40:27 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:27 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 0/5] net: allow hw addresses for virtual devices
Date:   Mon,  3 Dec 2018 20:40:18 +0200
Message-Id: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the reasons of this proposition is safety and performance -
host should not receive traffic which is not designated for it.

Some network devices can hold separate address tables for vlans and
real device, but for some reason there is no possibility to apply it
with generic net addressing scheme easily. At this moment the fastest
solution is to add mcast/ucast entries for every created vlan
including real device. But it also adds holes in the filtering and
thus wastes cpus cycles.

This patchseries tries to correct core to assign mcast and ucast
addresses only for vlans that really require it and as result an end
driver can exclusively and simply set its rx filters. As an example
it's implemented on cpsw TI driver, but generic changes provided by
this series can be reused by other ethernet drivers having similar
rx filter address possibilities.

An address+vid is considered as separate address. The reserved device
address length is 32 Bytes, for ethernet devices it's additional
opportunity to pass auxiliary address info, like virtual ID
identifying a device the address belongs to. This series makes it
possible at least for ETH_P_8021Q, but can be easily extended for ab.
Thus end real device can setup separate tables for virtual devices
just retrieving VID from the address. A device address space can
maintain addresses and references on them separately for each virtual
device if it needs so, or only addresses for real device (and all its
vlans) it holds usually.

A vlan device can be in any place of device chain upper real device,
say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.
Similar approach can be used for passing additional information for
virtual devices as allmulti flag or/and promisc flag and do this per
vlan, but this is separate story and could be added as a continuation.

I was biased by try to add exclusive mcast and ucast support for vlans
and now have same with small generic correction and mostly locally in
the cpsw driver:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=mcast_vlan
and can say it looks better with generic changes provided by this patchset,
that's why this RFC. Above links can be used as fallback.

This series is verified on TI am572x EVM that can hold separate tables
for vlans. Potentially it can be easily extended to netcp driver for
keystone 2 boards (including k2g) and also new am6 chipsets. As a
simple test case, different combinations of vlan+macvlan, macvlan+vlan
were used and tested as with unicast as multicast addresses.

Based on net-next/master

Ivan Khoronzhuk (5):
  net: core: dev_addr_lists: add VID to device address space
  net: 8021q: vlan_dev: add vid tag for uc and mc address lists
  net: 8021q: vlan_dev: add vid tag for vlan device mac address
  net: ethernet: add default vid len for all ehternet kind devices
  net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based
    on addr vids

 drivers/net/ethernet/ti/cpsw.c |  86 +++++++++++++++++++----
 include/linux/if_vlan.h        |   1 +
 include/linux/netdevice.h      |   7 ++
 net/8021q/vlan.c               |   3 +
 net/8021q/vlan_core.c          |  10 +++
 net/8021q/vlan_dev.c           | 103 ++++++++++++++++++++++-----
 net/core/dev_addr_lists.c      | 124 +++++++++++++++++++++++++++------
 net/ethernet/eth.c             |  15 +++-
 8 files changed, 290 insertions(+), 59 deletions(-)

-- 
2.17.1

