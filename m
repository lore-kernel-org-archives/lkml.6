Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8534C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4492089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4492089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeKQNwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:52:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:52:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6DDF313F587EA;
        Fri, 16 Nov 2018 19:37:26 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:37:25 -0800 (PST)
Message-Id: <20181116.193725.1381952801953862286.davem@davemloft.net>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1] tg3: optionally get mac address from devicetree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181113161508.7427-1-TheSven73@googlemail.com>
References: <20181113161508.7427-1-TheSven73@googlemail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 19:37:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: thesven73@gmail.com
Date: Tue, 13 Nov 2018 11:15:08 -0500

> If the tg3 has a device node, and that node contains a valid
> mac address property, use that as the tg3's mac address.
> 
> This behaviour was previously only present on SPARC, using a
> conditional compile (#ifdef CONFIG_SPARC), presumably because
> at the time, devicetree nodes for pci devices only worked on
> SPARC. However, this has recently been made universal, see
> commit 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
> 
> Devicetree example:
> (see Documentation/devicetree/bindings/pci/pci.txt)
> 
> &pcie {
> 	host@0 {
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		reg = <0 0 0 0 0>;
> 		bcm5778: bcm5778@0 {
> 			reg = <0 0 0 0 0>;
> 			mac-address = [CA 11 AB 1E 10 01];
> 		};
> 	};
> };
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>

Please use eth_platform_get_mac_address() and you can delete all of the
SPARC specific code altogether.
