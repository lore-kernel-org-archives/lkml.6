Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968999AbeE3JLw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:11:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S968792AbeE3JLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:11:47 -0400
Date: Wed, 30 May 2018 11:11:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <20180530074130.GA6927@infradead.org>
References: <20180530075920.1f73275a@mschwideX1>
        <20180530074130.GA6927@infradead.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18053009-0040-0000-0000-0000043F3B60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053009-0041-0000-0000-000026448E96
Message-Id: <20180530111140.40c791bd@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 00:41:30 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > -	req->completion_data = cqr;
> > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > +  
> 
> Please don't play such tricks.  In general your driver structure
> should have struct request embedded.  If for some reason
> struct dasd_ccw_req has a different life time please create a new
> structure instead of these hacks.

Why do you consider this to be a 'trick'? The blk_mq_rq_to_pdu is
meant to be used to access a block of data that is is associated
with a request, no? With the change we store a single value, the
pointer to a struct dasd_ccw_req. The struct request comes first,
later do_dasd_request creates the struct dasd_ccw_req with the
CCW chain for the request. And for the blk timeout handler we need
a way to find the dasd_ccw_req again.

> In either way this really doesn't look like a post-rc7 change.

You think so? It fixes a crash for s390 with a minimal number of
changed lines:

 drivers/s390/block/dasd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
