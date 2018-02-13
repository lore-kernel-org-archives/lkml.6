Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966077AbeBMW5y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:57:54 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34952 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeBMW5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:57:53 -0500
X-Google-Smtp-Source: AH8x226hxXEs9qAGTGp9FZiNb4gJo4ZbgBIrfE47VZCaYYmPrHsgfE4+4b/WP9C2e7qPQslktXsCtApw/3QEckqI36Y=
MIME-Version: 1.0
In-Reply-To: <20180213094016.Horde.CGfpaa2rdOUHbXlCDH3u5ra@gator4166.hostgator.com>
References: <20180213094016.Horde.CGfpaa2rdOUHbXlCDH3u5ra@gator4166.hostgator.com>
From: Ben Skeggs <bskeggs@redhat.com>
Date: Wed, 14 Feb 2018 08:57:51 +1000
Message-ID: <CABDvA=kds=GtcXXe4BY-NzuYa0mt-vc2MQPGmNS-HGmxSBNLxA@mail.gmail.com>
Subject: Re: [drm-nouveau-mmu] question about potential NULL pointer dereference
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 1:40 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
>
> Hi all,
>
> While doing some static analysis I ran into the following piece of code at
> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c:957:
>
>  957#define node(root, dir) ((root)->head.dir == &vmm->list) ? NULL :
> \
>  958        list_entry((root)->head.dir, struct nvkm_vma, head)
>  959
>  960void
>  961nvkm_vmm_unmap_region(struct nvkm_vmm *vmm, struct nvkm_vma *vma)
>  962{
>  963        struct nvkm_vma *next;
>  964
>  965        nvkm_memory_tags_put(vma->memory, vmm->mmu->subdev.device,
> &vma->tags);
>  966        nvkm_memory_unref(&vma->memory);
>  967
>  968        if (vma->part) {
>  969                struct nvkm_vma *prev = node(vma, prev);
>  970                if (!prev->memory) {
>  971                        prev->size += vma->size;
>  972                        rb_erase(&vma->tree, &vmm->root);
>  973                        list_del(&vma->head);
>  974                        kfree(vma);
>  975                        vma = prev;
>  976                }
>  977        }
>  978
>  979        next = node(vma, next);
>  980        if (next && next->part) {
>  981                if (!next->memory) {
>  982                        vma->size += next->size;
>  983                        rb_erase(&next->tree, &vmm->root);
>  984                        list_del(&next->head);
>  985                        kfree(next);
>  986                }
>  987        }
>  988}
>
> The issue here is that in case _node_ returns NULL, _prev_ is not being null
> checked, hence there is a potential null pointer dereference at line 970.
>
> Notice that _next_ is being null checked at line 980, so I wonder if _prev_
> should be checked the same as _next_.
>
> The fact that both _next_ and next->part are null checked, makes me wonder
> if in case _prev_ actually needs to be checked, there is another pointer
> contained into _prev_ to be validated as well? I'm sorry, this is not clear
> to me at this moment.
It's not checked because it can't happen.  If vma->part is set, there
will be a previous node that it was split from.

Ben.

>
> I appreciate your feedback
> Thank you
> --
> Gustavo
>
>
>
>
>
>
