Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeE3NAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:00:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752409AbeE3NAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:00:08 -0400
Date: Wed, 30 May 2018 14:59:58 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Christoph Hellwig <hch@infradead.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <20180530074130.GA6927@infradead.org>
References: <20180530075920.1f73275a@mschwideX1> <20180530074130.GA6927@infradead.org>
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
x-cbid: 18053013-0040-0000-0000-0000043F529E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053013-0041-0000-0000-00002644A732
Message-Id: <alpine.LFD.2.21.1805301425580.1717@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Christoph Hellwig wrote:

> > -	req->completion_data = cqr;
> > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > +
> 
> Please don't play such tricks.  In general your driver structure
> should have struct request embedded.  If for some reason
> struct dasd_ccw_req has a different life time please create a new
> structure instead of these hacks.

Would you agree that this is an improvement over using completion_data
(at least now we don't mess with the block layers internal data)?

I already looked into what needs to be done to put struct dasd_ccw_req
behind the request and let it be managed by the block layer.

My concerns are lifetime and memory constraints (some of our HW interfaces
still use 31 bit pointers) but I think both of these are manageable with
the blk-mq interfaces.

But this would not be a small change and nothing for rc7. Would you be
OK with doing the small fix now and I'll work on the mentioned
improvement?

Regards,
Sebastian
