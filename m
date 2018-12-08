Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DCC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435F2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A435F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLHHdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 02:33:06 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:54926 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHHdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 02:33:06 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wB87Wxm3011878;
        Sat, 8 Dec 2018 08:32:59 +0100
Date:   Sat, 8 Dec 2018 08:32:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Laura Abbott <labbott@redhat.com>
Cc:     stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Process for severe early stable bugs?
Message-ID: <20181208073259.GB11787@1wt.eu>
References: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Fri, Dec 07, 2018 at 04:33:10PM -0800, Laura Abbott wrote:
> The latest file system corruption issue (Nominally fixed by
> ffe81d45322c ("blk-mq: fix corruption with direct issue") later
> fixed by c616cbee97ae ("blk-mq: punt failed direct issue to dispatch
> list")) brought a lot of rightfully concerned users asking about
> release schedules. 4.18 went EOL on Nov 21 and Fedora rebased to
> 4.19.3 on Nov 23. When the issue started getting visibility,
> users were left with the option of running known EOL 4.18.x
> kernels or running a 4.19 series that could corrupt their
> data. Admittedly, the risk of running the EOL kernel was pretty
> low given how recent it was, but it's still not a great look
> to tell people to run something marked EOL.
> 
> I'm wondering if there's anything we can do to make things easier
> on kernel consumers. Bugs will certainly happen but it really
> makes it hard to push the "always run the latest stable" narrative
> if there isn't a good fallback when things go seriously wrong. I
> don't actually have a great proposal for a solution here other than
> retroactively bringing back 4.18 (which I don't think Greg would
> like) but I figured I should at least bring it up.

This type of problem may happen once in a while but fortunately is
extremely rare, so I guess it can be addressed with unusual methods.

For my use cases, I always make sure that the last two LTS branches
work fine. Since there's some great maintenance overlap between LTS
branches, I can quickly switch to 4.14.x (or even 4.9.x) if this
happens. In our products we make sure that our toolchain is built
with support for the previous kernel as well "just in case". We've
never switched back and will probably never do, but at least it
serves us a lot to compare strange behaviours between two kernels.

I think that if your distro is functionally and technically compatible
with the previous LTS branch, it could be an acceptable escape for
users who are concerned about their data and their security at the
same time. After all, previous LTS branches are there for those who
can't upgrade. In my opinion this situation perfectly qualifies.

But it requires some preparation like I mentioned. It might be that
some components in the distro rely on features from the very latest
kernels. At the very least it might deserve a bit of inspection to
know if such dependencies exist, and/or what is lost in case of such
a fall back, to warn users.

Just my two cents,
Willy
