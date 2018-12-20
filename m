Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E37218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545320500;
	bh=eaNy5oGe5YhiyNPCoCRvlbDVwDNKFIaCKXYzzWFIrik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pIcWY2c3zfzpfL9Lyb4SSIIE7an4caN7W0lyzDiEmUzgMhRk2n3NFEBeRQ2IdvKds
	 ZR01buMlzQRJ/keKg2600ffToxcZDc51shOuZXI3xEC5P8G4JFc2Pm0aSiTR6wSdNJ
	 q8lbTaMROaeNF7EA3804RntYm+OLmcoQIp1+GKCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeLTPlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeLTPli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:41:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37D02186A;
        Thu, 20 Dec 2018 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545320498;
        bh=eaNy5oGe5YhiyNPCoCRvlbDVwDNKFIaCKXYzzWFIrik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9ILjwqjuGjBYrvuWNtYTFGdPji1oWKuuQVCy0bAbpOiFii0/Cy6lWskRq3N5PP+i
         GzaSTXYFLH3qt5GW+v6TRLofm09TEblILVmCn560DdqBArnNrcZ6w7Jw0t20UD8FqT
         E51T+lYcztLhY70fJHhNn9iem256nR3TCGPNFa44=
Date:   Thu, 20 Dec 2018 16:41:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 21/72] locking/qspinlock: Ensure node is initialised
 before updating prev->next
Message-ID: <20181220154135.GB9962@kroah.com>
References: <20181220085922.332225035@linuxfoundation.org>
 <20181220085923.169451350@linuxfoundation.org>
 <CADVatmMq2cNhoM0RJyuS=u_u-K9ksM1TWLeD1+ytTzVsHx=i-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmMq2cNhoM0RJyuS=u_u-K9ksM1TWLeD1+ytTzVsHx=i-A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 12:19:04PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Dec 20, 2018 at 9:27 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > commit 95bcade33a8af38755c9b0636e36a36ad3789fe6 upstream.
> 
> It seems 9d4646d14d51 ("locking/qspinlock: Elide back-to-back RELEASE
> operations with smp_wmb()") is improving the fix. Is it worth to take
> this also?

If someone could test that this really does help things out, I would be
glad to take it :)

thanks,

greg k-h
