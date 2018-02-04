Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeBDB2M (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 20:28:12 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44238 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeBDB2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 20:28:04 -0500
X-Google-Smtp-Source: AH8x225rnZf2IdY8ezYA1RmS+TpIqEAgoh4sDTpXdGqMqC75cJ80RODGJpRyPfmh3tJl8KvSHb/ScMvi600kN5ArEJk=
MIME-Version: 1.0
In-Reply-To: <20180202154902.1626750-1-arnd@arndb.de>
References: <20180202154902.1626750-1-arnd@arndb.de>
From: Steve French <smfrench@gmail.com>
Date: Sat, 3 Feb 2018 19:27:43 -0600
Message-ID: <CAH2r5msFvyukg=QWPQMcR8bPuRWcdys0rdc5P-Tr1KPYLBgwhw@mail.gmail.com>
Subject: Re: [PATCH] cifs: silence compiler warnings showing up with gcc-8.0.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steve French <sfrench@samba.org>, Martin Sebor <msebor@gcc.gnu.org>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>, Long Li <longli@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>, Sachin Prabhu <sprabhu@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Fri, Feb 2, 2018 at 9:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This bug was fixed before, but came up again with the latest
> compiler in another function:
>
> fs/cifs/cifssmb.c: In function 'CIFSSMBSetEA':
> fs/cifs/cifssmb.c:6362:3: error: 'strncpy' offset 8 is out of the bounds [0, 4] [-Werror=array-bounds]
>    strncpy(parm_data->list[0].name, ea_name, name_len);
>
> Let's apply the same fix that was used for the other instances.
>
> Fixes: b2a3ad9ca502 ("cifs: silence compiler warnings showing up with gcc-4.7.0")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/cifs/cifssmb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 72d71703f1e8..78bc86c315ec 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -6343,9 +6343,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
>         pSMB->InformationLevel =
>                 cpu_to_le16(SMB_SET_FILE_EA);
>
> -       parm_data =
> -               (struct fealist *) (((char *) &pSMB->hdr.Protocol) +
> -                                      offset);
> +       parm_data = (void *)pSMB + offsetof(struct smb_hdr, Protocol) + offset;
>         pSMB->ParameterOffset = cpu_to_le16(param_offset);
>         pSMB->DataOffset = cpu_to_le16(offset);
>         pSMB->SetupCount = 1;
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
