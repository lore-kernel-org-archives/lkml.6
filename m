Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B2C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EE120866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EE120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIMNfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:35:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeIMNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:35:13 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0MxU-0005cg-8e; Thu, 13 Sep 2018 10:26:40 +0200
Date:   Thu, 13 Sep 2018 10:26:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chen Yu <yu.c.chen@intel.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4][v2] PM / hibernate: Check the success of generating
 md5 digest before hibernation
In-Reply-To: <afb1c18493fa3fb891a37752161e9f73a46fc2df.1536685746.git.yu.c.chen@intel.com>
Message-ID: <alpine.DEB.2.21.1809131024500.1473@nanos.tec.linutronix.de>
References: <cover.1536685746.git.yu.c.chen@intel.com> <afb1c18493fa3fb891a37752161e9f73a46fc2df.1536685746.git.yu.c.chen@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Chen Yu wrote:
>  static bool hibernation_e820_mismatch(void *buf)
> @@ -306,6 +307,7 @@ static bool hibernation_e820_mismatch(void *buf)
>  int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  {
>  	struct restore_data_record *rdr = addr;
> +	int ret = -EINVAL;

What's the point of initializing ret?

>  	if (max_size < sizeof(struct restore_data_record))
>  		return -EOVERFLOW;
> @@ -333,7 +335,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  
>  	rdr->magic = RESTORE_MAGIC;
>  
> -	hibernation_e820_save(rdr->e820_digest);
> +	ret = hibernation_e820_save(rdr->e820_digest);
> +	if (ret)
> +		return ret;
>  
>  	return 0;

And what;s the point of ret at all?

	return hibernation_e820_save();

is effectivly the same.

Thanks,

	tglx
