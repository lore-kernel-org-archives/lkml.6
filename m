Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5840EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F6B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeGSOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:18:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731126AbeGSOSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2F847A7E5;
        Thu, 19 Jul 2018 13:34:59 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FBFF111AF17;
        Thu, 19 Jul 2018 13:34:58 +0000 (UTC)
Subject: Re: [PATCH] x86/kvm: Don't use pvqspinlock code if only 1 vCPU
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>
References: <1531864767-30648-1-git-send-email-longman@redhat.com>
 <20180719011546.GB28585@char.US.ORACLE.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <24e1962a-075c-8168-5d95-033b826ee919@redhat.com>
Date:   Thu, 19 Jul 2018 09:34:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719011546.GB28585@char.US.ORACLE.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:34:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:34:59 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 09:15 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 17, 2018 at 05:59:27PM -0400, Waiman Long wrote:
>> On a VM with only 1 vCPU, the locking fast path will always be
>> successful. In this case, there is no need to use the the PV qspinlock
>> code which has higher overhead on the unlock side than the native
>> qspinlock code.
> Why not make this global? That is for both KVM and Xen and any
> other virtualized guest that uses this?

Right, I will send another patch for Xen. The pvqspinlock code has to be
explicitly opted in. Right now, both Xen and KVM used it in the tree. I
am not sure about other out-of-tree modules. There is nothing I can do
for those.

Cheers,
Longman
