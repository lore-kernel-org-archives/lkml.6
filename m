Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeBPVcI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:32:08 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:59312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeBPVcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:32:07 -0500
Date: Fri, 16 Feb 2018 16:32:05 -0500 (EST)
Message-Id: <20180216.163205.742896307415861222.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, jasowang@redhat.com
Subject: Re: [RFC PATCH] ptr_ring: linked list fallback
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180216094054-mutt-send-email-mst@kernel.org>
References: <20180216094054-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 16 Feb 2018 09:40:54 +0200

> So pointer rings work fine, but they have a problem:
> make them too small and not enough entries fit.
> Make them too large and you start flushing your cache
> and running out of memory.
> 
> This is a new idea of mine: a ring backed by a
> linked list. Once you run out of rin entries,
> instead of a drop you fall back on a list with
> a common lock.
> 
> Should work well for the case where the ring is typically sized
> correctly, but will help address the fact that some user try to set e.g.
> tx queue length to 1000000.
> 
> My hope this will move us closer to direction where e.g. fw codel can
> use ptr rings without locking at all.
> The API is still very rough, and I really need to take a hard look
> at lock nesting.
> 
> Completely untested, sending for early feedback/flames.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

So the idea is that if a user sets a really huge TX queue length, we allocate
a ptr_ring which is smaller, and use the backup linked list when necessary
to provide the requested TX queue length legitimately.

Right?
