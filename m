Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C1C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0C280A0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F0C280A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936887AbeF2WLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:11:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:28177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936809AbeF2WLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:11:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 15:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="236719395"
Received: from ssaleem-mobl4.amr.corp.intel.com (HELO ssaleem-mobl1) ([10.122.32.166])
  by orsmga005.jf.intel.com with SMTP; 29 Jun 2018 15:10:56 -0700
Received: by ssaleem-mobl1 (sSMTP sendmail emulation); Fri, 29 Jun 2018 17:10:54 -0500
Date:   Fri, 29 Jun 2018 17:10:52 -0500
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        "Orosco, Henry" <henry.orosco@intel.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] [v2] infiniband: i40iw, nes: don't use wall time for TCP
 sequence numbers
Message-ID: <20180629221052.GA14152@ssaleem-MOBL4.amr.corp.intel.com>
References: <20180627132628.915978-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627132628.915978-1-arnd@arndb.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:26:05AM -0600, Arnd Bergmann wrote:
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
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use secure_tcpv6_seq for IPv6 support as suggested by Shiraz Saleem.
> ---

Looks good.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
