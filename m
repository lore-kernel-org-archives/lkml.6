Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A48DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515DC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Amx8MJT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515DC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeGSJCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:02:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbeGSJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:02:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so7108824wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4g4nfG4m1OzdchswEO7R+ZYaZi/kfpnI9ADiubMWl8Y=;
        b=Amx8MJT+5nEgP9xOvPbdT0osakqARL75F42jimkpp5mpdtjn2YdKAdUFqTgI/kq506
         +RITgEc2GhOTc8T+Lx6Nr1xZOMaGjFYpVZaUsS8MSuOIAvBy80L/ilJizZCGRmp3LvSz
         Mbg8vXJPsCf74//M2InhK17tgAyqS//U7sgAI6g7tPkd4H3BfeoSAEd0yrXeTeP+BTsa
         YZ6kRM13gfwi81EjJlngRExldE5JlaWm3AsojLfRG8d2diHCxuXko14fDnDJHMZBSX9E
         Q6hbWPxD/h5zJv4tKyhce9jmkuuM9O30GBiozDyCaG7eH/WMe/aokup0CCLzlzF9X1qU
         CLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4g4nfG4m1OzdchswEO7R+ZYaZi/kfpnI9ADiubMWl8Y=;
        b=JfCEXPOYOs8oce2bBrcerHLVwGKdL3rA631Vd+6ElGPyVCnycSOMVAxmP2N1GL0yqj
         ffVmnCzP4+EL3EG5EtH7+GKQ1oiyPZRTkT4D0G05KgNjd6JiGHM+OHixQSO5Hf8GGaMl
         tvZj8XbNRxZTSWCxr8PTLzqMD+CtZ7/ZaXnNPonHmxW1VK/Oc9SQJBijN3F7wHrgYfY2
         1wnveQvHhVd3p0Ol2pGGvV5kPoXRr+ICeT0CAn1v0lDtY710B319M8xxcOYnQ83vsiRK
         7sFto9zf3VHjaXgZklJ0KEvNL1TVt10YGFCSyH/59McPlywwq+lqMfjBR5OKAZ8b56LF
         QrXQ==
X-Gm-Message-State: AOUpUlE5NPNVRdu4Ke66wBvQfk/ji2um+h/h30IZ0a+8zS0tjC1wqrvq
        W6KDjGQYm74AR84Xn9IBeeNdeQ==
X-Google-Smtp-Source: AAOMgpc4Avsy6YUnEry/rn3bidWA9oPkn/PjP+aghKdmR5Zp5nGld5XGWGG7+Ghj/1nR5dOyEfFLiA==
X-Received: by 2002:adf:e34d:: with SMTP id n13-v6mr7032614wrj.158.1531988432033;
        Thu, 19 Jul 2018 01:20:32 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id h43-v6sm1716338wrh.1.2018.07.19.01.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:20:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/3] net: extend eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 10:20:25 +0200
Message-Id: <20180719082028.26116-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to a series I posted a while ago the goal of which
was to replace the at24 platform data with device properties. To do so
we need to somehow remove reading the MAC address from relevant board
files.

In my patches I used nvmem and MTD to read the MAC address from within
the davinci emac driver. It was suggested that we generalize it further
but since MTD doesn't support nvmem yet, the best we can do is to move
this code over to net core code.

The following patches modify the eth_platform_get_mac_address()
function which seems to be the best candidate for this code.

The first patch calls is_valid_ether_addr() on the read address so
that we're sure it's correct.

The last two patches add nvmem and MTD support to the function. In
order to stay compatible with existing users, nvmem and MTD will be
tried last - after device tree and arch-specific callback.

If this series gets accepted I will modify my previous patches to
use it instead of handcoding the same operations in davinci_emac.

v1 -> v2:
- dropped patches 1 & 2
- improved the MAC address verification and fixed a potential buffer
  overflow in patch 2/3

Bartosz Golaszewski (3):
  net: fortify eth_platform_get_mac_address()
  net: add support for nvmem to eth_platform_get_mac_address()
  net: add MTD support to eth_platform_get_mac_address()

 net/ethernet/eth.c | 47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
2.17.1

