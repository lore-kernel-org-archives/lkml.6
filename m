Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DCC219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DCC219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeGFHXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:23:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753476AbeGFHXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:23:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99439AFAC;
        Fri,  6 Jul 2018 07:23:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 06 Jul 2018 17:22:30 +1000
Subject: [PATCH 0/5] Rhashtable: convert to bit-spin locks.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086169828.24852.10332573315056854948.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bit-spinlocks are ideal for locking individual chains of a
hashtable as they do not take extra memory, and they share
a cachle line with the chain head which needs to be loaded (and often
written) anyway.

bit-spinlocks are not fair, but this is only a problem if contention
is likely.  Resizing hashtable are designed to avoid contention on
individual chains - when chains have more than a very few object, the
table is resized.

This is a resend of patches which have been previously posted.  The
only comment raised before concerned the need for lockdep support and
so the last patch was written and posted.
The only changes is that another occurrence of 'locks_mul' needed to
be removed.

Thanks,
NeilBrown

---

NeilBrown (5):
      rhashtable: use cmpxchg() in nested_table_alloc()
      rhashtable: don't hold lock on first table throughout insertion.
      rhashtable: allow rht_bucket_var to return NULL.
      rhashtable: use bit_spin_locks to protect hash bucket.
      rhashtable: add lockdep tracking to bucket bit-spin-locks.


 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  216 +++++++++++++++++++++++++-------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  188 ++++++++++++++++-----------------
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 10 files changed, 233 insertions(+), 180 deletions(-)

--
Signature

