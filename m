Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14725C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE222077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeIGS6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:58:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727642AbeIGS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0175807689C;
        Fri,  7 Sep 2018 14:17:35 +0000 (UTC)
Received: from redhat.com (ovpn-124-199.rdu2.redhat.com [10.10.124.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9087710FD2B7;
        Fri,  7 Sep 2018 14:17:35 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:17:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
 tun_build_skb()
Message-ID: <20180907101645-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-5-jasowang@redhat.com>
 <20180906130425-mutt-send-email-mst@kernel.org>
 <e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 14:17:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 14:17:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:22:00AM +0800, Jason Wang wrote:
> > > @@ -1668,6 +1668,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
> > >   	if (copied != len)
> > >   		return ERR_PTR(-EFAULT);
> > > +	get_page(alloc_frag->page);
> > > +	alloc_frag->offset += buflen;
> > > +
> > This adds an atomic op on XDP_DROP which is a data path
> > operation for some workloads.
> 
> Yes, I have patch on top to amortize this, the idea is to have a very big
> refcount once after the frag was allocated and maintain a bias and decrease
> them all when allocating new frags.'

Why bother with refcounting for a drop though? It should be simple.

-- 
MST
