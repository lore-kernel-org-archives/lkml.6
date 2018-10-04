Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55782083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55782083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJEBb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:31:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37166 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJEBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:31:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g88V3-0006ew-Gw; Thu, 04 Oct 2018 12:37:25 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g88V2-0000lQ-Ck; Thu, 04 Oct 2018 12:37:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>,
        "Eric W. Biederman" <ebiederm@redhat.com>, selinux@tycho.nsa.gov,
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
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
Date:   Thu, 04 Oct 2018 20:37:09 +0200
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Fri, 21 Sep 2018 17:30:08 +0100")
Message-ID: <87sh1ld0dm.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g88V2-0000lQ-Ck;;;mid=<87sh1ld0dm.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Amy9+X87RMMZdxlLTh3md5UNJ0E9sHG4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/34] VFS: Introduce filesystem context [ver #12]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David,

I have been going through these and it is a wonderful proof of concept
patchset.  There are a couple significant problems with it however.

- Many patches do more than one thing that could benefit from being
  broken up into more patches so that there is only one logical change
  per patch.  I have attempted a little of that and have found several
  significant bugs.

- There are many unnecessary changes in this patchset that just add
  noise and make it difficult to review.

- There are many typos and thinkos in this patchset that while not hard
  to correct keep this from being anywhere close to being ready for
  prime time.

- Some of the bugs I have encountered.
  * proc that isn't pid_ns_prepare_proc does not set fc->user_ns to
    match the pid namespace.
  * mqueue does not set fc->user_ns to match the ipc namespace.
  * The cpuset filesystem always fails to mount
  * Non-converted filesystems don't have the old security hooks
    and only have a bit blob so don't call into the new security
    hooks either.
  * The changes to implement the new security hooks at least for
    selinux are riddled with typos, and thinkos.

I was hoping to get into the semantic questions but I can't get
there until I get a good solid baseline patch to work with.

I have been able to hoist the permission check out of sget_fc for
converted filesystems.  So progress is being made.  That absolutely
requires fc->user_ns to be set properly before vfs_get_tree.  Something
that still needs to be fixed.

I have also observed that by not allowing unconverted filesystems
to mount using the new api.  The compatbitility code can be
significantly simplified, and the who data_size problem goes away.

I am going to be travelling for the next couple of days so I
don't expect I will be able to answer questions in a timely manner.
In the hopes that it might help below is my work in progress git
tree where I have cleaned up some of these issues.

https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git new-mount-api-testing

Eric


