Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C21C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A720840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5A720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbeHAUdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:33:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51200 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeHAUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:33:47 -0400
Received: from localhost (c-71-59-158-49.hsd1.or.comcast.net [71.59.158.49])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DB452100A24BE;
        Wed,  1 Aug 2018 11:46:39 -0700 (PDT)
Date:   Wed, 01 Aug 2018 11:46:36 -0700 (PDT)
Message-Id: <20180801.114636.279269263935333136.davem@davemloft.net>
To:     xiyou.wangcong@gmail.com
Cc:     sd@queasysnail.net, eric.dumazet@gmail.com,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, dsahern@gmail.com, fw@strlen.de,
        jbenc@redhat.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
References: <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
        <20180731134014.GA32114@bistromath.localdomain>
        <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 11:46:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 31 Jul 2018 16:03:13 -0700

> Looks like this commit is completely unnecessary,
> fib6_drop_pcpu_from() calls fib6_info_release()
> which calls fib6_info_destroy_rcu(), so this metrics
> will be released twice...

And even if there was a leak here, it's illegal to free this
metrics memory synchronously since it is RCU protected.

That's why it normally goes through fib6_info_destroy_rcu().

Sabrina, I'm going to revert your changes unless I see some
progress here by the end of today.

