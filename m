Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeEYD5V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:57:21 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41806 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934254AbeEYD5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:57:19 -0400
Date: Fri, 25 May 2018 13:57:16 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged
 mounts
Message-ID: <20180525035716.GE10363@dastard>
References: <87o9h6554f.fsf@xmission.com>
 <20180524214617.GG7712@thunk.org>
 <87y3g8y6x9.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3g8y6x9.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 06:23:30PM -0500, Eric W. Biederman wrote:
> "Theodore Y. Ts'o" <tytso@mit.edu> writes:
> 
> > On Wed, May 23, 2018 at 06:22:56PM -0500, Eric W. Biederman wrote:
> >> 
> >> Very slowly the work has been progressing to ensure the vfs has the
> >> necessary support for mounting filesystems without privilege.
> >
> > What's the thinking behind how system administrators and/or file
> > systems would configure whether or not a particular file system type
> > will be allowed to be mounted w/o privilege?
> 
> The mechanism is .fs_flags in file_system_type.   If the FS_USERNS_MOUNT
> flag is set then root in a user namespace (AKA an unprivileged user)
> will be allowed to mount to mount the filesystem.
> 
> There are very real concerns about attacking a filesystem with an
> invalid filesystem image, or by a malicious protocol speaker.  So I
> don't want to enable anything without the file system maintainers
> consent and without a reasonable expecation that neither a system wide
> denial of service attack nor a privilege escalation attack is possible
> from if the filesystem is enabled.
> 
> So at a practical level what we have in the vfs is the non-fuse specific
> bits that enable unprivileged mounts of fuse.  Things like handling
> of unmapped uid and gids, how normally trusted xattrs are dealt with,
> etc.
> 
> A big practical one for me is that if either the uid or gid is not
> mapped the vfs avoids writing to the inode.
> 
> Right now my practical goal is to be able to say: "Go run your
> filesystem in userspace with fuse if you want stronger security
> guarantees."  I think that will be enough to make removable media
> reasonably safe from privilege escalation attacks.
> 
> There is enough code in most filesystems that I don't know what our
> chances of locking down very many of them are.  But I figure a few more
> of them are possible.

I'm not sure we need to - fusefs-lkl gives users the ability to
mount any of the kernel filesystems via fuse without us needing to
support unprivileged kernel mounts for those filesystems.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
