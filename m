Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A534C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE702087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfAGOuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:50:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10641 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfAGOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:50:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A459369BC;
        Mon,  7 Jan 2019 14:50:21 +0000 (UTC)
Received: from redhat.com (ovpn-122-143.rdu2.redhat.com [10.10.122.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8267E608E6;
        Mon,  7 Jan 2019 14:50:20 +0000 (UTC)
Date:   Mon, 7 Jan 2019 09:50:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC PATCH V3 1/5] vhost: generalize adding used elem
Message-ID: <20190107094739-mutt-send-email-mst@kernel.org>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20181229124656.3900-2-jasowang@redhat.com>
 <20190104162857-mutt-send-email-mst@kernel.org>
 <20190105003339.GE11288@linux.intel.com>
 <9111a7a2-8396-d866-449e-11ee4008f988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9111a7a2-8396-d866-449e-11ee4008f988@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 14:50:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:00:17PM +0800, Jason Wang wrote:
> 
> On 2019/1/5 上午8:33, Sean Christopherson wrote:
> > On Fri, Jan 04, 2019 at 04:29:34PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 29, 2018 at 08:46:52PM +0800, Jason Wang wrote:
> > > > Use one generic vhost_copy_to_user() instead of two dedicated
> > > > accessor. This will simplify the conversion to fine grain
> > > > accessors. About 2% improvement of PPS were seen during vitio-user
> > > > txonly test.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > I don't hve a problem with this patch but do you have
> > > any idea how come removing what's supposed to be
> > > an optimization speeds things up?
> > With SMAP, the 2x vhost_put_user() will also mean an extra STAC/CLAC pair,
> > which is probably slower than the overhead of CALL+RET to whatever flavor
> > of copy_user_generic() gets used.  CALL+RET is really the only overhead
> > since all variants of copy_user_generic() unroll accesses smaller than
> > 64 bytes, e.g. on a 64-bit system, __copy_to_user() will write all 8
> > bytes in a single MOV.
> > 
> > Removing the special casing also eliminates a few hundred bytes of code
> > as well as the need for hardware to predict count==1 vs. count>1.
> > 
> 
> Yes, I don't measure, but STAC/CALC is pretty expensive when we are do very
> small copies based on the result of nosmap PPS.
> 
> Thanks

Yes all this really looks like a poster child for uaccess_begin/end
plus unsafe accesses. And if these APIs don't do the job for us
then maybe better ones are needed ...


-- 
MST
