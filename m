Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CC72075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBVLoH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:44:07 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:38853 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfBVLoG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Fri, 22 Feb 2019 06:44:06 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 22 Feb 2019 04:44:05 -0700
Message-Id: <5C6FE084020000780021916C@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Fri, 22 Feb 2019 04:44:04 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Julien Grall" <julien.grall@arm.com>
Cc:     "Dave P Martin" <dave.martin@arm.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: xen/evtchn and forced threaded irq
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <1574a7fe-a5ac-4bc2-d3f0-967d8d01e5f1@oracle.com>
 <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
In-Reply-To: <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.02.19 at 23:03, <julien.grall@arm.com> wrote:
> On 2/20/19 9:46 PM, Boris Ostrovsky wrote:
>> On 2/20/19 3:46 PM, Julien Grall wrote:
>>> On 2/20/19 8:04 PM, Boris Ostrovsky wrote:
>>>> On 2/20/19 1:05 PM, Julien Grall wrote:
>>>> Some sort of a FIFO that stores {irq, data} tuple. It could obviously be
>>>> implemented as a ring but not necessarily as Xen shared ring (if that's
>>>> what you were referring to).

I'm sort of lost here with the mixed references to "interrupts" and
"events". Interrupts can be shared (and have a per-instance
(irq,data) tuple), but there should be at most one interrupt
underlying the event channel systems, shouldn't there? Event
channels otoh can't be shared, and hence there's only one
"data" item to be associated with each channel, at which point a
plain counter ought to do.

>>> The underlying question is what happen if you miss an interrupt. Is it
>>> going to be ok?
>> 
>> This I am not sure about. I thought yes since we are signaling the
>> process only once.
> 
> I have CCed Andrew and Jan to see if they can help here.

What meaning of "miss" do you use here? As long as is only means
delay (i.e. miss an instance, but get notified as soon as feasible
even if there is not further event coming from the source) - that
would be okay, I think. But if you truly mean "miss" (i.e. event lost
altogether, with silence resulting if there's no further event), then
no, this would not be tolerable.

Jan


