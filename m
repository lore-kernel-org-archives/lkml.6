Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0470C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDA5206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAGWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:02:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfAGWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:02:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3978552FC;
        Mon,  7 Jan 2019 22:02:26 +0000 (UTC)
Received: from [10.10.120.16] (ovpn-120-16.rdu2.redhat.com [10.10.120.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D593219C7B;
        Mon,  7 Jan 2019 22:02:24 +0000 (UTC)
Subject: Re: [PATCH 1/1] x86/boot/compressed/64: Set EFER.LME=1 in 32-bit
 trampoline code before returning to long mode
To:     Benjamin Gilbert <bgilbert@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-x86_64@vger.kernel.org
References: <20190104054411.12489-1-wei@redhat.com>
 <20190107082512.w5gkbebsypionyey@black.fi.intel.com>
 <6899e645-9579-f599-922a-eb26fc56e8ab@redhat.com>
 <20190107215318.GA22396@trogon.sfo.coreos.systems>
From:   Wei Huang <wei@redhat.com>
Message-ID: <1e63a69d-a59f-5df0-1621-2e25b40ef9d2@redhat.com>
Date:   Mon, 7 Jan 2019 16:02:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107215318.GA22396@trogon.sfo.coreos.systems>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 07 Jan 2019 22:02:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 3:53 PM, Benjamin Gilbert wrote:
> On Mon, Jan 07, 2019 at 02:03:15PM -0600, Wei Huang wrote:
>> On 1/7/19 2:25 AM, Kirill A. Shutemov wrote:
>>> On Fri, Jan 04, 2019 at 05:44:11AM +0000, Wei Huang wrote:
>>>> In some old AMD KVM implementation, guest's EFER.LME bit is cleared by KVM
>>>> when the hypervsior detects guest sets CR0.PG to 0. This causes guest OS
>>>> to reboot when it tries to return from 32-bit trampoline code because CPU
>>>> is in incorrect state: CR4.PAE=1, CR0.PG=1, CS.L=1, but EFER.LME=0.
>>>> As a precaution, this patch sets EFER.LME=1 as part of long mode
>>>> activation procedure. This extra step won't cause any harm when Linux is
>>>> booting on bare-metal machine.
>>>>
>>>> Signed-off-by: Wei Huang <wei@redhat.com>
>>>
>>> Thanks for tracking this down.
>>
>> BTW I think this patch _might_ be related the recent reboot issue
>> reported in https://lkml.org/lkml/2018/7/1/836 since the symptoms are
>> exactly the same.
> 
> The problem in that case turned out to be https://lkml.org/lkml/2018/7/4/723
> which was fixed by d503ac531a.

OK, then it is a different problem. For this specific patch, without it,
the latest kernel can't boot on RHEL6 (and other old KVM distros) as a
guest VM on AMD box.

> 
> --Benjamin Gilbert
> 
