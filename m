Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeDJOpj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:45:39 -0400
Received: from h2.hallyn.com ([78.46.35.8]:56842 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753423AbeDJOph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:45:37 -0400
Date: Tue, 10 Apr 2018 09:45:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: KASAN: null-ptr-deref Read in xattr_getsecurity
Message-ID: <20180410144536.GA13386@mail.hallyn.com>
References: <0000000000008d2e0d05697a693d@google.com>
 <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 07:13:23PM +0900, Tetsuo Handa wrote:
> syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
> for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
> memory allocation failed. Return -ENOMEM if memory allocation failed.
> 
> [1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
> Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
> Cc: stable <stable@vger.kernel.org> # 4.14+
> Cc: Serge E. Hallyn <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

thanks!

-serge

> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  security/commoncap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48620c9..1ce701f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  				magic |= VFS_CAP_FLAGS_EFFECTIVE;
>  			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
>  			cap->magic_etc = cpu_to_le32(magic);
> +		} else {
> +			size = -ENOMEM;
>  		}
>  	}
>  	kfree(tmpbuf);
> --
> 1.8.3.1
