Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30451C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8424204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8424204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeH2TkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:40:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729028AbeH2TkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:40:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E5FA401EF02;
        Wed, 29 Aug 2018 15:42:51 +0000 (UTC)
Received: from flask (unknown [10.40.205.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F68A2166B41;
        Wed, 29 Aug 2018 15:42:48 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:42:47 +0200
Date:   Wed, 29 Aug 2018 17:42:47 +0200
From:   Radim Krcmar <rkrcmar@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180829154246.GB19487@flask>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
 <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
 <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829102910.rkyato47chayt22s@mwanda>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 15:42:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 15:42:51 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-29 13:29+0300, Dan Carpenter:
> On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
> > On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > > > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > > > index 0cefba2..86e933c 100644
> > > > > > --- a/arch/x86/kvm/lapic.c
> > > > > > +++ b/arch/x86/kvm/lapic.c
> > > > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > > > > >   rcu_read_lock();
> > > > > >   map = rcu_dereference(kvm->arch.apic_map);
> > > > > >
> > > > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < min))
> > > > > > +         goto out;
> > > > >
> > > > > I personally think “if ((min + __fls(ipi_bitmap_low)) > map->max_apic_id)” is more readable.
> > > > > But that’s just a matter of taste :)
> > > >
> > > > That's an integer overflow.
> > > >
> > > > But I do prefer to put the variable on the left.  The truth is that some
> > > > Smatch checks just ignore code which is backwards written because
> > > > otherwise you have to write duplicate code and the most code is written
> > > > with the variable on the left.
> > > >
> > > >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
> > >
> > > Wait, the (s32) cast doesn't make sense.  We want negative min values to
> > > be treated as invalid.
> > 
> > In v2, how about:
> > 
> > if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) >
> > map->max_apic_id))
> >     goto out;
> 
> That works, too.  It still has the off by one and we should set
> "count = -KVM_EINVAL;".

I'd prefer to ignore destinations that are not present and deliver the
rest, possibly nothing, instead of returning an error.
(It's closer to how the real hardware behaves and we already return the
 number of notified VCPUs, so the caller can tell whether something went
 wrong.)

Either in the form that I have posted earlier, or as:

	if (min > map->max_apic_id)
		goto out;

	for_each_set_bit(i, &ipi_bitmap_low, MIN(BITS_PER_LONG, map->max_apic_id - min + 1))
