Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7912082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7912082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeJ2UPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbeJ2UPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:15:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TBNwsi032162
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:27:27 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ndwx494yn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:27:27 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 29 Oct 2018 07:27:26 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Oct 2018 07:27:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9TBRNiv24379448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Oct 2018 11:27:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A30B2065;
        Mon, 29 Oct 2018 11:27:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE83B205F;
        Mon, 29 Oct 2018 11:27:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.180])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Oct 2018 11:27:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6628C16C2E1E; Mon, 29 Oct 2018 04:27:25 -0700 (PDT)
Date:   Mon, 29 Oct 2018 04:27:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFR] Store tearing
Reply-To: paulmck@linux.ibm.com
References: <20181028230627.GA3420@andrea>
 <20181028231003.GA4021@andrea>
 <20181029012042.GR4170@linux.ibm.com>
 <CAK8P3a3t54qYyj1r0vjXJzgb3wvJLt4ypb7=xesavcJwC30_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3t54qYyj1r0vjXJzgb3wvJLt4ypb7=xesavcJwC30_kg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102911-0040-0000-0000-00000488398C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009947; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01109627; UDB=6.00574892; IPR=6.00889720;
 MB=3.00023950; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-29 11:27:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102911-0041-0000-0000-000008905745
Message-Id: <20181029112725.GV4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:23:07AM +0100, Arnd Bergmann wrote:
> On Mon, Oct 29, 2018 at 2:21 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Mon, Oct 29, 2018 at 12:10:03AM +0100, Andrea Parri wrote:
> > > Hopefully, with Paul's proper email address this time,
> > >
> > >   Andrea
> > >
> > > On Mon, Oct 29, 2018 at 12:06:27AM +0100, Andrea Parri wrote:
> > > > Hi,
> > > >
> > > > memory-barriers.txt says:
> > > >
> > > >   [on "store tearing"]
> > > >
> > > >   "In fact, a recent bug (since fixed) caused GCC to incorrectly use
> > > >    this optimization in a volatile store.".
> > > >
> > > > I was wondering if you could help me retrieve some reference/discussions
> > > > about this?
> >
> > This was quite some time ago, but it involved a 32-bit volatile store
> > of a constant such as 0x10001.  The machine in question had a narrow
> > store-immediate instruction, so the compiler emitted  a pair of 16-bit
> > store-immediate instructions.  This bug was fixed, though only after
> > significant screaming and shouting.
> 
> A related issue I remember was on ARMv5 (an architecture without
> unaligned access) where a function like )not sure if this specific
> one triggers it, but something like it did)
> 
> struct my_registers {
>      u32 a;
>      u32 b;
>      u32 c;
> } __attribute__((packed));
> #define __raw_writel(p, v) do { (volatile u32 __iomem *)(p) = (v); } while (0)
> void my_write_a(struct my_registers __iomem *r, u32 val)
> {
>        __raw_writel(&r->a, val);
> }
> 
> The above is undefined behavior because we cast from an unaligned
> data type to a 32-bit aligned type, and gcc resolved this by turning the
> intended 32-bit store into a set of 8 bit stores. We worked around this
> by changing __raw_writel() into a inline assembly that always uses a
> 32-bit store.

I had either missed or forgotten this one, nice example of store tearing!

							Thanx, Paul

