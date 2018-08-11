Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D044C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD72077B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBD72077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHKHVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 03:21:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40749 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeHKHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 03:21:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foLpF-0001HY-1G; Fri, 10 Aug 2018 22:48:29 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foLpE-0007vZ-Fj; Fri, 10 Aug 2018 22:48:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <87d0uqpba5.fsf@xmission.com>
        <20180810151606.GA6515@ZenIV.linux.org.uk>
        <87pnypiufr.fsf@xmission.com> <20180811014619.GA14368@thunk.org>
Date:   Fri, 10 Aug 2018 23:48:24 -0500
In-Reply-To: <20180811014619.GA14368@thunk.org> (Theodore Y. Ts'o's message of
        "Fri, 10 Aug 2018 21:46:19 -0400")
Message-ID: <8736vlo6ef.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foLpE-0007vZ-Fj;;;mid=<8736vlo6ef.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/7iC9C0vySju5oNK9rKvy8DgkmTU/ux0Q=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
>> 
>> My complaint is that the current implemented behavior of practically
>> every filesystem in the kernel, is that it will ignore mount options
>> when mounted a second time.
>
> The file system is ***not*** mounted a second time.
>
> The design bug is that we allow bind mounts to be specified via a
> block device.  A bind mount is not "a second mount" of the file
> system.  Bind mounts != mounts.
>
> I had assumed we had allowed bind mounts to be specified via the block
> device because of container use cases.  If the container folks don't
> want it, I would be pushing to simply not allow bind mounts to be
> specified via block device at all.

No it is not a container thing.

> The only reason why we should support it is because we don't want to
> break scripts; and if the goal is not to break scripts, then we have
> to keep to the current semantics, however broken you think it is.

But we don't have to support returning filesystems with mismatched mount
options in the new fsopen api.   That is my concern.  Confusing
userspace this way has been shown to be harmful let's not keep doing it.

Eric

