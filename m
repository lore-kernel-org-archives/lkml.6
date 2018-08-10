Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3CAC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2684223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2684223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeHJRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:41:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJRlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FB1640241F7;
        Fri, 10 Aug 2018 15:11:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C36DE2026D65;
        Fri, 10 Aug 2018 15:11:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87d0uqpba5.fsf@xmission.com>
References: <87d0uqpba5.fsf@xmission.com> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
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
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: BUG: Mount ignores mount options
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22360.1533913891.1@warthog.procyon.org.uk>
Date:   Fri, 10 Aug 2018 16:11:31 +0100
Message-ID: <22361.1533913891@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 15:11:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 15:11:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> There is a serious problem with mount options today that fsopen does not
> address.  The problem is that mount options are ignored for block based
> filesystems, and any other type of filesystem that follows the same
> pattern.

Yes.  Since you *absolutely* *insist* on this being fixed *right* *now* *or*
*else*, I'm working up a set of additional patches to give userspace the
option of whether they want no sharing; sharing, but only with exactly the
same parameters; or to ignore the parameter differences and just accept
sharing of what's already already mounted (ie. the current behaviour).

The second option, however, is not trivial as it needs to compare the fs
contexts, including the LSM parameters.  To make that work, I really need to
remove the old security_mnt_opts stuff - which means I need to port btrfs to
the new context stuff.

We discussed this yesterday, and I proposed a solution, and I'm working on it.

Yes, I agree it would be nice to have, but it *doesn't* really need supporting
right this minute, since what I have now oughtn't to break the current
behaviour.

David
