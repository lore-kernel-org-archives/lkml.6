Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D89C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2293C222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfBNAe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:34:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBNAe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:34:28 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 291C414CEC643;
        Wed, 13 Feb 2019 16:34:27 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:34:26 -0800 (PST)
Message-Id: <20190213.163426.603453137542648612.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH net] sctp: set stream ext to NULL after freeing it in
 sctp_stream_outq_migrate
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0cb9e543c21495df48c3723044d6c9f64f238eca.1549968661.git.lucien.xin@gmail.com>
References: <0cb9e543c21495df48c3723044d6c9f64f238eca.1549968661.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Feb 2019 16:34:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 12 Feb 2019 18:51:01 +0800

> In sctp_stream_init(), after sctp_stream_outq_migrate() freed the
> surplus streams' ext, but sctp_stream_alloc_out() returns -ENOMEM,
> stream->outcnt will not be set to 'outcnt'.
> 
> With the bigger value on stream->outcnt, when closing the assoc and
> freeing its streams, the ext of those surplus streams will be freed
> again since those stream exts were not set to NULL after freeing in
> sctp_stream_outq_migrate(). Then the invalid-free issue reported by
> syzbot would be triggered.
> 
> We fix it by simply setting them to NULL after freeing.
> 
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Reported-by: syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Also applied and queued up for -stable, thanks.
