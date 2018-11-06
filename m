Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059EC206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPmdbnof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059EC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbeKFVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:02:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeKFVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nhV7MP9fmom1olzqQQOBdE69jYgH85uDi+QqRtqAtg8=; b=WPmdbnofwrpymTzT3W5uqbalC
        yXkbFo768UY/COShyd5oe5c/+DoDMcPiDFDEILxY+/wsrTsSwSUZ4F05ry8gNXXwaE5gHDPLs8QTC
        8FOM6qPfvhqcAWFF4hlWMrzKVwo9XHGgxrVAVxG+ZumK+LJlNl3izMYnOdazqgP+8wfFSSQVOK+id
        6eylgHIMpBHZgN8MdD3Avg4w7iz6BYU7Mi5gH8AH+esD0/JhIveGhdjryxAsGVHr9CcS/xdcFXBt2
        +cRP7RsEAQh4WglbaXK9j++C8OZn1Lhy1XQldL9yfTI+TYrJ4ztw0+qI2LCjq1LVDeK76dBmdObhS
        jXOrHc29w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJzfa-0005i1-Bz; Tue, 06 Nov 2018 11:37:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D61242029F9FF; Tue,  6 Nov 2018 12:37:12 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:37:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 05/12] cpuset: Add an error state to
 cpuset.sched.partition
Message-ID: <20181106113712.GL22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:30PM -0400, Waiman Long wrote:
> Handling error returned by update_parent_subparts_cpumask() in
> update_cpumasks_hier() is problematic as the states may become
> inconsistent. To avoid that and increase flexibility in handling other
> error cases, a new error state (-1) is added to the partition_root_state
> flag. This new error state is set internally and user cannot write this
> value to "cpuset.sched.partition".
> 
> In this error state, the partition root becomes an erroneous one. It is
> no longer a real partition root, but the CS_CPU_EXCLUSIVE flag will
> still be set as it can be changed back to a real one if appropriate
> change happens later on.

I feel this Changelog should be much more explicit about the reasons
this -1 state can happen. As is, I've got no clue.
