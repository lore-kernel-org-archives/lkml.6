Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6BFECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5390D2156D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5390D2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jjacky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJUB6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:58:17 -0400
Received: from mail.jjacky.com ([23.29.69.116]:57419 "EHLO mail.jjacky.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeJUB6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:58:16 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 21:58:16 EDT
Received: by mail.jjacky.com (OpenSMTPD) with ESMTP id a8b5acfe;
        Sat, 20 Oct 2018 17:40:23 +0000 (UTC)
From:   Olivier Brunel <jjk@jjacky.com>
To:     Network Development <netdev@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Olivier Brunel <jjk@jjacky.com>
Subject: [PATCH 0/2] Re: bpfilter causes a leftover kernel process
Date:   Sat, 20 Oct 2018 19:39:55 +0200
Message-Id: <20181020173957.31239-1-jjk@jjacky.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
References: <20180826180816.04ef7d16@jjacky.com> <20180827183122.0b4ac65e@jjacky.com> <20180828033500.g3siwst5h2ckewwb@ast-mbp> <20180905175243.78a6ba81@jjacky.com> <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 16:38:56 +0000
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Sep 5, 2018 at 5:05 PM Olivier Brunel <jjk@jjacky.com> wrote:
> >
> > You'll see in the end that systemd complains that it can't
> > unmount /oldroot (EBUSY), aka the root fs; and that's because of the
> > bpfilter helper, which wasn't killed because it's seen as a kernel
> > thread due to its empty command line and therefore not signaled.  
> 
> thanks for tracking it down.
> can somebody send a patch to give bpfilter non-empty cmdline?
> I think that would be a better fix than tweaking all pid1s.

So I'm not a kernel dev and this would be my first atttempt at a kernel patch,
but I did have a look and came up with the following patch(es) to fix this.
Hopefully I did things right.

It adds a default command line ("usermodehelper") to such processes, so any &
all such helpers will be seen as user process and not kernel threads, but
there's also the possibility to specify a command line to use, here
"bpfilter_umh"

Cheers,


Olivier Brunel (2):
  umh: Add command line to user mode helpers
  net: bpfilter: Set user mode helper's command line

 include/linux/umh.h          |  1 +
 kernel/umh.c                 | 16 ++++++++++++++--
 net/bpfilter/bpfilter_kern.c |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.19.0

