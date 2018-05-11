Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeEKKqp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:46:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbeEKKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:46:43 -0400
Date: Fri, 11 May 2018 06:46:30 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Yanjun Zhu <yanjun.zhu@oracle.com>
Cc: DaeRyong Jeong <threeearcat@gmail.com>, santosh.shilimkar@oracle.com,
        davem@davemloft.net, rds-devel@oss.oracle.com, kt0755@gmail.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, byoungyoung@purdue.edu
Subject: Re: [rds-devel] KASAN: null-ptr-deref Read in rds_ib_get_mr
Message-ID: <20180511104630.GD14952@oracle.com>
References: <20180511052056.GA10547@dragonet.kaist.ac.kr>
 <fa3461d4-8872-48af-9b67-be0affd16bbd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3461d4-8872-48af-9b67-be0affd16bbd@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8889 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 15:48), Yanjun Zhu wrote:
> diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> index e678699..2228b50 100644
> --- a/net/rds/ib_rdma.c
> +++ b/net/rds/ib_rdma.c
> @@ -539,11 +539,17 @@ void rds_ib_flush_mrs(void)
>    void *rds_ib_get_mr(struct scatterlist *sg, unsigned long nents,
>                                         struct rds_sock *rs, u32 *key_ret)
>    {
> -             struct rds_ib_device *rds_ibdev;
> +             struct rds_ib_device *rds_ibdev = NULL;
>                 struct rds_ib_mr *ibmr = NULL;
> -             struct rds_ib_connection *ic = rs->rs_conn->c_transport_data;
> +             struct rds_ib_connection *ic = NULL;
>                 int ret;
> 
> +             if (rs->rs_bound_addr == 0) {
> +                             ret = -EPERM;
> +                             goto out;
> +             }
> +
> +             ic = rs->rs_conn->c_transport_data;
>                 rds_ibdev = rds_ib_get_device(rs->rs_bound_addr);
>                 if (!rds_ibdev) {
>                                 ret = -ENODEV;
> 
> I made this raw patch. If you can reproduce this bug, please make tests 
> with it.

I dont think this solves the problem, I think it
just changes the timing under which it can still happen. 

what if the rds_remove_bound() in rds_bind() happens after the check
for if (rs->rs_bound_addr == 0) added above by the patch 

I believe you need some type of synchronization (either
through mutex, or some atomic flag in the rs or similar) to make
sure rds_bind() and rds_ib_get_mr() are mutually exclusive.

--Sowmini
 
