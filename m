Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937367AbeE1Ote (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:49:34 -0400
Received: from imap.thunk.org ([74.207.234.97]:35458 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932390AbeE1Ot2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:49:28 -0400
Date: Mon, 28 May 2018 10:49:26 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: xin tan <tanxin0725@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can I use 'signed -off-by' to define maintainers' workload?
Message-ID: <20180528144926.GH4613@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        xin tan <tanxin0725@gmail.com>, linux-kernel@vger.kernel.org
References: <CAPt3h3X0MKiNotU7=bQWzd=sxwu4pkuw3YOvFU9qw23xu8v6oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt3h3X0MKiNotU7=bQWzd=sxwu4pkuw3YOvFU9qw23xu8v6oA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 01:31:56PM +0800, xin tan wrote:
> 
> 1) Do all the maintainers in the path from the author of the commits
> to the mainline repository sign their name?

No.

> 3) If the answer is no, why do some maintainers sign their names, and
> some do not? Is it because these maintainers trust the lower layer
> very much and feel that it is not necessary to review it?

There are two ways a commit can enter git.  One is by having the
maintainer apply the patch directly, usually the patch has been
discussed and revised via e-mail.  Git the patch author and patch
committer separately.  For example:

% git log --pretty=fuller -1 db41ae2c3e4716ceffe212a742d3c963e400fa1e
commit db41ae2c3e4716ceffe212a742d3c963e400fa1e
Author:     Chandan Rajendra <chandan@linux.vnet.ibm.com>
AuthorDate: Wed May 23 08:52:07 2018 +0530
Commit:     Theodore Ts'o <tytso@mit.edu>
CommitDate: Thu May 24 17:28:33 2018 -0400

This is an example of a commit in the e2fsprogs repository that was
sent to me via e-mail, and which was applied using "git am --signoff".
In this case, git automatically added the --signed-off message.  I
then used git commit --amend to add the "Reviewed-by" message which
was sent in a separate message by Andreas:

    Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Reviewed-by: Andreas Dilger <adilger@dilger.ca>

There are other ways which a maintainer can apply a change directly;
this might involve letting the patchwork web application concatente
the Reviewed-by, thus avoiding the need to use git commit --amend.  Or
a maintainer could use guilt to manage a patch stack, in which case
the Author Date and Commit Date will be the same.  But all of these
methods have in common that the maintainer in question is directly
adding the patch to git, and thus has the opportunity to
modify/annotate the commit description before it enters a git
repository.  (In some cases, where the patch author's native languge
is not English, I've completely rewritten the patch description to
make it more intelligible.  Obviously this doesn't scale to the upper
layer maintainers who might be responsible for hundreds of patches
entering mainline per release.)


Commits can also enter the git tree belonging to maintainer (more
typically an upper-layer maintainer) by being merged (or pulled) into
the maintainer's git repository.  When a commit is merged, it's not
changed.  So in that case it's not possible for a signed-off to be
added.  It's also the case that normally the maintainer will tend to
assume that commit was fully reviewed when it entered the git tree he
or she is pulling from.

Of course, that's not necessarily true.  A contributor might have
their own git tree (this is the case with most github-originated pull
requests) and so the commit might not have been reviewed, and so the
responsible maintainer will have to carefully review the commits
before accepting the pull request and republishing the commits in
their tree.

> 4) Is there any special situation that leads to signing-off-by not
> identifying all the maintainers in the path of the commits develiry?
> For example, the upper maintainer does not trust the lower layer
> maintainers, and he/she will contribute a new commits by himself
> instead of passing by, so it will not record the maintainer of the
> lower layer.

This is not likely.  However, sometimes commits are sent directly to
the upper-layer maintainer; you should not assume that patches are
always sent in a strictly hierarchical fashion.  There are always
exceptions to this rule.

> Or because this commit contains modification to several files and each
> file has a specific maintainer, only one maintainer merged it to his
> repository and signed his name.

This is much more common; what will typically happen here is that
other maintainers will indicated they have reivewed the patch
modifying code that they maintain via an Acked-by: header:

Acked-by: Theodore Ts'o <tytso@mit.edu>

Regards,

					- Ted
