Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EBBC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BC62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFH2SLNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BC62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLLJJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:09:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1K/gSdyRUUVriiomPu/vAxOnqsHCvi3CfN9yXMG9g20=; b=kFH2SLNl5YsaGqKzDdq6DH0/A
        9CGxqsegjcfoihBg4wkD9lpTVEBKp5+CyZC6YXAQJC6BFfXhuHDXi6rsHLGm0PN1sDM/on7GNbOEa
        m8sa1J3TNYZIgBT5+ZjdIlp0wtKLIFTohEizeaheB/JEFmQvCQsborkE+WidHyTowhQfifdmYQwop
        8oDg2mxB4SDUMcB9WTMLLFAOciIhcqKce5gq6dJj4g52K7csy3jW9wCBZUU7ZgGThyxLE2ZlBMJHL
        T4+gFZ75MNT8qsngG28miaMOUMqiKpRumE91HZ4acBnsi+fehRx6dpESJ5AOLRuNm8Czti+Tg2BtT
        b1CMTIzaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX0Vq-0006Up-Rw; Wed, 12 Dec 2018 09:09:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE6BB2075BF39; Wed, 12 Dec 2018 10:09:01 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:09:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: RFC [PATCH 1/1] locking/lockdep: Fix nest lock warning on unlock
Message-ID: <20181212090901.GV5289@hirez.programming.kicks-ass.net>
References: <20181212022506.171936-1-dbasehore@chromium.org>
 <20181212022506.171936-2-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212022506.171936-2-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:25:06PM -0800, Derek Basehore wrote:
> The function __lock_acquire checks that the nest lock is held passed
> in as an argument. The issue with this is that __lock_acquire is used
> for internal bookkeeping on lock_release. This produces a false
> positive lockdep warning on unlock. Since you explicitly don't need to
> hold the nest lock on unlock, this is an issue.

Who is triggering this?
