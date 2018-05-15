Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeEOCwR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:52:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOCwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:52:15 -0400
Date: Mon, 14 May 2018 22:52:13 -0400 (EDT)
Message-Id: <20180514.225213.1789810083198383905.davem@davemloft.net>
To: dave@stgolabs.net
Cc: akpm@linux-foundation.org, tgraf@suug.ch, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dbueso@suse.de
Subject: Re: [PATCH] lib/rhashtable: reorder some inititalization sequences
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514151332.31352-1-dave@stgolabs.net>
References: <20180514151332.31352-1-dave@stgolabs.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>
Date: Mon, 14 May 2018 08:13:32 -0700

> rhashtable_init() allocates memory at the very end of the
> call, once everything is setup; with the exception of the
> nelems parameter. However, unless the user is doing something
> bogus with params for which -EINVAL is returned, memory
> allocation is the only operation that can trigger the call
> to fail.
> 
> Thus move bucket_table_alloc() up such that we fail back to
> the caller asap, instead of doing useless checks. This is
> safe as the the table allocation isn't using the halfly
> setup 'ht' structure and bucket_table_alloc() call chain only
> ends up using the ht->nulls_base member in INIT_RHT_NULLS_HEAD.
> 
> Also move the locking initialization down to the end.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

The user potentially "doing something bogus" is why the most
expensive part of the initialization (the memory allocation)
is done after everything else is validated.

I think it's best to keep things as-is.
