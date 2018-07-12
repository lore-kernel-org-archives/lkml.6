Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6EBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AA021471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AA021471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbeGLP0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:26:17 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:39325 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732491AbeGLP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:26:17 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 11:26:16 EDT
Received: from player756.ha.ovh.net (unknown [10.109.108.62])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2CE33D805D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:59:27 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id CC7281200C3;
        Thu, 12 Jul 2018 16:59:15 +0200 (CEST)
Date:   Thu, 12 Jul 2018 16:59:14 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 4/6] 9p: Embed wait_queue_head into
 p9_req_t
Message-ID: <20180712165914.7d1f949f@bahia.lan>
In-Reply-To: <20180712144012.GA21574@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
        <20180711210225.19730-5-willy@infradead.org>
        <20180712163649.36057b6e@bahia.lan>
        <20180712144012.GA21574@nautica>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7840485479542331648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrgeekgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 16:40:12 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Greg Kurz wrote on Thu, Jul 12, 2018:
> > This is true when all tags have been used at least once. But the current code
> > lazily allocates the wait_queue_head_t, ie, only when a tag is used for the
> > first time. Your patch causes a full row of wait_quest_head_t to be pre-allocated.
> > 
> > ie, P9_ROW_MAXTAG * 24 = 255 * 24 = 6120
> > 
> > instead of (P9_ROW_MAXTAG * 8) + 24 = 255 * 8 + 24 = 2064
> > 
> > This is nearly a page of allocated memory that might be never used.
> > 
> > Not sure if this is a problem though...  
> 
> I thought the exact same, but the next patch in the serie removes that
> array and allocates even more lazily with a slab, so this was a
> no-brainer :)
> 

Ah ? I haven't started looking at that *big* other patch yet... :)
