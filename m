Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeCULTA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:19:00 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:43647 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeCULS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:18:57 -0400
X-Google-Smtp-Source: AG47ELv9fA/dQpB0gxAYcFEnnwGo3x77iqy3FFPQ2WRZSTNUuYhYxe5CmEp0HSVFurBgnRINg40GjGiz+qoG4W0H2Cc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180321143120.6d9bbe0f@canb.auug.org.au>
References: <20180321143120.6d9bbe0f@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Mar 2018 07:18:55 -0400
Message-ID: <CAHC9VhTfHja9-NYG2boM6mv+5FSBSBEEX8E3tLNLNyaJm4c4TQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the security tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: James Morris <jmorris@namei.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 11:31 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Paul,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   security/selinux/hooks.c
>
> between commit:
>
>   6b4f3d01052a ("usb, signal, security: only pass the cred, not the secid, to kill_pid_info_as_cred and security_task_kill")
>
> from the security tree and commit:
>
>   6b6bc6205d98 ("selinux: wrap AVC state")
>
> from the selinux tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/selinux/hooks.c
> index fdd523e575e3,21b377aef69a..000000000000
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@@ -4050,11 -4164,10 +4170,12 @@@ static int selinux_task_kill(struct tas
>                 perm = PROCESS__SIGNULL; /* null signal; existence test */
>         else
>                 perm = signal_to_av(sig);
>  -      if (!secid)
>  +      if (!cred)
>                 secid = current_sid();
>  +      else
>  +              secid = cred_sid(cred);
> -       return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
> +       return avc_has_perm(&selinux_state,
> +                           secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
>   }
>
>   static void selinux_task_to_inode(struct task_struct *p,

Thanks Stephen, that looks correct to me.

-- 
paul moore
www.paul-moore.com
