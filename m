Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935159AbeEIOjd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:39:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60344 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeEIOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:39:32 -0400
Date: Wed, 9 May 2018 16:39:20 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Joachim Eastwood <manabian@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        ldv-project@linuxtesting.org, sil2review@lists.osadl.org,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nxp-spifi: decrement flash_np refcnt on error
 paths
Message-ID: <20180509163920.67a5f203@bbrezillon>
In-Reply-To: <04eca940-cf53-d365-9899-336eb213e089@ispras.ru>
References: <1525812456-25877-1-git-send-email-khoroshilov@ispras.ru>
        <20180509114250.120eb299@bbrezillon>
        <04eca940-cf53-d365-9899-336eb213e089@ispras.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 17:35:41 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> On 09.05.2018 12:42, Boris Brezillon wrote:
> > On Tue,  8 May 2018 23:47:36 +0300
> > Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> >   
> >> nxp_spifi_probe() increments refcnt of SPI flash device node by
> >> of_get_next_available_child() and then it passes the node
> >> to mtd device in nxp_spifi_setup_flash().
> >> But if a failure happens before mtd_device_register() succeed,
> >> the refcnt is left undecremented.  
> > 
> > Why not doing that in the error path of the probe function? Also, you
> > probably want to call of_node_put() in the ->remove() function.
> >   
> 
> 
> You are right.
> 
> I believed that after successful mtd_device_register()
> the node is managed by mtd device. I missed that it calls of_node_get()
> in add_mtd_device() by itself.
> 
> I will prepare v2.
> But I guess there is no need to have of_node_put() in ->remove(), since
> probe() finishes its own usage of flash_np, while mtd_device incremented
> refcnt by itself and will decrement it in ->remove() in
> mtd_device_unregister(&spifi->nor.mtd). So, I would propose
> of_node_put() on both successful and error path.

Sounds good.
