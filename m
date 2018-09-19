Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA120880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeITBRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:17:39 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56978 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbeITBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:17:38 -0400
Received: from mobile-166-172-63-156.mycingular.net ([166.172.63.156] helo=[192.168.43.58])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g2iId-0005fP-KQ; Wed, 19 Sep 2018 15:38:11 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
From:   Rik van Riel <riel@surriel.com>
In-Reply-To: <099b9f82-e162-c91a-bc51-aa1ac0cd50aa@redhat.com>
Date:   Wed, 19 Sep 2018 15:38:07 -0400
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1EBB279F-DC28-404D-9351-65492F9232F2@surriel.com>
References: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
 <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
 <20180918160419.2zeru6xnufxixcax@linutronix.de>
 <11aa7d0f4ba36eff8b61a5dc1bd35ee5195fd576.camel@surriel.com>
 <c3492a53-74cd-4474-b664-f227ef37b7de@redhat.com>
 <20180919165719.iepvc7tg6aabp5mm@linutronix.de>
 <099b9f82-e162-c91a-bc51-aa1ac0cd50aa@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 19, 2018, at 1:00 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> On 19/09/2018 18:57, Sebastian Andrzej Siewior wrote:
>> On 2018-09-19 07:55:51 [+0200], Paolo Bonzini wrote:
>>> A kthread can do use_mm/unuse_mm.
>> 
>> indeed. The FPU struct for the kernel thread isn't valid / does not
>> contain the expected PKRU value. So loading the pkru value from the
>> struct FPU does not work as expected. We could set it to 0 for a kernel
>> thread so we don't end up with a random value.
>> If we want to get this usecase working then we would have to move pkru
>> value from FPU to mm_struct and consider it in use_mm(). Do we want
>> this?
> 
> As a start, I think keeping it in the FPU struct but loading it
> unconditionally will work.  kthreads will not obey PKU but it will be
> better already.
> 
> I honestly don't know if PKRU should be per-mm, I don't know mm very
> well despite my brilliant observation above. :)
> 
One of the rumored use cases for PKRU is to allow different
threads in the same process to have different memory
permissions, while still sharing the same page tables.

Making it per-mm would break that :)

