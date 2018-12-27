Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE5C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F27214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeL0F1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:27:48 -0500
Received: from ozlabs.org ([203.11.71.1]:57791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbeL0F1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 00:27:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43QJJJ14NFz9s3l;
        Thu, 27 Dec 2018 16:27:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/10] pseries: ibmebus.c: convert to use BUS_ATTR_WO
In-Reply-To: <20181221075442.17109-5-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org> <20181221075442.17109-5-gregkh@linuxfoundation.org>
Date:   Thu, 27 Dec 2018 16:27:50 +1100
Message-ID: <87tvizy1wp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> We are trying to get rid of BUS_ATTR() and the usage of that in
> ibmebus.c can be trivially converted to use BUS_ATTR_WO(), so use that
> instead.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/platforms/pseries/ibmebus.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
> index 5b4a56131904..84e8ec4011ba 100644
> --- a/arch/powerpc/platforms/pseries/ibmebus.c
> +++ b/arch/powerpc/platforms/pseries/ibmebus.c
> @@ -261,8 +261,7 @@ static char *ibmebus_chomp(const char *in, size_t count)
>  	return out;
>  }
>  
> -static ssize_t ibmebus_store_probe(struct bus_type *bus,
> -				   const char *buf, size_t count)
> +static ssize_t probe_store(struct bus_type *bus, const char *buf, size_t count)
>  {
>  	struct device_node *dn = NULL;
>  	struct device *dev;
> @@ -298,10 +297,9 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
>  		return rc;
>  	return count;
>  }
> -static BUS_ATTR(probe, 0200, NULL, ibmebus_store_probe);
> +static BUS_ATTR_WO(probe);
>  
> -static ssize_t ibmebus_store_remove(struct bus_type *bus,
> -				    const char *buf, size_t count)
> +static ssize_t remove_store(struct bus_type *bus, const char *buf, size_t count)
>  {
>  	struct device *dev;
>  	char *path;
> @@ -325,7 +323,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
>  		return -ENODEV;
>  	}
>  }
> -static BUS_ATTR(remove, 0200, NULL, ibmebus_store_remove);
> +static BUS_ATTR_WO(remove);
>  
>  static struct attribute *ibmbus_bus_attrs[] = {
>  	&bus_attr_probe.attr,
> -- 
> 2.20.1
