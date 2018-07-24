Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A330C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E1320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E1320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeGXNLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:11:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:36579 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388313AbeGXNLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:11:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6OC5Tbc020813;
        Tue, 24 Jul 2018 07:05:30 -0500
Message-ID: <9a9e496406587b1e21b1e313d7bd68a6e015d715.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi: master-ast-cf: use correct format string for size_t
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 24 Jul 2018 22:05:28 +1000
In-Reply-To: <20180724093433.1623525-1-arnd@arndb.de>
References: <20180724093433.1623525-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 11:34 +0200, Arnd Bergmann wrote:
> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
> causes a warning:
> 
> drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_read':
> drivers/fsi/fsi-master-ast-cf.c:609:23: error: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
>   dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
> drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_write':
> drivers/fsi/fsi-master-ast-cf.c:634:23: error: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
> 
> The correct format string is %zu.

Thanks Arnd, but I've already pushed such a fix in the fsi tree today
:)

Cheers,
Ben.

> Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/fsi/fsi-master-ast-cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 57afaae0b691..d1bbdf8b8343 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -606,7 +606,7 @@ static int fsi_master_acf_read(struct fsi_master *_master, int link,
>  		return -ENODEV;
>  
>  	mutex_lock(&master->lock);
> -	dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
> +	dev_dbg(master->dev, "read id %d addr %x size %zu\n", id, addr, size);
>  	build_ar_command(master, &cmd, id, addr, size, NULL);
>  	rc = fsi_master_acf_xfer(master, id, &cmd, size, val);
>  	last_address_update(master, id, rc == 0, addr);
> @@ -631,7 +631,7 @@ static int fsi_master_acf_write(struct fsi_master *_master, int link,
>  
>  	mutex_lock(&master->lock);
>  	build_ar_command(master, &cmd, id, addr, size, val);
> -	dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
> +	dev_dbg(master->dev, "write id %d addr %x size %zu raw_data: %08x\n",
>  		id, addr, size, *(uint32_t *)val);
>  	rc = fsi_master_acf_xfer(master, id, &cmd, 0, NULL);
>  	last_address_update(master, id, rc == 0, addr);

