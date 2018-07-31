Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8BB20840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8BB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeGaFwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:52:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbeGaFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:52:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6V4EPRH076898
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:14:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kjg43gujs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:14:31 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 00:14:30 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 00:14:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V4ERUr5046604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 04:14:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12180B2068;
        Tue, 31 Jul 2018 00:14:01 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D14C2B2065;
        Tue, 31 Jul 2018 00:14:00 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.140.233])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 00:14:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0486416CA604; Mon, 30 Jul 2018 21:14:25 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:14:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.vnet.ibm.com
References: <87h8kqrhi0.fsf@notabene.neil.brown.name>
 <20180723205625.GZ12945@linux.vnet.ibm.com>
 <87r2jtpqm4.fsf@notabene.neil.brown.name>
 <20180724225825.GE12945@linux.vnet.ibm.com>
 <87in53oqzz.fsf@notabene.neil.brown.name>
 <20180725152250.GN12945@linux.vnet.ibm.com>
 <87r2jpmqu2.fsf@notabene.neil.brown.name>
 <20180727031815.GW24813@linux.vnet.ibm.com>
 <20180727145731.GA2780@linux.vnet.ibm.com>
 <87zhy8s05i.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhy8s05i.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073104-0072-0000-0000-00000387ECA8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009460; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068318; UDB=6.00549185; IPR=6.00846471;
 MB=3.00022418; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 04:14:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073104-0073-0000-0000-000048E6E917
Message-Id: <20180731041425.GI24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:45:45AM +1000, NeilBrown wrote:
> On Fri, Jul 27 2018, Paul E. McKenney wrote:
> 
> > On Thu, Jul 26, 2018 at 08:18:15PM -0700, Paul E. McKenney wrote:
> >> On Fri, Jul 27, 2018 at 11:04:37AM +1000, NeilBrown wrote:
> >> > On Wed, Jul 25 2018, Paul E. McKenney wrote:
> >> > >> 
> >> > >> Looks good ... except ... naming is hard.
> >> > >> 
> >> > >>  is_after_call_rcu_init()  asserts where in the lifecycle we are,
> >> > >>  is_after_call_rcu() tests where in the lifecycle we are.
> >> > >> 
> >> > >>  The names are similar but the purpose is quite different.
> >> > >>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
> >> > >
> >> > > How about rcu_head_init() and rcu_head_after_call_rcu()?
> >> 
> >> Very well, I will pull this change in on my next rebase.
> >
> > Like this?
> 
> Hard to say - unwinding white-space damage in my head is too challenging
> when newlines have been deleted :-(

What???  Don't you like block-structured code?

All kidding aside, how about the following more conventionally formatted
version?

							Thanx, Paul

------------------------------------------------------------------------

commit e3408141ed7d702995b2fdc94703af88aadd226b
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Jul 24 15:28:09 2018 -0700

    rcu: Provide functions for determining if call_rcu() has been invoked
    
    This commit adds rcu_head_init() and rcu_head_after_call_rcu() functions
    to help RCU users detect when another CPU has passed the specified
    rcu_head structure and function to call_rcu().  The rcu_head_init()
    should be invoked before making the structure visible to RCU readers,
    and then the rcu_head_after_call_rcu() may be invoked from within
    an RCU read-side critical section on an rcu_head structure that
    was obtained during a traversal of the data structure in question.
    The rcu_head_after_call_rcu() function will return true if the rcu_head
    structure has already been passed (with the specified function) to
    call_rcu(), otherwise it will return false.
    
    If rcu_head_init() has not been invoked on the rcu_head structure
    or if the rcu_head (AKA callback) has already been invoked, then
    rcu_head_after_call_rcu() will do WARN_ON_ONCE().
    
    Reported-by: NeilBrown <neilb@suse.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Apply neilb naming feedback. ]

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e4f821165d0b..4db8bcacc51a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -857,6 +857,46 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
 
 
+/* Has the specified rcu_head structure been handed to call_rcu()? */
+
+/*
+ * rcu_head_init - Initialize rcu_head for rcu_head_after_call_rcu()
+ * @rhp: The rcu_head structure to initialize.
+ *
+ * If you intend to invoke rcu_head_after_call_rcu() to test whether a
+ * given rcu_head structure has already been passed to call_rcu(), then
+ * you must also invoke this rcu_head_init() function on it just after
+ * allocating that structure.  Calls to this function must not race with
+ * calls to call_rcu(), rcu_head_after_call_rcu(), or callback invocation.
+ */
+static inline void rcu_head_init(struct rcu_head *rhp)
+{
+	rhp->func = (rcu_callback_t)~0L;
+}
+
+/*
+ * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
+ * @rhp: The rcu_head structure to test.
+ * @func: The function passed to call_rcu() along with @rhp.
+ *
+ * Returns @true if the @rhp has been passed to call_rcu() with @func,
+ * and @false otherwise.  Emits a warning in any other case, including
+ * the case where @rhp has already been invoked after a grace period.
+ * Calls to this function must not race with callback invocation.  One way
+ * to avoid such races is to enclose the call to rcu_head_after_call_rcu()
+ * in an RCU read-side critical section that includes a read-side fetch
+ * of the pointer to the structure containing @rhp.
+ */
+static inline bool
+rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
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

