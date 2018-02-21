Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeBUPKy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:10:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBUPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:10:51 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
Date: Wed, 21 Feb 2018 10:10:27 -0500
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-Id: <361D2F0F-F03C-438D-9C90-D6ABD0CAC12B@oracle.com>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LFBEx0017319



> On Feb 21, 2018, at 8:44 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>>> On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>>>> /* # of WCs to poll for with a single call to ib_poll_cq */
>>>> -#define IB_POLL_BATCH			16
>>>> +#define IB_POLL_BATCH			8
>>> 
>>> The purpose of batch polling is to minimize contention on the cq spinlock.
>>> Reducing the IB_POLL_BATCH constant may affect performance negatively. Has
>>> the performance impact of this change been verified for all affected drivers
>>> (ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB Direct, NFS
>>> over RDMA, ...)?
>> Only the users of the DIRECT polling method use an on-stack
>> array of ib_wc's. This is only the SRP drivers.
>> The other two modes have use of a dynamically allocated array
>> of ib_wc's that hangs off the ib_cq. These shouldn't need any
>> reduction in the size of this array, and they are the common
>> case.
>> IMO a better solution would be to change ib_process_cq_direct
>> to use a smaller on-stack array, and leave IB_POLL_BATCH alone.
> 
> The only reason why I added this array on-stack was to allow consumers
> that did not use ib_alloc_cq api to call it, but that seems like a
> wrong decision when thinking it over again (as probably these users
> did not set the wr_cqe correctly).
> 
> How about we make ib_process_cq_direct use the cq wc array and add
> a WARN_ON statement (and fail it gracefully) if the caller used this
> API without calling ib_alloc_cq?

Agreed, I prefer that all three modes use dynamically allocated
memory for that array.


> --
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index bc79ca8215d7..cd3e9e124834 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -25,10 +25,10 @@
> #define IB_POLL_FLAGS \
>        (IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
> 
> -static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *poll_wc)
> +static int __ib_process_cq(struct ib_cq *cq, int budget)
> {
>        int i, n, completed = 0;
> -       struct ib_wc *wcs = poll_wc ? : cq->wc;
> +       struct ib_wc *wcs = cq->wc;
> 
>        /*
>         * budget might be (-1) if the caller does not
> @@ -72,9 +72,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *poll_wc)
>  */
> int ib_process_cq_direct(struct ib_cq *cq, int budget)
> {
> -       struct ib_wc wcs[IB_POLL_BATCH];
> -
> -       return __ib_process_cq(cq, budget, wcs);
> +       if (unlikely(WARN_ON_ONCE(!cq->wc)))
> +               return 0;
> +       return __ib_process_cq(cq, budget);
> }
> EXPORT_SYMBOL(ib_process_cq_direct);
> 
> @@ -88,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
>        struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
>        int completed;
> 
> -       completed = __ib_process_cq(cq, budget, NULL);
> +       completed = __ib_process_cq(cq, budget);
>        if (completed < budget) {
>                irq_poll_complete(&cq->iop);
>                if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
> @@ -108,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
>        struct ib_cq *cq = container_of(work, struct ib_cq, work);
>        int completed;
> 
> -       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
> +       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
>        if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
>            ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>                queue_work(ib_comp_wq, &cq->work);
> --

--
Chuck Lever
