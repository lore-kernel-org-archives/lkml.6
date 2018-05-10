Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966255AbeEJPbb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:31:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:60725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965949AbeEJPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:31:30 -0400
Message-ID: <1525966280.5207.1.camel@gmx.de>
Subject: Re: [Nouveau] kernel spew from nouveau/ swiotlb
From: Mike Galbraith <efault@gmx.de>
To: Jerome Glisse <jglisse@redhat.com>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Date: Thu, 10 May 2018 17:31:20 +0200
In-Reply-To: <474293973.18773550.1525962696189.JavaMail.zimbra@redhat.com>
References: <1525943427.8013.11.camel@gmx.de>
         <474293973.18773550.1525962696189.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C+Ij9P9MY4CL5UtO2rhBkWI9ofSiW+3dWeKDnCLJFb8kjwuzNp2
 GTHoAZnpHW4ViTgZv5rt9CVu8+7rDPz43QacoDOu8wZ1RWhrRTVXeEsvn8q9nKjkRWfAt51
 1kOJDNDv1DREY+F82eYw3mrAEFZArv06sqMO+RhNlDVS9UzEqe8H8iE2T5m4DNzRK6kweoC
 WK13ifQ3YfZwKhJMpxBSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uktDvysgenY=:21gnMcQfnGlevP+7RAhBFF
 Y06mWnOfAL5tW1JuaNXxduakeXhq9KpFE2bwp0+VODENxZJIV2jOxXf09b7W+Fnl8VN6VV50N
 aPjjvofVkVLBp86VZYfO+oijaqA9O6EAZEY69hSsjxnAbrFqs9jQivoPCkbKXG81JHEaQl0G4
 6HPtf1N4OZKqYEe1kZ6u3UduWHyiAknVHBIOgR7MEhCuP15Cd4Gy1hieWalr5dbZ3nz7k2ESB
 h6IK9vXMB8QoRTzvyazV3/TM3W7CpV1v1ObUu94LETnMOqlApLSJZNVv9lvxfiW5FCmxXiVKG
 jbltMcQn0b50eQfCanBdYP+SfEVoNe9Jut/qiCPgzWT3KRYel8tS/WdzBw8FvBYjgwbFT/CVR
 IzdHzmJG9zGaG/7YMdHNM9zbF+5Q9RAjaVG5Ylju+ZTM/S4Q8kEgZ2a1+FwKSw6lQURWG0Sqb
 bsYbnaupnWdd8nvcMGjWNOm7Gf8Nb0KHqH2JvoeNdqDJZq3FtJTepHh99o4LfB4N6ocVGHSls
 bzmwANl2LUwmrVpIe2zgjq5+QnjnvoUsUQj6FMAAE/HdraybW9A7GFUXZepsC1gtlqpJg2hCG
 GoSZ/WbP7bO6k93SquEdqp9O6MtV/uGWrqj4J53MqtMYZVea69g7ooscL4F1KZdh1S7I/QEEL
 /ZVJHrlfRVdJd4z6divLgK9LdNtaAvotGpDY3kRWbfxIIayVgu8seV6QTW1DWg9t2IbpL3DNf
 QugpXIhiDgFvyVuQdzZw8+CB8RIJLAk58Tuk8LUMJmPE8Sw9KSJSwjvOVJwq6SsamLXHK6zIc
 nVuAsra
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 10:31 -0400, Jerome Glisse wrote:
> 
> Could you bisect ? I would love to point finger upstream to the DMA
> folk who made changes to that API without testing with GPU.

Rummaging a bit, it might be...

nouveau_bo_new()
...
ttm_dma_pool_alloc_new_pages()
  dma_alloc_attrs()
    ops->alloc() == x86_swiotlb_alloc_coherent()
    x86_swiotlb_alloc_coherent() flags |= __GFP_NOWARN;
      swiotlb_alloc_coherent(..flags)
        swiotlb_alloc_coherent(..flags) attrs = (flags & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0;
          swiotlb_alloc_buffer(..attr)
            swiotlb_alloc_buffer(..0)  <== hm, pass zero instead of attr?
              swiotlb_tbl_map_single() gripeage

...that?

	-Mike
