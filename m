Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05428C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9115F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGey3TVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9115F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJWB0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:26:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWB0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cxrK62JfnGPPJk3XW7EJ1jhir/EKRH+8X2rTeI5dC94=; b=jGey3TVbR+XHCuvTNoGS0Rd/U
        iqTftU/4iX7AWcHyqxPJJon1QSuIIIZhcIDpCORuiD3gDaFPm4d7V4i/IeuvBh4HLGdjHOzRlxaiO
        pk7bVEhvTickb7iNxmujfXons7IGNcpZ76rW/34DDxeFiYFM/GUISpR/xUqKgiqud1DWawQdeITu9
        1MpP+YVM5PZzbXJuWc8iRrxSRI0KbkjpM632ZM2X4RpUZxYshGHDBm6SaVpNIfrtDtCwidttXusUH
        lxtSDUDximdggP3lBn2ec0TN4AZiZzlwTdxA2lAYkI9HKo19eMV+zmVZCH8oG8dPekPQ9/igY10n4
        vxs4EcBIQ==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEdfA-00011D-9e; Mon, 22 Oct 2018 17:06:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id B8C1C6E0AED; Mon, 22 Oct 2018 19:06:04 +0200 (CEST)
Date:   Mon, 22 Oct 2018 19:06:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steve Sistare <steven.sistare@oracle.com>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
Message-ID: <20181022170604.GG3117@worktop.programming.kicks-ass.net>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 07:59:40AM -0700, Steve Sistare wrote:
> The STEAL feature causes regressions on hackbench on larger NUMA systems,
> so disable it on systems with more than sched_steal_node_limit nodes
> (default 2).

How come? From a quick read the stealing is per LLC, where do we steal
across nodes?
