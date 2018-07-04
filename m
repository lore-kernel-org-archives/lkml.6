Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A76720873
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A76720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lisas.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeGDOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:30:28 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:52554 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:30:26 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 10:30:25 EDT
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 1203)
        id 83F0F2244669; Wed,  4 Jul 2018 16:21:16 +0200 (CEST)
Date:   Wed, 4 Jul 2018 16:21:16 +0200
From:   Adrian Reber <adrian@lisas.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180704142116.GM17048@lisas.de>
References: <20180502211448.18276-1-hch@lst.de>
 <20180502211448.18276-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502211448.18276-8-hch@lst.de>
X-Url:  <http://lisas.de/~adrian/>
X-Operating-System: Linux (4.14.16-300.fc27.x86_64)
X-Load-Average: 4.97 4.97 4.66
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:14:48PM +0200, Christoph Hellwig wrote:
> This is the io_getevents equivalent of ppoll/pselect and allows to
> properly mix signals and aio completions (especially with IOCB_CMD_POLL)
> and atomically executes the following sequence:
> 
> 	sigset_t origmask;
> 
> 	pthread_sigmask(SIG_SETMASK, &sigmask, &origmask);
> 	ret = io_getevents(ctx, min_nr, nr, events, timeout);
> 	pthread_sigmask(SIG_SETMASK, &origmask, NULL);
> 
> Note that unlike many other signal related calls we do not pass a sigmask
> size, as that would get us to 7 arguments, which aren't easily supported
> by the syscall infrastructure.  It seems a lot less painful to just add a
> new syscall variant in the unlikely case we're going to increase the
> sigset size.

Starting with this commit following code does not compile for me
anymore:

#include <signal.h>
#include <linux/aio_abi.h>

int main()
{
        return 0;
}

In file included from /usr/include/linux/signal.h:5,
                 from /usr/include/linux/aio_abi.h:32,
                 from include.c:2:
/usr/include/asm/signal.h:16:23: error: conflicting types for ‘sigset_t’
 typedef unsigned long sigset_t;
                       ^~~~~~~~
In file included from /usr/include/signal.h:35,
                 from include.c:1:
/usr/include/bits/types/sigset_t.h:7:20: note: previous declaration of ‘sigset_t’ was here
 typedef __sigset_t sigset_t;
                    ^~~~~~~~
In file included from /usr/include/linux/signal.h:5,
                 from /usr/include/linux/aio_abi.h:32,
                 from include.c:2:
/usr/include/asm/signal.h:115:8: error: redefinition of ‘struct sigaction’
 struct sigaction {
        ^~~~~~~~~
In file included from /usr/include/signal.h:226,
                 from include.c:1:
/usr/include/bits/sigaction.h:27:8: note: originally defined here
 struct sigaction
        ^~~~~~~~~
[and much more]

Before this commit it compiles without errors.

		Adrian
