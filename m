Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4ADECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E4820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E4820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeGUOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:22:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:15889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeGUOWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:22:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 06:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,385,1526367600"; 
   d="scan'208";a="76665215"
Received: from ssaleem-mobl4.amr.corp.intel.com (HELO ssaleem-mobl1) ([10.255.33.195])
  by orsmga002.jf.intel.com with SMTP; 21 Jul 2018 06:29:52 -0700
Received: by ssaleem-mobl1 (sSMTP sendmail emulation); Sat, 21 Jul 2018 08:29:52 -0500
Date:   Sat, 21 Jul 2018 08:29:51 -0500
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Orosco, Henry" <henry.orosco@intel.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] [v3] infiniband: i40iw, nes: don't use wall time for TCP
 sequence numbers
Message-ID: <20180721132951.GB4640@ssaleem-MOBL4.amr.corp.intel.com>
References: <20180709083523.448587-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083523.448587-1-arnd@arndb.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:34:43AM -0600, Arnd Bergmann wrote:
> The nes infiniband driver uses current_kernel_time() to get a nanosecond
> granunarity timestamp to initialize its tcp sequence counters. This is
> one of only a few remaining users of that deprecated function, so we
> should try to get rid of it.
> 
> Aside from using a deprecated API, there are several problems I see here:
> 
> - Using a CLOCK_REALTIME based time source makes it predictable in
>   case the time base is synchronized.
> - Using a coarse timestamp means it only gets updated once per jiffie,
>   making it even more predictable in order to avoid having to access
>   the hardware clock source
> - The upper 2 bits are always zero because the nanoseconds are at most
>   999999999.
> 
> For the Linux TCP implementation, we use secure_tcp_seq(), which appears
> to be appropriate here as well, and solves all the above problems.
> 
> i40iw uses a variant of the same code, so I do that same thing there
> for ipv4. Unlike nes, i40e also supports ipv6, which needs to call
> secure_tcpv6_seq instead.
> 
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use secure_tcpv6_seq for IPv6 support as suggested by Shiraz Saleem.
> v3: add a soft IPv6 dependency to prevent a link error with CONFIG_IPV6=m,
>     this now forces i40iw to be a module as well, add an IS_ENABLED()
>     check to avoid calling it when IPV6 is completely disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/i40iw/Kconfig    |  1 +
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 26 +++++++++++++++++++++-----
>  drivers/infiniband/hw/nes/nes_cm.c     |  8 +++++---
>  net/core/secure_seq.c                  |  1 +
>  4 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/i40iw/Kconfig b/drivers/infiniband/hw/i40iw/Kconfig
> index 2962979c06e9..d867ef1ac72a 100644
> --- a/drivers/infiniband/hw/i40iw/Kconfig
> +++ b/drivers/infiniband/hw/i40iw/Kconfig
> @@ -1,6 +1,7 @@
>  config INFINIBAND_I40IW
>  	tristate "Intel(R) Ethernet X722 iWARP Driver"
>  	depends on INET && I40E
> +	depends on IPV6 || !IPV6
>  	depends on PCI
>  	select GENERIC_ALLOCATOR
>  	---help---

v3 update looks ok. Thanks!
