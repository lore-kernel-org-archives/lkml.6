Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF85C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E25F21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="kyDIqzsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBIStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:53 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:47530 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfBIStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sq/gOVvgxP7lx7MAR6Fw6A6M85ThCs5LxdB8sVN8QSY=; b=kyDIqzsyLbo3rPeUo7mLdyyqBP
        y7A2dvLz6xJb4oW05A7RNBiJnF0Sk40Dq4bY5yZ00+26mj7UCuG5qrH6gecc0n+FfRkF1ynBrJuPM
        gpgQezKUpOYd4QxJpFwHU05cYPDhALoXfvyRa3InoQmX4D1ogrYcXWWiuSQw1u9mrsQg=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:50588 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1gsXhH-0007xQ-R8; Sat, 09 Feb 2019 19:49:51 +0100
Subject: Re: Linux 5.0 regression: BUG: unable to handle kernel paging request
 at ffff888023e26778 RIP: e030:move_page_tables+0x7c1/0xae0
To:     Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
References: <39ae9195-cf8f-01fe-df83-38a9a4c52e48@eikelenboom.it>
 <da8badb7-9743-020e-6891-dac944b61ee9@eikelenboom.it>
 <094e923b-4e64-57d8-42c4-6e8890473035@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <3be0ee8f-79d4-2a2f-59a5-71f3514d9dbd@eikelenboom.it>
Date:   Sat, 9 Feb 2019 19:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <094e923b-4e64-57d8-42c4-6e8890473035@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2019 19:48, Juergen Gross wrote:
> On 09/02/2019 19:45, Sander Eikelenboom wrote:
>> On 09/02/2019 09:26, Sander Eikelenboom wrote:
>>> L.S.,
>>>
>>>
>>> While testing a Linux 5.0-rc5-ish kernel (pull of yesterday) with some additional patches for
>>> already reported other issues i came across the issue below which i haven't seen with 4.20.x
>>>
>>> I haven't got a reproducer so i might be hard to hit it again, 
>>> system is AMD and this is from the host kernel running under
>>> the Xen hypervisor might it matter.
>>
>>> --
>>>
>>> Sander
>>
>> Hi Boris / Juergen,
>>
>> The commit causing this is:
>> 2c91bd4a4e2e530582d6fd643ea7b86b27907151 mm: speed up mremap by 20x on large regions
>>
>> Since it seems there haven't been any other reports about this .. 
>> could it be this doesn't specifically work well with a Xen PVH dom0 ?
> 
> PVH? Not PV?

Ah sorry, indeed PV !

> 
> Juergen
> 

