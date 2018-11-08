Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229702086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229702086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKHReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:34:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51625 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:34:07 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKfEB-0002rX-Sb; Thu, 08 Nov 2018 08:59:47 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKfEA-0003Zd-It; Thu, 08 Nov 2018 08:59:46 +0100
Date:   Thu, 8 Nov 2018 08:59:46 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] scripts/spdxcheck: make python3 compliant
Message-ID: <20181108075946.uhcjir4rh4kpg6nx@pengutronix.de>
References: <20181023070802.22558-1-u.kleine-koenig@pengutronix.de>
 <20181107153251.bac94150f8ebc8dbf53abe23@linux-foundation.org>
 <20181108062200.ytkezavtcaypdlat@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108062200.ytkezavtcaypdlat@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 08, 2018 at 07:22:00AM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 07, 2018 at 03:32:51PM -0800, Andrew Morton wrote:
> > On Tue, 23 Oct 2018 09:08:02 +0200 Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > Without this change the following happens when using Python3 (3.6.6):
> > > 
> > > 	$ echo "GPL-2.0" | python3 scripts/spdxcheck.py -
> > > 	FAIL: 'str' object has no attribute 'decode'
> > > 	Traceback (most recent call last):
> > > 	  File "scripts/spdxcheck.py", line 253, in <module>
> > > 	    parser.parse_lines(sys.stdin, args.maxlines, '-')
> > > 	  File "scripts/spdxcheck.py", line 171, in parse_lines
> > > 	    line = line.decode(locale.getpreferredencoding(False), errors='ignore')
> > > 	AttributeError: 'str' object has no attribute 'decode'
> > > 
> > > So as the line is already a string, there is no need to decode it and
> > > the line can be dropped.
> > 
> > I suppose people might want to run spdxcheck.py against (say) 4.19.x
> > using python3.  So I'll add a cc:stable here, OK?
> 
> Not sure if people call spdxcheck.py stand-alone. checkpatch.pl calls it
> using "python scripts/spdxcheck.py" which AFAICT should still be python2
> on all machines. The shebang-line also uses "python" and not "python3".
> 
> So for now this is only cosmetic (unless there are distros that install
> Python 3 as "python").

I just learned that /usr/bin/python on Arch is Python 3. So this would
indeed be worth to go into 4.19.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
