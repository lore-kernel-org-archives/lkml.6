Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935355AbeEJMl5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:41:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757217AbeEJMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:41:55 -0400
Date: Thu, 10 May 2018 15:41:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jiri@mellanox.com, idosch@mellanox.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core: Fix an error handling path in
 'mlxsw_core_bus_device_register()'
Message-ID: <20180510124138.6yerbsfcl3abqtmq@mwanda>
References: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:26:16PM +0200, Christophe JAILLET wrote:
> Resources are not freed in the reverse order of the allocation.
> Labels are also mixed-up.
> 
> Fix it and reorder code and labels in the error handling path of
> 'mlxsw_core_bus_device_register()'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Please review carefully. This patch is proposed because it triggers one of
> my coccinelle scripts. I'm not 100% sure if correct.
> 

Looks correct.

The err = mlxsw_driver->resources_register(mlxsw_core); pointer is a
pointer to mlxsw_sp_resources_register().  That function doesn't clean
up after itself on failure.  Ideally, you'd want a matching
mlxsw_driver->resources_unregister as well pointer instead of hard
coding devlink_resources_unregister().

The error handling would be easier to review if the gotos told you what
the did.  Right now they're written in "come from" style so the tell you
what happened on the line before.

	if (!foo)
		goto allocating_foo_failed;

Hopefully if someone fixes mlxsw_sp_resources_register() they'll choose
better label names.

regards,
dan carpenter
