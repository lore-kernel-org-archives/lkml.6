Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74FF218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548356651;
	bh=kOnuYNYDy15N5B74rTqYFeUF1hRqsnVaTnt4kzyacuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iHpyjFu7lUhvbeLRGupT5LGJfLzGov1A0CTZ0Kwqn8+8ZSUgAwIGKSk+3q437F9s8
	 XDNDcI2NR6+60D2xieLP6WhDF4HUgfIL7e1g7MH9dQXMzulvNYboY+asVUvS/pa80y
	 LbCZ8TzzKFWtmxOGjkKY++HwQKZvrg20y7Fo4ppw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfAXTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAXTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:04:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E55218A2;
        Thu, 24 Jan 2019 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548356648;
        bh=kOnuYNYDy15N5B74rTqYFeUF1hRqsnVaTnt4kzyacuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syZVieD3j+CPsWiRf5W0zYUUCzsOmaV3nHkYsASpDClqk46tTuxqQHdC+Poc1EM7W
         nSef+l7Q5R5yMMX1E1aEwsymfKvtYnfvrQySBxXxfcIw56e8YKV57+o/0NCDbTxpti
         OHJtS1HSo81GHZGwgrR1+CEetA3Ta48bW5BmfGdw=
Date:   Thu, 24 Jan 2019 20:04:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH stable-4.9.y] locking/qspinlock: Pull in asm/byteorder.h
 to ensure correct endianness
Message-ID: <20190124190405.GB32078@kroah.com>
References: <20190124185415.29830-1-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124185415.29830-1-will.deacon@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 06:54:15PM +0000, Will Deacon wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> This commit is not required upstream, but is required for the 4.9.y
> stable series.
> 
> Upstream commit 101110f6271c ("Kbuild: always define endianess in
> kconfig.h") ensures that either __LITTLE_ENDIAN or __BIG_ENDIAN is
> defined to reflect the endianness of the target CPU architecture
> regardless of whether or not <asm/byteorder.h> has been #included. The
> upstream definition of 'struct qspinlock' relies on this property.
> 
> Unfortunately, the 4.9.y stable series does not provide this guarantee,
> so the 'spin_unlock()' routine can erroneously treat the underlying
> lockword as big-endian on little-endian architectures using native
> qspinlock (i.e. x86_64 without PV) if the caller has not included
> <asm/byteorder.h>. This can lead to hangs such as the one in
> 'i915_gem_request()' reported via bugzilla:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=202063
> 
> Fix the issue by ensuring that <asm/byteorder.h> is #included in
> <asm/qspinlock_types.h>, where 'struct qspinlock' is defined.

That is crazy...

Thanks for the patch, now queued up.

greg k-h
