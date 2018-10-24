Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E21ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888C12075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DI3gnGwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888C12075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeJYGlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:41:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36241 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYGlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:41:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so6278744lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2wekwl08ppG5bWJohwkrQhGWtV/pNRvSCYDRWHzcyLc=;
        b=DI3gnGwEbrr/GSGQ9aIwaRzeIZWC/7U6HFtKqnWxiXPUN2ajeNuIb77EVmwrAy7qVG
         bZCIeU312HR9Riy/dGOBpleHQ7e1c10vXPKFLIoWlQq6VT6tGMtfk4YPUadmab7rekjQ
         YrgUiaoTgjE3JcRqhvT/uHjOuK+UbFHUYpqo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2wekwl08ppG5bWJohwkrQhGWtV/pNRvSCYDRWHzcyLc=;
        b=pNIJ4X4EIIkFBg/c/FF7adK+5I/LNGDNTb+mO6Ay1W7slEgXun3GdzsDy7G+4QIp9u
         CAx0HLSJJV+rysIpFaUcRGc/ZW7+EKmJHRNG0S2iNFKQHc400mV6TOZQtcQMzrLpyyxD
         TrQxkcNE+aEverU3o382isoWEZthE35qE9p3dGOt5u1slHZM6QsFievTboNgue+OVAP+
         Wlr04REOvfUJEZOWiD4sF5xnt6UJXUrX0TRdWJEeY+zCu16Yspk+oF35uNRCK5hEikwO
         ZvzsUV3ednJ41P6iiEqI0oI7I1swW4dBAklnHFvHPt4/c72ZGqTpGZwyVvEJgtEDBJwc
         4Q2w==
X-Gm-Message-State: AGRZ1gI38CwqKo1YaJNUfCly1iaFpj8bJZtR04sTvJmuPgd9ZtsDFUQd
        awlCtFtoqp+WklKWCJcs0u1w6g==
X-Google-Smtp-Source: AJdET5dm3Zn0CArlZ+8WolfM7ZqLS/hcMhT4KtjgbDxltJW+dGw1YGIohZ0N79x7HE0PQdgliKpX9A==
X-Received: by 2002:a2e:651d:: with SMTP id z29-v6mr3167408ljb.36.1540419071720;
        Wed, 24 Oct 2018 15:11:11 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f19-v6sm835350ljc.31.2018.10.24.15.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:11:10 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date:   Thu, 25 Oct 2018 01:10:55 +0300
Message-Id: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
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

 drivers/net/ethernet/ti/cpsw.c | 212 ++++++++++++++++++++++++++++-----
 include/linux/if_vlan.h        |  11 ++
 include/linux/netdevice.h      |  10 ++
 net/8021q/vlan_core.c          |  27 +++++
 net/core/dev_addr_lists.c      |  97 +++++++++++++++
 5 files changed, 326 insertions(+), 31 deletions(-)

-- 
2.17.1

