Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeDYNtB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:49:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbeDYNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:48:59 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] rds: ib: Fix missing call to rds_ib_dev_put in
 rds_ib_setup_qp
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
Date: Wed, 25 Apr 2018 15:48:51 +0200
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Message-Id: <67AE1ED5-55ED-4572-92E9-9FCE18C824A5@oracle.com>
References: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
To: Dag Moxnes <dag.moxnes@oracle.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=15 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3PDn84T002861



> On 25 Apr 2018, at 13:22, Dag Moxnes <dag.moxnes@oracle.com> wrote:
> 
> The function rds_ib_setup_qp is calling rds_ib_get_client_data and
> should correspondingly call rds_ib_dev_put. This call was lost in
> the non-error path with the introduction of error handling done in
> commit 3b12f73a5c29 ("rds: ib: add error handle")
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>

Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>


Thxs, Håkon

> ---
> net/rds/ib_cm.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
> index eea1d86..13b38ad 100644
> --- a/net/rds/ib_cm.c
> +++ b/net/rds/ib_cm.c
> @@ -547,7 +547,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
> 	rdsdebug("conn %p pd %p cq %p %p\n", conn, ic->i_pd,
> 		 ic->i_send_cq, ic->i_recv_cq);
> 
> -	return ret;
> +	goto out;
> 
> sends_out:
> 	vfree(ic->i_sends);
> @@ -572,6 +572,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
> 		ic->i_send_cq = NULL;
> rds_ibdev_out:
> 	rds_ib_remove_conn(rds_ibdev, conn);
> +out:
> 	rds_ib_dev_put(rds_ibdev);
> 
> 	return ret;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
