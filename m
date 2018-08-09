Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FFB21CDB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FFB21CDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeHILfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:35:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHILfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:35:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63959AF3F;
        Thu,  9 Aug 2018 09:11:13 +0000 (UTC)
Message-ID: <1533805400.17217.16.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ryan Chen <yu.chen.surf@gmail.com>, jlee@suse.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ebiggers@google.com, Theodore Ts'o <tytso@mit.edu>,
        smueller@chronox.de, denkenz@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kookoo.gu@intel.com, Zhang Rui <rui.zhang@intel.com>
Date:   Thu, 09 Aug 2018 11:03:20 +0200
In-Reply-To: <20180809030135.GA21364@chenyu-desktop>
References: <20180723162302.GA4503@sandybridge-desktop>
         <1532590246.7411.3.camel@suse.com> <20180726081404.GG4244@linux-l9pv.suse>
         <20180730170415.GQ4244@linux-l9pv.suse>
         <20180803033702.GB416@sandybridge-desktop>
         <20180803053445.GC4244@linux-l9pv.suse>
         <CADjb_WSURQz86+E8kakNf7UBDM+aho+uaz3QdDkuGsEgan=szw@mail.gmail.com>
         <20180805100200.GB22948@amd> <20180806084534.GB12124@chenyu-desktop>
         <20180808175036.GA16217@amd> <20180809030135.GA21364@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2018-08-09 at 11:01 +0800, Yu Chen wrote:

Hi,

> User requirement:
> A is the user, B is the attacker, user A launches a STD and
> encrypts A's ram data, then writes these encrypted data onto
> the disk,  so that: Even if user B has access to the disk,
> B could not know the content of A. Which implies:
> 1. If B unplugs the disk from A's machine, and plugs the disk onto
>    another machine, B could not decode the content without A's
>    'permission'.

That is what encrypted STD does.

> 2. If B is using the same machine as A, even A has walked away leaving
>    the system suspend, B could not resume to A's context without
>    A's 'permission'.

No, that is out of scope for Secure Boot

> Previously, there are three proposal for this:
> a. Enhance the uswsusp(Pavel)
> b. Using user provided password to generate the key, for encryption(Yu)
> c. Using security boot(TPM or EFI key) for encryption(Joey)
> 
> Since I was proposing solution b, I'll say a little more about it.
> The original idea was that, the user provides a password, then this
> password is used to generate the key, which means, if user B has provided
> an incorrect password, the kernel will fail to decrypt the data and is
> likely to fail the resume process. That is to say, no matter
> which physical machine B is using, only if he has provided the
> password, he would be able to resume. In the first version, the key
> deviration was firstly done in kernel space, which satisfies the
> requirement and both saftey. Unfortunately it was rejected and
> people would like to see the key generated in user space instead.
> However, using user provided key directly is not safe, according
> to the discussion in the thread. I don't have good idea on
> how to improve this, but only have some workarounds, say, ask the
> kernel to use TPM key to protects the user provided 'key', etc.

Well, this has no relation to Secure Boot.
Secure Boot will not prevent you from booting the machine.
It restricts the OS you can boot to a cryptographically signed subset.

If you want to demand a password to resume a machine, you can
do so. But it has no relation to encrypted STD, other than that
you need encrypted STD for this to make sense.

> Then let's talk a little more about secure boot. According
> to my understanding, the situation secure boot tries to deal
> with is a little different from the user case we raised above -
> It is an enhancement for case 1, because it refuses to resume
> once the machine is changed. And it does not cover case 2. But
> if it is a requirement from the user, that's ok.
> 
> uswsusp is to do all the staff in user space, and other two
> aim to do all the staff in kernel space. I'm not arguing
> which one is better, but I'm not sure how often user is using
> it, as we don't get uswsusp related bug report on kernel
> bugzilla (both internally)recent years. Another point is,
> why the compression is in kernel rather than in uswsusp,
> it looks like the same case as encryption here.

Secure Boot has no concept of users. Code is trusted, not users.
For Secure Boot to work, you need a key generated and RAM encrypted
in kernel space.

If you want a requirement to restrict booting or resuming, you need
to encrypt the key. These are different things.

	Regards
		Oliver

