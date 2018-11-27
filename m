Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B26208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="viMfo1K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B26208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeK0Ska (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbeK0Sk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:40:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5EC20873;
        Tue, 27 Nov 2018 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543304610;
        bh=KMUuDeFxIIAT6StFc5ffKRNYDVzzYQhrih4Pz/zc3P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=viMfo1K1Ji6Q196am/85M0PmwdMK6SHnqU+eHY6U5cdxIOcZvwOHifzfuO1hvqMIE
         xHCK4VOOAuevJWwUHme+KukzuOkF/tUgpWQqfBEm+P9zgQcsEfo758z630/INYb15u
         9F8oxVgKlKfRywZR+qdEDiJ1C3I4uNmJnKrW3viM=
Date:   Tue, 27 Nov 2018 08:43:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lkdtm: print real addresses
Message-ID: <20181127074327.GD13965@kroah.com>
References: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 08:14:10PM +0000, Christophe Leroy wrote:
> Today, when doing a lkdtm test before the readiness of the
> random generator, (ptrval) is printed instead of the address
> at which it perform the fault:
> 
> [ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
> [ 1597.337142] lkdtm: attempting ok execution at (ptrval)
> [ 1597.337398] lkdtm: attempting bad execution at (ptrval)
> [ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
> [ 1597.344769] Unable to handle kernel paging request for instruction fetch
> [ 1597.351392] Faulting instruction address: 0x77858000
> [ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]
> 
> If the lkdtm test is done later on, it prints an hashed address.
> 
> In both cases this is pointless. The purpose of the test is to
> ensure the kernel generates an Oops at the expected address,
> so real addresses needs to be printed. This patch fixes that.

I am pretty sure this is intentional.  Kees?

