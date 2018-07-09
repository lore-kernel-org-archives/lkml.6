Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EF3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB972084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB972084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeGII1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:27:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:14329 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754346AbeGII1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:27:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 01:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="70717078"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 09 Jul 2018 01:27:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Jul 2018 11:27:32 +0300
Date:   Mon, 9 Jul 2018 11:27:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: avoid format-overflow warning
Message-ID: <20180709082732.GC8308@kuha.fi.intel.com>
References: <20180706132843.51206-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706132843.51206-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:28:32PM +0200, Arnd Bergmann wrote:
> gcc-8 points out that the fix-byte buffer might be too small if
> desc->mode is a three-digit number:
> 
> drivers/usb/typec/class.c: In function 'typec_register_altmode':
> drivers/usb/typec/class.c:502:32: error: '%d' directive writing between 1 and 3 bytes into a region of size 2 [-Werror=format-overflow=]
>   sprintf(alt->group_name, "mode%d", desc->mode);
>                                 ^~
> drivers/usb/typec/class.c:502:27: note: directive argument in the range [0, 255]
>   sprintf(alt->group_name, "mode%d", desc->mode);
>                            ^~~~~~~~
> drivers/usb/typec/class.c:502:2: note: 'sprintf' output between 6 and 8 bytes into a destination of size 6
>   sprintf(alt->group_name, "mode%d", desc->mode);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I assume this cannot happen in practice, but we can simply make the
> string long enough to avoid the warning. This uses the two padding
> bytes that already exist after the string.
> 
> Fixes: 4ab8c18d4d67 ("usb: typec: Register a device for every mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> index 62aaf8b56bde..db40e61d8b72 100644
> --- a/drivers/usb/typec/bus.h
> +++ b/drivers/usb/typec/bus.h
> @@ -16,7 +16,7 @@ struct altmode {
>  	enum typec_port_data		roles;
>  
>  	struct attribute		*attrs[5];
> -	char				group_name[6];
> +	char				group_name[8];
>  	struct attribute_group		group;
>  	const struct attribute_group	*groups[2];
>  

Thanks,

-- 
heikki
