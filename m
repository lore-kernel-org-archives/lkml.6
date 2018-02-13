Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934597AbeBMQFE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:05:04 -0500
Received: from gateway20.websitewelcome.com ([192.185.60.19]:28979 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933774AbeBMQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:05:03 -0500
Date: Tue, 13 Feb 2018 09:40:16 -0600
Message-ID: <20180213094016.Horde.CGfpaa2rdOUHbXlCDH3u5ra@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [drm-nouveau-mmu] question about potential NULL pointer dereference
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1elcgr-0001Ev-7b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:35369
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

While doing some static analysis I ran into the following piece of  
code at drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c:957:

  957#define node(root, dir) ((root)->head.dir == &vmm->list) ? NULL :  
              \
  958        list_entry((root)->head.dir, struct nvkm_vma, head)
  959
  960void
  961nvkm_vmm_unmap_region(struct nvkm_vmm *vmm, struct nvkm_vma *vma)
  962{
  963        struct nvkm_vma *next;
  964
  965        nvkm_memory_tags_put(vma->memory,  
vmm->mmu->subdev.device, &vma->tags);
  966        nvkm_memory_unref(&vma->memory);
  967
  968        if (vma->part) {
  969                struct nvkm_vma *prev = node(vma, prev);
  970                if (!prev->memory) {
  971                        prev->size += vma->size;
  972                        rb_erase(&vma->tree, &vmm->root);
  973                        list_del(&vma->head);
  974                        kfree(vma);
  975                        vma = prev;
  976                }
  977        }
  978
  979        next = node(vma, next);
  980        if (next && next->part) {
  981                if (!next->memory) {
  982                        vma->size += next->size;
  983                        rb_erase(&next->tree, &vmm->root);
  984                        list_del(&next->head);
  985                        kfree(next);
  986                }
  987        }
  988}

The issue here is that in case _node_ returns NULL, _prev_ is not  
being null checked, hence there is a potential null pointer  
dereference at line 970.

Notice that _next_ is being null checked at line 980, so I wonder if  
_prev_ should be checked the same as _next_.

The fact that both _next_ and next->part are null checked, makes me  
wonder if in case _prev_ actually needs to be checked, there is  
another pointer contained into _prev_ to be validated as well? I'm  
sorry, this is not clear to me at this moment.

I appreciate your feedback
Thank you
--
Gustavo
