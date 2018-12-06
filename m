Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846E821479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVEGvgeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846E821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeLFNgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:36:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A9bUj8qKByziXJe8knW/1KJe5DNQkkrr4jgFlsvWEEg=; b=DVEGvgeRUGwardkU8UrrHmZBW
        c3cYsUxapXICUyfP2vCoAUXX/qGnB8RssgmaGEqySCYnIhdH5SBJ8I+kqfe0NuLofnwjGeZkqpnWk
        JRtvr+EvoqI49mGbxFA/vN5hwe2HBorDdMArFLHxOqfXkN1EsZX3g9tD3YgQd5dkOFx+jze1Uic+0
        cMvBVTgdS9r/4YCL25/tgaNHulMq7vgzpfMzN6pVcWU6Jo67EfV1iek8c2qGd8gSAjc4gVcJzzdOC
        w/h7zq65V4RtWVje47JL/TRcmXO4E/XlcZDeU3HX0wS73CIBOAT8FubGSJIHBZs/mPdpjEYzAFV8a
        u31kk82fQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUtpE-0003qK-CO; Thu, 06 Dec 2018 13:36:20 +0000
Date:   Thu, 6 Dec 2018 05:36:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] radix tree: Don't return internal entries on lookup
Message-ID: <20181206133620.GC24603@bombadil.infradead.org>
References: <154408284374.405977.5950625525821388567.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154408284374.405977.5950625525821388567.stgit@bahia.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:54:03AM +0100, Greg Kurz wrote:
> Commit 66ee620f06f9 ("idr: Permit any valid kernel pointer to
> be stored") changed the radix tree lookup so that it stops when
> reaching the bottom of the tree. But radix_tree_descend() may have
> changed the node variable to point to an internal entry which then
> gets returned to the caller and bad things may happen.

> pe_data is equal to R3 which is the return value of radix_tree_lookup(),
> ie, 0x406 == RADIX_TREE_RETRY.

Thank you for the report and the debugging!  I've decided to fix the
problem slightly differently, and I've also added a test to the test-suite
that reproduces the problem in only a few iterations (the largest I've
seen is a few hundred; and often it'll reproduce in under twenty).

You can see it here:
http://git.infradead.org/users/willy/linux-dax.git/commitdiff/eff3860bbfedbac6edac57fb0d7f3a60e860c1c3

I'll give the build bots a couple of days to chew on it and then ask
Linus to pull it.
