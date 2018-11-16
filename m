Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2442D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2442D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbeKQEKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:10:31 -0500
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:41825 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727544AbeKQEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:10:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 657E71806ECF3;
        Fri, 16 Nov 2018 17:57:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pipe08_37beb9f9c14e
X-Filterd-Recvd-Size: 2724
Received: from XPS-9350 (unknown [172.58.19.122])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Nov 2018 17:57:03 +0000 (UTC)
Message-ID: <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stfrench@microsoft.com, Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Date:   Fri, 16 Nov 2018 09:56:59 -0800
In-Reply-To: <878t1tgpk8.fsf@intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
         <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
         <alpine.DEB.2.21.1811142146230.9620@hadrien>
         <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com>
         <alpine.DEB.2.21.1811150544090.2354@hadrien> <878t1tgpk8.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 14:44 +0200, Jani Nikula wrote:
> I quickly cooked up this script to produce the top-5 commit prefixes for
> the given files over the arbitrary last 200 commits. It'll give you a
> pretty good idea if you're even close.
> 
> ---
> #!/bin/sh
> # usage: subject-prefix FILE [...]
> # show top 5 subject prefixes for FILEs
> 
> git log --format=%s -n 200 -- "$@" |\
> 	grep -v "^Merge " |\
> 	sed 's/\(.*\):.*/\1/' |\
> 	sort | uniq -c | sort -nr | sed 's/ *[0-9]\+ //' |\
> 	head -n 5
> ---
> 
> Someone who knows perl could turn that into a checkpatch check: See if
> the patch subject prefix is one of the top-5 for all files changed by
> the patch, and ask the user to double check if it isn't. Or some
> heuristics thereof.

This won't work when a patch contains multiple files
from different paths, or even multiple files from a
single driver.

Perhaps it's better to use a generic mechanism like

	basename $(dirname $filename):

with some exceptions and add an override patch subject
grammar to appropriate various sections of MAINTAINERS.

I also think it's better to use a separate script like
scripts/spdxcheck.py and tie any necessary checkpatch
use to that script.



