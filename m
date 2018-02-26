Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeBZBKj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 20:10:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751915AbeBZBKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 20:10:37 -0500
Date: Mon, 26 Feb 2018 03:10:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: [RFC PATCH] ptr_ring: linked list fallback
Message-ID: <20180226031015-mutt-send-email-mst@kernel.org>
References: <20180216094054-mutt-send-email-mst@kernel.org>
 <20180216.163205.742896307415861222.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216.163205.742896307415861222.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:32:05PM -0500, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Fri, 16 Feb 2018 09:40:54 +0200
> 
> > So pointer rings work fine, but they have a problem:
> > make them too small and not enough entries fit.
> > Make them too large and you start flushing your cache
> > and running out of memory.
> > 
> > This is a new idea of mine: a ring backed by a
> > linked list. Once you run out of rin entries,
> > instead of a drop you fall back on a list with
> > a common lock.
> > 
> > Should work well for the case where the ring is typically sized
> > correctly, but will help address the fact that some user try to set e.g.
> > tx queue length to 1000000.
> > 
> > My hope this will move us closer to direction where e.g. fw codel can
> > use ptr rings without locking at all.
> > The API is still very rough, and I really need to take a hard look
> > at lock nesting.
> > 
> > Completely untested, sending for early feedback/flames.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> So the idea is that if a user sets a really huge TX queue length, we allocate
> a ptr_ring which is smaller, and use the backup linked list when necessary
> to provide the requested TX queue length legitimately.
> 
> Right?

Exactly, thanks for adding this clarification.

-- 
MST
