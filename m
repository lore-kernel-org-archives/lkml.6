Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5199206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILrAno4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfBZSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:46:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43484 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so11692610ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ehPWfRVfK1p99dYox//webXUAklCK+7Ufmh1dOaEe+Y=;
        b=ILrAno4mM9tahTLrOcBdadOTIiUxI4PHdflVrHrcckIYitpumxGkRp0rBgo61bX34f
         RfpfYJ4MiLi+xU4iLOcHDcupGxq6AWsYNoBDZwbiZteNManCzuhujW0+na8YZhb2bUZT
         wF+bfMzHbSDPVez+BsPPK+f/OdUfSZOwdsrY6d2gQnrAzAmQU9/6+iWJN1bQfU3QyOtc
         X9dwoVWMzgy503gkboTMMFaX4Hh3bl9fABSvVlMJz7/VAIF04AIYSr1yeVsg4kSkmH19
         5rXh7J32qtAmkPtRyiNxBLVX7ORTwSSzUt0vZKO7wBVJaUljc7QIUgJ7bQ4bQ2vgCmKg
         H0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehPWfRVfK1p99dYox//webXUAklCK+7Ufmh1dOaEe+Y=;
        b=tuFm46kIgbQOcwe5vH2L5c9V/WFqPEbk4D5566C86XyrGSp0ZgeTUud5i2e9nA3m5R
         TBerhtKWyg4x7xHp7S7LaZQEQ1+sy8xEUTWDxYL8ffU3iPNMBaNDtJmtb8HN15PutCQD
         fOfmEXn15Nm+u9XG74TvWdK0XpwFFwPCvwh7y2RrXu4sLW1rAQ5rlkBHgCVTzXnBQqJl
         MXY6BuyzV0NYi9tiV+YFLjnBa/sryry14UBf2TO6r2gjNbn4rA94el9rt3cvKuFM8b3x
         GgdNjPo/UHdOH0FYQtyHjcs3w829M9F68j6c8Zf/WuWkXKFw3UNEu3RgXBUDFV5OxrCn
         gbAg==
X-Gm-Message-State: AHQUAuatmuTwFojoDT2FKFfIHD+K+xCCBR5+SQnJ04b9phoA4M9yXbAI
        atEY3OoXFstGcehJEH01LdX+7A==
X-Google-Smtp-Source: AHgI3Ia4lzOchB5cU6yO1VIBEX1Fqvjnp3CCQGJTZd2DwkO1jDotcuhXPbn9bFWtKH+AdsucFMOQjw==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr14138162ljj.171.1551206788079;
        Tue, 26 Feb 2019 10:46:28 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:27 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/6] net: add individual virtual device filtering
Date:   Tue, 26 Feb 2019 20:45:50 +0200
Message-Id: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
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
including real device. But it not only consumes forwarding table but
also adds holes in the filtering and thus wastes cpus cycles.

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
possible at least for ETH_P_8021Q.

Thus end real device can setup separate tables for virtual devices
just retrieving VID from the address. A device address space can
maintain addresses and references on them separately for each virtual
device if it needs so, or only addresses for real device (and all its
vlans) it holds usually.

A vlan device can be in any place of device chain upper real device,
say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.

This series is verified on TI am572x EVM that can hold separate tables
for vlans. Potentially it can be easily extended to netcp driver for
keystone 2 boards (including k2g) and also new am6 chipsets. As a
simple test case, different combinations of vlan+macvlan, macvlan+vlan
were used and tested as with unicast as multicast addresses.

Based on net-next/master

It's continuation of RFC:

[RFC PATCH net-next 0/5] net: allow hw addresses for virtual device
https://lkml.org/lkml/2018/12/3/817

Ivan Khoronzhuk (6):
  net: core: dev_addr_lists: add VID to device address
  net: 8021q: vlan_dev: add vid tag to addresses of uc and mc lists
  net: 8021q: vlan_dev: add vid tag for vlan device own address
  ethernet: eth: add default vid len for all ehternet kind devices
  net: ethernet: ti: cpsw: update mc filtering to use IVDF
  net: ethernet: ti: cpsw: add macvlan and ucast/vlan filtering support

 drivers/net/ethernet/ti/Kconfig |   1 +
 drivers/net/ethernet/ti/cpsw.c  | 139 ++++++++++++--------------------
 include/linux/if_vlan.h         |   2 +
 include/linux/netdevice.h       |   4 +
 net/8021q/Kconfig               |  12 +++
 net/8021q/vlan.c                |   3 +
 net/8021q/vlan.h                |   2 +
 net/8021q/vlan_core.c           |  25 ++++++
 net/8021q/vlan_dev.c            | 103 ++++++++++++++++++-----
 net/core/dev_addr_lists.c       | 124 ++++++++++++++++++++++------
 net/ethernet/eth.c              |  10 ++-
 11 files changed, 292 insertions(+), 133 deletions(-)

-- 
2.17.1

