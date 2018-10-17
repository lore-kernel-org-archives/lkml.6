Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C021214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7rlTd+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C021214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJQKC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeJQKC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:02:57 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFCE214C4;
        Wed, 17 Oct 2018 02:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539742177;
        bh=2IjcjD5/vhD7G3iaWIDtbvodTFcuD1fZAzHoDWY6/fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7rlTd+zeg7Jj2T2AnKfW5fWPmI63k8eCYiuvHJpwmXKPM5jk10zP28XtfRsUFffU
         brvyEu4O4OINBZif2b8nSo6c2wQcjuKBOhzo0mmxfw71/HlwYrsUZXtcaz2EtCBksG
         HliviyyBUcmForHgn+gdMWc3Tq/lrzouxvDo8uD0=
Date:   Wed, 17 Oct 2018 04:09:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20181017020933.GC24723@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
> C) How does it work?
> --------------------
> 
> This patch series introduces hierarchical runqueues, that represent larger
> and larger fractions of the system. By default, there is one runqueue per
> scheduling domain. These additional levels of runqueues are activated by
> the "cosched_max_level=" kernel command line argument. The bottom level is
> 0.
> 
> One CPU per hierarchical runqueue is considered the leader, who is
> primarily responsible for the scheduling decision at this level. Once the
> leader has selected a task group to execute, it notifies all leaders of the
> runqueues below it to select tasks/task groups within the selected task
> group.
> 
> For each task-group, the user can select at which level it should be
> scheduled. If you set "cpu.scheduled" to "1", coscheduling will typically
> happen at core-level on systems with SMT. That is, if one SMT sibling
> executes a task from this task group, the other sibling will do so, too. If
> no task is available, the SMT sibling will be idle. With "cpu.scheduled"
> set to "2" this is extended to the next level, which is typically a whole
> socket on many systems. And so on.  If you feel, that this does not provide
> enough flexibility, you can specify "cosched_split_domains" on the kernel
> command line to create more fine-grained scheduling domains for your
> system.

Have you considered using cpuset to specify the set of CPUs inside which
you want to coschedule task groups in? Perhaps that would be more flexible
and intuitive to control than this cpu.scheduled value.

Unless you require this feature to act always symmetrical through the branches
of a given domain tree?

Thanks.
