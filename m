Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HzktCoZIGltGJAAAmS7hNA
	; Fri, 08 Jun 2018 09:12:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19A61607DC; Fri,  8 Jun 2018 09:12:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58C6B601C3;
	Fri,  8 Jun 2018 09:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58C6B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeFHJMb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:12:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48557 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeFHJM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:12:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCCDDAEC1;
        Fri,  8 Jun 2018 09:12:27 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1498AA09F0; Fri,  8 Jun 2018 11:12:27 +0200 (CEST)
Date: Fri, 8 Jun 2018 11:12:27 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tmb@mageia.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: building in 32bit chroot on x86_64 host broken
Message-ID: <20180608091227.jbigan3vplns2oxk@unicorn.suse.cz>
References: <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
 <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
 <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
 <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
 <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:40:30PM -0700, Linus Torvalds wrote:
> On Thu, Jun 7, 2018 at 12:35 PM Thomas Backlund <tmb@mageia.org> wrote:
> >
> > I can work around it for now (or keep the revert in our kernel builds
> > for now) until it gets properly fixed...
> 
> So rather than doing the revert, it's probably better if  your
> workaround just does
> 
>    make ARCH=i386 oldconfig
> 
> (or maybe even just a "export ARCH=i386" in the environment)
> 
> That should get you to continue to otherwise do the same thing.
> 
> And if it turns out that your flow is the *only* one affected by this,
> and nobody else complains, maybe we can just say "yeah, slight change
> in build rules, easy to work around" and leave it at that.

Not the only one, we hit the same problem when building openSUSE
packages (4.17-rc1) but we resolved it by always setting ARCH:

  https://github.com/openSUSE/kernel-source/commit/fb21b7321ab5

It also revealed that we forgot to pass MAKE_ARGS to other phases of RPM
build process so we don't have reason to complain.

Michal Kubecek
