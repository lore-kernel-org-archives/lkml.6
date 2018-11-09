Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1BE20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVHNAKXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1BE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeKIWMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKIWMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:12:30 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FD520825;
        Fri,  9 Nov 2018 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541766725;
        bh=6p1FuJ58l+NxYdK9mbi5fh7H7aG/ZVSWix+1xuRR+9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVHNAKXjIJ7uCRdDUWuzJ1YcFgfHjOZrhmH7p5UI2mPMDbU5HyAxxpGFtBFfOtAMV
         3+bJTUE1xTQQl8kzZkbKus34Ghv0+u3EX/ghpJUQS+jnO4YknVDJnFvXN2xruXE3lF
         CYTR3uUCBdFCTGk7eX6kMy4F5tg9bkXB88n9lL34=
Date:   Fri, 9 Nov 2018 04:32:04 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix race that allows malicious free of live
 buffer
Message-ID: <20181109123204.GA11583@kroah.com>
References: <20181106235532.171646-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181106235532.171646-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:55:32PM -0800, Todd Kjos wrote:
> Malicious code can attempt to free buffers using the
> BC_FREE_BUFFER ioctl to binder. There are protections
> against a user freeing a buffer while in use by the
> kernel, however there was a window where BC_FREE_BUFFER
> could be used to free a recently allocated buffer that
> was not completely initialized. This resulted in a
> use-after-free detected by KASAN with a malicious
> test program.
> 
> This window is closed by setting the buffer's
> allow_user_free attribute to 0 when the buffer
> is allocated or when the user has previously
> freed it instead of waiting for the caller
> to set it. The problem was that when the struct
> buffer was recycled, allow_user_free was stale
> and set to 1 allowing a free to go through.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Acked-by: Arve Hjønnevåg <arve@android.com>

No "stable" tag here?  Any idea how far back the stable backporting
should go, if any?

thanks,

greg k-h
