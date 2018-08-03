Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3832EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED12175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEED12175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeHCP1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732286AbeHCP1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0018F40241D6;
        Fri,  3 Aug 2018 13:31:25 +0000 (UTC)
Received: from [10.43.17.201] (unknown [10.43.17.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 099EF1D080;
        Fri,  3 Aug 2018 13:31:19 +0000 (UTC)
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Linus Torvalds <torvalds@linux-foundation.org>, wgh@torlan.ru
Cc:     Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
From:   Zdenek Kabelac <zkabelac@redhat.com>
Organization: Red Hat
Message-ID: <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
Date:   Fri, 3 Aug 2018 15:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 13:31:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 13:31:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'zkabelac@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 2.8.2018 v 23:52 Linus Torvalds napsal(a):
> On Thu, Aug 2, 2018 at 2:39 PM WGH <wgh@torlan.ru> wrote:
>>
>> I've just found one public report of this bug, though:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900442
> 
> Yeah, it does sound like we should fix this issue.
> 


Hi

IMHO (as the author of fixing lvm2 patch) user should not be upgrading kernels 
and keep running older lvm2 user-land tool (and there are very good reasons 
for this).

Kernel had a bug which has been fixed, lvm2 misused this kernel bug and was 
also fixed.  Keeping kernel bug present allowing certain device to write to 
read-only devices can be possibly seen as some security risk.

Also the number of users who ever create a read-only snapshot is probably very 
low.

Maybe there could be  some  'dm-snapshot'  loading modinfo option to allowing 
to create in case user really wants to have this bug being present in kernel 
(reinstantiate old buggy logic), but on default the user should get error when 
it tries to write to read-only volume and should upgrade lvm2.

Regards

Zdenek
