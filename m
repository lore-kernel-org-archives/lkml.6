Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966407AbeEJQa6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:30:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:57029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965017AbeEJQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:30:57 -0400
Message-ID: <1525969846.5308.2.camel@gmx.de>
Subject: Re: [Nouveau] kernel spew from nouveau/ swiotlb
From: Mike Galbraith <efault@gmx.de>
To: Jerome Glisse <jglisse@redhat.com>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Date: Thu, 10 May 2018 18:30:46 +0200
In-Reply-To: <1525966280.5207.1.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
         <474293973.18773550.1525962696189.JavaMail.zimbra@redhat.com>
         <1525966280.5207.1.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:YIvWi7ZBayUCt/HkWjZAqbqyDPmYoUBz0ErKIH9/Wdkn72Us4bk
 suSU+Tcm3jlQS6JiSNeN8moh2CWUb6IY/2s30AHz89B/J0Zhe1yN0Noz1IZi6OHa4sVWbs3
 ks1DgHzElYbyswjEbMu9Lf/JwqM7o1YeTTGRECDP9WyImDFiiKrELgNYRta+jsLvSTOr6qa
 Vt36lDS/N9yxtye28dKVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OAhuVl9AwaU=:LaB1oJHA3bbAYNfDem0Ww0
 dIpD6IbZAE059qZxyfzRyXKQhwa3YUPEu+DQLRnvMTyjs3XJTjSxNZcIMrzTeb/nDgRNnXbPi
 OSk5X7YCbdp2yvn/JMABrE48HNslV/QtmKU8+Sc0iHUvHCLVWOLXz6wSDSl03F6xEZNqNcy2S
 qeseCoXB1Qhng3GGay2AlE/HY0BJ3jf4Mme/l1uRUj/qoh5zaIZCo7iV7oYcyNbbnojC7Her3
 vWa8FyY3C4B0a4FUtck9TuCm8E28FVwdWqotghNUILG3urag41GLBWMQ0bhaz6OoT6REnX+bv
 cAMU8/pLgPIUB5ztbHwhMeNTJwj/t1YonEIIniI4gVBah0/V049F6OoYMLCJJqYs2dqgtz66f
 pzuVPGxz4zVONq3gPyBlBSgHe3rPTSTqikqkpjl2XkGJgJ2XoTd++JP/Ai0yoZsDZjEXMQ/LS
 qQ1Zqv6hC6BzI/wY8pvJLsVFojBOklkUq1Yb6ct3C/8OimgGI/W6mumgL4oCbgpPGV1nnE8XX
 JHx3lnu9D6K5i7eZBdWo3kFkklrdEbGk6Dqsuk7c6KtDWRXlfKPWkPrY1bFVMMU13SHvv8Srz
 7Iy6obVNa11QS281BM8MPftVlqTfvcDcGWbhccUPzrQ035kK4R341+VhcX4sKFRCvoINNECRP
 bMIJwW6WTRHPH6cnNbE3ThInQbci2/g/WW5kqjNlcOtx9zZZjZKJBQ91m/NA14+mEkv/qIy9P
 f7PjaaODFxz3X7xK4iad4jpDdNwa/V0F85v6uE4eV/WzoSKOfPgDdoM9FfdzcdEC4i0zM8NHt
 sq0otWB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 17:31 +0200, Mike Galbraith wrote:
> On Thu, 2018-05-10 at 10:31 -0400, Jerome Glisse wrote:
> > 
> > Could you bisect ? I would love to point finger upstream to the DMA
> > folk who made changes to that API without testing with GPU.
> 
> Rummaging a bit, it might be...
> 

(unsend, whack duplicate line, munge, send;)

> nouveau_bo_new()
> ...
> ttm_dma_pool_alloc_new_pages()
>   dma_alloc_attrs()
>     ops->alloc() == x86_swiotlb_alloc_coherent()
>     x86_swiotlb_alloc_coherent() flags |= __GFP_NOWARN;
>       swiotlb_alloc_coherent(..flags)
>         swiotlb_alloc_coherent(..flags) attrs = (flags & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0;
>           swiotlb_alloc_buffer(..attrs)
*              swiotlb_tbl_map_single(..0) passed 0 vs attrs, gripeage follows

Or something like that.
