Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0B217C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76542088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76542088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756264AbeFOOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:38:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756167AbeFOOid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADD7E8A6FA;
        Fri, 15 Jun 2018 14:38:32 +0000 (UTC)
Received: from redhat.com (ovpn-120-46.rdu2.redhat.com [10.10.120.46])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3E4520284D6;
        Fri, 15 Jun 2018 14:38:31 +0000 (UTC)
Date:   Fri, 15 Jun 2018 17:38:31 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Message-ID: <20180615172933-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <20180615142610-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 14:38:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 14:38:32 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:28:49PM +0000, Wang, Wei W wrote:
> On Friday, June 15, 2018 7:30 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 15, 2018 at 12:43:09PM +0800, Wei Wang wrote:
> > >       - remove the cmd id related interface. Now host can just send a free
> > >         page hint command to the guest (via the host_cmd config register)
> > >         to start the reporting.
> > 
> > Here we go again. And what if reporting was already started previously?
> > I don't think it's a good idea to tweak the host/guest interface yet again.
> 
> This interface is much simpler, and I'm not sure if that would be an
> issue here now, because now the guest delivers the whole buffer of
> hints to host once, instead of hint by hint as before. And the guest
> notifies host after the buffer is delivered. In any case, the host
> doorbell handler will be invoked, if host doesn't need the hints at
> that time, it will just give back the buffer. There will be no stale
> hints remained in the ring now.
> 
> Best,
> Wei

I still think all the old arguments for cmd id apply.

-- 
MST
