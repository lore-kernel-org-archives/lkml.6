Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B5C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A662086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2AGTRH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A662086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeKHTQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:16:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKHTQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZezUjLDr/j2WA2NJdtNAakJBWQx0nHV5kn7qTWMNssQ=; b=S2AGTRH5xZWc6DN7qLP2ah6Pg
        TpgqWa80wl6fcmQlXGFwqEUv+/TJOmh+VB9pRqtQRy746zoYTunXQO5MfoRc/5n0Hm84q+aRw33Bv
        UDy6Qiwz5n6aVsaQ92/I/uhW1p5UHEwd7E5pwpkZ4GKW++Tf+w+uSwf6hRRhdzFOjXTSsTV7/0pyJ
        QWelvfvbIjamADbggOWGlfBxbyrW7fa3Avlj1wPnVueNUs4gIf3qD/ZPYp7p+IRNJuHLYLQxOnkiN
        QA/wgb21gIghxeb8kEBu722dqQIls8nS49o3mwiBUFbGH5yVNc8xDsi3zzzxvFiQ2a/+WiCpidphK
        2HeotcqEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKgoh-00080T-6w; Thu, 08 Nov 2018 09:41:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8C5120284F98; Thu,  8 Nov 2018 10:41:33 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:41:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181108094133.GN9761@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
 <20181106115335.GQ22431@hirez.programming.kicks-ass.net>
 <20181106115558.GB22485@hirez.programming.kicks-ass.net>
 <8c386375-b801-8adb-602e-40c73a7efedc@redhat.com>
 <20181107213229.GB2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107213229.GB2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 01:32:29PM -0800, Tejun Heo wrote:

> How about the following?
> 
> Interface file is named "cpuset.cpus.partition" as it's a partition of
> cpus.  The writeable keys are "root" and "member" - a partition root
> and a partition member.  When "root" is requested but can't be
> satisfied it shows "root invalid".  This seems pretty consistent with
> cgroup.type and other cpuset files.

I can live with that, thanks!
