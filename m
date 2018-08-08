Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4311C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EED21B34
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EED21B34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeHIBl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:41:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:52370 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHIBl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:41:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 16:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,212,1531810800"; 
   d="scan'208";a="81828955"
Received: from unknown (HELO [192.168.0.102]) ([10.10.37.145])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2018 16:20:04 -0700
Subject: Re: [PATCH] misc: mic: SCIF Fix scif_get_new_port() error handling
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
In-Reply-To: <20180802084222.xa3uwxld5en3cfzx@kili.mountain>
References: <20180802084222.xa3uwxld5en3cfzx@kili.mountain>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 08 Aug 2018 16:13:43 -0700
Message-ID: <1533770023.18931.412.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 (2.28.3-30.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 01:42 -0700, Dan Carpenter wrote:
> There are only 2 callers of scif_get_new_port() and both appear to get
> the error handling wrong.  Both treat zero returns as error, but it
> actually returns negative error codes and >= 0 on success.
> 
> Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I have not tested this patch.  Please review carefully.

Thanks for the patch Dan.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> 
> diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
> index 463f06d0b4ef..8dd0ccedeb94 100644
> --- a/drivers/misc/mic/scif/scif_api.c
> +++ b/drivers/misc/mic/scif/scif_api.c
> @@ -371,11 +371,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
>  			goto scif_bind_exit;
>  		}
>  	} else {
> -		pn = scif_get_new_port();
> -		if (!pn) {
> -			ret = -ENOSPC;
> +		ret = scif_get_new_port();
> +		if (ret < 0)
>  			goto scif_bind_exit;
> -		}
> +		pn = ret;
>  	}
>  
>  	ep->state = SCIFEP_BOUND;
> @@ -649,13 +648,12 @@ int __scif_connect(scif_epd_t epd, struct scif_port_id *dst, bool non_block)
>  			err = -EISCONN;
>  		break;
>  	case SCIFEP_UNBOUND:
> -		ep->port.port = scif_get_new_port();
> -		if (!ep->port.port) {
> -			err = -ENOSPC;
> -		} else {
> -			ep->port.node = scif_info.nodeid;
> -			ep->conn_async_state = ASYNC_CONN_IDLE;
> -		}
> +		err = scif_get_new_port();
> +		if (err < 0)
> +			break;
> +		ep->port.port = err;
> +		ep->port.node = scif_info.nodeid;
> +		ep->conn_async_state = ASYNC_CONN_IDLE;
>  		/* Fall through */
>  	case SCIFEP_BOUND:
>  		/*


