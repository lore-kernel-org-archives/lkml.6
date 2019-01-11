Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE702183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbfAKTL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:11:56 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:43844 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfAKTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:11:56 -0500
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 02F0A1A40E7B; Fri, 11 Jan 2019 11:11:55 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:11:55 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: Re: commit 83d817f410 broke my ability to use Linux with a braille
 display
Message-ID: <20190111191155.s4e5sn5fqk33fqr4@shells.gnugeneration.com>
References: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:33:09PM -0500, Nicolas Pitre wrote:
> I use Linux with the help of a braille display and the brltty daemon. It 
> turns out that the latest mainline kernel I can work with comes from 
> commit 231f8fd0cc. Anything past that and I lose the ability to read the 
> console barely a few seconds after the system has booted as brltty is 
> thrown a wrench and the braille display becomes completely inoperable.
> 
> Things get somewhat better with commit c96cf923a9 as brltty is not 
> longer incapacitated, but some programs would randomly crash. Even the 
> very first login attempt won't work as I soon as I hit enter after my 
> user name the password prompt is skipped over, just like if the enter 
> key had been hit twice. Then lynx (the text web browser) would crash as 
> soon as I switch the virtual console with LeftAlt+FN. Mind you, this 
> isn't easy to perform bisection in those conditions.
> 
> And the worst commit i.e. 83d817f410 is marked for stable!  :-(
> 
> Some interaction with brltty must be at play here otherwise such 
> breakage would never have survived up to the mainline kernel.
> 
> As far as latest mainline is concerned, I managed to reproduce at least 
> one of the unwelcome behavior change (hoping that's all there is to this 
> issue) with a very simple test case so you won't have to learn braille 
> to debug this:
> 
> # from any vt, make sure tty40 is allocated and empty
> openvt -c 40 -f -- true
> 
> # open it and wait on read()
> cat /dev/tty40
> 
> # from a second vt, simply open tty40 again
> true < /dev/tty40
> 
> # come back to the first vt and watch cat bailing out with EAGAIN.
> 
> Please fix.
> 
> 
> Nicolas


This all sounds familiar, and I suspect this is the fix:

https://lkml.org/lkml/2019/1/8/1379

Regards,
Vito Caputo
