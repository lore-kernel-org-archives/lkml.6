Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74062C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427C208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4427C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeLMKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:01:47 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:49245 "EHLO
        9.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeLMKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:01:46 -0500
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2018 05:01:45 EST
Received: from player732.ha.ovh.net (unknown [10.109.146.132])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id DDC7B43290
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:43:19 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id 46C37AE027D;
        Thu, 13 Dec 2018 09:43:15 +0000 (UTC)
Date:   Thu, 13 Dec 2018 10:43:14 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] radix tree: Don't return internal entries on lookup
Message-ID: <20181213104314.71fd74eb@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20181206172102.0538b2a9@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154408284374.405977.5950625525821388567.stgit@bahia.lan>
        <20181206133620.GC24603@bombadil.infradead.org>
        <20181206172102.0538b2a9@bahia.lab.toulouse-stg.fr.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3005871279397312837
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudehvddgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 17:21:02 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Thu, 6 Dec 2018 05:36:20 -0800
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Dec 06, 2018 at 08:54:03AM +0100, Greg Kurz wrote:  
> > > Commit 66ee620f06f9 ("idr: Permit any valid kernel pointer to
> > > be stored") changed the radix tree lookup so that it stops when
> > > reaching the bottom of the tree. But radix_tree_descend() may have
> > > changed the node variable to point to an internal entry which then
> > > gets returned to the caller and bad things may happen.    
> >   
> > > pe_data is equal to R3 which is the return value of radix_tree_lookup(),
> > > ie, 0x406 == RADIX_TREE_RETRY.    
> > 
> > Thank you for the report and the debugging!  I've decided to fix the
> > problem slightly differently, and I've also added a test to the test-suite  
> 
> Heh this is the fix I came up with initially, but then I wasn't sure
> if other kind of internal entries could possibly be returned by
> radix_tree_descend() so I tried to be smarter... I should have sticked
> to my initial intuition :)
> 
> > that reproduces the problem in only a few iterations (the largest I've
> > seen is a few hundred; and often it'll reproduce in under twenty).
> > 
> > You can see it here:
> > http://git.infradead.org/users/willy/linux-dax.git/commitdiff/eff3860bbfedbac6edac57fb0d7f3a60e860c1c3
> >   
> 
> You can add:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>
> 
> > I'll give the build bots a couple of days to chew on it and then ask
> > Linus to pull it.  
> 

Hi Matthew and Andrew,

I see this fix is in linux-next. I just want to make sure it will
land in 4.20 in order to avoid kernel panics in the OCXL driver.

Cheers,

--
Greg


> Great !
> 
> Cheers,
> 
> --
> Greg

