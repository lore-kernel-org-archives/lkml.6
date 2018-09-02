Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E520837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2E520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeICDTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 23:19:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35704 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeICDTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 23:19:08 -0400
Received: from localhost (168-64-212-66.spl.org [66.212.64.168])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 036161262C4F6;
        Sun,  2 Sep 2018 16:01:44 -0700 (PDT)
Date:   Sun, 02 Sep 2018 16:01:44 -0700 (PDT)
Message-Id: <20180902.160144.542360312136980090.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        dvlasenk@redhat.com, xiyou.wangcong@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: scm: Fix a possible sleep-in-atomic-context bug
 in scm_fp_copy()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180901100026.16956-1-baijiaju1990@gmail.com>
References: <20180901100026.16956-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 16:01:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Sat,  1 Sep 2018 18:00:26 +0800

> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] kmalloc(GFP_KERNEL)
> net/core/scm.c, 85: kmalloc in scm_fp_copy
> net/core/scm.c, 161: scm_fp_copy in __scm_send
> ./include/net/scm.h, 88: __scm_send in scm_send
> net/unix/af_unix.c, 1600: scm_send in maybe_init_creds
> net/unix/af_unix.c, 1983: maybe_init_creds in unix_stream_sendpage
> net/unix/af_unix.c, 1973: spin_lock in unix_stream_sendpage

Please, do a full analysis of the code for these changes you are
submitting.

Read maybe_init_creds(), it sets msg.msg_controllen to zero.

	struct msghdr msg = { .msg_controllen = 0 };

When that is zero, __scm__send() is never called.

static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
			       struct scm_cookie *scm, bool forcecreds)
{
 ...
	if (msg->msg_controllen <= 0)
		return 0;
	return __scm_send(sock, msg, scm);

If this bug existed, sleeping in atomic warnings would be triggering
all the time and people would report that.
