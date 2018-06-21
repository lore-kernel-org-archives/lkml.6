Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC18C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847DF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847DF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFUA22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:28:28 -0400
Received: from ozlabs.org ([203.11.71.1]:39697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753938AbeFUA21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:28:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41B2c83gkcz9s1B;
        Thu, 21 Jun 2018 10:28:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Walker <danielwa@cisco.com>,
        "Guilherme G. Piccoli" <guilherme@gpiccoli.net>,
        benh@kernel.crashing.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-kernel@external.cisco.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check on phd_id
In-Reply-To: <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com> <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com> <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com> <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com> <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
Date:   Thu, 21 Jun 2018 10:28:22 +1000
Message-ID: <87in6dvv89.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Sorry we broke things for you.

Daniel Walker <danielwa@cisco.com> writes:
> On 06/19/2018 09:26 AM, Guilherme G. Piccoli wrote:
>>> [...]
>>> What your doing is changing the phb_id to some transformation of "reg" for
>>> all platforms except which have "ibm,opal-phbid". This is what we observe.
>>> This is a radical altering of the prior phb_id selection before your patch.
...
>
> I didn't look into changing the behavior on our side because it didn't 
> look like the intent of the patch was to make a global change. I can 
> take a look at changing this behavior on our side , given that this was 
> intended by your changes.

You're right the change log and the patch are a bit out of sync, that
was probably my fault.

> However, they're may be other platforms or drivers which depend on these 
> numbers getting set a certain way, so there may be other userspace 
> dependencies on these values.

That's true, though I think yours is the first report we've had of
problems.

The old behaviour relied on device tree ordering in nearly all cases, so
you basically get whatever order your firmware happened to flatten the
device tree in.

That tends to be consistent on a single system or with a single firmware
version, but it's not stable in general. If your firmware changes, or
you kexec then the ordering can change.

So I'd definitely prefer we didn't go back to that behaviour, because
it's basically "random order".

If there's anything you can do on your end to cope with the new ordering
that would be great.

cheers
