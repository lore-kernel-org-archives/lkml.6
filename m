Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCTQZJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:25:09 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:38356 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:25:07 -0400
X-Google-Smtp-Source: AG47ELuxmsNX5/2vSiEx4nQoHyhH1W1W55CakmROtNJUpDCVlp4mc3x0LObdfWBEt5HVJO8cbeNphJFwhoni5zwrWes=
MIME-Version: 1.0
In-Reply-To: <87ina6ntx0.fsf_-_@xmission.com>
References: <cover.1512741134.git.dongsu@kinvolk.io> <878tbmf5vl.fsf@xmission.com>
 <87po4rz4ui.fsf_-_@xmission.com> <87r2p287i8.fsf_-_@xmission.com> <87ina6ntx0.fsf_-_@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 20 Mar 2018 17:25:06 +0100
Message-ID: <CAOssrKebhX-nm06RAwep8HUUV4QpsAa=ZOgxdRyP=WF9p-=4Tw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] fuse: mounts from non-init user namespaces
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 10:23 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> This patchset builds on the work by Donsu Park and Seth Forshee and is
> reduced to the set of patches that just affect fuse.  The non-fuse
> vfs patches are far enough along we can ignore them except possibly for the
> question of when does FS_USERNS_MOUNT get set in fuse_fs_type.
>
> Fuse with a block device has been left as an exercise for a later time.
>
> Since v5 I changed the core of this patchset around as the previous
> patches were showing signs of bitrot.  Some important explanations were
> missing, some important functionality was missing, and xattr handling
> was completely absent.
>
> Since v6 I have:
> - Removed the failure case from fuse_get_req_nofail_nopages that I
>   added.
> - Updated fuse to always to use posix_acl_access_xattr_handler, and
>   posix_acl_default_xattr_handler, by teaching fuse to set
>   ACL_DONT_CACHE when FUSE_POSIX_ACL is not set.
>
> Since v7 I have:
> - Rethought and reworked how I am unifying the cached and the non-cached
>   posix acl case so the code is cleaner and simpler.
>   - I have dropped enhancements to caching negative acls when
>     fc->no_getxattr is set.
>   - Removed the need to wrap forget_all_cached_acls in fuse.
> - Reorder the patches so the posix acl work comes first
>
> Since v8 I have:
> - Dropped and postponed the unification of the uncached and the cached
>   posix acls case.  The code is not hard but tricky enough it needs
>   to be considered on it's own on it's own merits.
>
> Miklos can you take a look and see what you think?
>
> Miklos if you could pick these up I would appreciate it.  If not I can
> merge these through the userns tree.

Thank you Eric for moving this along.  Patches pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next

I did just one modification to "fuse: Fail all requests with invalid
uids or gids": instead of zeroing out the context for the nofail case,
continue to use the "_munged" variants. I don't think this hurts and
is better for backward compatibility (I guess the only relevant use
would be for debugging output, but we don't want to regress even for
that if not necessary).

Thanks,
Miklos
