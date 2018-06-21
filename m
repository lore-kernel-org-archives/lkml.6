Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36DEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866A224A0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9866A224A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeFUWVB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:21:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38698 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeFUWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:20:59 -0400
Received: from localhost (unknown [119.205.93.152])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03021109771BD;
        Thu, 21 Jun 2018 15:20:57 -0700 (PDT)
Date:   Fri, 22 Jun 2018 07:20:56 +0900 (KST)
Message-Id: <20180622.072056.1223319763674661318.davem@davemloft.net>
To:     garrmcnu@gmail.com
Cc:     netdev@vger.kernel.org, stephen@networkplumber.org,
        jiri@resnulli.us, nikolay@cumulusnetworks.com,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: fix potential null pointer dereference on
 return from br_port_get_rtnl()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180621201427.4961-1-garrmcnu@gmail.com>
References: <20180621201427.4961-1-garrmcnu@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Jun 2018 15:20:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Garry McNulty <garrmcnu@gmail.com>
Date: Thu, 21 Jun 2018 21:14:27 +0100

> br_port_get_rtnl() can return NULL if the network device is not a bridge
> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> br_port_fill_slave_info() callbacks dereference this pointer without
> checking. Currently this is not a problem because slave devices always
> set this flag. Add null check in case these conditions ever change.
> 
> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> 
> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>

I don't think this is reasonable.

The bridge code will never, ever, install a slave that doesn't have
that bit set.  It's the most fundamental aspect of how these objects
are managed.
