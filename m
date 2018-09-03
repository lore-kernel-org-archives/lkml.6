Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE256C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663A020645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3CleS88w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663A020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeICUTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:19:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeICUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EnX+BQY6ul306UcbgPAw3DULIQqU5btIsQ9GZKiqgls=; b=3CleS88w9koUgDDgXlUvWdOh7B
        PDvG/H5SZJt1eodm7m4NsZFaHFBn07Y53ZmTeaLJSOONqBOhAk0yvYYC5sKhH8X17e/2G/9yPMDTF
        qX+nkdovxHgnMqcsQzIkdw3t9uE8YQnNxgeb48u5r4WpCstO8v1v4aYzoJI1ocnJbpl4E0BJ4hZeb
        fwT71ksj2Xk2kFoWOVDhRlcRCdeynAKkZlPEa1IUl6xuF5kp60DFNLXtHsZKFyUPzf7VK3F5C46Or
        DaCC10uFzElhL1ciuBVBbUT38VDB0Tau0866FDAyoQb2pSDrZRzHNxV0xmULpFr8OOqzlszjMKkpF
        l2+pZHcA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwrFZ-0000Nu-4C; Mon, 03 Sep 2018 15:58:49 +0000
Subject: Re: [PATCH] firewire: nosy: don't read packets bigger than requested
To:     Jann Horn <jannh@google.com>, stefanr@s5r6.in-berlin.de,
        linux1394-devel@lists.sourceforge.net
Cc:     kernel list <linux-kernel@vger.kernel.org>
References: <20180706151649.31119-1-jannh@google.com>
 <CAG48ez1etiHmD-e9szTEApia9YhUFomCcZM3Yp9wj9xrDWKmzg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cbf4c05d-94f2-6ef0-0c90-1f5823329bbb@infradead.org>
Date:   Mon, 3 Sep 2018 08:58:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1etiHmD-e9szTEApia9YhUFomCcZM3Yp9wj9xrDWKmzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 08:55 AM, Jann Horn wrote:
> On Fri, Jul 6, 2018 at 5:16 PM Jann Horn <jannh@google.com> wrote:
>> In general, accessing userspace memory beyond the length of the supplied
>> buffer in VFS read/write handlers can lead to both kernel memory corruption
>> (via kernel_read()/kernel_write(), which can e.g. be triggered via
>> sys_splice()) and privilege escalation inside userspace.
>>
>> Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> No CC stable because this device shouldn't be available to unprivileged
>> code by default and should be pretty rare.
>>
>>  drivers/firewire/nosy.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
>> index a128dd1126ae..732075fc312e 100644
>> --- a/drivers/firewire/nosy.c
>> +++ b/drivers/firewire/nosy.c
>> @@ -161,11 +161,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
>>         if (atomic_read(&buffer->size) == 0)
>>                 return -ENODEV;
>>
>> -       /* FIXME: Check length <= user_length. */
>> -
>>         end = buffer->data + buffer->capacity;
>>         length = buffer->head->length;
>>
>> +       if (length > user_length)
>> +               return -EINVAL;
>> +
>>         if (&buffer->head->data[length] < end) {
>>                 if (copy_to_user(data, buffer->head->data, length))
>>                         return -EFAULT;
> 
> Ping. I sent this about two months ago, I haven't received a reply,
> and from what I can tell, it hasn't landed in any tree so far...
> 

:(
I have that same problem with some Firewire documentation patches.
I plan to ask someone else to merge my patches.

-- 
~Randy
