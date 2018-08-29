Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A826C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CD620868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlyCkJ74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CD620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeH2N1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:27:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2N1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=683pyD3fpdeO6nuoovqsuaoSgXZnYdaUCWmrDkWV4Ec=; b=XlyCkJ74y9Qt/+T4hlFHXHi83G
        mf3Tl1pRTUbYEQi5csYLPkmLJIgMnpxVy4G3qzxLGPk6fniic8TAnkRbLS4jGBR54DhY/Cc0Ie9+M
        K5O/pN1W9r4Ib6ts6D+BjhNL3DW/gppUgYG+Y/oSY0WULBCkgwHpf9TqU9+ELjwGmoUVBznZOWmdv
        To0nRwEq9QY1N5RiGTYOpnpjfIRHPEZFPmMiCvfJUZ1iZabbEQzOG47nPBiK0/M9Dkz2sJJVXszFH
        5S7Yy+QIwFpj8bVUcBmqoGA2+qsv1A0n895aoW6EDuZErIXl5m6nOWH593iYCfXg1r4mLWMRRm3wS
        ltZ8fQjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuwot-00079d-Un; Wed, 29 Aug 2018 09:31:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED1312024D706; Wed, 29 Aug 2018 11:31:21 +0200 (CEST)
Date:   Wed, 29 Aug 2018 11:31:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH] locking/lockdep: Delete unnecesary #include
Message-ID: <20180829093121.GQ24124@hirez.programming.kicks-ass.net>
References: <20180828203315.GD18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180828203315.GD18030@decadent.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:33:15PM +0100, Ben Hutchings wrote:
> Commit c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and u
> nify their usage") added the inclusion of <trace/events/preemptirq.h>.
> liblockdep doesn't have a stub version of that header so now fails to
> build.
>=20
> However, commit bff1b208a5d1 ("tracing: Partial revert of "tracing:
> Centralize preemptirq tracepoints and unify their usage"") removed the
> use of functions declared in that header.  So delete the #include.
>=20
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ...")
> Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize ...=
")

There's no actual breakage because of this extra include, is there?
