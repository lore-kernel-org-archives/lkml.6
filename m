Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD50C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD16E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD16E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbeGYAHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:07:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388679AbeGYAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:07:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OMs9hK136305
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:58:30 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kecp296fr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:58:29 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 18:58:28 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 18:58:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6OMwO4X11075966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 22:58:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C9AB2065;
        Tue, 24 Jul 2018 18:58:07 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B4DB2064;
        Tue, 24 Jul 2018 18:58:07 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 18:58:07 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0389816CA2D3; Tue, 24 Jul 2018 15:58:25 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:58:25 -0700
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
 <20180722215446.GH12945@linux.vnet.ibm.com>
 <87h8kqrhi0.fsf@notabene.neil.brown.name>
 <20180723205625.GZ12945@linux.vnet.ibm.com>
 <87r2jtpqm4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2jtpqm4.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072422-0068-0000-0000-0000031CE824
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065643; UDB=6.00547422; IPR=6.00843501;
 MB=3.00022307; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-24 22:58:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072422-0069-0000-0000-00004525D3AC
Message-Id: <20180724225825.GE12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:52:03AM +1000, NeilBrown wrote:
> On Mon, Jul 23 2018, Paul E. McKenney wrote:
> 
> > On Mon, Jul 23, 2018 at 09:13:43AM +1000, NeilBrown wrote:
> >> On Sun, Jul 22 2018, Paul E. McKenney wrote:
> >> >
> >> > One issue is that the ->func pointer can legitimately be NULL while on
> >> > RCU's callback lists.  This happens when someone invokes kfree_rcu()
> >> > with the rcu_head structure at the beginning of the enclosing structure.
> >> > I could add an offset to avoid this, or perhaps the kmalloc() folks
> >> > could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
> >> > the slab allocators, so that RCU only ever sees function pointers in
> >> > the ->func field.
> >> >
> >> > Either way, this should be hidden behind an API to allow adjustments
> >> > to be made if needed.  Maybe something like is_after_call_rcu()?
> >> > This would (for example) allow debug-object checks to be used to catch
> >> > check-after-free bugs.
> >> >
> >> > Would something of that sort work for you?
> >> 
> >> Yes, if you could provide an is_after_call_rcu() API, that would
> >> perfectly suit my use-case.
> >
> > After beating my head against the object-debug code a bit, I have to ask
> > if it would be OK for you if the is_after_call_rcu() API also takes the
> > function that was passed to RCU.
> 
> Sure.  It feels a bit clumsy, but I can see it could be easier to make
> robust.
> So yes: I'm fine with pass the same function and rcu_head to both
> call_rcu() and is_after_call_rcu().  Actually, when I say it like that,
> it seems less clumsy :-)

How about like this?  (It needs refinements, like lockdep, but should
get the gist.)

							Thanx, Paul

------------------------------------------------------------------------

commit 5aa0ebf4799b8bddbbd0124db1c008526e99fc7c
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Jul 24 15:28:09 2018 -0700

    rcu: Provide functions for determining if call_rcu() has been invoked
    
    This commit adds is_after_call_rcu() and is_after_call_rcu_init()
    functions to help RCU users detect when another CPU has passed
    the specified rcu_head structure and function to call_rcu().
    The is_after_call_rcu_init() should be invoked before making the
    structure visible to RCU readers, and then the is_after_call_rcu() may
    be invoked from within an RCU read-side critical section on an rcu_head
    structure that was obtained during a traversal of the data structure
    in question.  The is_after_call_rcu() function will return true if the
    rcu_head structure has already been passed (with the specified function)
    to call_rcu(), otherwise it will return false.
    
    If is_after_call_rcu_init() has not been invoked on the rcu_head
    structure or if the rcu_head (AKA callback) has already been invoked,
    then is_after_call_rcu() will do WARN_ON_ONCE().
    
    Reported-by: NeilBrown <neilb@suse.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e4f821165d0b..82e5a91539b5 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -857,6 +857,45 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
 
 
+/* Has the specified rcu_head structure been handed to call_rcu()? */
+
+/*
+ * is_after_call_rcu_init - Initialize rcu_head for is_after_call_rcu()
+ * @rhp: The rcu_head structure to initialize.
+ *
+ * If you intend to invoke is_after_call_rcu() to test whether a given
+ * rcu_head structure has already been passed to call_rcu(), then you must
+ * also invoke this is_after_call_rcu_init() function on it just after
+ * allocating that structure.  Calls to this function must not race with
+ * calls to call_rcu(), is_after_call_rcu(), or callback invocation.
+ */
+static inline void is_after_call_rcu_init(struct rcu_head *rhp)
+{
+	rhp->func = (rcu_callback_t)~0L;
+}
+
+/*
+ * is_after_call_rcu - Has this rcu_head been passed to call_rcu()?
+ * @rhp: The rcu_head structure to test.
+ * @func: The function passed to call_rcu() along with @rhp.
+ *
+ * Returns @true if the @rhp has been passed to call_rcu() with @func, and
+ * @false otherwise.  Emits a warning in any other case, including the
+ * case where @rhp has already been invoked after a grace period.
+ * Calls to this function must not race with callback invocation.  One
+ * way to avoid such races is to enclose the call to is_after_call_rcu()
+ * in an RCU read-side critical section that includes a read-side fetch
+ * of the pointer to the structure containing @rhp.
+ */
+static inline bool is_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
+{
+	if (READ_ONCE(rhp->func) == f)
+		return true;
+	WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
+	return false;
+}
+
+
 /* Transitional pre-consolidation compatibility definitions. */
 
 static inline void synchronize_rcu_bh(void)
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5dec94509a7e..4c56c1d98fb3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -224,6 +224,7 @@ void kfree(const void *);
  */
 static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 {
+	rcu_callback_t f;
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
@@ -234,7 +235,9 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 		return true;
 	} else {
 		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
-		head->func(head);
+		f = head->func;
+		WRITE_ONCE(head->func, (rcu_callback_t)0L);
+		f(head);
 		rcu_lock_release(&rcu_callback_map);
 		return false;
 	}

