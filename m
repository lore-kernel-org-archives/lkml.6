Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6420693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeGRFwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:52:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeGRFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:52:04 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D276D13EA8052;
        Tue, 17 Jul 2018 22:16:01 -0700 (PDT)
Date:   Wed, 18 Jul 2018 14:15:59 +0900 (KST)
Message-Id: <20180718.141559.1076017531577697883.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     baoyou.xie@gmail.com, willemb@google.com, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tklauser@distanz.ch, matthew@mjdsystems.ca, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] datagram: return from __skb_recv_datagram() as soon
 as possible
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAF=yD-+N6BBcbKFo3B=FmVcp9VD+NUr2mfk-qkvtkVZYDhsRHQ@mail.gmail.com>
References: <1531653191-6456-1-git-send-email-baoyou.xie@gmail.com>
        <CAF=yD-+N6BBcbKFo3B=FmVcp9VD+NUr2mfk-qkvtkVZYDhsRHQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 22:16:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Jul 2018 15:17:54 -0700

> If the above occurs, that implies that the queue is not empty so the
> next iteration of the loop in __skb_recv_datagram should return
> the oldest packet on the queue.

Isn't it possible, with two threads pulling from the socket in
parallel, for one of them to be constantly unable to pass that
test:

	if (sk->sk_receive_queue.prev != skb)
		goto out;

because the other one empties the queue too quickly every time?

We sample 'last' with the queue lock held, but the above test is done
without that lock.
