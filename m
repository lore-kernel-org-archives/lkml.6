Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E56C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F3320879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F3320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeLMTk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:40:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51067 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:40:57 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXWql-0005fj-Pe; Thu, 13 Dec 2018 20:40:47 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXWqk-0006Sv-0h; Thu, 13 Dec 2018 20:40:46 +0100
Date:   Thu, 13 Dec 2018 20:40:45 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
Message-ID: <20181213194045.om6gixij6a63jvfg@pengutronix.de>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
 <20181212181410.GC2352@laptop.jcline.org>
 <20181213073708.nwj4nmnccuugvrhc@pengutronix.de>
 <20181213151052.GA13313@laptop.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213151052.GA13313@laptop.jcline.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:10:52AM -0500, Jeremy Cline wrote:
> On Thu, Dec 13, 2018 at 08:37:08AM +0100, Uwe Kleine-König wrote:
> > It didn't break for me. Can you provide details about how and when it
> > broke for you?
> 
> I was wrong about it being Python 2 that broke, sorry about that.
> 6f4d29df66ac broke Python 3 when you run it against a sub-tree because
> scan_git_tree() opens the files in binary mode, but then find is run
> with a text string:
> 
> $ python3 scripts/spdxcheck.py net/
> FAIL: argument should be integer or bytes-like object, not 'str'
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 259, in <module>
>     scan_git_subtree(repo.head.reference.commit.tree, p)
>   File "scripts/spdxcheck.py", line 211, in scan_git_subtree
>     scan_git_tree(tree)
>   File "scripts/spdxcheck.py", line 206, in scan_git_tree
>     parser.parse_lines(fd, args.maxlines, el.path)
>   File "scripts/spdxcheck.py", line 175, in parse_lines
>     if line.find("SPDX-License-Identifier:") < 0:
> TypeError: argument should be integer or bytes-like object, not 'str'
> 
> The reason I opened things in binary mode when I started adding Python 3
> support was because not all files were valid UTF-8 (and some were
> binary) so I decoded the text line-by-line and ignored any decoding
> errors for simplicity's sake.

OK I understand. The problem is that there are inconsistencies
in handling files as binaries or not that already existed before
6f4d29df66ac. Different code paths result in a different type for line
depending on how fd was opened. I fixed the cases where fd was opened
as text file and broke the cases where it was opened as binary.

So changing this to consistently using binary mode (as the patch by
Thierry does) seems the right thing to do. 

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
