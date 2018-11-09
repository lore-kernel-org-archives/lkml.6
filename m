Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B079DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772AB20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEICTFYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772AB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKJClj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJClj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:41:39 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB5C20855;
        Fri,  9 Nov 2018 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541782814;
        bh=0y1vxe9UYqU39FgXgs3aaxN1/WJTF7Tn0EspaL/fnC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEICTFYF2RGJu1bUrvB/wwYfFYzKqF3rgpMpyabaQRP4p3gWAsB5pmuSkGjgsD6KH
         eLRbrNMg719a9olxBH6eZdLGZZIcRLm/Fux5v72XkvdyAx/ya8F0ALZpL7GFqu28zk
         CkGIAzNFAWxJkhIyfMaUkbDLlBFk23KCYb+oEkuw=
Date:   Fri, 9 Nov 2018 09:00:13 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART
Message-ID: <20181109170013.GB13927@kroah.com>
References: <20181018234352.26788-1-paul.walmsley@sifive.com>
 <20181018234352.26788-3-paul.walmsley@sifive.com>
 <20181109165951.GA13927@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109165951.GA13927@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:59:51AM -0800, Greg Kroah-Hartman wrote:
> On Thu, Oct 18, 2018 at 04:43:54PM -0700, Paul Walmsley wrote:
> > Add a serial driver for the SiFive UART, found on SiFive FU540 devices
> > (among others).
> > 
> > The underlying serial IP block is relatively basic, and currently does
> > not support serial break detection.  Further information on the IP
> > block can be found in the documentation and Chisel sources:
> > 
> > https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> > 
> > https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > 
> > This driver was written in collaboration with Wesley Terpstra
> > <wesley@sifive.com>.
> > 
> > Boot-tested on a SiFive HiFive Unleashed A00 board.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Wesley Terpstra <wesley@sifive.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> >  drivers/tty/serial/Kconfig       |   24 +
> >  drivers/tty/serial/Makefile      |    1 +
> >  drivers/tty/serial/sifive.c      | 1070 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |    3 +
> >  4 files changed, 1098 insertions(+)
> >  create mode 100644 drivers/tty/serial/sifive.c
> 
> Seems like the 0-day bot did not like this driver, can you fix up those
> build errors and resend?

Nevermind, you did, sorry about that...
