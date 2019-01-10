Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5920665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9SkaYoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfAJUDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:03:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=prrTEl/O1mn8pEBS0AEe6chxDE6RBTZn76+uyV1l/z4=; b=B9SkaYoZd/wV9XMafsHVbPK2S
        vm46mM1w1YM4Hu4GqgioDlx/HYJcsSfrW8fqc3AeB0hIYxSehADi8otcoAzEZbBDbUyN/UTsGiW5c
        +R6RERORijCtJsvnHZmoS4eNcwMreVgrumGIDyg0nq6Y/mwK0unQcQwru84M0JFo5hsE/9uYhwMNs
        0JrHn/I8m9vfxt/YJ/JserMisvgBAF+1kf+cclefeGxi22ciWPQWvUd8eLcVHENze1d33w9NfkxCO
        NkQg/+BQz4vjY7MgeZxKFhaLPBpwIFFdaR2V+tGQUURCRSxMp6b2e3ZNV2wk6VKUxNUbTxnDj1nh8
        y9I2f/PpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgXi-0007ys-UY; Thu, 10 Jan 2019 20:03:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D5E89844AF; Thu, 10 Jan 2019 21:03:03 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:03:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, longman@redhat.com,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: Question about qspinlock nest
Message-ID: <20190110200303.GG2861@worktop.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:02:53PM +0800, Zhenzhong Duan wrote:
> Hi Maintainer,
> 
> 
> There is a question confused me for days. Appreciate an answer.
> 
> In below code, the comment says we never have more than 4 nested contexts.
> 
> What happen if debug and mce exceptions nest with the four, or we ensure it
> never happen?

MCE and NMI really should not use spinlocks at all since they cannot be
masked.

