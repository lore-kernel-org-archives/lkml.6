Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D3120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Alf7PPyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D3120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKZTjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:39:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=upHccE84qko1SAtWxh1pmEqvVg9EbpXGOdVNEHwnQL8=; b=Alf7PPyQqsXsNSGz42T47xB0z
        iWERJb7X6TSihJNG/Xe5rn7C9obt2oVwrhUsbbl6KYscBMfkj/mdPFEgVAkkG3ChFoHef1Aj2NWsb
        2L8u/fMix4YwEMtXaMTUGheK551ciZBXWV9obYnnQ7U+aL5vJ5WkyeEnj1BnxjWgGjWs053Sf75CX
        zxNDIKfLsSPo2WPG2y3+lG2YGnO6jO52A+vwuvghDMfg374QjZGzZvyIHaxFxN1y6X3uBLJ9tZkAV
        YNBlyjOTED5ME9BOUwbZjV9R7E95k+NKruU4aIaYA+11yz7vmYp+twB35abo7VR0AU/WceHkC87k5
        qC0DBXViA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRCXA-0004GJ-MZ; Mon, 26 Nov 2018 08:46:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85A052029FD58; Mon, 26 Nov 2018 09:46:21 +0100 (CET)
Date:   Mon, 26 Nov 2018 09:46:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: build atomic headers as required
Message-ID: <20181126084621.GL2113@hirez.programming.kicks-ass.net>
References: <20181123153321.8561-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123153321.8561-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:33:21PM +0000, Mark Rutland wrote:
> Andrew and Ingo report that the check-atomics.sh script is simply too
> slow to run for every kernel build, and it's impractical to make it
> faster without rewriting it in something other than shell.
> 
> Rather than committing the generated headers, let's regenerate these
> as-required for a pristine tree.

Thing is, I '_never_' have a pristine tree. Now, I would also be in a
position to know if something with the atomics changed, but that can't
help other people that never use pristine trees.

Could we perhaps get an explicit 'genatomics' target or something to
check/force-update this stuff?
