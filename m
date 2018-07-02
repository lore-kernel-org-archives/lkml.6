Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7512C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1842521C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1842521C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGBGdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:33:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbeGBGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:32:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2584B78;
        Mon,  2 Jul 2018 06:32:58 +0000 (UTC)
Date:   Mon, 2 Jul 2018 08:32:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4.17 154/220] UBIFS: Fix potential integer overflow in
 allocation
Message-ID: <20180702063255.GA12378@kroah.com>
References: <20180701160908.272447118@linuxfoundation.org>
 <20180701160914.723817814@linuxfoundation.org>
 <CAFLxGvwxDRMUoJH-3NKefXS6YxL62DjxRDd-5e_ui5jjJAJiJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvwxDRMUoJH-3NKefXS6YxL62DjxRDd-5e_ui5jjJAJiJQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 08:48:07PM +0200, Richard Weinberger wrote:
> On Sun, Jul 1, 2018 at 6:22 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.17-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> >
> > commit 353748a359f1821ee934afc579cf04572406b420 upstream.
> >
> > There is potential for the size and len fields in ubifs_data_node to be
> > too large causing either a negative value for the length fields or an
> > integer overflow leading to an incorrect memory allocation. Likewise,
> > when the len field is small, an integer underflow may occur.
> >
> > Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> > Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Guys, this patch was never on linux-mtd nor was I CC'ed.
> I don't see it so super security critical which argues to bypass the
> whole community review process.
> 
> Anyway, I don't like this patch for two reasons.
> 1. Instead of doing the kmalloc_array() dance, just check whether size
> is 0 > and <= UBIFS_BLOCK_SIZE, in the caller.
> 2. It will not apply to most stable kernels since it targets the code
> path with UBIFS encryption available.

Can you get a fix into Linus's tree that I can also queue up for a
stable release?

thanks,

greg k-h
