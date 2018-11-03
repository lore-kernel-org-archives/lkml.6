Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BBC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1414F20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1414F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeKCW1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:27:44 -0400
Received: from mail.us.es ([193.147.175.20]:50480 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeKCW1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:27:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E4532A7F36
        for <linux-kernel@vger.kernel.org>; Sat,  3 Nov 2018 14:16:22 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D499ADA7A2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Nov 2018 14:16:22 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C988FDA79C; Sat,  3 Nov 2018 14:16:22 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 00939DA73F;
        Sat,  3 Nov 2018 14:16:21 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 03 Nov 2018 14:16:20 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C2CE84265A30;
        Sat,  3 Nov 2018 14:16:20 +0100 (CET)
Date:   Sat, 3 Nov 2018 14:16:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vasily Khoruzhick <vasilykh@arista.com>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: conntrack: fix calculation of next bucket
 number in early_drop
Message-ID: <20181103131620.alepdriguhu2rxc3@salvia>
References: <20181025191543.15061-1-vasilykh@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025191543.15061-1-vasilykh@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:15:43PM -0700, Vasily Khoruzhick wrote:
> If there's no entry to drop in bucket that corresponds to the hash,
> early_drop() should look for it in other buckets. But since it increments
> hash instead of bucket number, it actually looks in the same bucket 8
> times: hsize is 16k by default (14 bits) and hash is 32-bit value, so
> reciprocal_scale(hash, hsize) returns the same value for hash..hash+7 in
> most cases.
> 
> Fix it by increasing bucket number instead of hash and rename _hash
> to bucket to avoid future confusion.

Applied, thanks.
