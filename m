Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A3D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q96QQ2L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A3D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeJWGnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:43:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeJWGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0exL65SMWkt7bA7UoCUM+yr7wNAAQcfagAceHNam41U=; b=q96QQ2L5bUuG9AD7rVYRQHwi+
        sDSgEpRdf7Q3T+0WqVRNrH/tJ2gqXeCR2sbuUV9nItNfRjBSh1eosggVVVKJYQ97bTwuiXSxBzLfY
        bCiNXowg2RpQ/ZboGVLH/NWdpZrpAlJ8O12ZaqYfjA65lETvwjvbsPwEYjCvhw/ZHSsYxZ0E6Fof/
        uk1ZwMEZbo8QE+Fapa6AYOnTmsZBOeQD+oM6xnJsoKx+okp3/Qo4ygdP933aBEE9wgrewCZNNeDUW
        BIA3WLTtPahZHPmpMJgBLHa9cEB95+Kj+VoUd1+Ou9jdt8EiYk0SChGMtdp6YhLeOz2umsiVLo1tj
        pUpu3B5GQ==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEib3-0000Kr-LT; Mon, 22 Oct 2018 22:22:49 +0000
Received: by worktop (Postfix, from userid 1000)
        id 323306E08B3; Tue, 23 Oct 2018 00:05:09 +0200 (CEST)
Date:   Tue, 23 Oct 2018 00:05:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
Message-ID: <20181022220509.GC3109@worktop.c.hoisthospitality.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
 <20181022170604.GG3117@worktop.programming.kicks-ass.net>
 <1356a3cc-a9f2-6593-4737-1b20fc5daa75@oracle.com>
 <274b79fd-b001-3d30-3773-7f01940ca8a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274b79fd-b001-3d30-3773-7f01940ca8a6@oracle.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 03:21:20PM -0400, Steven Sistare wrote:
> On 10/22/2018 2:47 PM, Steven Sistare wrote:
> > On 10/22/2018 1:06 PM, Peter Zijlstra wrote:
> >> On Mon, Oct 22, 2018 at 07:59:40AM -0700, Steve Sistare wrote:
> >>> The STEAL feature causes regressions on hackbench on larger NUMA systems,
> >>> so disable it on systems with more than sched_steal_node_limit nodes
> >>> (default 2).
> >>
> >> How come? From a quick read the stealing is per LLC, where do we steal
> >> across nodes?
> > 
> > See the complete explanation in this patch.  It is deeper than can be gleaned
> > from a quick read.
> 
> I should have said a bit more.  Your quick take on stealing is correct, we do
> not steal across nodes.  However, stealing reduces average run queue length which 
> influences wake_affine migrations.  Now see the complete explanation.

Right; read a bit more just now.

hackbench is a fairly poor benchmark for numa performance. One that
comes to mind is multi wharehouse specjbb stuff (assuming you have numa
balance enabled of course).


