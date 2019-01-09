Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4838E2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfAIEbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:31:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIEbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 540A4D4E56;
        Wed,  9 Jan 2019 04:31:16 +0000 (UTC)
Received: from redhat.com (ovpn-120-220.rdu2.redhat.com [10.10.120.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27DC35D9CA;
        Wed,  9 Jan 2019 04:31:15 +0000 (UTC)
Date:   Tue, 8 Jan 2019 23:31:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: __get_user slower than get_user (was Re: [RFC PATCH V3 0/5] Hi:)
Message-ID: <20190108232459-mutt-send-email-mst@kernel.org>
References: <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
 <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com>
 <20190106230224-mutt-send-email-mst@kernel.org>
 <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
 <20190107084853-mutt-send-email-mst@kernel.org>
 <CAPcyv4jf-4=2oGJrdvMBeRiAJnQoKbYhwZDD+5ZEH+xgDaOzRQ@mail.gmail.com>
 <20190107172517-mutt-send-email-mst@kernel.org>
 <CAPcyv4iQMQxZC8ehr2OP8_rqpuCeSWn5xyKN64JSyfR8_r7eOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4iQMQxZC8ehr2OP8_rqpuCeSWn5xyKN64JSyfR8_r7eOg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 04:31:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:44:24PM -0800, Dan Williams wrote:
> On Mon, Jan 7, 2019 at 2:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jan 07, 2019 at 01:39:15PM -0800, Dan Williams wrote:
> > > On Mon, Jan 7, 2019 at 6:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Sun, Jan 06, 2019 at 11:15:20PM -0800, Dan Williams wrote:
> > > > > On Sun, Jan 6, 2019 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
> > > > > > >
> > > > > > > On 2019/1/7 上午11:28, Michael S. Tsirkin wrote:
> > > > > > > > On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
> > > > > > > > > On 2019/1/3 上午4:47, Michael S. Tsirkin wrote:
> > > > > > > > > > On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
> > > > > > > > > > > This series tries to access virtqueue metadata through kernel virtual
> > > > > > > > > > > address instead of copy_user() friends since they had too much
> > > > > > > > > > > overheads like checks, spec barriers or even hardware feature
> > > > > > > > > > > toggling.
> > > > > > > > > > Will review, thanks!
> > > > > > > > > > One questions that comes to mind is whether it's all about bypassing
> > > > > > > > > > stac/clac.  Could you please include a performance comparison with
> > > > > > > > > > nosmap?
> > > > > > > > > >
> > > > > > > > > On machine without SMAP (Sandy Bridge):
> > > > > > > > >
> > > > > > > > > Before: 4.8Mpps
> > > > > > > > >
> > > > > > > > > After: 5.2Mpps
> > > > > > > > OK so would you say it's really unsafe versus safe accesses?
> > > > > > > > Or would you say it's just a better written code?
> > > > > > >
> > > > > > >
> > > > > > > It's the effect of removing speculation barrier.
> > > > > >
> > > > > >
> > > > > > You mean __uaccess_begin_nospec introduced by
> > > > > > commit 304ec1b050310548db33063e567123fae8fd0301
> > > > > > ?
> > > > > >
> > > > > > So fundamentally we do access_ok checks when supplying
> > > > > > the memory table to the kernel thread, and we should
> > > > > > do the spec barrier there.
> > > > > >
> > > > > > Then we can just create and use a variant of uaccess macros that does
> > > > > > not include the barrier?
> > > > > >
> > > > > > Or, how about moving the barrier into access_ok?
> > > > > > This way repeated accesses with a single access_ok get a bit faster.
> > > > > > CC Dan Williams on this idea.
> > > > >
> > > > > It would be interesting to see how expensive re-doing the address
> > > > > limit check is compared to the speculation barrier. I.e. just switch
> > > > > vhost_get_user() to use get_user() rather than __get_user(). That will
> > > > > sanitize the pointer in the speculative path without a barrier.
> > > >
> > > > Hmm it's way cheaper even though IIRC it's measureable.
> > > > Jason, would you like to try?
> > > > Although frankly __get_user being slower than get_user feels very wrong.
> > > > Not yet sure what to do exactly but would you agree?
> > >
> > > Agree. __get_user() being faster than get_user() defeats the whole
> > > point of converting code paths to the access_ok() + __get_user()
> > > pattern.
> >
> > Did you mean the reverse?
> 
> Hmm, no... I'll rephrase: __get_user() should have lower overhead than
> get_user().

Right ...

Linus, given that you just changed all users of access_ok anyway, do
you still think that the access_ok() conversion to return a speculation
sanitized pointer or NULL is too big a conversion?

It was previously discarded here:
https://lkml.org/lkml/2018/1/17/929
but at that point we didn't have numbers and there was an understandable
rush to ship something safe.

At this point I think that vhost can show very measureable gains from
this conversion.

Thanks,

-- 
MST
