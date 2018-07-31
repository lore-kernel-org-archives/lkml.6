Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC8520870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fG1BWqbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC8520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeGaKc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:32:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeGaKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+d6dxIydmDGzGUcHW51+EdQ0pZRUvIfZR3rUqB2lB8g=; b=fG1BWqbh1pjNSkAW4EOvObe2Y
        migJeLN+9BpOxvO7PNGGjbsagFm5XaquhA222qvdvQW6CfT8laGd4eeiqlaUYnxYzYLzbvBj/GDYu
        03QYzKUKMZrRVOtbJnUCOBKbU6e1UY/ubPhD8qsfiklV3zTFRN3fvgswj6YMjj12lpvYRNH7T+7FP
        RCdWmmXIZAlpziWcVh40Z7mWxx23Tfe+WVefh/JDnnceansuxQCkeXuMc89vAQTqbUmPB/qj/vTqa
        i7xLxEMml+rlLLGSTIdbc0dHroPScr5+jkN3MudQ2LrJy+LW3LTG2V59e7EVdpWdAEtbM4a1hWYBL
        NXwlLPWAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkQOp-0007J1-VQ; Tue, 31 Jul 2018 08:53:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D40552027585B; Tue, 31 Jul 2018 10:52:57 +0200 (CEST)
Date:   Tue, 31 Jul 2018 10:52:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        ying.huang@intel.com, mingo@kernel.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, len.brown@intel.com, glider@google.com,
        peter@hurleysoftware.com, aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180731085257.GR2494@hirez.programming.kicks-ass.net>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> In restrictive cases like only addtions happen but never deletion, can't
> we safely traverse a llist? I believe llist can be more useful if we can
> release the restriction. Can't we?

Yes you can, but I'm not sure it makes much sense to confuse the
comments with this.

This really ends up in the 'you had better know what you're doing'
category.
