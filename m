Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C21C9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722742087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722742087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbeFKVXY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:23:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56288 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeFKVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:23:23 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B3F81015159D;
        Mon, 11 Jun 2018 14:23:22 -0700 (PDT)
Date:   Mon, 11 Jun 2018 14:23:21 -0700 (PDT)
Message-Id: <20180611.142321.1509037661741097364.davem@davemloft.net>
To:     jiazhouyang09@gmail.com
Cc:     santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb3: add error handling for some functions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1528706547-35243-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528706547-35243-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Jun 2018 14:23:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>
Date: Mon, 11 Jun 2018 16:42:26 +0800

> When sysfs_create_group or alloc_skb fails, the lack of error-handling
> code may cause unexpected results.
> 
> This patch adds error-handling code after the functions.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>

The ->nofail_skb handling is perfectly fine.

It is a backup SKB, meant to handle alloc_skb() failures for the
primary 'skb' allocation the _next_ time this function is called.

Even if the ->nofail_skb allocation fails, the primary operation
done by init_tp_parity() has succeeeded and we should return
success.

All of the code in this function is perfectly prepared to handle
the case where ->nofail_skb is NULL.
