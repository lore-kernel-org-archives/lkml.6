Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A142C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0708821471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgzpuwVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0708821471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJQCMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:12:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46644 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJQCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:12:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3-v6so21824851lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0hJSCJb1LP0ObcdLd4/9veYEjRQvXzCQb4b6QhGgsf0=;
        b=IgzpuwVeZdd//YHzrzdu6mgAuH4UjtyXtRFxHDI+YSMyg+24XxFA0ntztIfAAHEns+
         BW93ur3BWEoDJSrbZ/HggdCmgoIcV7kbtbc0lE2RNZM2Q4NYaBztITDsF0mnGMvKermI
         19UZRSARhDpcH57qoctDXTnmxhGz2Jf8ZfHcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0hJSCJb1LP0ObcdLd4/9veYEjRQvXzCQb4b6QhGgsf0=;
        b=HQ0girzT+g/mRVuIc9KeLDc956bsGcTnI+0DdRwPoWShrI8/OPcaDtw+QXosTWdl+n
         TBLqcNktiDM2W1tGSxTyzgv+dwU3IgKVVRtayMV6zjK5TvxGSRE4KL4hGwJyogLI1+Z1
         cU8nwrXg+q3WkBuDCiGJCdViGJmwj3dCy74VRMrNUu0DYSAFIyEaFpwqF2F0qA5XvakR
         /cetPvA7JYs9cI5QPB4XZbcadNJ8xIkT8SMnH2kaYYqGNh6rriht+i+1ud7Y5/6essHX
         eqLJo/bznqDAE/MZBSBh89yp7iW3tFl3VfifJF1NkmJ9OBm1y9cgvDOjM1Yt4OHZljAN
         xU+A==
X-Gm-Message-State: ABuFfoiWnoc85tUKYyVeDUvOMuzHIB6r5MSuE96JAQuq+glYtaKvutue
        TRqUPx8shNXG60sQkR+zPvfbjw==
X-Google-Smtp-Source: ACcGV63GZmNK0wL68swjik2eh0lr7nw/58KQgje4eEqgnC7g9Wt+B6P8QYf2D6izxmsmXaIJiaSfrA==
X-Received: by 2002:a2e:9a93:: with SMTP id p19-v6mr14544570lji.87.1539714038483;
        Tue, 16 Oct 2018 11:20:38 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i27-v6sm3207844lfc.22.2018.10.16.11.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:20:37 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date:   Tue, 16 Oct 2018 21:20:31 +0300
Message-Id: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpsw holds separate mcast entires for vlan entries. At this moment
driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
As result mcast for vlans doesn't work. It can be fixed by adding same
mcast entries for every created vlan, but this patchseries uses more
sophisticated way and allows to create mcast entries only for vlans
that really require it. Generic functions from this series can be
reused for fixing vlan and macvlan unicast.

Simple example of ALE table before and after this series, having same
mcast entries as for vlan 100 as for real device (reserved vlan 2),
and one mcast address only for vlan 100 - 01:1b:19:00:00:00.

<---- Before this patchset ---->
vlan , vid = 2, untag_force = 0x5, reg_mcast = 0x5, mem_list = 0x5
mcast, vid = 2, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 2, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
vlan , vid = 0, untag_force = 0x7, reg_mcast = 0x0, mem_list = 0x7
mcast, vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:00:5e:00:00:01, port_mask = 0x1
vlan , vid = 1, untag_force = 0x3, reg_mcast = 0x3, mem_list = 0x3
mcast, vid = 1, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 1, addr = 74:da:ea:47:7d:9c, persistant, port_num = 0x0
mcast, vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 2, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 33:33:ff:47:7d:9c, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:fc, port_mask = 0x1
vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
mcast, vid = 2, addr = 01:1b:19:00:00:00, port_mask = 0x1
			 ^^^
 Here mcast entry (ptpl2), has to be added only for vlan 100
 but added for reserved vlan 2...that's not enough.

<---- After this patchset ---->
vlan , vid = 2, untag_force = 0x5, reg_mcast = 0x5, mem_list = 0x5
mcast, vid = 2, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 2, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
vlan , vid = 0, untag_force = 0x7, reg_mcast = 0x0, mem_list = 0x7
mcast, vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:00:5e:00:00:01, port_mask = 0x1
vlan , vid = 1, untag_force = 0x3, reg_mcast = 0x3, mem_list = 0x3
mcast, vid = 1, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 1, addr = 74:da:ea:47:7d:9c, persistant, port_num = 0x0
mcast, vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 2, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 1, addr = 33:33:ff:47:7d:9c, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:01:00:03, port_mask = 0x1
vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 100, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 100, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 100, addr = 01:1b:19:00:00:00, port_mask = 0x1
			 ^^^
    Here mcast entry (ptpl2), is added only for vlan 100
    as it should be.

Based on net-next/master

Ivan Khoronzhuk (4):
  net: core: dev_addr_lists: add auxiliary func to handle reference
    address updates
  net: 8021q: vlan_core: allow use list of vlans for real device
  net: ethernet: ti: cpsw: fix vlan mcast
  net: ethernet: ti: cpsw: fix vlan configuration while down/up

 drivers/net/ethernet/ti/cpsw.c | 189 +++++++++++++++++++++++++++------
 include/linux/if_vlan.h        |  10 ++
 include/linux/netdevice.h      |  10 ++
 net/8021q/vlan_core.c          |  27 +++++
 net/core/dev_addr_lists.c      |  97 +++++++++++++++++
 5 files changed, 303 insertions(+), 30 deletions(-)

-- 
2.17.1

