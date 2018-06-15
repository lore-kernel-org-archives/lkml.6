Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C785C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30782086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30782086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbeFOETJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:19:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60455 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeFOETH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:19:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fTgCS-0008GM-Cn; Thu, 14 Jun 2018 22:19:00 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fTgCR-0002Bg-J1; Thu, 14 Jun 2018 22:19:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
Date:   Thu, 14 Jun 2018 23:18:50 -0500
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Fri, 25 May 2018 01:05:23 +0100")
Message-ID: <87in6kptqt.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fTgCR-0002Bg-J1;;;mid=<87in6kptqt.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/tEwAtKhk/Ea2JRa3ATONR1uVuVu3AQkY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #8]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Here are a set of patches to create a filesystem context prior to setting
> up a new mount, populating it with the parsed options/binary data, creating
> the superblock and then effecting the mount.  This is also used for remount
> since much of the parsing stuff is common in many filesystems.

Dave,
I have read through these patches and I noticed a significant issue.

Today in mount_bdev we do something that looks like:

mount_bdev(...)
{
	s = sget(..., bdev);
	if (s->s_root) {
        	/* Noop */
        } else {
        	err = fill_super(s, ...);
                if (err) {
                	deactivate_locked_super(s);
                        return ERR_PTR(err);
                }
                s->s_flags |= SB_ATTIVE;
                bdev->bd_super = s;
        }
        return dget(s->s_root);
}

The key point is that we don't process the mount options at all if
a super block already exists in the kernel.  Similar to what
your fscontext changes are doing (after parsing the options).

Your fscontext changes do not improve upon this area of the mount api at
all and that concerns me.  This is an area where people can and already
do shoot themselves in their feet.

The real world security issue we had in with this involved devpts.  The
devpts filesystem requires the mode and gid parameters for new ttys to
be specified to be posix compliant.  People were setting up chroot
environments and mounting devpts with the wrong arguments.  As these two
devpts mounts shared a super block a change of arguments on one was a
change of arguments on the other.  Which mean the chroots were
periodically breaking the primary devpts and causing new terminals to be
opened with essentially unusable permissions.  Fun when you are trying
to ssh in to a box.

Creating a new mount and finding an old mount are the same operation in
the kernel today.  This is fundamentally confusing.  In the new api
could we please separate these two operations?

Perhaps someting like:
x create
x find

With the "x create" case failing if the filesystem already exists,
still allowing "x find"?  And with the "x find" case failing if
the superblock is not already created in the kernel.

That should make it clear to a userspace program what is going on
and give it a chance to mount a filesystem anyway.



In a similar vein could we please clarify the rules for changing mount
options for an existing superblock are in the new api?

Today mount assumes that it has to provide all of the existing options
to reconfigure a mount.  What people want to do and what most
filesystems support is just specifying the options that need to be
changed.  Can we please make this the rule of how this are expected
to work for fscontext?  That only changing mount options need to
be specified before: "x reconfigure"

Eric


