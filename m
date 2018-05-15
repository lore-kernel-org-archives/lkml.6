Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeEONuj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:50:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752662AbeEONui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:50:38 -0400
Date: Tue, 15 May 2018 15:49:40 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Bart Van Assche <bart.vanassche@wdc.com>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
In-Reply-To: <20180514184634.2160-3-bart.vanassche@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com> <20180514184634.2160-3-bart.vanassche@wdc.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18051513-0040-0000-0000-00000459A7CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051513-0041-0000-0000-000020FDD18C
Message-Id: <alpine.LFD.2.21.1805151542370.1605@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018, Bart Van Assche wrote:
> Recently the blk-mq timeout handling code was reworked. See also Tejun
> Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
> (https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
> This patch reworks the blk-mq timeout handling code again. The timeout
> handling code is simplified by introducing a state machine per request.
> This change avoids that the blk-mq timeout handling code ignores
> completions that occur after blk_mq_check_expired() has been called and
> before blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block
> driver timeout handler always returns BLK_EH_RESET_TIMER then the result
> will be that the request never terminates.
> 
> Fix this race as follows:
> - Replace the __deadline member of struct request by a new member
>   called das that contains the generation number, state and deadline.
>   Only 32 bits are used for the deadline field such that all three
>   fields occupy only 64 bits. This change reduces the maximum supported
>   request timeout value from (2**63/HZ) to (2**31/HZ).
> - Remove all request member variables that became superfluous due to
>   this change: gstate, gstate_seq and aborted_gstate_sync.
> - Remove the request state information that became superfluous due to
>   this patch, namely RQF_MQ_TIMEOUT_EXPIRED.
> - Remove the code that became superfluous due to this change, namely
>   the RCU lock and unlock statements in blk_mq_complete_request() and
>   also the synchronize_rcu() call in the timeout handler.
> 
> Notes:
> - A spinlock is used to protect atomic changes of rq->das on those
>   architectures that do not provide a cmpxchg64() implementation.
> - Atomic instructions are only used to update the request state if
>   a concurrent request state change could be in progress.
> - blk_add_timer() has been split into two functions - one for the
>   legacy block layer and one for blk-mq.
> 

I tested your patch on top of block/for-next (with forced timeouts) -
works as expected. The lockdep warnings with regard to gstate_seq are
gone (surprise with gstate_seq gone) - thanks for that!

Regards,
Sebastian
