Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93D920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKTFaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:30:06 -0500
Received: from p3plsmtpa11-05.prod.phx3.secureserver.net ([68.178.252.106]:42610
        "EHLO p3plsmtpa11-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeKTFaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:30:06 -0500
Received: from [192.168.0.55] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id Ook3gaUhGAqHTOok3g5YIg; Mon, 19 Nov 2018 11:57:52 -0700
Subject: Re: [PATCH v2 0/6] RFC: gup+dma: tracking dma-pinned pages
To:     john.hubbard@gmail.com, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <942cb823-9b18-69e7-84aa-557a68f9d7e9@talpey.com>
Date:   Mon, 19 Nov 2018 13:57:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181110085041.10071-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFe+OBCAmnlpJw9wT9GY2cVm7QTMevYwA5awvvA6yPA1fMGXeZIktaiyAcGKXn3Vyxbq0cFw02R8zM8TJN5kQYHA59JQ7g9wLK5pY/KKdx9txGqijmiq
 bvKbOg2rdZrWKbo3GegF6TwYteR29/1K0/wAzzKp82zboSop69FzyoTDFiAjqHyprAJq7+Uj8cJNBXwkhdn3q1bL3LeNXSvGEecHkQ1Q/fWtQjfutOQPklyV
 5P6nY0N7OEgJm66bWpw7fOf7FjgIYwCZW/YvYWevYipiclfAHxU8UrwKng/s/WOPMyB+pIbjvmBbKl4KKeuaeekvfLERe9QRQl65P/d9aFzJbvlq6lkFFoum
 M+9uXCiVS7nWxQV+ftzFGPVHy41u+dlN4jOEiNyEruHDOQrWuYw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John, thanks for the discussion at LPC. One of the concerns we
raised however was the performance test. The numbers below are
rather obviously tainted. I think we need to get a better baseline
before concluding anything...

Here's my main concern:

On 11/10/2018 3:50 AM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>...
> ------------------------------------------------------
> WITHOUT the patch:
> ------------------------------------------------------
> reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
> fio-3.3
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=55.5MiB/s,w=0KiB/s][r=14.2k,w=0 IOPS][eta 00m:00s]
> reader: (groupid=0, jobs=1): err= 0: pid=1750: Tue Nov  6 20:18:06 2018
>     read: IOPS=13.9k, BW=54.4MiB/s (57.0MB/s)(1024MiB/18826msec)

~14000 4KB read IOPS is really, really low for an NVMe disk.

>    cpu          : usr=2.39%, sys=95.30%, ctx=669, majf=0, minf=72

CPU is obviously the limiting factor. At these IOPS, it should be far
less.
> ------------------------------------------------------
> OR, here's a better run WITH the patch applied, and you can see that this is nearly as good
> as the "without" case:
> ------------------------------------------------------
> 
> reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
> fio-3.3
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=53.2MiB/s,w=0KiB/s][r=13.6k,w=0 IOPS][eta 00m:00s]
> reader: (groupid=0, jobs=1): err= 0: pid=2521: Tue Nov  6 20:01:33 2018
>     read: IOPS=13.4k, BW=52.5MiB/s (55.1MB/s)(1024MiB/19499msec)

Similar low IOPS.

>    cpu          : usr=3.47%, sys=94.61%, ctx=370, majf=0, minf=73

Similar CPU saturation.

>

I get nearly 400,000 4KB IOPS on my tiny desktop, which has a 25W
i7-7500 and a Samsung PM961 128GB NVMe (stock Bionic 4.15 kernel
and fio version 3.1). Even then, the CPU saturates, so it's not
necessarily a perfect test. I'd like to see your runs both get to
"max" IOPS, i.e. CPU < 100%, and compare the CPU numbers. This would
give the best comparison for making a decision.

Can you confirm what type of hardware you're running this test on?
CPU, memory speed and capacity, and NVMe device especially?

Tom.
