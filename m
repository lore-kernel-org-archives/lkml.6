Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB76C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC57C20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC57C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJEQrw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:47:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52474 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:47:52 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id c01a0ac78b522896; Fri, 5 Oct 2018 11:49:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org, tglx@linutronix.de,
        rafael@kernel.org, indou.takao@jp.fujitsu.com
Subject: Re: [PATCH v3] acpi/processor: Fix the return value of acpi_processor_ids_walk()
Date:   Fri, 05 Oct 2018 11:46:49 +0200
Message-ID: <2335374.IdaxaSRSxG@aspire.rjw.lan>
In-Reply-To: <20180824025126.19231-1-douly.fnst@cn.fujitsu.com>
References: <20180824025126.19231-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 24, 2018 4:51:26 AM CEST Dou Liyang wrote:
> ACPI driver should make sure all the processor IDs in their ACPI Namespace
> are unique. the driver performs a depth-first walk of the namespace tree
> and calls the acpi_processor_ids_walk() to check the duplicate IDs.
> 
> But, the acpi_processor_ids_walk() mistakes the return value. If a
> processor is checked, it returns true which causes the walk break
> immediately, and other processors will never be checked.
> 
> Repace the value with AE_OK which is the standard acpi_status value.
> And don't abort the namespace walk even on error.
> 
> Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for processor enumeration")
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
> Changelog:
>   v2 --> v3:
>    - Fix a compiler error reported by LKP
>   v1 --> v2:
>    - Fix the check against duplicate IDs suggested by Rafael.
>   
>   Now，the duplicate IDs only be found in Ivb42 machine, and we have added this check at 
>   linux-4.9. But, we introduced a bug in linux-4.12 by commit 8c8cb30f49b8.
> 
>   For resolving the bug, firstly, I removed the check[1]. because Linux will compare
>   the coming ID with present processors when it hot-added a physical CPU and will avoid
>   using duplicate IDs.
> 
>   But, seems we should consider all the possible processors. So, with this patch, All
>   the processors with the same IDs will never be hot-plugged.
> 
> [1] https://lkml.org/lkml/2018/5/28/213
> ---
>  drivers/acpi/acpi_processor.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 449d86d39965..fc447410ae4d 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -643,7 +643,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
>  
>  	status = acpi_get_type(handle, &acpi_type);
>  	if (ACPI_FAILURE(status))
> -		return false;
> +		return status;
>  
>  	switch (acpi_type) {
>  	case ACPI_TYPE_PROCESSOR:
> @@ -663,11 +663,12 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
>  	}
>  
>  	processor_validated_ids_update(uid);
> -	return true;
> +	return AE_OK;
>  
>  err:
> +	/* Exit on error, but don't abort the namespace walk */
>  	acpi_handle_info(handle, "Invalid processor object\n");
> -	return false;
> +	return AE_OK;
>  
>  }
>  
> 

Applied, thanks!


