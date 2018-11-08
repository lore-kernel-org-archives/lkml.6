Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4805C20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDRIfdpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4805C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeKHS4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:56:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeKHS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EJsKISGxYo4H2RYZRbLqy+Y+g60nV2TrympHApZXX/Y=; b=PDRIfdpUYxX2BoW6QzNPIRrxx
        I44lQ64A18R56SFuBXPDtOTY1yHLWnCc4ns35Sjx10ejPt02zekpcwBsxsQ6MGFI9Zmwa4SXeL9ku
        bJvWNdlSCkKDfAzE1ujt14SroGJrKX3gPOnz+DNzRAxSl1OjJAaXp3zAUkoo98/tbMREI5KIEB9ir
        io3dSyU/Uf6TqDjWfASwSEvllqeTqUuaNDrv76LzFKh/b04p8qdbF1kN6sJv72im7K3MWAxsu56b6
        RotCEMQGghNgBZ1u5lZ4Mhais1yOLtpZDyQvyHzXy2lbTpCsbl0eabHm3FPIT5B+5cKzoklcBzdtO
        iXOR7xMnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKgVd-0001TG-Dz; Thu, 08 Nov 2018 09:21:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 336BE20284F98; Thu,  8 Nov 2018 10:21:51 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:21:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Question on comment header for for_each_domain()
Message-ID: <20181108092151.GM9761@hirez.programming.kicks-ass.net>
References: <20181107230002.GA15577@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107230002.GA15577@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 03:00:02PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> The header comment for for_each_domain() talks about a call to
> synchronize_sched() within detach_destroy_domains(), but I am not
> seeing any such call.  Because synchronize_sched() is now folded into
> synchronize_rcu(), I have a patch that edits the comment, but it looks
> like a larger change is needed.
> 
> Or am I blind today?

I think you're quite right and that comment is a wee bit stale.

The sched domain tree is indeed protected by regular RCU (not RCU-sched
as the comment seems to imply) and this is per destroy_sched_domains()
using call_rcu().

And most (I didn't look at all) uses for the sched-domain tree do indeed
employ rcu_read_lock().


