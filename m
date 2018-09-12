Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA6C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086312087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jwyIAVbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086312087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeILVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:30:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dnl+nsZSFtuJH7PGS4Sec4+GXx7gVXmHXNRwYQVPmPk=; b=jwyIAVbACcLprCWbP6im3Ephe
        FlrTud8yZMp3a6xYXakuAN3CznHqt7dr7+Jf6RW2n4vnsPx37Tt9a7XXOk3Z/vWreKLmWKxbHG6OF
        JSCg9GTI+AEYZE+YZvwv7GkRjuX+3a7D6HX1iZc15bmJUbRZJvNiS3JNwyQKUQQOSMDxwQrkRQdBN
        ZaxPqjMPQDVu1UDYD4vAKfm26zIV0Ks6EFTKjRgzY1PiJf0jBDnrUAXMeGsPEWiK81voWDMdgIHgW
        OJpA5Jy0L2enFDNfEzlW0zkoj3ay3xGxudqTltk7pa7bZZccNHZdiu//zv4ZiGCm6/21pz5kQXIJG
        S2wPJHKJw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07wX-0001ki-L5; Wed, 12 Sep 2018 16:24:41 +0000
Subject: Re: [PATCH 5/5] PM / hibernate: An option to request that snapshot
 image must be authenticated
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-6-jlee@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ee402c0-bd0e-ea84-9def-f6355b83b4f5@infradead.org>
Date:   Wed, 12 Sep 2018 09:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912142337.21955-6-jlee@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 7c5c30149dbc..3c998fd6dc4c 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -90,6 +90,17 @@ config HIBERNATION_ENC_AUTH
>  	  master key of hibernation. The TPM trusted key depends on TPM. The
>  	  security of user defined key relies on user space.
>  
> +config HIBERNATION_ENC_AUTH_FORCE
> +	bool "Require hibernate snapshot image to be validly signed"
> +	depends on HIBERNATION_ENC_AUTH
> +	help
> +	  This option will prevent that a snapshot image without (valid)
> +	  signature be restored. Without this option, a unauthenticated

	                                              an

> +	  snapshot image can be restored but the restored kernel will be
> +	  tainted. Which also means that the hibernation can be triggered

s/Which/This/

or like this:
	  tainted, which also

> +	  without snapshot key but kernel will be tainted without this
> +	  option.
> +


-- 
~Randy
