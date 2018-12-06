Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72720989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A72720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeLFIye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:54:34 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:43285 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIyd (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 03:54:33 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 09:54:31 +0100
Received: from [192.168.1.132] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 08:54:05 +0000
Message-ID: <1544086444.5492.1.camel@suse.com>
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for
 UUID"
From:   Jean Delvare <jdelvare@suse.com>
To:     Peter Korsgaard <peter@korsgaard.com>, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 09:54:04 +0100
In-Reply-To: <20181205211351.5309-1-peter@korsgaard.com>
References: <20181205211351.5309-1-peter@korsgaard.com>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 22:13 +0100, Peter Korsgaard wrote:
> This reverts commit 712ff25450bd01366301eef81c33e865d901e7b7.
> 
> The output of dmi_save_uuid() is exposed to user space as
> /sys/devices/virtual/dmi/id/*_uuid, so this breaks backwards compatibility,
> E.G.  I have systems that include the content of dmi/id/product_uuid as part
> of the keyphrase for cryptsetup luksOpen.
> 
> As the change was purely cosmetical, revert it to fix such breakage.

The change is not "cosmetical". The change was done to comply with RFC
4122:

https://tools.ietf.org/html/rfc4122

  The hexadecimal values "a" through "f" are output as
  lower case characters and are case insensitive on input.

If "cryptsetup luksOpen" does not lowercase digits before computing its
key passphrase, then it's not RFC 4122-compliant and should be fixed.

> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
>  drivers/firmware/dmi_scan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 099d83e4e910..2ed51651565f 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -211,9 +211,9 @@ static void __init dmi_save_uuid(const struct dmi_header *dm, int slot,
>  	 * says that this is the defacto standard.
>  	 */
>  	if (dmi_ver >= 0x020600)
> -		sprintf(s, "%pUl", d);
> +		sprintf(s, "%pUL", d);
>  	else
> -		sprintf(s, "%pUb", d);
> +		sprintf(s, "%pUB", d);
>  
>  	dmi_ident[slot] = s;
>  }

Nak. This is too late. Changing it again would just add confusion.

-- 
Jean Delvare
SUSE L3 Support
