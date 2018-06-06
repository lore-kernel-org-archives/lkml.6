Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFFroDlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C09D3605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbeFFI2X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932417AbeFFI2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:28:22 -0400
Date: Wed, 6 Jun 2018 10:27:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/14] coresight: move shared barrier_pkt[] to
 coresight_priv.h
Message-ID: <20180606082757.GD19727@kroah.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-4-kim.phillips@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605210710.22227-4-kim.phillips@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:06:59PM -0500, Kim Phillips wrote:
> barrier_pkt[] is used in the etb and tmc-etf coresight
> components.  Change barrier_pkt[] to a static definition,
> so as to allow them to be built as modules.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h | 8 +++++++-
>  drivers/hwtracing/coresight/coresight.c      | 7 -------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 158c720119dd..e76f19ca9e04 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -57,7 +57,13 @@ static DEVICE_ATTR_RO(name)
>  #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
>  	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
>  
> -extern const u32 barrier_pkt[4];
> +/*
> + * When losing synchronisation a new barrier packet needs to be inserted at the
> + * beginning of the data collected in a buffer.  That way the decoder knows that
> + * it needs to look for another sync sequence.
> + */
> +static const u32 barrier_pkt[4] = { 0x7fffffff, 0x7fffffff,
> +				    0x7fffffff, 0x7fffffff };

Are you _sure_ this is doing what you think it is doing?

You now just created a bunch of different copies of this structure,
which might change the logic involved, right?

Putting a static variable in a .h file is generally considered a very
bad thing to do, I need a lot more "proof" this is ok before I can
accept this.  Worse case, just put the variable in the individual places
where it is needed.

thanks,

greg k-h
