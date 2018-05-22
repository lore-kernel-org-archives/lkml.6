Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeEVQgI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:36:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752424AbeEVQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:36:03 -0400
Date: Tue, 22 May 2018 09:36:48 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        "swapnil.ingle" <swapnil.ingle@profitbricks.com>,
        Danil Kipnis <danil.kipnis@profitbricks.com>,
        Jinpu Wang <jinpu.wang@profitbricks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/26] rculist: introduce list_next_or_null_rr_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-2-roman.penyaev@profitbricks.com>
 <20180519163735.GX3803@linux.vnet.ibm.com>
 <CAJrWOzAt8BDtypaRwYx_y9jpCVD5W_VL9aQsFsC3bL-XaoJz9g@mail.gmail.com>
 <20180520004318.GY3803@linux.vnet.ibm.com>
 <CAJrWOzBenkHg_5zs1VAxP_rVbCbOJO_eO0toJBhnzXuy_yWH2Q@mail.gmail.com>
 <CA+55aFymFCVqh4VxtqDPoFYh6zsGEDLSV79_AnsMp3M=t2mhqg@mail.gmail.com>
 <20180521153337.GF3803@linux.vnet.ibm.com>
 <CAJrWOzDfJ46Vwz5k7VgUwz04EzCCUtt57jxCx1RC0LoOA3t0AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrWOzDfJ46Vwz5k7VgUwz04EzCCUtt57jxCx1RC0LoOA3t0AA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052216-0004-0000-0000-000014227E77
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036085; UDB=6.00529999; IPR=6.00815212;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 16:36:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052216-0005-0000-0000-0000874F2A2D
Message-Id: <20180522163648.GV3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:09:08AM +0200, Roman Penyaev wrote:
> On Mon, May 21, 2018 at 5:33 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Mon, May 21, 2018 at 08:16:59AM -0700, Linus Torvalds wrote:
> >> On Mon, May 21, 2018 at 6:51 AM Roman Penyaev <
> >> roman.penyaev@profitbricks.com> wrote:
> >>
> >> > No, I continue from the pointer, which I assigned on the previous IO
> >> > in order to send IO fairly and keep load balanced.
> >>
> >> Right. And that's exactly what has both me and Paul nervous. You're no
> >> longer in the RCU domain. You're using a pointer where the lifetime has
> >> nothing to do with RCU any more.
> >>
> >> Can it be done? Sure. But you need *other* locking for it (that you haven't
> >> explained), and it's fragile as hell.
> >
> > He looks to actually have it right, but I would want to see a big comment
> > on the read side noting the leak of the pointer and documenting why it
> > is OK.
> 
> Hi Paul and Linus,
> 
> Should I resend current patch with more clear comments about how careful
> caller should be with a leaking pointer?  Also I will update read side
> with a fat comment about "rcu_assign_pointer()" which leaks the pointer
> out of RCU domain and what is done to prevent nasty consequences.
> Does that sound acceptable?

That sounds good to me.

							Thanx, Paul
