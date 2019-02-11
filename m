Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85C20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBKJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:09:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfBKJJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58E19811D9;
        Mon, 11 Feb 2019 09:09:38 +0000 (UTC)
Received: from localhost (ovpn-12-138.pek2.redhat.com [10.72.12.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 644895D97A;
        Mon, 11 Feb 2019 09:09:34 +0000 (UTC)
Date:   Mon, 11 Feb 2019 17:09:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Julian Stecklina <js@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Julian Stecklina <jsteckli@amazon.de>
Subject: Re: [PATCH 1/2] x86/boot: fix KASL when memmap range manipulation is
 used
Message-ID: <20190211090931.GA2501@localhost>
References: <1548866403-13390-1-git-send-email-js@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548866403-13390-1-git-send-email-js@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 09:09:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/19 at 05:40pm, Julian Stecklina wrote:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709..5657e34 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -155,6 +155,12 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
>  	case '#':
>  	case '$':
>  	case '!':
> +		/*
> +		 * % would need some more complex parsing, because regions might
> +		 * actually become usable for KASLR, but the simple way of
> +		 * ignoring anything that is mentioned in % works for now.
> +		 */

This seems to make thing more complicated even though have to. One
concern is whether we need to check the oldtype|newtype , e.g
oldtype=reserverd, newtype=RAM, is it possible to set like that?

Thanks
Baoquan

> +	case '%':
>  		*start = memparse(p + 1, &p);
>  		return 0;
>  	case '@':
> -- 
> 2.7.4
> 
