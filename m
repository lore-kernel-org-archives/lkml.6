Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbeDXXdo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:33:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33853 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDXXdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:33:41 -0400
X-Google-Smtp-Source: AIpwx4+4FlMT/7iprO21pYGvAOfaWpUl3L7Og/n+4+OAe18IVkNOi04tWsZq9SK2X418xvLUzUz/7qCCv/2c3i0ewrA=
MIME-Version: 1.0
In-Reply-To: <1524562495-28137-1-git-send-email-matt.redfearn@mips.com>
References: <1524562495-28137-1-git-send-email-matt.redfearn@mips.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 24 Apr 2018 18:33:20 -0500
Message-ID: <CAH2r5mvSFDeH7MvWRfKz2_LozDkFxO=2HFEoxZ+=5_Ere-Pwfw@mail.gmail.com>
Subject: Re: [PATCH] cifs: smbd: Fix printk format warning for iov on the stack
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Long Li <longli@microsoft.com>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the original patch with Matt's suggestion and added him on CC
and repushed to cifs-2.6.git for-next

On Tue, Apr 24, 2018 at 4:34 AM, Matt Redfearn <matt.redfearn@mips.com> wrote:
> Commit 4863cc758216 ("cifs: smbd: Avoid allocating iov on the stack")
> (next-20180424) added a warning when the pdu size is not as expected,
> but used a %lu for the printk warning. This results in the following
> warning being emitted from MIPS allyesconfig builds:
>
> fs/cifs/smbdirect.c:2106:3: warning: format '%lu' expects argument of
> type 'long unsigned int', but argument 4 has type 'size_t' [-Wformat=]
>
> Change the format specifier to %zu for the size_t argument.
>
> Fixes: 4863cc758216 ("cifs: smbd: Avoid allocating iov on the stack")
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>
> ---
>
> This is new in next-20180424. Feel free to squash this if possible
> before it hits master.
>
> ---
>  fs/cifs/smbdirect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 24cea63e17f5..c62f7c95683c 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2103,7 +2103,7 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
>          */
>
>         if (rqst->rq_iov[0].iov_len != 4) {
> -               log_write(ERR, "expected the pdu length in 1st iov, but got %lu\n", rqst->rq_iov[0].iov_len);
> +               log_write(ERR, "expected the pdu length in 1st iov, but got %zu\n", rqst->rq_iov[0].iov_len);
>                 return -EINVAL;
>         }
>         iov = &rqst->rq_iov[1];
> --
> 2.7.4
>



-- 
Thanks,

Steve
