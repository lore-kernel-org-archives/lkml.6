Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A20C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25E9218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfAYCZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:25:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfAYCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:25:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7DFFE10888E81;
        Thu, 24 Jan 2019 18:25:42 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:25:41 -0800 (PST)
Message-Id: <20190124.182541.341610576126108739.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH net] sctp: set flow sport from saddr only when it's 0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <91961be2ab833139b1a4b0188ba47c2581b991d4.1548096161.git.lucien.xin@gmail.com>
References: <91961be2ab833139b1a4b0188ba47c2581b991d4.1548096161.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 18:25:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Jan 2019 02:42:41 +0800

> Now sctp_transport_pmtu() passes transport->saddr into .get_dst() to set
> flow sport from 'saddr'. However, transport->saddr is set only when
> transport->dst exists in sctp_transport_route().
> 
> If sctp_transport_pmtu() is called without transport->saddr set, like
> when transport->dst doesn't exists, the flow sport will be set to 0
> from transport->saddr, which will cause a wrong route to be got.
> 
> Commit 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in
> sctp_transport_route") made the issue be triggered more easily
> since sctp_transport_pmtu() would be called in sctp_transport_route()
> after that.
> 
> In gerneral, fl4->fl4_sport should always be set to
> htons(asoc->base.bind_addr.port), unless transport->asoc doesn't exist
> in sctp_v4/6_get_dst(), which is the case:
> 
>   sctp_ootb_pkt_new() ->
>     sctp_transport_route()
> 
> For that, we can simply handle it by setting flow sport from saddr only
> when it's 0 in sctp_v4/6_get_dst().
> 
> Fixes: 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in sctp_transport_route")
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable.
