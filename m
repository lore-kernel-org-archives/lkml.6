Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDLXoF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 19:44:05 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56224 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeDLXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 19:44:04 -0400
X-Google-Smtp-Source: AIpwx4/uhO65GD26jytSSpYVL2hYu/ASOvo2Vg4OjrPjksaxYQjVA0RYGq6DENeUNhZPPSnXVlXlaQ==
Subject: Re: [PATCH] rapidio: fix rio_dma_transfer error handling
To: Andrew Morton <akpm@linux-foundation.org>,
        Ioan Nicu <ioan.nicu.ext@nokia.com>
Cc: Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
References: <20180412150605.GA31409@nokia.com>
 <20180412142803.cd235a40155503700dc73b21@linux-foundation.org>
From: Alexandre Bounine <alex.bou9@gmail.com>
Message-ID: <d77db0b1-2cca-c0f6-987d-32ffb45cb16f@gmail.com>
Date: Thu, 12 Apr 2018 19:44:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412142803.cd235a40155503700dc73b21@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-04-12 05:28 PM, Andrew Morton wrote:
> On Thu, 12 Apr 2018 17:06:05 +0200 Ioan Nicu <ioan.nicu.ext@nokia.com> wrote:
> 
>> Some of the mport_dma_req structure members were initialized late
>> inside the do_dma_request() function, just before submitting the
>> request to the dma engine. But we have some error branches before
>> that. In case of such an error, the code would return on the error
>> path and trigger the calling of dma_req_free() with a req structure
>> which is not completely initialized. This causes a NULL pointer
>> dereference in dma_req_free().
>>
>> This patch fixes these error branches by making sure that all
>> necessary mport_dma_req structure members are initialized in
>> rio_dma_transfer() immediately after the request structure gets
>> allocated.
> 
> This sounds like something which someone has actually triggered in a
> real-world situation.  So I added a cc:stable.  Please let me know if
> that was inappropriate.
> 
> And please remember to always include all information regarding
> end-user impact when fixing bugs.
> 
This bug fix is applicable to versions starting from v4.6
