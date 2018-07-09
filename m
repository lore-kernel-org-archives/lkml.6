Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A4C20844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A4C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeGIQk2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933009AbeGIQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:40:27 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FFC3C057FA1;
        Mon,  9 Jul 2018 16:40:27 +0000 (UTC)
Received: from [10.10.122.164] (ovpn-122-164.rdu2.redhat.com [10.10.122.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CFA5300193B;
        Mon,  9 Jul 2018 16:40:25 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] uio: fix crash after the device is unregistered
To:     Xiubo Li <xiubli@redhat.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-4-git-send-email-xiubli@redhat.com>
 <5B3FBBF1.9080902@redhat.com>
 <434b1b7c-604d-a446-b73a-8de7a50817c5@redhat.com>
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B438FF3.4040707@redhat.com>
Date:   Mon, 9 Jul 2018 11:40:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <434b1b7c-604d-a446-b73a-8de7a50817c5@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 09 Jul 2018 16:40:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 08:47 PM, Xiubo Li wrote:
> On 2018/7/7 2:58, Mike Christie wrote:
>> On 07/05/2018 09:57 PM, xiubli@redhat.com wrote:
>>>   void uio_event_notify(struct uio_info *info)
>>>   {
>>> -    struct uio_device *idev = info->uio_dev;
>>> +    struct uio_device *idev;
>>> +
>>> +    if (!info)
>>> +        return;
>>> +
>>> +    idev = info->uio_dev;
>>>   
>> For this one too, I am not sure if it is needed.
>>
>> uio_interrupt -> uio_event_notify. See other mail.
>>
>> driver XYZ -> uio_event_notify. I think drivers need to handle this and
>> set some bits and/or perform some cleanup to make sure they are not
>> calling uio_event_notify after it has called uio_unregister_device. The
>> problem with the above test is if they do not they could have called
>> uio_unregister_device right after the info test so you could still hit
>> the problem.
> 
> When we are tcmu_destroy_device(), if the netlink notify event to
> userspace is not successful then the TCMU will call the uio unregister,
> which will set the idev->info = NULL, without close and deleting the
> device in userspace. But the TCMU could still queue cmds to the ring
> buffer, then the uio_event_notify will be called.

Before tcmu_destroy_device is called LIO will have stopped new IO and
waited for outstanding IO to be completed, so it would never be called
after uio_unregister_device. If it does, it's a bug in LIO.
