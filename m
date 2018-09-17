Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42944ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372C214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E372C214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeIQO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:56:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeIQO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:56:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9316D898;
        Mon, 17 Sep 2018 09:29:37 +0000 (UTC)
Date:   Mon, 17 Sep 2018 11:29:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Richard Biener <rguenther@suse.de>,
        Jakub Jelinek <jakub@gcc.gnu.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] [v2] crypto: aes-generic - fix aes-generic regression
 on powerpc
Message-ID: <20180917092935.GA26181@kroah.com>
References: <20180115160735.593519-1-arnd@arndb.de>
 <20180120004425.GA6484@gondor.apana.org.au>
 <VI1PR0402MB34855F454AA1D324ABEC0090981E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB34855F454AA1D324ABEC0090981E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:18:37AM +0000, Horia Geanta wrote:
> On 1/20/2018 2:44 AM, Herbert Xu wrote:
> > On Mon, Jan 15, 2018 at 05:07:22PM +0100, Arnd Bergmann wrote:
> >> My last bugfix added -Os on the command line, which unfortunately caused
> >> a build regression on powerpc in some configurations.
> >>
> >> I've done some more analysis of the original problem and found slightly
> >> different workaround that avoids this regression and also results in
> >> better performance on gcc-7.0: -fcode-hoisting is an optimization step
> >> that got added in gcc-7 and that for all gcc-7 versions causes worse
> >> performance.
> >>
> >> This disables -fcode-hoisting on all compilers that understand the option.
> >> For gcc-7.1 and 7.2 I found the same performance as my previous patch
> >> (using -Os), in gcc-7.0 it was even better. On gcc-8 I could see no
> >> change in performance from this patch. In theory, code hoisting should
> >> not be able make things better for the AES cipher, so leaving it
> >> disabled for gcc-8 only serves to simplify the Makefile change.
> >>
> >> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> >> Link: https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg30418.html
> >> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
> >> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83651
> >> Fixes: 148b974deea9 ("crypto: aes-generic - build with -Os on gcc-7+")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Patch applied.  Thanks.
> > 
> This fix ("commit 6e36719fbe90213fbba9f50093fa2d4d69b0e93c upstream") is needed
> also in 4.14.y stable tree, since it contains commit
> 7cae67e31292 ("crypto: aes-generic - build with -Os on gcc-7+")
> 
> Compilation fails without it:
> crypto/aes_generic.o: In function `crypto_aes_set_key':
> crypto/aes_generic.c:1300: undefined reference to `_restgpr_31_x'

Thanks for letting me know, now queued up.

greg k-h
