Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D0D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfAKNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729947AbfAKNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:49:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAE5C3DBD2;
        Fri, 11 Jan 2019 13:49:59 +0000 (UTC)
Received: from flask (unknown [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53AFC1000049;
        Fri, 11 Jan 2019 13:49:57 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:49:56 +0100
Date:   Fri, 11 Jan 2019 14:49:56 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] KVM: validate userspace input in
 kvm_clear_dirty_log_protect()
Message-ID: <20190111134955.GE14852@flask>
References: <20190102172937.28741-1-tomasbortoli@gmail.com>
 <99de332c-d4e3-0628-8ad1-982032e67690@redhat.com>
 <8418f6c8-0fc8-e22c-c39a-bfcaee7471e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8418f6c8-0fc8-e22c-c39a-bfcaee7471e2@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 13:49:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-01-08 17:28+0100, Tomas Bortoli:
> Hi Paolo,
> 
> On 1/7/19 11:42 PM, Paolo Bonzini wrote:
> > On 02/01/19 18:29, Tomas Bortoli wrote:
> >>  	n = kvm_dirty_bitmap_bytes(memslot);
> >> +
> >> +	if (n << 3 < log->num_pages || log->first_page > log->num_pages)
> >> +		return -EINVAL;
> >> +
> > 
> > This should be
> > 
> > 	if (log->first_page > memslot->npages ||

(Wouldn't this be clearer with a >= instead?)

> > 	    log->num_pages > memslot->npages - log->first_page)
> > 		return -EINVAL;
> > 
> > i.e. the comparison should check the last page in the range, not the
> > number of pages.  In addition, using "n" is unnecessary since we do have
> > the memslot.  I'll do the changes myself if you prefer, but an ack would
> > be nice.
> > 
> > 
> 
> 
> Yeah, I agree. Thanks for the reply and sure you can do the changes, np :)

Done that and applied, thanks.
