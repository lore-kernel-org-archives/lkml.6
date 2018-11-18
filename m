Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055E320869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055E320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKSKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 05:17:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:11494 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeKSKRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 05:17:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 15:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,250,1539673200"; 
   d="scan'208";a="87445097"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2018 15:56:10 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8B799301015; Sun, 18 Nov 2018 15:56:10 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
        <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
        <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
        <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
        <CAHk-=wjo9==zLdUuZkCgMx1YBUTpZkD3NnLBPDf7Fw388z5Y6g@mail.gmail.com>
Date:   Sun, 18 Nov 2018 15:56:10 -0800
In-Reply-To: <CAHk-=wjo9==zLdUuZkCgMx1YBUTpZkD3NnLBPDf7Fw388z5Y6g@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 18 Nov 2018 14:36:09 -0800")
Message-ID: <871s7i0wkl.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Nov 18, 2018 at 2:17 PM Jiri Kosina <jikos@kernel.org> wrote:
>> Which gets us back to Tim's fixup patch. Do you still prefer the revert,
>> given the existence of that?
>
> I don't think the code needs to be reverted, but the *behavior* of
> just unconditionally enabling STIBP needs to be reverted.

Actually I think it should be reverted. Yes of course opt-in
is needed.

But also when you opt-in it doesn't make sense to set STIBP
when the sibling is running the same security context, which
is actually a common case. So to even use it properly you would
need some scheduler support to detect these cases and only
enable it then with opt-in. These patches didn't even try to tackle
this problem.

-Andi
