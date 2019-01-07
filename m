Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC232C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C19F206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfAGTAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728940AbfAGS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07IoKSZ110302
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 13:59:14 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvcd60d7v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:59:14 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 7 Jan 2019 18:59:13 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 18:59:09 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07Ix8QX23331038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 18:59:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55019B2067;
        Mon,  7 Jan 2019 18:59:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37488B2064;
        Mon,  7 Jan 2019 18:59:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 18:59:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E684A16C607B; Mon,  7 Jan 2019 10:59:31 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:59:31 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, josh@joshtriplett.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: Turn kmemleak_lock to spin lock and RCU
 primitives
Reply-To: paulmck@linux.ibm.com
References: <1546612153-451172-1-git-send-email-zhe.he@windriver.com>
 <20190104183715.GC187360@arrakis.emea.arm.com>
 <f923e9e9-ed73-5054-3d82-b2244c67a65e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f923e9e9-ed73-5054-3d82-b2244c67a65e@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010718-2213-0000-0000-00000337D062
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010362; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000273; SDB=6.01143147; UDB=6.00595104; IPR=6.00923398;
 MB=3.00025019; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-07 18:59:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010718-2214-0000-0000-00005CE06EA4
Message-Id: <20190107185931.GE1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:31:18PM +0800, He Zhe wrote:
> 
> 
> On 1/5/19 2:37 AM, Catalin Marinas wrote:
> > On Fri, Jan 04, 2019 at 10:29:13PM +0800, zhe.he@windriver.com wrote:
> >> It's not necessary to keep consistency between readers and writers of
> >> kmemleak_lock. RCU is more proper for this case. And in order to gain better
> >> performance, we turn the reader locks to RCU read locks and writer locks to
> >> normal spin locks.
> > This won't work.
> >
> >> @@ -515,9 +515,7 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
> >>  	struct kmemleak_object *object;
> >>  
> >>  	rcu_read_lock();
> >> -	read_lock_irqsave(&kmemleak_lock, flags);
> >>  	object = lookup_object(ptr, alias);
> >> -	read_unlock_irqrestore(&kmemleak_lock, flags);
> > The comment on lookup_object() states that the kmemleak_lock must be
> > held. That's because we don't have an RCU-like mechanism for removing
> > removing objects from the object_tree_root:
> >
> >>  
> >>  	/* check whether the object is still available */
> >>  	if (object && !get_object(object))
> >> @@ -537,13 +535,13 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
> >>  	unsigned long flags;
> >>  	struct kmemleak_object *object;
> >>  
> >> -	write_lock_irqsave(&kmemleak_lock, flags);
> >> +	spin_lock_irqsave(&kmemleak_lock, flags);
> >>  	object = lookup_object(ptr, alias);
> >>  	if (object) {
> >>  		rb_erase(&object->rb_node, &object_tree_root);
> >>  		list_del_rcu(&object->object_list);
> >>  	}
> >> -	write_unlock_irqrestore(&kmemleak_lock, flags);
> >> +	spin_unlock_irqrestore(&kmemleak_lock, flags);
> > So here, while list removal is RCU-safe, rb_erase() is not.
> >
> > If you have time to implement an rb_erase_rcu(), than we could reduce
> > the locking in kmemleak.
> 
> Thanks, I really neglected that rb_erase is not RCU-safe here.
> 
> I'm not sure if it is practically possible to implement rb_erase_rcu. Here
> is my concern:
> In the code paths starting from rb_erase, the tree is tweaked at many
> places, in both __rb_erase_augmented and ____rb_erase_color. To my
> understanding, there are many intermediate versions of the tree
> during the erasion. In some of the versions, the tree is incomplete, i.e.
> some nodes(not the one to be deleted) are invisible to readers. I'm not
> sure if this is acceptable as an RCU implementation. Does it mean we
> need to form a rb_erase_rcu from scratch?
> 
> And are there any other concerns about this attempt?
> 
> Let me add RCU supporters Paul and Josh here. Your advice would be
> highly appreciated.

If updates and rebalancing are handled carefully, it can be made to work.
The classic paper by Kung and Lehman covers the rebalancing issues:
http://www.eecs.harvard.edu/~htk/publication/1980-tods-kung-lehman.pdf

							Thanx, Paul

