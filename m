Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF90B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF90B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeJELFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:05:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbeJELFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:05:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95447Zh081635
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 00:08:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mx0hwgbs4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:08:19 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 00:08:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 00:08:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9548CkY28442710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 04:08:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B05C7B2065;
        Fri,  5 Oct 2018 00:06:21 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E2F8B205F;
        Fri,  5 Oct 2018 00:06:21 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.210.4])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 00:06:21 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5502616C1CED; Thu,  4 Oct 2018 21:08:12 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:08:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     NeilBrown <neilb@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend] VFS: use synchronize_rcu_expedited() in
 namespace_unlock()
Reply-To: paulmck@linux.ibm.com
References: <87y3nyd4pu.fsf@notabene.neil.brown.name>
 <20171026122743.GX3659@linux.vnet.ibm.com>
 <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com>
 <20171127144125.GF3624@linux.vnet.ibm.com>
 <87induxd3u.fsf@notabene.neil.brown.name>
 <87tvm1rxme.fsf@notabene.neil.brown.name>
 <20181005014002.GS32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005014002.GS32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100504-0040-0000-0000-0000047B7BA9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009824; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098052; UDB=6.00567916; IPR=6.00878092;
 MB=3.00023621; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 04:08:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100504-0041-0000-0000-00000883882B
Message-Id: <20181005040812.GT2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 02:40:02AM +0100, Al Viro wrote:
> On Fri, Oct 05, 2018 at 11:27:37AM +1000, NeilBrown wrote:
> > 
> > The synchronize_rcu() in namespace_unlock() is called every time
> > a filesystem is unmounted.  If a great many filesystems are mounted,
> > this can cause a noticable slow-down in, for example, system shutdown.
> > 
> > The sequence:
> >   mkdir -p /tmp/Mtest/{0..5000}
> >   time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
> >   time umount /tmp/Mtest/*
> > 
> > on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
> > 100 seconds to unmount them.
> > 
> > Boot the same VM with 1 CPU and it takes 18 seconds to mount the
> > tmpfs filesystems, but only 36 to unmount.
> > 
> > If we change the synchronize_rcu() to synchronize_rcu_expedited()
> > the umount time on a 4-cpu VM drop to 0.6 seconds
> > 
> > I think this 200-fold speed up is worth the slightly high system
> > impact of using synchronize_rcu_expedited().
> > 
> > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rcu perspective)
> > Signed-off-by: NeilBrown <neilb@suse.com>
> > ---
> > 
> > I posted this last October, then again last November (cc:ing Linus)
> > Paul is happy enough with it, but no other response.
> > I'm hoping it can get applied this time....
> 
> Umm...  IIRC, the last one got sidetracked on the other thing in the series...
> <checks> that was s_anon stuff.  I can live with this one; FWIW, what kind
> of load would trigger the impact of the change?  Paul?

You lost me with "what kind of load would trigger the impact of the
change?", but if you are asking about the downside, that would be IPIs
sent from each call to synchronize_rcu_expedited().  But people with
things like real-time workloads that therefore don't like those IPIs
have a number of options:

1.	Boot with rcupdate.rcu_normal=1, which converts all calls to
	synchronize_rcu_expedited() to synchronize_rcu().  This of
	course loses the performance gain, but this can be a good
	tradeoff for real-time workloads.

2.	Build with CONFIG_NO_HZ_FULL=y and boot with nohz_full= to
	cover the CPUs running your real-time workload.  Then
	as long as there is only one runnable usermode task per
	nohz_full CPU, synchronize_rcu_expedited() will avoid sending
	IPIs to any of the nohz_full CPUs.

3.	Don't do unmounts while your real-time application is running.

Probably other options as well, but those are the ones that come
immediately to mind.

If I missed the point of your question, please help me understand
what you are asking for.

							Thanx, Paul

