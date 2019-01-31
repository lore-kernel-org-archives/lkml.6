Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF5FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B121872
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548971061;
	bh=tONGFam/ja1LeJ4xY5qGd4SoU1LxE70EjcaZ++/CmYQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=tViUbGtt9SdknhSWRKPGoXmZTFg2UaNJ8mHj9ceFCXVdqm7kkiM3OVaqacRHJBI8S
	 OvRS6upyZo5VvLafQ3AZIfCOLuCxxGKUiW3qvJ9wq9GENf7K3Z/m2bDtgr3T9PwW9V
	 LN2wyZ+GLPLssqwOKtrrF5a2RBtX3HjZQrLCZSo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAaVoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAaVoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:44:19 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98EA420869;
        Thu, 31 Jan 2019 21:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548971059;
        bh=tONGFam/ja1LeJ4xY5qGd4SoU1LxE70EjcaZ++/CmYQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mIJ9gCdDNofYKWSkONXiUcAe43xsbKzDXQBlCcUJVuFg4BVxOPUx2i8hfMLcTzfMT
         ANhEo5//Z2pDDIwXYcwKhadw4bnakeR1ouuSAw9tkd0de9ivoK5Gf6pJYrdIcDTIhn
         5JtKlTBjZNKyet0B/5vxEkXMbdj0XG4O95eNONxU=
Date:   Thu, 31 Jan 2019 13:44:15 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
cc:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
In-Reply-To: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
Message-ID: <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1499689100-1548971056=:22962"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1499689100-1548971056=:22962
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 31 Jan 2019, Oleksandr Andrushchenko wrote:
> Hello,
> 
> I am working on porting an out-of-tree kernel driver to the kernel
> 5.0 and that driver uses functionality provided by 
> drivers/xen/mem-reservation.c
> module.  Since commit [1] it is not possible to build a kernel module
> which uses mem-reservation API as xen_scrub_pages variable, which is 
> checked in
> xenmem_reservation_scrub_page, became a kernel module parameter and is 
> now only
> accessible for built-in modules:
> 
> static inline void xenmem_reservation_scrub_page(struct page *page)
> ^^^^^^^^^^^^^
> {
>      if (xen_scrub_pages)
>          ^^^^^^^^^^^^^^^
>          clear_highpage(page);
> }
> 
> This results in link-time warning:
> 
>      WARNING: "xen_scrub_pages" [yourmodule.ko] undefined!
> 
> and thus not allowing the module to run. At the moment I can only see a 
> possible fix
> for this by making the following change:
> 
> diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
> index 3782cf070338..85fecfec50e1 100644
> --- a/drivers/xen/mem-reservation.c
> +++ b/drivers/xen/mem-reservation.c
> @@ -18,6 +18,7 @@
> 
>   bool __read_mostly xen_scrub_pages = 
> IS_ENABLED(CONFIG_XEN_SCRUB_PAGES_DEFAULT);
>   core_param(xen_scrub_pages, xen_scrub_pages, bool, 0);
> +EXPORT_SYMBOL(xen_scrub_pages);
> 
> but this looks a bit unusual for the kernel?
> 
> I am looking for community advice here and help
> 
> Thank you,
> Oleksandr
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=197ecb3802c04499d8ff4f8cb28f6efa008067db

The alternative would be to turn xenmem_reservation_scrub_page into a
regular function (not a static inline)?
--8323329-1499689100-1548971056=:22962--
