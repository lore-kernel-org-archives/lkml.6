Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF44C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB620645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0hp0BDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCB620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeJWBvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:51:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeJWBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=URkB75rJsVa2bCEpG8luURFvng73Q4+LU2k9AWbtWNY=; b=R0hp0BDMm/Llo0bD77eq5RWjB
        P8HbnUinZj7wgAeCUU0rbhTQaEeEZsaPsH3aswqrX4LuIHF0bH6VNDPTe47AcqX+NSaBsouqfuJ+t
        pB5m+fE2Yq//JuCV2c67eeKc2q6CHIp05kfqwZzSBZP1ND9L0SnW0CwhGHSMDbIdqOSm0ZPnzRFj+
        c5idhfyganuuW6fzw3chE4efkUMe4lw6EF7s5SdAh18fFH8EqtuIocEj3nq+ZnafQn+QQobO161We
        KwhNIOGpAzzq1wt9Dez1LflaMg1X7cHyGaqvU3SfqKkNg6mAG2fd/9A43aLO3HqOl9xKmpXXb3COB
        ElMInPmqA==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEe3O-0001xC-My; Mon, 22 Oct 2018 17:31:46 +0000
Received: by worktop (Postfix, from userid 1000)
        id 78DFC6E08C3; Mon, 22 Oct 2018 19:31:44 +0200 (CEST)
Date:   Mon, 22 Oct 2018 19:31:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>, Yi Sun <yi.y.sun@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181022173144.GB3109@worktop.c.hoisthospitality.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <6d8095c0-af95-5967-3ca5-2ceeb74233ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8095c0-af95-5967-3ca5-2ceeb74233ea@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:27:27PM -0400, Waiman Long wrote:

> >> I agree with Juergen on that. I would suggest rename the
> >> vcpu_is_preempted hook into a more generic vcpu_stop_spinning, perhaps,
> >> so different hypervisors can act on the information accordingly. Adding
> >> an extra parameter is fine.
> > No; no extra parameters. vcpu_is_preempted() is a simple and intuitive
> > interface. Why would we want to make it complicated?
> 
> Hyperv seems to do it in a somewhat different way by looking at the spin
> counter and decide if it should continue. I don't know why they do that
> and what advantage it has.
> 
> The current patch is definitely not OK. A revised patch that makes use
> of an existing paravirt hook will be more acceptable. Again, I would
> like to see some performance figure and why they do it this way to see
> if it is worthwhile to change the existing interface.

Note that there are vcpu_is_preempted() users that are not in a
spin-loop.
