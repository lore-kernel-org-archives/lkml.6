Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937296AbeE3Ig3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:36:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeE3IgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:36:25 -0400
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
 <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
Date: Wed, 30 May 2018 16:36:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=646
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ming

Thanks for your kindly response.

On 05/30/2018 04:22 PM, Ming Lei wrote:
>>> you could keep the software queues as-is but add our own version of
>>> flush_busy_ctxs() that only removes requests of the domain that we want.
>>> If one domain gets backed up, that might get messy with long iterations,
>>> though.
>> Yes, I also considered this approach :)
>> But the long iterations on every ctx->rq_list looks really inefficient.
> Right, this list can be quite long if dispatch token is used up.
> 
> You might try to introduce per-domain list into ctx directly, then 'none'
> may benefit from this change too since bio merge should be done
> on the per-domain list actually.

Yes, it maybe good for merging of 'none', because the rq_list is split into 3
lists, and not need to iterate the whole rq_list any more.
But what's about the dispatch when there is no io scheduler.
We will dispatch request from ctx one by one at the moment.
If we have per-domain list in ctx, we have to introduce some policies to determine
which domain to dispatch, and these policies should be in io scheduler actually.

Thanks
Jianchao
