Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFAC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1E22084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJEC3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:29:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727528AbeJEC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:29:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94JTr8m014494
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 15:34:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mwrs994cq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 15:34:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Oct 2018 15:34:25 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Oct 2018 15:34:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w94JY7Ae24117308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Oct 2018 19:34:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14C9AB2064;
        Thu,  4 Oct 2018 15:32:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAC5CB206A;
        Thu,  4 Oct 2018 15:32:16 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.172])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Oct 2018 15:32:16 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B8DDA16C3757; Thu,  4 Oct 2018 12:34:07 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:34:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Reply-To: paulmck@linux.ibm.com
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004185949.GA233675@dtor-ws>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100419-0052-0000-0000-0000033C82F1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009822; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097881; UDB=6.00567814; IPR=6.00877921;
 MB=3.00023616; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 19:34:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100419-0053-0000-0000-00005E4BD1F5
Message-Id: <20181004193407.GK2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:59:49AM -0700, Dmitry Torokhov wrote:
> Hi Eric,
> 
> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > syzbot was able to trigger rcu stalls by calling write()
> > with large number of bytes.
> > 
> > Add a cond_resched() in the loop to avoid this.
> 
> I think this simply masks a deeper issue. The code fetches characters
> from userspace in a loop, takes a lock, quickly places response in an
> output buffer, and releases interrupt. I do not see why this should
> cause stalls as we do not hold spinlock/interrupts off for extended
> period of time.
> 
> Adding Paul so he can straighten me out...

If you are running a !PREEMPT kernel, then you need the cond_resched()
to allow the scheduler to choose someone else to run if needed and
to let RCU know that grace periods can end.  Without the cond_resched(),
if you stay in that loop long enough you will get excessive scheduling
latencies and eventually even RCU CPU stall warning splats.

In a PREEMPT (instead of !PREEMPT) kernel, you would be right.  When
preemption is enabled, the scheduler can preempt and RCU can sense
lack of readers from the scheduling-clock interrupt handler.  Which
is why cond_resched() is nothingness in a PREEMPT kernel.

But because people run !PREEMPT as well as PREEMPT kernels, if that loop
can run for a long time, you need that cond_resched().

							Thanx, Paul

> > Link: https://lkml.org/lkml/2018/8/23/1106
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > ---
> >  drivers/input/mousedev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> > index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
> > --- a/drivers/input/mousedev.c
> > +++ b/drivers/input/mousedev.c
> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
> >  		mousedev_generate_response(client, c);
> >  
> >  		spin_unlock_irq(&client->packet_lock);
> > +		cond_resched();
> >  	}
> >  
> >  	kill_fasync(&client->fasync, SIGIO, POLL_IN);
> > -- 
> > 2.19.0.605.g01d371f741-goog
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> 

