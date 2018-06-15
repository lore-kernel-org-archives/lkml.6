Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8D963C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4979C20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4979C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=icdsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756232AbeFOOcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:32:50 -0400
Received: from us.icdsoft.com ([192.252.146.184]:44820 "EHLO us.icdsoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755816AbeFOOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:32:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2018 10:32:48 EDT
Received: (qmail 29044 invoked by uid 1001); 15 Jun 2018 14:26:07 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 15 Jun 2018 14:26:07 -0000
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
From:   Ivan Zahariev <famzah@icdsoft.com>
Message-ID: <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
Date:   Fri, 15 Jun 2018 17:26:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614150650.GU1351649@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-bg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.6.2018 г. 18:06 ч., Tejun Heo wrote:
> On Thu, Jun 14, 2018 at 02:56:00PM +0300, Ivan Zahariev wrote:
>> I posted a kernel bug about this a month ago but it did not receive
>> any attention: https://bugzilla.kernel.org/show_bug.cgi?id=199713
>>
>> Here is a copy of the bug report and I hope that this is the correct
>> place to discuss this:
> Well, for now at least, that's the expected behavior.  It's not
> supposed to be able to account all changes immediately (the kernel
> doesn't free a lot of things immediately for performance and other
> reasons).  The intended use is setting up a reasonable upperbound with
> some buffer space.

If that's by design, it's a bit disappointing and at least the docs 
should mention it.

The standard RLIMIT_NPROC does not suffer from such accounting 
discrepancies at any time. The "memory" cgroups controller also does not 
suffer from any discrepancies -- it accounts memory usage in real time 
without any lag on process start or exit. The "tasks" file list is also 
always up-to-date.

Is it really technically not possible to make "pids.current" do 
accounting properly like RLIMIT_NPROC does? We were hoping to replace 
RLIMIT_NPROC with the "pids" controller.

--Ivan
