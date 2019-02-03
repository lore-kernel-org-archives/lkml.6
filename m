Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94220856
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBCDm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 22:42:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfBCDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 22:42:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE64C81F12;
        Sun,  3 Feb 2019 03:42:27 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C5348CC0;
        Sun,  3 Feb 2019 03:42:24 +0000 (UTC)
Date:   Sat, 02 Feb 2019 19:42:24 -0800 (PST)
Message-Id: <20190202.194224.82433482865207218.davem@redhat.com>
To:     callum.sinclair@alliedtelesis.co.nz
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
From:   David Miller <davem@redhat.com>
In-Reply-To: <20190130205209.18183-2-callum.sinclair@alliedtelesis.co.nz>
References: <20190130205209.18183-1-callum.sinclair@alliedtelesis.co.nz>
        <20190130205209.18183-2-callum.sinclair@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 03 Feb 2019 03:42:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Date: Thu, 31 Jan 2019 09:52:09 +1300

>  
> -/* Close the multicast socket, and clear the vif tables etc */
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +/* Clear the vif tables */
> +static void mroute_clean_cache(struct mr_table *mrt, bool all)
>  {
> -	struct net *net = read_pnet(&mrt->net);
>  	struct mr_mfc *c, *tmp;
>  	struct mfc_cache *cache;
> -	LIST_HEAD(list);
> -	int i;
> -
> -	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		vif_delete(mrt, i, 0, &list);
> -	}
> -	unregister_netdevice_many(&list);
> +	struct net *net = read_pnet(&mrt->net);

Please do not change the order of local variables like this, you're breaking
the correct reverse christmas tree ordering of longest to shortest line for
local variable declarations.

Thanks.
