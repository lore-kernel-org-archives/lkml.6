Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B066F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfANQb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:31:29 -0500
Received: from smtp.infotech.no ([82.134.31.41]:58345 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfANQb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:31:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id EC63120419A;
        Mon, 14 Jan 2019 17:31:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IMAFZuxzB1pv; Mon, 14 Jan 2019 17:31:24 +0100 (CET)
Received: from [192.168.48.23] (host-192.252-161-233.dyn.295.ca [192.252.161.233])
        by smtp.infotech.no (Postfix) with ESMTPA id 0D46D204164;
        Mon, 14 Jan 2019 17:31:22 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: wd719x Replace GFP_KERNEL with GFP_ATOMIC in
 wd719x_chip_init
To:     Christoph Hellwig <hch@infradead.org>, wangbo <wdjjwb@163.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, wang.bo116@zte.com.cn,
        Ondrej Zary <linux@rainbow-software.org>
References: <1547479489-11560-1-git-send-email-wdjjwb@163.com>
 <20190114152943.GA10454@infradead.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <e7ed2d3c-26f4-1b43-ecfe-2e77d94372b1@interlog.com>
Date:   Mon, 14 Jan 2019 11:31:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114152943.GA10454@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-14 10:29 a.m., Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 11:24:49PM +0800, wangbo wrote:
>> wd719x_host_reset get spinlock first then call wd719x_chip_init,
>> so replace GFP_KERNEL with GFP_ATOMIC in wd719x_chip_init.
> 
> Please move the allocation outside the lock instead.  GFP_ATOMIC
> DMA allocations are generally a bad idea and should be avoided where
> we can.
> 
> More importantly we should never actually trigger the allocation
> under the lock as far as fw_virt will always be set already
> in that case.
> 
> So I think you can safely move the request firmware + allocation
> + memcpy from wd719x_chip_init to wd719x_board_found, but I'd rather
> have Ondrej review that plan.

Further to this, the result of holding a lock (probably with _irqsave()
tacked onto it) during a GFP_KERNEL is a message like this in the log:
    hrtimer: interrupt took 1084 ns

It is not always easy to find since it is a "_once" message. The sg v3
driver (the one in production) produces these. I have been able to stamp
them out by taking care in the sg v4 driver (in testing) around
allocations. It also meant adding a new state in my state machine to
fend off "bad things" happening to that object while it is unlocked.
So there may be a cost to dropping the lock.

Doug Gilbert


