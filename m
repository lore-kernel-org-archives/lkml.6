Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7692621871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfAEAdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:33:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:43548 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAEAdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:33:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 16:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,440,1539673200"; 
   d="scan'208";a="307618368"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 16:33:39 -0800
Date:   Fri, 4 Jan 2019 16:33:39 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC PATCH V3 1/5] vhost: generalize adding used elem
Message-ID: <20190105003339.GE11288@linux.intel.com>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20181229124656.3900-2-jasowang@redhat.com>
 <20190104162857-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104162857-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 04:29:34PM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 29, 2018 at 08:46:52PM +0800, Jason Wang wrote:
> > Use one generic vhost_copy_to_user() instead of two dedicated
> > accessor. This will simplify the conversion to fine grain
> > accessors. About 2% improvement of PPS were seen during vitio-user
> > txonly test.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I don't hve a problem with this patch but do you have
> any idea how come removing what's supposed to be
> an optimization speeds things up?

With SMAP, the 2x vhost_put_user() will also mean an extra STAC/CLAC pair,
which is probably slower than the overhead of CALL+RET to whatever flavor
of copy_user_generic() gets used.  CALL+RET is really the only overhead
since all variants of copy_user_generic() unroll accesses smaller than
64 bytes, e.g. on a 64-bit system, __copy_to_user() will write all 8
bytes in a single MOV.

Removing the special casing also eliminates a few hundred bytes of code
as well as the need for hardware to predict count==1 vs. count>1.

> 
> > ---
> >  drivers/vhost/vhost.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 55e5aa662ad5..f179b5ee14c4 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2174,16 +2174,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
> >  
> >  	start = vq->last_used_idx & (vq->num - 1);
> >  	used = vq->used->ring + start;
> > -	if (count == 1) {
> > -		if (vhost_put_user(vq, heads[0].id, &used->id)) {
> > -			vq_err(vq, "Failed to write used id");
> > -			return -EFAULT;
> > -		}
> > -		if (vhost_put_user(vq, heads[0].len, &used->len)) {
> > -			vq_err(vq, "Failed to write used len");
> > -			return -EFAULT;
> > -		}
> > -	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
> > +	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
> >  		vq_err(vq, "Failed to write used");
> >  		return -EFAULT;
> >  	}
> > -- 
> > 2.17.1
