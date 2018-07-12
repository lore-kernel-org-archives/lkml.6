Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7B620875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeGLFy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:54:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeGLFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:54:57 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 68CCD13FDE78F;
        Wed, 11 Jul 2018 22:47:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 22:46:58 -0700 (PDT)
Message-Id: <20180711.224658.2077863065492745521.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH resend] rhashtable: detect when object movement might
 have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87k1q8yh70.fsf@notabene.neil.brown.name>
References: <152782824943.30340.8224535954517915320.stgit@noble>
        <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
        <87k1q8yh70.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Jul 2018 22:47:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Fri, 06 Jul 2018 17:08:35 +1000

> 
> Some users of rhashtable might need to change the key
> of an object and move it to a different location in the table.
> Other users might want to allocate objects using
> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
> being used for a different (type-compatible) purpose and similarly
> end up in a different hash-chain.
> 
> To support these, we store a unique NULLS_MARKER at the end of
> each chain, and when a search fails to find a match, we check
> if the NULLS marker found was the expected one.  If not,
> the search is repeated.
> 
> The unique NULLS_MARKER is derived from the address of the
> head of the chain.
> 
> If an object is removed and re-added to the same hash chain, we won't
> notice by looking that the NULLS marker.  In this case we must be sure
> that it was not re-added *after* its original location, or a lookup may
> incorrectly fail.  The easiest solution is to ensure it is inserted at
> the start of the chain.  insert_slow() already does that,
> insert_fast() does not.  So this patch changes insert_fast to always
> insert at the head of the chain.
> 
> Note that such a user must do their own double-checking of
> the object found by rhashtable_lookup_fast() after ensuring
> mutual exclusion which anything that might change the key, such as
> successfully taking a new reference.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Applied to net-next.
