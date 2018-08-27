Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91780C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A57208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A57208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeH0NHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:07:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0NHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:07:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBB94ADFE;
        Mon, 27 Aug 2018 09:21:39 +0000 (UTC)
Message-ID: <1535361211.9321.6.camel@suse.com>
Subject: Re: [PATCH v2] usb: iowarrior: replace kmalloc with kmalloc_array
From:   Oliver Neukum <oneukum@suse.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 27 Aug 2018 11:13:31 +0200
In-Reply-To: <20180823174415.GA26008@embeddedor.com>
References: <20180823174415.GA26008@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2018-08-23 at 12:44 -0500,  Gustavo A. R. Silva  wrote:
> A common flaw in the kernel is integer overflow during memory allocation
> size calculations. In an effort to reduce the frequency of these bugs,
> kmalloc_array was implemented, which allocates memory for an array,
> while at the same time detects integer overflow.
> 
> This patch replaces cases of:
> 
> kmalloc(a * b, gfp)
> 
> with:
> 	kmalloc_array(a * b, gfp)

I am afraid there is a problem here. The driver currently is a gross
violation of the DMA rules. Unfortunately your patch does not fix that.

That is on anyrhing other than x86 you cannot take the size of a
report,
but you must use the size of a cache line.

	Regards
		Oliver

