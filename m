Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0005C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B31204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B31204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHKHQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 03:16:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40360 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeHKHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 03:16:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foLkN-0000ul-2O; Fri, 10 Aug 2018 22:43:27 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foLkL-0001rK-9f; Fri, 10 Aug 2018 22:43:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
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
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <87d0uqpba5.fsf@xmission.com>
        <20180810151606.GA6515@ZenIV.linux.org.uk>
        <87pnypiufr.fsf@xmission.com>
        <20180811015815.GD6515@ZenIV.linux.org.uk>
        <20180811021704.GE6515@ZenIV.linux.org.uk>
Date:   Fri, 10 Aug 2018 23:43:20 -0500
In-Reply-To: <20180811021704.GE6515@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 11 Aug 2018 03:17:04 +0100")
Message-ID: <87mutto6mv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foLkL-0001rK-9f;;;mid=<87mutto6mv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WCCYVSKk/QTVxU98k2T+AX8pP+BodV3w=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Sat, Aug 11, 2018 at 02:58:15AM +0100, Al Viro wrote:
>> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
>> 
>> > All I proposed was that we distinguish between a first mount and an
>> > additional mount so that userspace knows the options will be ignored.
>> 
>> For pity sake, just what does it take to explain to you that your
>> notions of "first mount" and "additional mount" ARE HEAVILY FS-DEPENDENT
>> and may depend upon the pieces of state userland (especially in container)
>> simply does not have?
>> 
>> One more time, slowly:
>> 
>> mount -t nfs4 wank.example.org:/foo/bar /mnt/a
>> mount -t nfs4 wank.example.org:/baz/barf /mnt/b
>> 
>> yield the same superblock.  Is anyone who mounts something over NFS
>> required to know if anybody else has mounted something from the same
>> server, and if so how the hell are they supposed to find that out,
>> so that they could decide whether they are creating the "first" or
>> "additional" mount, whatever that might mean in this situation?
>> 
>> And how, kernel-side, is that supposed to be handled by generic code
>> of any description?  
>> 
>> While we are at it,
>> mount -t nfs4 wank.example.org:/foo/bar -o wsize=16384 /mnt/c
>> is *NOT* the same superblock as the previous two.
>
> s/as the previous two/as in the previous two cases/, that is - the first two
> examples yield one superblock, this one - another.

Exactly because the mount options differ.

I don't have a problem if we have something sophisticated like nfs that
handles all of the hairy details and does not reuse a superblock unless the
mount options match.

What I have a problem with is the helper for ordinary filesystems that
are not as sophisticated as nfs that don't handle all of the option
magic and give userspace something different from what userspace asked
for.

It may take a little generalization of the definitions I proposed but it
still remains simple and straight forward.

CMD_THESE_MOUNT_OPTIONS_NO_SURPRISES
CMD_WHATEVER_ALREADY_EXISTS

Or we can make the filesystems more sophisticated when we move
them to the new API and perform the comparisons there.  I think
that is what David Howells is working on.

Eric
