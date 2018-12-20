Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE52121773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545304447;
	bh=qkcBJQcK9EzKTNvCn2J3Q56O1CSgbtK7TIpoj0Cd1MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZS5M2wf80QsKrwcQcSqlKr9OvlTk61I6YSZhfzSzqegugx7A+W1Rweq+jtBH/Xofr
	 99bg0DKsWuuuq0aEcwgTJI0V8fZY6wc5Ij89mOd7vrYy02LPmeEcVN2DIKB763+omX
	 1FvDMcSkN+1U0ktTvr5/8zJQ15CgmIcl61u9z92A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeLTLOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTLOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:14:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31EE22177E;
        Thu, 20 Dec 2018 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545304445;
        bh=qkcBJQcK9EzKTNvCn2J3Q56O1CSgbtK7TIpoj0Cd1MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NB1MIHDtKAO6S3NbbT/7Muqq1uORKJnYiv0l928izLYYVbo4Z7jlbMQFJRsrK7oG/
         JGZ12MMEB5E1MM0HKOr6GU6sN2Z2J3j8LSVx9afVTFLLrSvHhK8hmZ7FN8cvM6P6+S
         JD6dkxejLlXwKRQbupoarJZxBbGNPPWYwIVv6JZw=
Date:   Thu, 20 Dec 2018 12:14:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
Message-ID: <20181220111403.GB10978@kroah.com>
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220102247.4911-2-a.hajda@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);

Can you show a driver being converted to use this to show if it really
will save a bunch of lines and make things simpler?  Usually you are
requesting lots of resources so you need to do more than just return,
you need to clean stuff up first.

thanks,

greg k-h
