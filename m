Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1859C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbeGTPac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:30:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731591AbeGTPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:30:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KEd8sX112413
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:41:55 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kbhaa9btr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:41:55 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 10:41:54 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 10:41:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6KEfpiT6095546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 14:41:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC676B206B;
        Fri, 20 Jul 2018 10:41:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF76B2064;
        Fri, 20 Jul 2018 10:41:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jul 2018 10:41:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9684F16C3E69; Fri, 20 Jul 2018 07:41:52 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:41:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.vnet.ibm.com
References: <153086169828.24852.10332573315056854948.stgit@noble>
 <153086175009.24852.7782466383056542839.stgit@noble>
 <20180720075409.kfckhodsnvktift7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720075409.kfckhodsnvktift7@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072014-0040-0000-0000-00000451C0BC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009398; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01063566; UDB=6.00546171; IPR=6.00841417;
 MB=3.00022230; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-20 14:41:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072014-0041-0000-0000-00000857EEDE
Message-Id: <20180720144152.GW12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:54:09PM +0800, Herbert Xu wrote:
> On Fri, Jul 06, 2018 at 05:22:30PM +1000, NeilBrown wrote:
> > rhashtable_try_insert() currently hold a lock on the bucket in
> > the first table, while also locking buckets in subsequent tables.
> > This is unnecessary and looks like a hold-over from some earlier
> > version of the implementation.
> > 
> > As insert and remove always lock a bucket in each table in turn, and
> > as insert only inserts in the final table, there cannot be any races
> > that are not covered by simply locking a bucket in each table in turn.
> > 
> > When an insert call reaches that last table it can be sure that there
> > is no match entry in any other table as it has searched them all, and
> > insertion never happens anywhere but in the last table.  The fact that
> > code tests for the existence of future_tbl while holding a lock on
> > the relevant bucket ensures that two threads inserting the same key
> > will make compatible decisions about which is the "last" table.
> > 
> > This simplifies the code and allows the ->rehash field to be
> > discarded.
> > 
> > We still need a way to ensure that a dead bucket_table is never
> > re-linked by rhashtable_walk_stop().  This can be achieved by
> > calling call_rcu() inside the locked region, and checking
> > ->rcu.func in rhashtable_walk_stop().  If it is not NULL, then
> > the bucket table is empty and dead.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.com>
> 
> ...
> 
> > @@ -339,13 +338,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
> >  	spin_lock(&ht->lock);
> >  	list_for_each_entry(walker, &old_tbl->walkers, list)
> >  		walker->tbl = NULL;
> > -	spin_unlock(&ht->lock);
> >  
> >  	/* Wait for readers. All new readers will see the new
> >  	 * table, and thus no references to the old table will
> >  	 * remain.
> > +	 * We do this inside the locked region so that
> > +	 * rhashtable_walk_stop() can check ->rcu.func and know
> > +	 * not to re-link the table.
> >  	 */
> >  	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
> > +	spin_unlock(&ht->lock);
> >  
> >  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
> >  }
> 
> ...
> 
> > @@ -964,7 +942,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
> >  	ht = iter->ht;
> >  
> >  	spin_lock(&ht->lock);
> > -	if (tbl->rehash < tbl->size)
> > +	if (tbl->rcu.func == NULL)
> >  		list_add(&iter->walker.list, &tbl->walkers);
> >  	else
> >  		iter->walker.tbl = NULL;
> 
> This appears to be relying on implementation details within RCU.
> Paul, are you OK with rhashtable doing this trick?

The notion of accessing objects that are already on RCU's callback lists
makes me -very- nervous because this sort of thing is not easy to
get right.  After all, if you are accessing something that is already
on one of RCU's callback lists, RCU might invoke the callback it at any
time (thus freeing it in this case), and because it is already on RCU's
callback lists, rcu_read_lock() is going to be of no help whatsoever.

In addition, RCU does no ordering on its store to ->func, but the ht->lock
compensates in this case.  But suppose rhashtable_walk_stop() sees the
pointer as non-NULL.  What prevents RCU from freeing the bucket table out
from under rhashtable_walk_stop()?  In v4.17, bucket_table_free_rcu()
just does some calls to various deallocators, which does not provide
the necessary synchronization.

Does the rhashtable_iter structure use some trick to make this safe?
Or has synchronization been added to bucket_table_free_rcu()?  Or is
some other trick in use?

							Thanx, Paul

