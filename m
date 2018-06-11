Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 04840C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A532086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A532086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeFKUGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:06:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35744 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbeFKUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:06:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fST4j-0005qZ-Sy; Mon, 11 Jun 2018 20:06:01 +0000
Date:   Mon, 11 Jun 2018 21:06:01 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Stephane Eranian <eranian@google.com>
Cc:     willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        hch@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: perfmon trouble
Message-ID: <20180611200601.GW30522@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
 <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk>
 <20180611162313.GA6942@infradead.org>
 <20180611164859.GA28292@bombadil.infradead.org>
 <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
 <20180611171811.GB28292@bombadil.infradead.org>
 <CABPqkBTwqtFxtFsCjTNyHa_T1_vCbCQWHwo42RZAbg0QRi1BFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTwqtFxtFsCjTNyHa_T1_vCbCQWHwo42RZAbg0QRi1BFw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:51:34AM -0700, Stephane Eranian wrote:

> Thanks Al for the careful analysis. If I understand correctly, the
> problem seems to be that on
> execve the mapping of the sampling buffer is not destroyed and then on
> close, the kernel
> unmaps whatever the new binary had in that address range. The fix
> would be to ensure
> the mmap is destroyed on execve.

mmap *is* destroyed on execve; it's just that perfmon doesn't notice and
then tries to destroy it again on close, nevermind that it's a different
process, different mapping, etc.

> My problem is that I do not have IA64 hw anymore, so whatever the fix,
> I will not be able
> to test this. In the meantime, I agree with Matthew, simply disable
> PERFMON support.

Out of curiosity - what happened to never-went-into-mainline rewrite
of perfmon circa 2008?  perfmon2 sourceforget site has a collection
of those, up to 2.6.29; AFAICS, they did have a somewhat saner syscall
interface (no auto-mmap on creation, no auto-munmap attempts on close).
By this point it obviously would've been too late to resurrect anyway,
but I wonder what happened with it...
