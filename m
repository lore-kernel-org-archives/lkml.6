Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F38D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJECbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:31:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727499AbeJECbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:31:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94JZNnS021106
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 15:36:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mwpd3frx3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 15:36:20 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Oct 2018 15:36:19 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Oct 2018 15:36:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w94JaGR226083406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Oct 2018 19:36:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD71B2065;
        Thu,  4 Oct 2018 15:34:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FCD8B2068;
        Thu,  4 Oct 2018 15:34:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.172])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Oct 2018 15:34:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1DF7916C3757; Thu,  4 Oct 2018 12:36:16 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:36:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Reply-To: paulmck@linux.ibm.com
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws>
 <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100419-0052-0000-0000-0000033C8336
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009822; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097881; UDB=6.00567814; IPR=6.00877922;
 MB=3.00023616; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 19:36:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100419-0053-0000-0000-00005E4BD2EC
Message-Id: <20181004193616.GL2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 12:28:56PM -0700, Eric Dumazet wrote:
> On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > > syzbot was able to trigger rcu stalls by calling write()
> > > with large number of bytes.
> > >
> > > Add a cond_resched() in the loop to avoid this.
> >
> > I think this simply masks a deeper issue. The code fetches characters
> > from userspace in a loop, takes a lock, quickly places response in an
> > output buffer, and releases interrupt. I do not see why this should
> > cause stalls as we do not hold spinlock/interrupts off for extended
> > period of time.
> >
> > Adding Paul so he can straighten me out...
> >
> 
> Well...
> 
> write(fd, buffer, 0x7FFF0000);
> 
> Takes between 20 seconds and 2 minutes depending on CONFIG options ....

And two minutes would get you an RCU CPU stall warning, even on distro
kernels that set the stall-warning time to a full minute (as opposed
to 21 seconds in mainline).

> So either apply my patch, or add a limit on the max count, and
> possibly break legitimate user space ?
> 
> I dunno...

I vote for Eric's patch.  In fact:

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> > > Link: https://lkml.org/lkml/2018/8/23/1106
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > ---
> > >  drivers/input/mousedev.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> > > index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
> > > --- a/drivers/input/mousedev.c
> > > +++ b/drivers/input/mousedev.c
> > > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
> > >               mousedev_generate_response(client, c);
> > >
> > >               spin_unlock_irq(&client->packet_lock);
> > > +             cond_resched();
> > >       }
> > >
> > >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
> > > --
> > > 2.19.0.605.g01d371f741-goog
> > >
> >
> > Thanks.
> >
> > --
> > Dmitry
> 

