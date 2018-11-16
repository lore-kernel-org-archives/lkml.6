Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECC22087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECC22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbeKPWzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:55:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:63354 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPWzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:55:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 04:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="108686430"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2018 04:43:31 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        stfrench@microsoft.com, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook: Subsystem Profile
In-Reply-To: <alpine.DEB.2.21.1811150544090.2354@hadrien>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com> <alpine.DEB.2.21.1811142146230.9620@hadrien> <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com> <alpine.DEB.2.21.1811150544090.2354@hadrien>
Date:   Fri, 16 Nov 2018 14:44:07 +0200
Message-ID: <878t1tgpk8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Thu, 15 Nov 2018, Geert Uytterhoeven wrote:
>
>> Hi Julia,
>>
>> On Thu, Nov 15, 2018 at 6:48 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>> > How about patch subject lines?  What is the formula that should be used to
>> > transform the name(s) of the affected file(s) into an appropriate suject
>> > line?
>>
>> Automating that may be difficult.
>> I always use "git log --oneline", and try to derive something sane
>> from its output.
>
> Yes, I do likewise.  But there may be some subsystems for which it would
> be possible to come up with a more specific policy.  The advantage of what
> is proposed here is that it is not necessary to come up with a single
> formula that works everywhere.  Even a description in English could be
> helpful.

I quickly cooked up this script to produce the top-5 commit prefixes for
the given files over the arbitrary last 200 commits. It'll give you a
pretty good idea if you're even close.

---
#!/bin/sh
# usage: subject-prefix FILE [...]
# show top 5 subject prefixes for FILEs

git log --format=%s -n 200 -- "$@" |\
	grep -v "^Merge " |\
	sed 's/\(.*\):.*/\1/' |\
	sort | uniq -c | sort -nr | sed 's/ *[0-9]\+ //' |\
	head -n 5
---

Someone who knows perl could turn that into a checkpatch check: See if
the patch subject prefix is one of the top-5 for all files changed by
the patch, and ask the user to double check if it isn't. Or some
heuristics thereof.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
