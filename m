Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFAEpL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeFAEpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:06 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [RFC PATCH 00/18] Assorted rhashtable improvements
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 the following is my current set of rhashtable improvements.
 Some have been seen before, some have been improved,
 others are new.

 They include:
   working list-nulls support
   stability improvements for rhashtable_walk
   bit-spin-locks for simplicity and reduced cache footprint
      during modification
   optional per-cpu locks to improve scalability for modificiation
   various cleanups

 If I get suitable acks I will send more focused subsets to Davem for
 inclusion.

 I had said previously that I thought there was a way to provide
 stable walking of an rhl table in the face of concurrent
 insert/delete.  Having tried, I no longer think this can be
 done without substantial impact to lookups and/or other operations.
 The idea of attaching a marker to the list is incompatible with
 the normal rules for working with rcu-protected lists ("attaching"
 might be manageable.  "moving" or "removing" is the problematic part).

 The last patch is the one I'm least certain of.  It seems like a good
 idea to improve the chance of a walk avoiding any rehash, but it
 cannot provide a solid guarantee without risking a denial-of-service.
 My compromise is to guarantee no rehashes caused by shrinkage, and
 discourage rehashes caused by growth.  I'm not yet sure if that is
 sufficiently valuable, but I thought I would include the patch in the
 RFC anyway.

Thanks,
NeilBrown


---

NeilBrown (18):
      rhashtable: silence RCU warning in rhashtable_test.
      rhashtable: split rhashtable.h
      rhashtable: remove nulls_base and related code.
      rhashtable: detect when object movement might have invalidated a lookup
      rhashtable: simplify INIT_RHT_NULLS_HEAD()
      rhashtable: simplify nested_table_alloc() and rht_bucket_nested_insert()
      rhashtable: use cmpxchg() to protect ->future_tbl.
      rhashtable: clean up dereference of ->future_tbl.
      rhashtable: use cmpxchg() in nested_table_alloc()
      rhashtable: remove rhashtable_walk_peek()
      rhashtable: further improve stability of rhashtable_walk
      rhashtable: add rhashtable_walk_prev()
      rhashtable: don't hold lock on first table throughout insertion.
      rhashtable: allow rht_bucket_var to return NULL.
      rhashtable: use bit_spin_locks to protect hash bucket.
      rhashtable: allow percpu element counter
      rhashtable: rename rht_for_each*continue as *from.
      rhashtable: add rhashtable_walk_delay_rehash()


 .clang-format                                     |    8 
 MAINTAINERS                                       |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h        |    1 
 drivers/staging/lustre/lustre/fid/fid_request.c   |    2 
 drivers/staging/lustre/lustre/fld/fld_request.c   |    1 
 drivers/staging/lustre/lustre/include/lu_object.h |    1 
 include/linux/ipc.h                               |    2 
 include/linux/ipc_namespace.h                     |    2 
 include/linux/mroute_base.h                       |    2 
 include/linux/percpu_counter.h                    |    4 
 include/linux/rhashtable-types.h                  |  147 ++++++
 include/linux/rhashtable.h                        |  537 +++++++++++----------
 include/net/inet_frag.h                           |    2 
 include/net/netfilter/nf_flow_table.h             |    2 
 include/net/sctp/structs.h                        |    2 
 include/net/seg6.h                                |    2 
 include/net/seg6_hmac.h                           |    2 
 ipc/msg.c                                         |    1 
 ipc/sem.c                                         |    1 
 ipc/shm.c                                         |    1 
 ipc/util.c                                        |    2 
 lib/rhashtable.c                                  |  481 +++++++++++--------
 lib/test_rhashtable.c                             |   22 +
 net/bridge/br_fdb.c                               |    1 
 net/bridge/br_vlan.c                              |    1 
 net/bridge/br_vlan_tunnel.c                       |    1 
 net/ipv4/inet_fragment.c                          |    1 
 net/ipv4/ipmr.c                                   |    2 
 net/ipv4/ipmr_base.c                              |    1 
 net/ipv6/ip6mr.c                                  |    2 
 net/ipv6/seg6.c                                   |    1 
 net/ipv6/seg6_hmac.c                              |    1 
 net/netfilter/nf_tables_api.c                     |    1 
 net/sctp/input.c                                  |    1 
 net/sctp/socket.c                                 |    1 
 35 files changed, 760 insertions(+), 481 deletions(-)
 create mode 100644 include/linux/rhashtable-types.h

--
Signature
