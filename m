Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeE2Q0f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:26:35 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34906 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936536AbeE2Q0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:26:30 -0400
X-Google-Smtp-Source: ADUXVKKQ0awAbeIAJQw7Db50NUSTfh5kLW0qZdmh4qQaEvEeOZ3o5urN/6Ye6cQb3T6wErPGv9rqWw==
Date: Tue, 29 May 2018 09:26:27 -0700
From: "'tj@kernel.org'" <tj@kernel.org>
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: Re: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Message-ID: <20180529162627.GH1351649@devbig577.frc2.facebook.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 28, 2018 at 12:54:03PM +0000, Hatayama, Daisuke wrote:
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 89d1dc1..3aeeb7a 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1621,8 +1621,10 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
>  static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
>  	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
>  {
> +	struct kernfs_node *orig = pos;
> +
>  	pos = kernfs_dir_pos(ns, parent, ino, pos);
> -	if (pos) {
> +	if (pos && kernfs_sd_compare(pos, orig) <= 0) {

Hmm... the code seems a bit unintuitive to me and I wonder whether
it's because there are two identical skipping loops in
kernfs_dir_pos() and kernfs_dir_next_pos() and we're now trying to
selectively disable one of them.  Wouldn't it make more sense to get
rid of it from kernfs_dir_pos() and skip explicitly only when
necessary?

Thanks.

-- 
tejun
