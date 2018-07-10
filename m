Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA566C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723D22089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723D22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbeGJCgl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:36:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932797AbeGJCgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EF8B4023470;
        Tue, 10 Jul 2018 02:36:33 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDBD51E1;
        Tue, 10 Jul 2018 02:36:28 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] uio: fix crash after the device is unregistered
To:     Mike Christie <mchristi@redhat.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-4-git-send-email-xiubli@redhat.com>
 <5B3FBBF1.9080902@redhat.com>
 <434b1b7c-604d-a446-b73a-8de7a50817c5@redhat.com>
 <5B438FF3.4040707@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <95b229de-3f9c-4474-a363-871839cf4065@redhat.com>
Date:   Tue, 10 Jul 2018 10:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <5B438FF3.4040707@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 10 Jul 2018 02:36:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 10 Jul 2018 02:36:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 0:40, Mike Christie wrote:
> On 07/06/2018 08:47 PM, Xiubo Li wrote:
>> On 2018/7/7 2:58, Mike Christie wrote:
>>> On 07/05/2018 09:57 PM, xiubli@redhat.com wrote:
>>>>    void uio_event_notify(struct uio_info *info)
>>>>    {
>>>> -    struct uio_device *idev = info->uio_dev;
>>>> +    struct uio_device *idev;
>>>> +
>>>> +    if (!info)
>>>> +        return;
>>>> +
>>>> +    idev = info->uio_dev;
>>>>    
>>> For this one too, I am not sure if it is needed.
>>>
>>> uio_interrupt -> uio_event_notify. See other mail.
>>>
>>> driver XYZ -> uio_event_notify. I think drivers need to handle this and
>>> set some bits and/or perform some cleanup to make sure they are not
>>> calling uio_event_notify after it has called uio_unregister_device. The
>>> problem with the above test is if they do not they could have called
>>> uio_unregister_device right after the info test so you could still hit
>>> the problem.
>> When we are tcmu_destroy_device(), if the netlink notify event to
>> userspace is not successful then the TCMU will call the uio unregister,
>> which will set the idev->info = NULL, without close and deleting the
>> device in userspace. But the TCMU could still queue cmds to the ring
>> buffer, then the uio_event_notify will be called.
> Before tcmu_destroy_device is called LIO will have stopped new IO and
> waited for outstanding IO to be completed, so it would never be called
> after uio_unregister_device. If it does, it's a bug in LIO.
Yeah, So this should be fixed now. Only hit one crash seem related to 
uio of this code with lower kernel before.

Thanks,
BRs



