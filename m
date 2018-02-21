Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937154AbeBUNor (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:44:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33660 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936089AbeBUNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:44:45 -0500
X-Google-Smtp-Source: AH8x227hjya6IXLP9mTuGDvlAHwrQ/CHITRezFRPS4Ceu8oMHd9FOSSkCpSo5DDjTYaM4u3AsUwO8w==
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Chuck Lever <chuck.lever@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
Date: Wed, 21 Feb 2018 15:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>>> /* # of WCs to poll for with a single call to ib_poll_cq */
>>> -#define IB_POLL_BATCH			16
>>> +#define IB_POLL_BATCH			8
>>
>> The purpose of batch polling is to minimize contention on the cq spinlock.
>> Reducing the IB_POLL_BATCH constant may affect performance negatively. Has
>> the performance impact of this change been verified for all affected drivers
>> (ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB Direct, NFS
>> over RDMA, ...)?
> 
> Only the users of the DIRECT polling method use an on-stack
> array of ib_wc's. This is only the SRP drivers.
> 
> The other two modes have use of a dynamically allocated array
> of ib_wc's that hangs off the ib_cq. These shouldn't need any
> reduction in the size of this array, and they are the common
> case.
> 
> IMO a better solution would be to change ib_process_cq_direct
> to use a smaller on-stack array, and leave IB_POLL_BATCH alone.

The only reason why I added this array on-stack was to allow consumers
that did not use ib_alloc_cq api to call it, but that seems like a
wrong decision when thinking it over again (as probably these users
did not set the wr_cqe correctly).

How about we make ib_process_cq_direct use the cq wc array and add
a WARN_ON statement (and fail it gracefully) if the caller used this
API without calling ib_alloc_cq?

--
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index bc79ca8215d7..cd3e9e124834 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -25,10 +25,10 @@
  #define IB_POLL_FLAGS \
         (IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)

-static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
*poll_wc)
+static int __ib_process_cq(struct ib_cq *cq, int budget)
  {
         int i, n, completed = 0;
-       struct ib_wc *wcs = poll_wc ? : cq->wc;
+       struct ib_wc *wcs = cq->wc;

         /*
          * budget might be (-1) if the caller does not
@@ -72,9 +72,9 @@ static int __ib_process_cq(struct ib_cq *cq, int 
budget, struct ib_wc *poll_wc)
   */
  int ib_process_cq_direct(struct ib_cq *cq, int budget)
  {
-       struct ib_wc wcs[IB_POLL_BATCH];
-
-       return __ib_process_cq(cq, budget, wcs);
+       if (unlikely(WARN_ON_ONCE(!cq->wc)))
+               return 0;
+       return __ib_process_cq(cq, budget);
  }
  EXPORT_SYMBOL(ib_process_cq_direct);

@@ -88,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int 
budget)
         struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
         int completed;

-       completed = __ib_process_cq(cq, budget, NULL);
+       completed = __ib_process_cq(cq, budget);
         if (completed < budget) {
                 irq_poll_complete(&cq->iop);
                 if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
@@ -108,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
         struct ib_cq *cq = container_of(work, struct ib_cq, work);
         int completed;

-       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
+       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
         if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
             ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
                 queue_work(ib_comp_wq, &cq->work);
--
