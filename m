Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5843FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B332054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B332054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKAAhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:37:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52268 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbeKAAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:37:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHsa0-0000Zz-O8; Wed, 31 Oct 2018 09:38:48 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHsa0-0008C8-4v; Wed, 31 Oct 2018 09:38:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
Date:   Wed, 31 Oct 2018 10:38:17 -0500
In-Reply-To: <20181031053355.GQ32577@ZenIV.linux.org.uk> (Al Viro's message of
        "Wed, 31 Oct 2018 05:33:55 +0000")
Message-ID: <87a7mut9cm.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHsa0-0008C8-4v;;;mid=<87a7mut9cm.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18XAOKbFsInlH6z+/I3T22miDHqRnOUaEI=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [git pull] mount API series
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> 	mount API series from David Howells.  Last cycle's objections
> had been of the "I'd do it differently" variety and with no such
> differently done variants having ever materialized over several
> cycles...

Absolutely not.

My objections fundamentally is that I can find real problems when I look
at the code.  Further the changes have not been incremental changes that
have evolved the code from one state to another but complete
replacements of code that make code review very difficult and bisection
completely inapplicable.

I also object that this series completely fails to fix the worst but I
have ever seen in the mount API.  Whit no real intrest shown in working
to fix it.

A couple of bugs that I can see quickly.  Several of which I have
previously reported:

- There is an easily triggered NULL pointer deference with open_tree
  and mount propagation.

- Bisection will not work with the cpuset filesystem patch.  At least
  cpuset looks like it may be mountable now.

- The setting of fc->user_ns on proc remains broken.  In particular if you
  create a child user namespace and attempt to mount proc it will succeed
  instead of fail.

- The mqueue filesystem has the same issue as proc.  fc->user_ns is misset.

I suspect I didn't report it well but I reported both the proc and the
mqueue filesystem weeks before the merge window opened.


I am going to stop there.  I believe there are more issues in the code.
I am relieved that I am not seeing the loss of some of the security
hooks that I thought I saw last time I looked at the code.


Given both that I have reported bugs that remain unfixed and it's
non-evolutionary nature that makes this patchset hard to review I have
no confidence in this set of patches.

I think the scope has been too large for anyone to properly review the
code and it should be broken into smaller pieces.  That there were
significant open_tree and move_mount issues being found just before the
merge window opened seems a testament to that.  (AKA the first 3 or so
patches in the patchset and fundamental to the rest).


My apologies that we have not been able communication better and that I
have not been able to clearly point out all of the bugs.   My apologies
I have not yet been able to give more constructive feedback.

Still at the end of the day there remain regressions of existing
functionality in that tree.

Eric
