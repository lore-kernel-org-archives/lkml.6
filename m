Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF36ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A002083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRcpsRhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A002083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeIOODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:03:01 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35256 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:03:00 -0400
Received: by mail-pg1-f173.google.com with SMTP id 7-v6so5461220pgf.2;
        Sat, 15 Sep 2018 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5mYCOhwz3pZP2GiHoKWx5Fa5F4KoxRV9Mu6ACNTaAzo=;
        b=iRcpsRhlyI1USCseVCcbjgPY6E9Qv7oZOsBOCMsNtjaCkIbaBrkq+4WKuQ/lSeScXA
         m52S0jObfnQPet/QgqIcfPg/pFvTkCqMevKVWsMQSmM0kMtyPse41cjRscMAgNpww3wW
         16U9yYnUWsD68nkH0ZhbMo4gtuOA8LeYogFbEIIMjZw466MAYjdp12n8HM3sTMomRoiL
         BaDCTaPU1pjaPf0UtQc7SRF2UVfpOMKOzoG/xkSXfZEaUr2B8IDjPd3vB1yMw1Uw5axm
         OVILMNAL/JEVeztIXQeMyCPhaeqbzMHEm/KqJwcNLY9nCBTnaCzwJPDM9/z3hzidgwsf
         clwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5mYCOhwz3pZP2GiHoKWx5Fa5F4KoxRV9Mu6ACNTaAzo=;
        b=RrywVAP0sV/uD31GVdrnGmDnUdlbf2v6Of8z1mLS96axutr/yX10ZLfTjmiY5Mm/jX
         AWCxYWyvNg/HtwsxRZz2OERtAnbR1ebrEbe47/qw/Gy9IY6P24QAjmKvQoth8Un+s2Qv
         ogLuwmLg8ntnNw+CTwNUeOethIUTNJd498hSUZoZ5PLp1YQw9Tr534PcLMVyx3IOFDj3
         UHmS4+f6ctEqfBxdZh48r8BErlMTXbB1SWo7lgLIUOl+6GgK+PI+TNejd3W1NZR3EUSB
         tlXw2Go5CDQx69P6rfMz6CeeWlg2nZRoSGEpVjUjNPm5VpvJqv2OSOVHU0uldTC8MLp/
         x97A==
X-Gm-Message-State: APzg51BCBkaLyMJUf+LpQIkkWk5Kk3Y0q4rajE+NO5ph2TupYeXWM+AH
        F55ic5RSIFkLkMr8YDFnLB/hpczj
X-Google-Smtp-Source: ANB0VdZpTeiEC0CoRp9kL/TexDeCSxMAQJJtcAr73ylPGYCorzYLeXEWNUfkuinm6Uc2Uaiqud9MbQ==
X-Received: by 2002:a63:af17:: with SMTP id w23-v6mr15548057pge.47.1537001088333;
        Sat, 15 Sep 2018 01:44:48 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id k64-v6sm13441796pfg.141.2018.09.15.01.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 01:44:47 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: broadcom: b44: Possible sleep-in-atomic-context bugs in
 b44_chip_reset()
To:     michael.chan@broadcom.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <f7c5e6bf-867b-496b-c3e0-ce5766a33d26@gmail.com>
Date:   Sat, 15 Sep 2018 16:44:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] msleep
drivers/ssb/driver_pcicore.c, 671:
     msleep in ssb_pcie_mdio_write
drivers/ssb/driver_pcicore.c, 446:
     ssb_pcie_mdio_write in ssb_pcicore_serdes_workaround
drivers/ssb/driver_pcicore.c, 508:
     ssb_pcicore_serdes_workaround in ssb_pcicore_pcie_setup_workarounds
drivers/ssb/driver_pcicore.c, 729:
     ssb_pcicore_pcie_setup_workarounds in ssb_pcicore_dev_irqvecs_enable
drivers/net/ethernet/broadcom/b44.c, 1289:
     ssb_pcicore_dev_irqvecs_enable in b44_chip_reset
drivers/net/ethernet/broadcom/b44.c, 1363:
     b44_chip_reset in b44_halt
drivers/net/ethernet/broadcom/b44.c, 2498:
     b44_halt in b44_suspend
drivers/net/ethernet/broadcom/b44.c, 2496:
     spin_lock_irq in b44_suspend

[FUNC] msleep
drivers/ssb/driver_pcicore.c, 671:
     msleep in ssb_pcie_mdio_write
drivers/ssb/driver_pcicore.c, 446:
     ssb_pcie_mdio_write in ssb_pcicore_serdes_workaround
drivers/ssb/driver_pcicore.c, 508:
     ssb_pcicore_serdes_workaround in ssb_pcicore_pcie_setup_workarounds
drivers/ssb/driver_pcicore.c, 729:
     ssb_pcicore_pcie_setup_workarounds in ssb_pcicore_dev_irqvecs_enable
drivers/net/ethernet/broadcom/b44.c, 1289:
     ssb_pcicore_dev_irqvecs_enable in b44_chip_reset
drivers/net/ethernet/broadcom/b44.c, 1412:
     b44_chip_reset in b44_init_hw
drivers/net/ethernet/broadcom/b44.c, 2533:
     b44_init_hw in b44_resume
drivers/net/ethernet/broadcom/b44.c, 2531:
     spin_lock_irq in b44_resume

These bugs are found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai
