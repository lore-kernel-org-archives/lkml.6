Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCUIiw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:38:52 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:42302 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeCUIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:38:47 -0400
X-Google-Smtp-Source: AG47ELtBEVrY8gpk64fkpXIhEg4BJF9tNAXyBaiTo6Scg0LOeOy/1wLrz8PdLTBa5UalJlAGKfnM58AM8bl8zFtJs4w=
MIME-Version: 1.0
In-Reply-To: <87tvta38lu.fsf@xmission.com>
References: <cover.1512741134.git.dongsu@kinvolk.io> <878tbmf5vl.fsf@xmission.com>
 <87po4rz4ui.fsf_-_@xmission.com> <87r2p287i8.fsf_-_@xmission.com>
 <87ina6ntx0.fsf_-_@xmission.com> <CAOssrKebhX-nm06RAwep8HUUV4QpsAa=ZOgxdRyP=WF9p-=4Tw@mail.gmail.com>
 <87tvta38lu.fsf@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 21 Mar 2018 09:38:46 +0100
Message-ID: <CAOssrKf8_zhw+J_B59wkJ9zj-adRj_f3B4hDUq1CPSF30mX0nQ@mail.gmail.com>
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

On Tue, Mar 20, 2018 at 7:27 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> writes:

>> I did just one modification to "fuse: Fail all requests with invalid
>> uids or gids": instead of zeroing out the context for the nofail case,
>> continue to use the "_munged" variants. I don't think this hurts and
>> is better for backward compatibility (I guess the only relevant use
>> would be for debugging output, but we don't want to regress even for
>> that if not necessary)
>
> Hmm...
>
> The thing is the failure doesn't come in the difference between the
> _munged and the normal variants.  The difference between
> munged and non-munged variants is how they handled failure ((uid16_t)-2)
> aka 0xfffe for munged and -1 for the non-munged case.
>
> The failures are introduced by changing &init_user_ns to fc->user_ns.

Right.

> The operations in question are iop->flush and fuse_force_forget (on an
> error).   I don't know what value having ids on those paths will do
> they are operations that must succeed, and they should not change the
> on-disk ids.  I was thinking saying the most privileged id was asking
> for the oepration would seem to make sense.

I don't think anybody should actually *care* about the id's in flush,
but I'd still not change the current behavior for change's sake.

>
> With the munged variants we will get (uid16_t)-2 aka 0xfffe aka
> nobody asking for the operation if things don't map.  In practice
> the don't map case is new.
>
> Since the id's should not be looked at anyway I don't see it makes
> much difference which ids we use so the munged case seems at least
> plausible.
>
> It might be better to use the non-munghed variant and do:
>         if (req->in.h.uid == (uid_t)-1)
>                 req.in.h.uid = 0;
>         if (req->in.h.gid == (gid_t)-1)
>                 req.in.h.gid = 0;
>
> That might be less surprising to userspace.  As I don't think the
> unmapped case has ever occurred in practice yet.

Right, that would work too, but I don't think it actually matters, so
unless you can think of an actual security issue arising from using
the munged variants, I'd just leave it as it is.

Thanks,
Miklos
