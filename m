Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7071FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C50208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C50208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbeG0QbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:31:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbeG0QbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:31:19 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D147BC93;
        Fri, 27 Jul 2018 15:08:58 +0000 (UTC)
Date:   Fri, 27 Jul 2018 17:08:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging: gasket: save struct device for a gasket
 device
Message-ID: <20180727150855.GB3713@kroah.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
 <20180727030737.231268-2-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727030737.231268-2-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:07:28PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Save the struct device pointer to a gasket device in gasket's metadata,
> to facilitate use of standard logging calls and in anticipation of
> non-PCI gasket devices in the future.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 5 +++--
>  drivers/staging/gasket/gasket_core.h | 3 +++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 732218773c3c6..e8f3b021c20d1 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -450,6 +450,7 @@ static int gasket_alloc_dev(
>  	gasket_dev->internal_desc = internal_desc;
>  	gasket_dev->dev_idx = dev_idx;
>  	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
> +	gasket_dev->dev = parent;

Normally when saving off a pointer to an object that you reference later
on, and that you rely on, you need to grab a reference to it, otherwise
it may disappear at any point in time.

However this whole "wrap the pci layer" nonsense is a total mess with
the lifetime rules of devices, so it's probably the least of your
worries....

As long as you know you will have to fix that crud up, and what you are
doing here will bite you if you do not do it right, that's fine with
me...

thanks,

greg k-h
