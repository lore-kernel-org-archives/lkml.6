Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EAEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA898216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA898216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeI1Spr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:45:47 -0400
Received: from mail.us.es ([193.147.175.20]:47732 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeI1Spr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:45:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E00EE1EC2D0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:22:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D09E2DA85E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:22:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BA585DA87F; Fri, 28 Sep 2018 14:22:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0B1ADA846;
        Fri, 28 Sep 2018 14:22:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 28 Sep 2018 14:22:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A735D4265A5F;
        Fri, 28 Sep 2018 14:22:11 +0200 (CEST)
Date:   Fri, 28 Sep 2018 14:22:11 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Tan Hu <tan.hu@zte.com.cn>
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: Re: [PATCH] netfilter: masquerade: don't flush all conntracks if
 only one address deleted on device
Message-ID: <20180928122211.vxjfcrme6oiukjol@salvia>
References: <1536309213-19632-1-git-send-email-tan.hu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536309213-19632-1-git-send-email-tan.hu@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 04:33:33PM +0800, Tan Hu wrote:
> We configured iptables as below, which only allowed incoming data on
> established connections:
> 
> iptables -t mangle -A PREROUTING -m state --state ESTABLISHED -j ACCEPT
> iptables -t mangle -P PREROUTING DROP
> 
> When deleting a secondary address, current masquerade implements would
> flush all conntracks on this device. All the established connections on
> primary address also be deleted, then subsequent incoming data on the
> connections would be dropped wrongly because it was identified as NEW
> connection.
> 
> So when an address was delete, it should only flush connections related
> with the address.

Applied to nf-next, thanks.
