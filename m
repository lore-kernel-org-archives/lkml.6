Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFDIUb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:20:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751695AbeFDIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:20:30 -0400
Date: Mon, 4 Jun 2018 10:20:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <20180531161400.GB10203@infradead.org>
References: <20180530075920.1f73275a@mschwideX1>
        <20180530074130.GA6927@infradead.org>
        <20180530111140.40c791bd@mschwideX1>
        <20180531161400.GB10203@infradead.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18060408-0012-0000-0000-0000027A6870
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060408-0013-0000-0000-000020AB275C
Message-Id: <20180604102022.3bc03229@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040104
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 09:14:00 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, May 30, 2018 at 11:11:40AM +0200, Martin Schwidefsky wrote:
> > On Wed, 30 May 2018 00:41:30 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> >   
> > > > -	req->completion_data = cqr;
> > > > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > > > +    
> > > 
> > > Please don't play such tricks.  In general your driver structure
> > > should have struct request embedded.  If for some reason
> > > struct dasd_ccw_req has a different life time please create a new
> > > structure instead of these hacks.  
> > 
> > Why do you consider this to be a 'trick'? The blk_mq_rq_to_pdu is
> > meant to be used to access a block of data that is is associated
> > with a request, no? With the change we store a single value, the
> > pointer to a struct dasd_ccw_req. The struct request comes first,
> > later do_dasd_request creates the struct dasd_ccw_req with the
> > CCW chain for the request. And for the blk timeout handler we need
> > a way to find the dasd_ccw_req again.  
> 
> We'll we try really hard to have a structure that we can use
> container_of on.  At least a minimal container with just the pointer
> for a quick fix, but in general it seems like you should be able
> to allocate the whole dasd_ccw_req with the request and just initialize
> it later.

A minimal container with a pointer is easy enough to do. To replace
our allocation scheme for the CCW chains will be hard. For one there
are internal I/Os that do not have an associated 'struct request'.
For those we need to allocate the memory on our own anyway.
Then the size of the memory block you need for the CCW varies wildly
and can be quite large. The tag cmd_size is fixed at the time
blk_mq_alloc_tag_set is called. If we replace out allocation scheme
this would force us to use the maximum size CCW chain for the
tag size, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
