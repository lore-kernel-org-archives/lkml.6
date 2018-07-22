Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30202075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30202075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGVWw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:52:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730629AbeGVWw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:52:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6MLn5o7139981
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:54:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kcvkepuxv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:54:49 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 22 Jul 2018 17:54:48 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 22 Jul 2018 17:54:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6MLsje16816202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Jul 2018 21:54:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903C6B2068;
        Sun, 22 Jul 2018 17:54:29 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C011B2065;
        Sun, 22 Jul 2018 17:54:29 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.230.11])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 22 Jul 2018 17:54:29 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4473516C2E1C; Sun, 22 Jul 2018 14:54:46 -0700 (PDT)
Date:   Sun, 22 Jul 2018 14:54:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.vnet.ibm.com
References: <153086169828.24852.10332573315056854948.stgit@noble>
 <153086175009.24852.7782466383056542839.stgit@noble>
 <20180720075409.kfckhodsnvktift7@gondor.apana.org.au>
 <20180720144152.GW12945@linux.vnet.ibm.com>
 <87muulqq8q.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muulqq8q.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072221-0052-0000-0000-000003120323
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009412; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01064670; UDB=6.00546834; IPR=6.00842522;
 MB=3.00022267; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-22 21:54:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072221-0053-0000-0000-00005D74AABF
Message-Id: <20180722215446.GH12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807220259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 12:25:41PM +1000, NeilBrown wrote:
> On Fri, Jul 20 2018, Paul E. McKenney wrote:
> 
> > On Fri, Jul 20, 2018 at 03:54:09PM +0800, Herbert Xu wrote:
> >> On Fri, Jul 06, 2018 at 05:22:30PM +1000, NeilBrown wrote:
> >> > rhashtable_try_insert() currently hold a lock on the bucket in
> >> > the first table, while also locking buckets in subsequent tables.
> >> > This is unnecessary and looks like a hold-over from some earlier
> >> > version of the implementation.
> >> > 
> >> > As insert and remove always lock a bucket in each table in turn, and
> >> > as insert only inserts in the final table, there cannot be any races
> >> > that are not covered by simply locking a bucket in each table in turn.
> >> > 
> >> > When an insert call reaches that last table it can be sure that there
> >> > is no match entry in any other table as it has searched them all, and
> >> > insertion never happens anywhere but in the last table.  The fact that
> >> > code tests for the existence of future_tbl while holding a lock on
> >> > the relevant bucket ensures that two threads inserting the same key
> >> > will make compatible decisions about which is the "last" table.
> >> > 
> >> > This simplifies the code and allows the ->rehash field to be
> >> > discarded.
> >> > 
> >> > We still need a way to ensure that a dead bucket_table is never
> >> > re-linked by rhashtable_walk_stop().  This can be achieved by
> >> > calling call_rcu() inside the locked region, and checking
> >> > ->rcu.func in rhashtable_walk_stop().  If it is not NULL, then
> >> > the bucket table is empty and dead.
> >> > 
> >> > Signed-off-by: NeilBrown <neilb@suse.com>
> >> 
> >> ...
> >> 
> >> > @@ -339,13 +338,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
> >> >  	spin_lock(&ht->lock);
> >> >  	list_for_each_entry(walker, &old_tbl->walkers, list)
> >> >  		walker->tbl = NULL;
> >> > -	spin_unlock(&ht->lock);
> >> >  
> >> >  	/* Wait for readers. All new readers will see the new
> >> >  	 * table, and thus no references to the old table will
> >> >  	 * remain.
> >> > +	 * We do this inside the locked region so that
> >> > +	 * rhashtable_walk_stop() can check ->rcu.func and know
> >> > +	 * not to re-link the table.
> >> >  	 */
> >> >  	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
> >> > +	spin_unlock(&ht->lock);
> >> >  
> >> >  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
> >> >  }
> >> 
> >> ...
> >> 
> >> > @@ -964,7 +942,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
> >> >  	ht = iter->ht;
> >> >  
> >> >  	spin_lock(&ht->lock);
> >> > -	if (tbl->rehash < tbl->size)
> >> > +	if (tbl->rcu.func == NULL)
> >> >  		list_add(&iter->walker.list, &tbl->walkers);
> >> >  	else
> >> >  		iter->walker.tbl = NULL;
> >> 
> >> This appears to be relying on implementation details within RCU.
> >> Paul, are you OK with rhashtable doing this trick?
> >
> > The notion of accessing objects that are already on RCU's callback lists
> > makes me -very- nervous because this sort of thing is not easy to
> > get right.  After all, if you are accessing something that is already
> > on one of RCU's callback lists, RCU might invoke the callback it at any
> > time (thus freeing it in this case), and because it is already on RCU's
> > callback lists, rcu_read_lock() is going to be of no help whatsoever.
> 
> I don't follow that last line.  If some other thread has already called
> rcu_read_lock() when call_rcu() is called, then that other threads
> rcu_read_lock() will certainly help to ensure that the object doesn't
> get freed.  This code assumes that it also ensures that rcu.func will
> not be changed before the other thread calls rcu_read_unlock() and
> allows the grace period to end.
> (There is nothing explicitly about rcu lists here, just rcu.func).
> 
> >
> > In addition, RCU does no ordering on its store to ->func, but the ht->lock
> > compensates in this case.  But suppose rhashtable_walk_stop() sees the
> > pointer as non-NULL.  What prevents RCU from freeing the bucket table out
> > from under rhashtable_walk_stop()?  In v4.17, bucket_table_free_rcu()
> > just does some calls to various deallocators, which does not provide
> > the necessary synchronization.
> >
> > Does the rhashtable_iter structure use some trick to make this safe?
> > Or has synchronization been added to bucket_table_free_rcu()?  Or is
> > some other trick in use?
> >
> > 							Thanx, Paul
> 
> When rhashtable_rehash_table() has copied all objects out of a
> bucket_table, it must then disconnect any paused walkers and free the
> table. (a 'paused' walker has called rhashtable_walk_stop() and dropped
> the rcu read lock).
> It sets walk->tbl=NULL (thus implicitly removing from the list) and
> calls call_rcu(...,bucket_table_free_rcu) under a spinlock.
> 
> When rhashtable_walk_stop() is called, it needs to know whether it is
> safe to attach the walker to the bucket_table().
> It takes the same spin lock as above while still holding the
> rcu_read_lock that it took some time ago.
> If it gets the spinlock before rhashtable_rehash_table() gets it, then
> rcu.func will be NULL (tables are allocated with kzalloc) and the walker
> is attached to the table.  If it gets the spinlock after
> rhashtable_rehash_table() gets it, then rcu.func will not be NULL and
> the walker will not be attached to the table.
> 
> The only interesting question is whether RCU might ever set rcu.func to
> NULL (or change it at all) *after* call_rcu() has been called, and
> *before* the current grace period ends.
> If you don't want to guarantee that it doesn't, I can add an extra flag
> field to the table to say "this table must not be attached walkers", but
> I currently think that should be unnecessary.

One issue is that the ->func pointer can legitimately be NULL while on
RCU's callback lists.  This happens when someone invokes kfree_rcu()
with the rcu_head structure at the beginning of the enclosing structure.
I could add an offset to avoid this, or perhaps the kmalloc() folks
could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
the slab allocators, so that RCU only ever sees function pointers in
the ->func field.

Either way, this should be hidden behind an API to allow adjustments
to be made if needed.  Maybe something like is_after_call_rcu()?
This would (for example) allow debug-object checks to be used to catch
check-after-free bugs.

Would something of that sort work for you?

							Thanx, Paul

