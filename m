Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F88206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F88206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeKSTxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:53:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbeKSTxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:53:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55760AEB8;
        Mon, 19 Nov 2018 09:30:04 +0000 (UTC)
Message-ID: <1542619239.2630.6.camel@suse.com>
Subject: Re: [PATCH] usb: hub: add I/O error retry & reset routine
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        nsaaenzjulienne@suse.de, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Date:   Mon, 19 Nov 2018 10:20:39 +0100
In-Reply-To: <20181115171418.23522-1-nsaenzjulienne@suse.de>
References: <20181115171418.23522-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2018-11-15 at 18:14 +0100, Nicolas Saenz Julienne wrote:

Hi,

what Alan said, in addition you need to stop the error handling
when the device is suspended or reset.
 
> @@ -713,8 +751,10 @@ static void hub_irq(struct urb *urb)
>  		return;
>  
>  	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> -	if (status != 0 && status != -ENODEV && status != -EPERM)
> +	if (status != 0 && status != -ENODEV && status != -EPERM) {

This also needs to check for -ESHUTDOWN

	Regards
		Oliver

