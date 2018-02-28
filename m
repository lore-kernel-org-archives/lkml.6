Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeB1ELC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:11:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbeB1ELB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:11:01 -0500
Date: Wed, 28 Feb 2018 06:11:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
Message-ID: <20180228061003-mutt-send-email-mst@kernel.org>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
 <01aff5eb-a92f-2170-05f7-664220985070@redhat.com>
 <20180226223252-mutt-send-email-mst@kernel.org>
 <0316016a-717b-9d3f-5aef-dccaf34d0fae@redhat.com>
 <20180227190703-mutt-send-email-mst@kernel.org>
 <b73c7c1e-4a63-45c0-cef5-0ec8f1195eca@redhat.com>
 <909327f0-52b8-5c3c-47fe-7b1b71dca196@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <909327f0-52b8-5c3c-47fe-7b1b71dca196@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:39:15AM +0800, Jason Wang wrote:
> 
> 
> On 2018年02月28日 11:28, Jason Wang wrote:
> > > > Well I believe the main user for this is qdisc, which use skb
> > > > array. And we
> > > > can not use what implemented in this patch directly for sk_buff
> > > > without some
> > > > changes on the data structure.
> > > Why not? skb has next and prev pointers at 1st two fields:
> > > 
> > > struct sk_buff {
> > >          union {
> > >                  struct {
> > >                          /* These two members must be first. */
> > >                          struct sk_buff          *next;
> > >                          struct sk_buff          *prev;
> > > ...
> > > }
> > > 
> > > so it's just a question of casting to struct plist.
> > 
> > Well, then the casting can only be done in skb_array implementation?
> 
> Ok, could be done in ptr ring. But still looks tricky, because of the
> different meaning of prev and last.
> 
> Thanks

It doesn't matter much - the meaning is up to whoever has the skb
queued. But sure - adding struct plist into the union is cleaner
and just as easy.
