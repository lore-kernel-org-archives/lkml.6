Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeCQEZU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:25:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeCQEZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:25:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97C3860591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
To: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, "'Michael Werner'" <werner@chelsio.com>,
        "'Casey Leedom'" <leedom@chelsio.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
 <83387f6e-adcb-14e9-2c22-96abf9493cc6@codeaurora.org>
 <004501d3bd7b$505e70f0$f11b52d0$@opengridcomputing.com>
 <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org>
 <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
Date: Sat, 17 Mar 2018 00:25:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/2018 12:03 AM, Sinan Kaya wrote:
> On 3/16/2018 11:40 PM, Sinan Kaya wrote:
>> I'll change writel_relaxed() with __raw_writel() in the series like you suggested
>> and also look at your other comments.
> 
> I spoke too soon.
> 
> Now that I realized, code needs to follow one of the following patterns for correctness
> 
> 1)
> wmb()
> writel()/writel_relaxed()
> 
> or 
> 
> 2)
> wmb()
> __raw_wrltel()
> mmiowb()
> 
> but definitely not
> 
> wmb()
> __raw_wrltel()
> 
> Since #1 == #2, I'll stick to my current implementation of writel_relaxed()
> 
> Changing writel() to writel_relaxed() or __raw_writel() isn't enough. PowerPC needs mmiowb()
> for correctness. ARM's mmiowb() implementation is empty.
> 
> So, there is no one size fits all solution with the current state of affairs.
> 
> 

I think I finally got what you mean.

Code seems to have

wmb()
writel()/writeq()
wmb()

this can be safely replaced with

wmb()
__raw_writel()/__raw_writeq()
wmb()

This will work on all arches. Below is the new version. Let me know if this is OK.

+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -457,7 +457,7 @@ static inline void pio_copy(u64 __iomem *dst, u64 *src)
        int count = 8;

        while (count) {
-               writeq(*src, dst);
+               __raw_writeq(*src, dst);
                src++;
                dst++;
                count--;
@@ -477,15 +477,16 @@ static inline void t4_ring_sq_db(struct t4_wq *wq, u16 inc, union t4_wr *wqe)
                                 (u64 *)wqe);
                } else {
                        pr_debug("DB wq->sq.pidx = %d\n", wq->sq.pidx);
-                       writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
-                              wq->sq.bar2_va + SGE_UDB_KDOORBELL);
+                       __raw_writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
+                                    wq->sq.bar2_va + SGE_UDB_KDOORBELL);
                }

                /* Flush user doorbell area writes. */
                wmb();
                return;
        }
-       writel(QID_V(wq->sq.qid) | PIDX_V(inc), wq->db);
+       __raw_writel(QID_V(wq->sq.qid) | PIDX_V(inc), wq->db);
+       mmiowmb()
 }

 static inline void t4_ring_rq_db(struct t4_wq *wq, u16 inc,
@@ -502,15 +503,16 @@ static inline void t4_ring_rq_db(struct t4_wq *wq, u16 inc,
                                 (void *)wqe);
                } else {
                        pr_debug("DB wq->rq.pidx = %d\n", wq->rq.pidx);
-                       writel(PIDX_T5_V(inc) | QID_V(wq->rq.bar2_qid),
-                              wq->rq.bar2_va + SGE_UDB_KDOORBELL);
+                       __raw_writel(PIDX_T5_V(inc) | QID_V(wq->rq.bar2_qid),
+                                    wq->rq.bar2_va + SGE_UDB_KDOORBELL);
                }

                /* Flush user doorbell area writes. */
                wmb();
                return;
        }
-       writel(QID_V(wq->rq.qid) | PIDX_V(inc), wq->db);
+       __raw_writel(QID_V(wq->rq.qid) | PIDX_V(inc), wq->db);
+       mmiowmb();
 }


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
