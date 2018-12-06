Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93A21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544093652;
	bh=RdU04X7KWxterWJUY5M8QKseZAdJaJqWo5YYFHG+ubk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KgOXZCgw0vlH0wL7HbhpmJg2CyrbWnqbej4/rIY0Ba7GaJd+Pcne7fDqUIqhFYznZ
	 UIlMSaDsBjj8VtfSpIUOxyDvcirXG9tW9ujNX0JUzQcZaoS6W/AyiK5XFK/4xigTC9
	 f9xSQ8X5wKyVW7C7BJR2PX4nY23iAbcaL4c0iTsQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C93A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeLFKyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeLFKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:54:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DC42082B;
        Thu,  6 Dec 2018 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544093650;
        bh=RdU04X7KWxterWJUY5M8QKseZAdJaJqWo5YYFHG+ubk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUnBNxXo8r4UnssiD8ankHu/gUwA423ZZIR1QQFzmEAHfaIzJqVkIGubq5dfN+lg3
         Kkv/tAlrF2KoKQqExR66CM3vf/hBq5OBD7vYmPKmXcNuGETpAo+fCruwJcZhIaGBOk
         pRutu0W30e+c17nS0MG6hh+S86qtZjmYp/zpmzcQ=
Date:   Thu, 6 Dec 2018 11:54:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jari Ruusu <jariruusu@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?B?S3I/beE/?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 4.14 121/146] x86/fpu: Disable bottom halves while
 loading FPU registers
Message-ID: <20181206105407.GH19891@kroah.com>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103731.697870447@linuxfoundation.org>
 <5C07FC30.43601034@users.sourceforge.net>
 <20181205190020.GO29510@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205190020.GO29510@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:00:20PM +0100, Borislav Petkov wrote:
> On Wed, Dec 05, 2018 at 06:26:24PM +0200, Jari Ruusu wrote:
> > That same race appears to be present in older kernel branches also.
> > The context is sligthly different, so the patch for 4.14 does not
> > apply cleanly to older kernels. For 4.9 branch, this edit works:
> 
> You could take the upstream one, amend it with your change, test it and
> send it to Greg - I believe he'll take the backport gladly.
> 
> :-)

Yes, that's the easiest way for me to accept such a patch, otherwise it
gets put on the end of the very-long-queue...

thanks,

greg k-h
