Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806AECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4E20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A4E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeGUSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:14:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727483AbeGUSOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:14:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C32E6AE5B;
        Sat, 21 Jul 2018 17:21:26 +0000 (UTC)
Date:   Sat, 21 Jul 2018 10:21:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180721172120.kbdu4euc2wn4xzgf@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
 <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Andrew Morton wrote:

>We could open-code it locally.  Add a couple of
>WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
>Xen but surely just reading the thing isn't too expensive?

We could also pass on the responsibility to lockdep and just use
lockdep_assert_irqs_disabled(). But I guess that would be less effective
than to just open code it in epoll without lockdep -- note that over 80
places in the kernel do this.

Thanks,
Davidlohr
