Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61309C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE721477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJFBrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:47:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeJFBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:47:37 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 484E813ADF96D;
        Fri,  5 Oct 2018 11:47:38 -0700 (PDT)
Date:   Fri, 05 Oct 2018 11:47:35 -0700 (PDT)
Message-Id: <20181005.114735.1078401743683539709.davem@davemloft.net>
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb3_main: fix a missing-check bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1538747307-21403-1-git-send-email-wang6495@umn.edu>
References: <1538747307-21403-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 11:47:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Fri,  5 Oct 2018 08:48:27 -0500

> In cxgb_extension_ioctl(), the command of the ioctl is firstly copied from
> the user-space buffer 'useraddr' to 'cmd' and checked through the
> switch statement. If the command is not as expected, an error code
> EOPNOTSUPP is returned. In the following execution, i.e., the cases of the
> switch statement, the whole buffer of 'useraddr' is copied again to a
> specific data structure, according to what kind of command is requested.
> However, after the second copy, there is no re-check on the newly-copied
> command. Given that the buffer 'useraddr' is in the user space, a malicious
> user can race to change the command between the two copies. By doing so,
> the attacker can supply malicious data to the kernel and cause undefined
> behavior.
> 
> This patch adds a re-check in each case of the switch statement if there is
> a second copy in that case, to re-check whether the command obtained in the
> second copy is the same as the one in the first copy. If not, an error code
> EINVAL is returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied.
