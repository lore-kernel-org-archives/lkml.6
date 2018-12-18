Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D89C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E9C218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeLRODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:03:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbeLRODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:03:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBIDs2u1138990
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:03:03 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pf1snsqe7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:03:02 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 18 Dec 2018 14:03:01 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 14:02:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBIE2sNt8912932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 14:02:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F20B206A;
        Tue, 18 Dec 2018 14:02:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C6DCB2064;
        Tue, 18 Dec 2018 14:02:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 14:02:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EDCC16C3438; Tue, 18 Dec 2018 06:02:58 -0800 (PST)
Date:   Tue, 18 Dec 2018 06:02:58 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
Reply-To: paulmck@linux.ibm.com
References: <20181217112916.GG4170@linux.ibm.com>
 <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
 <20181217162421.6d636ee5@redhat.com>
 <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
 <20181218001828.49cea463@redhat.com>
 <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
 <20181218134024.45d2d5e3@redhat.com>
 <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121814-2213-0000-0000-0000032D246B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010243; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133530; UDB=6.00589285; IPR=6.00913705;
 MB=3.00024736; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-18 14:02:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121814-2214-0000-0000-00005CA6C6F8
Message-Id: <20181218140258.GQ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:26:00PM +0100, Dmitry Vyukov wrote:
> On Tue, Dec 18, 2018 at 1:40 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Tue, 18 Dec 2018 09:49:17 +0100
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > On Tue, Dec 18, 2018 at 12:18 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > >
> > > > On Mon, 17 Dec 2018 16:53:36 +0100
> > > > Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > > On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, 17 Dec 2018 06:57:35 -0800
> > > > > > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > > > >
> > > > > > > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > > > > > > fou, fou6: ICMP error handlers for FoU and GUE
> > > > > >
> > > > > > This:
> > > > > >
> > > > > > diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> > > > > > index 0d0ad19ecb87..20a6de26d146 100644
> > > > > > --- a/net/ipv4/fou.c
> > > > > > +++ b/net/ipv4/fou.c
> > > > > > @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
> > > > > >  {
> > > > > >         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
> > > > > >
> > > > > > +       if (ipprot == IPPROTO_UDP)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > >         if (ipprot && ipprot->err_handler) {
> > > > > >                 if (!ipprot->err_handler(skb, info))
> > > > > >                         return 0;
> > > > > >
> > > > > > should fix the issue, but I still have to run tests and make sure we
> > > > > > don't hit similar cases.
> > > > >
> > > > > Please don't forget to add a regression test for it too ;)
> > > >
> > > > Where would you suggest to add this? The only selftest that goes
> > >
> > > I dunno. But there must be some place for such tests, right?
> >
> > Not as far as I know. The selftests checking this path, by design, only
> > use supported configurations, they don't forge packets.
> >
> > Maybe it would be nice to have a semi-automated way to isolate and
> > describe/name specific conditions found by syzbot via fuzzing and turn
> > those into tests that are then repeated periodically. I'm not sure how
> > that would look like, but I think it's still more maintainable than a
> > pile of C reproducers with forged packets in selftests/net.
> 
> It would be nice to do something like this. Filed
> https://github.com/google/syzkaller/issues/884
> However, there are few open questions that I am not sure how to resolve yet...
> 
> 
> > Eric, Cong, Xin, as you also recently fixed a nice deal of similar cases
> > reported by syzbot, what do you think? Did you ever feel the need to
> > turn a syzbot reproducer into a regression test case?
> >
> > > > through this path currently is net/pmtu.sh, but as configuration of an
> > > > actual UDP-in-GUE tunnel is currently not supported, I would really
> > > > need to forge that specific packet, so that doesn't seem to be a good
> > > > fit.
> > > >
> > > > Won't syzbot add this to some list of reproducers that are checked in
> > > > the future?
> > >
> > > It won't. Also fuzzing is complementary to testing, not a replacement:
> >
> > Indeed, but that doesn't mean we need to limit the potential of fuzzing
> > because "it's not testing". It can be used to check for regressions,
> > too, especially in these cases.
> >
> > > https://twitter.com/dvyukov/status/1074719682962358272
> >
> > Now, I'm extremely thankful for the work you're doing and especially
> > for finding this subtle condition with syzbot, but this is quite
> > inaccurate. To be exposed to this issue, the user would need to
> > have the fou module loaded (it won't autoload), which is used quite
> > rarely, and, on top of that, have a UDP tunnel configured. It wouldn't
> > have been the kind of "evil packet crashes the internet" scenario you
> > were dreaming of ;)
> 
> Okay, I see. Full bug assessment is hard. I mess it both ways for
> different bugs.
> But I did not claim that it does not require some setup :)
> And maybe there is somebody important on the internet that uses such
> setup. Who knows.

Black hats, if no one else.  ;-)

							Thanx, Paul

