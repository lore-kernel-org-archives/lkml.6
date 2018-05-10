Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965505AbeEJOTB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:19:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:18:58 -0400
Date: Thu, 10 May 2018 17:18:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
Message-ID: <20180510141836.2qlm676j4675buti@mwanda>
References: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
 <20180510133808.GA10943@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510133808.GA10943@lap1>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=316
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:38:08PM +0300, Yuval Shaia wrote:
> On Thu, May 10, 2018 at 09:02:26AM +0200, Christophe JAILLET wrote:
> > If an error occurs, 'mlx4_en_destroy_netdev()' is called.
> > It then calls 'mlx4_en_free_resources()' which does the needed resources
> > cleanup.
> > 
> > So, doing some explicit kfree in the error handling path would lead to
> > some double kfree.
> 
> Patch make sense but what's bothering me is that mlx4_en_free_resources
> loops on the entire array, assuming !priv->tx_ring[t] means entry is
> allocated but the existing code does not assume that, see [1]. So i looked
> to see where tx_ring array is zeroed and didn't find it.
> 
> Am i missing something here.
> 

It's zeroed twice.  alloc_etherdev_mqs() allocates zeroed memory and
then we do a memset(priv, 0, sizeof(struct mlx4_en_priv));

regards,
dan carpenter
