Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEEJ3N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:29:13 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35404 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEEJ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:29:12 -0400
Date: Sat, 5 May 2018 17:29:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rhashtable: fix race in nested_table_alloc()
Message-ID: <20180505092907.2qa3scf6bzvubmtt@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605432.18473.11813271279255176724.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605432.18473.11813271279255176724.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> If two threads run nested_table_alloc() at the same time
> they could both allocate a new table.
> Best case is that one of them will never be freed, leaking memory.
> Worst case is hat entry get stored there before it leaks,
> and the are lost from the table.
> 
> So use cmpxchg to detect the race and free the unused table.
> 
> Fixes: da20420f83ea ("rhashtable: Add nested tables")
> Cc: stable@vger.kernel.org # 4.11+
> Signed-off-by: NeilBrown <neilb@suse.com>

What about the spinlock that's meant to be held around this
operation?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
