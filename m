Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeEYEGm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:06:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEYEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:06:40 -0400
Date: Thu, 24 May 2018 21:06:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged
 mounts
Message-ID: <20180525040620.GD4507@magnolia>
References: <87o9h6554f.fsf@xmission.com>
 <20180524214617.GG7712@thunk.org>
 <87y3g8y6x9.fsf@xmission.com>
 <20180525035716.GE10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525035716.GE10363@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8903 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805250049
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:57:16PM +1000, Dave Chinner wrote:
> On Thu, May 24, 2018 at 06:23:30PM -0500, Eric W. Biederman wrote:
> > "Theodore Y. Ts'o" <tytso@mit.edu> writes:
> > 
> > > On Wed, May 23, 2018 at 06:22:56PM -0500, Eric W. Biederman wrote:
> > >> 
> > >> Very slowly the work has been progressing to ensure the vfs has the
> > >> necessary support for mounting filesystems without privilege.
> > >
> > > What's the thinking behind how system administrators and/or file
> > > systems would configure whether or not a particular file system type
> > > will be allowed to be mounted w/o privilege?
> > 
> > The mechanism is .fs_flags in file_system_type.   If the FS_USERNS_MOUNT
> > flag is set then root in a user namespace (AKA an unprivileged user)
> > will be allowed to mount to mount the filesystem.
> > 
> > There are very real concerns about attacking a filesystem with an
> > invalid filesystem image, or by a malicious protocol speaker.  So I
> > don't want to enable anything without the file system maintainers
> > consent and without a reasonable expecation that neither a system wide
> > denial of service attack nor a privilege escalation attack is possible
> > from if the filesystem is enabled.
> > 
> > So at a practical level what we have in the vfs is the non-fuse specific
> > bits that enable unprivileged mounts of fuse.  Things like handling
> > of unmapped uid and gids, how normally trusted xattrs are dealt with,
> > etc.
> > 
> > A big practical one for me is that if either the uid or gid is not
> > mapped the vfs avoids writing to the inode.
> > 
> > Right now my practical goal is to be able to say: "Go run your
> > filesystem in userspace with fuse if you want stronger security
> > guarantees."  I think that will be enough to make removable media
> > reasonably safe from privilege escalation attacks.
> > 
> > There is enough code in most filesystems that I don't know what our
> > chances of locking down very many of them are.  But I figure a few more
> > of them are possible.
> 
> I'm not sure we need to - fusefs-lkl gives users the ability to
> mount any of the kernel filesystems via fuse without us needing to
> support unprivileged kernel mounts for those filesystems.

/me wonders, is there a fusefs-lkl package for Linux?

(He says, knowing that freebsd has one... :))

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
