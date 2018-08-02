Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAF8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E33E21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="eoo7n5h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeHBX3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:29:12 -0400
Received: from imap.thunk.org ([74.207.234.97]:60032 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbeHBX3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KwlrU/CPyV/Q35bT5wl/mW434v6Jsvo4rIN20TKx7dQ=; b=eoo7n5h6+ZkizYI/GMND7PIFLn
        TO5Cv4IqM/GngeE9p65J26+Y4zcKVpmr6hFG9Zyq+qAfGMKSAgXBIzpumge5f0Pb01+dUgpaCU4Xo
        72WiNkb0UFfosb1toKLvVMQZVCy9mvbCHRE0XhYHxnh63MXZEf9YA5ygQ4NF1WBWqDnk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1flLGK-0006Us-14; Thu, 02 Aug 2018 21:36:00 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 243E67A64C9; Thu,  2 Aug 2018 17:35:59 -0400 (EDT)
Date:   Thu, 2 Aug 2018 17:35:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH v1 1/3] random: Make crng state queryable
Message-ID: <20180802213559.GA32066@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
References: <20180731191102.2434-1-Jason@zx2c4.com>
 <20180731191102.2434-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731191102.2434-2-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:11:00PM +0200, Jason A. Donenfeld wrote:
> It is very useful to be able to know whether or not get_random_bytes_wait
> / wait_for_random_bytes is going to block or not, or whether plain
> get_random_bytes is going to return good randomness or bad randomness.
> 
> The particular use case is for mitigating certain attacks in WireGuard.
> A handshake packet arrives and is queued up. Elsewhere a worker thread
> takes items from the queue and processes them. In replying to these
> items, it needs to use some random data, and it has to be good random
> data. If we simply block until we can have good randomness, then it's
> possible for an attacker to fill the queue up with packets waiting to be
> processed. Upon realizing the queue is full, WireGuard will detect that
> it's under a denial of service attack, and behave accordingly. A better
> approach is just to drop incoming handshake packets if the crng is not
> yet initialized.
> 
> This patch, therefore, makes that information directly accessible.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Applied to the random.git tree.

					- Ted
