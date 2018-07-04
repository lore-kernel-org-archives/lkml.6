Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE773C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B173620837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B173620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeGDION (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:14:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932290AbeGDIOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:14:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFF0040201C7;
        Wed,  4 Jul 2018 08:14:08 +0000 (UTC)
Received: from wei-ubt (dhcp-14-122.nay.redhat.com [10.66.14.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FB5111C4A2;
        Wed,  4 Jul 2018 08:13:57 +0000 (UTC)
Date:   Wed, 4 Jul 2018 16:13:56 +0800
From:   Wei Xu <wexu@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
Subject: Re: [PATCH net-next 8/8] vhost: event suppression for packed ring
Message-ID: <20180704081356.GB9287@wei-ubt>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-9-git-send-email-jasowang@redhat.com>
 <20180704041352.GA9287@wei-ubt>
 <493c3a3e-e088-d6fb-1da4-cda8bfb34400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493c3a3e-e088-d6fb-1da4-cda8bfb34400@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 08:14:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 08:14:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'wexu@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:23:18PM +0800, Jason Wang wrote:
> 
> 
> On 2018年07月04日 12:13, Wei Xu wrote:
> >On Tue, Jul 03, 2018 at 01:38:04PM +0800, Jason Wang wrote:
> >>This patch introduces support for event suppression. This is done by
> >>have a two areas: device area and driver area. One side could then try
> >>to disable or enable (delayed) notification from other side by using a
> >>boolean hint or event index interface in the areas.
> >>
> >>For more information, please refer Virtio spec.
> >>
> >>Signed-off-by: Jason Wang<jasowang@redhat.com>
> >>---
> >>  drivers/vhost/vhost.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++----
> >>  drivers/vhost/vhost.h |  10 ++-
> >>  2 files changed, 185 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >>index 0f3f07c..cccbc82 100644
> >>--- a/drivers/vhost/vhost.c
> >>+++ b/drivers/vhost/vhost.c
> >>@@ -1115,10 +1115,15 @@ static int vq_access_ok_packed(struct vhost_virtqueue *vq, unsigned int num,
> >>  			       struct vring_used __user *used)
> >>  {
> >>  	struct vring_desc_packed *packed = (struct vring_desc_packed *)desc;
> >>+	struct vring_packed_desc_event *driver_event =
> >>+		(struct vring_packed_desc_event *)avail;
> >>+	struct vring_packed_desc_event *device_event =
> >>+		(struct vring_packed_desc_event *)used;
> >>-	/* TODO: check device area and driver area */
> >>  	return access_ok(VERIFY_READ, packed, num * sizeof(*packed)) &&
> >>-	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed));
> >>+	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed)) &&
> >R/W parameter doesn't make sense to most architectures and the comment in x86
> >says WRITE is a superset of READ, is it possible to converge them here?
> >
> >/**
> >  * access_ok: - Checks if a user space pointer is valid
> >  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
> >  *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
> >  *        to write to a block, it is always safe to read from it.
> >  * @addr: User space pointer to start of block to check
> >  * @size: Size of block to check
> >  *
> >  * Context: User context only. This function may sleep if pagefaults are
> >  *          enabled.
> >  *
> >  * Checks if a pointer to a block of memory in user space is valid.
> >  *
> >  * Returns true (nonzero) if the memory block may be valid, false (zero)
> >  * if it is definitely invalid.
> >  *
> >  * Note that, depending on architecture, this function probably just
> >  * checks that the pointer is in the user space range - after calling
> >  * this function, memory access functions may still return -EFAULT.
> >  */
> >#define access_ok(type, addr, size)
> >......
> >
> >Thanks,
> >Wei
> >
> 
> Well, this is a question that beyond the scope of this patch.
> 
> My understanding is we should keep it unless type was meaningless on all
> archs.

No problem, go ahead.

Wei

> 
> Thanks
> 
