Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeCIKtt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:49:49 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42740 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCIKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:49:46 -0500
X-Google-Smtp-Source: AG47ELux6ZkoZsdJIwxNIPT7IJYtnvQbsJBc+KnxoQi+h221xQRJfcIJDrALCmlJclyidyK4h3/zW6nuGnsd5ncFTsc=
MIME-Version: 1.0
In-Reply-To: <4ebee1c2-57f6-bcb8-0e2d-1833d1ee0bb7@huawei.com>
References: <CAG_fn=VW5tfzT6cHJd+jF=t3WO6XS3HqSF_TYnKdycX_M_48vw@mail.gmail.com>
 <4ebee1c2-57f6-bcb8-0e2d-1833d1ee0bb7@huawei.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 9 Mar 2018 11:49:43 +0100
Message-ID: <CAG_fn=XP6X5rqRVBameyU-F2UOc4hpbowUBNxZENf2ZHpMSmfQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: Avoid use uninitialized preferred_node
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w29AnrMe003609

On Fri, Mar 9, 2018 at 6:21 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> Alexander reported an use of uninitialized memory in __mpol_equal(),
> which is caused by incorrect use of preferred_node.
>
> When mempolicy in mode MPOL_PREFERRED with flags MPOL_F_LOCAL, it use
> numa_node_id() instead of preferred_node, however, __mpol_equeue() use
> preferred_node without check whether it is MPOL_F_LOCAL or not.
>
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Tested-by: Alexander Potapenko <glider@google.com>

I confirm that the patch fixes the problem. Thanks for the quick turnaround!
Any idea which commit had introduced the bug in the first place?
> ---
>  mm/mempolicy.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d879f1d..641545e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2124,6 +2124,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>         case MPOL_INTERLEAVE:
>                 return !!nodes_equal(a->v.nodes, b->v.nodes);
>         case MPOL_PREFERRED:
> +               /* a's flags is the same as b's */
> +               if (a->flags & MPOL_F_LOCAL)
> +                       return true;
>                 return a->v.preferred_node == b->v.preferred_node;
>         default:
>                 BUG();
> --
> 1.8.3.1
>



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Straße, 33
80636 München

Geschäftsführer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
