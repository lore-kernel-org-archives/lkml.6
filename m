Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeCQEbF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:31:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeCQEbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:31:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A58E60C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
X-Google-Smtp-Source: AG47ELu/hne18vVtl8C4gJOHgt6bpc4IsmpqlV1n4TS/vHTz1zlrfiSzkZIblaFT8OG26nVmtKh/+8+ILUqDZ6LJWN8=
MIME-Version: 1.0
In-Reply-To: <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org> <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
 <83387f6e-adcb-14e9-2c22-96abf9493cc6@codeaurora.org> <004501d3bd7b$505e70f0$f11b52d0$@opengridcomputing.com>
 <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org> <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
 <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Date: Fri, 16 Mar 2018 23:30:59 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWMmsSUXpT_XVboXM5DRHzt0=EXL9mFNPm0bWtTxhU_QA@mail.gmail.com>
Message-ID: <CAOZdJXWMmsSUXpT_XVboXM5DRHzt0=EXL9mFNPm0bWtTxhU_QA@mail.gmail.com>
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Steve Wise <swise@opengridcomputing.com>,
        netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, Casey Leedom <leedom@chelsio.com>,
        Steve Wise <swise@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Michael Werner <werner@chelsio.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:25 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> @@ -477,15 +477,16 @@ static inline void t4_ring_sq_db(struct t4_wq *wq, u16 inc, union t4_wr *wqe)
>                                  (u64 *)wqe);
>                 } else {
>                         pr_debug("DB wq->sq.pidx = %d\n", wq->sq.pidx);
> -                       writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),
> -                              wq->sq.bar2_va + SGE_UDB_KDOORBELL);
> +                       __raw_writel(PIDX_T5_V(inc) | QID_V(wq->sq.bar2_qid),

I think Jason might be right that drivers shouldn't be calling the
__raw_write functions.  You definitely need to run this by the PPC
developers, specifically Ben Herrenschmidt.


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
