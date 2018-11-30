Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A342C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TyvpAbBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeK3Mql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:46:41 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8003 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3Mql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:46:41 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0094c00001>; Thu, 29 Nov 2018 17:39:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 17:39:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 29 Nov 2018 17:39:07 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Nov
 2018 01:39:07 +0000
Subject: Re: [PATCH v2 0/6] RFC: gup+dma: tracking dma-pinned pages
To:     Tom Talpey <tom@talpey.com>, <john.hubbard@gmail.com>,
        <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <942cb823-9b18-69e7-84aa-557a68f9d7e9@talpey.com>
 <97934904-2754-77e0-5fcb-83f2311362ee@nvidia.com>
 <5159e02f-17f8-df8b-600c-1b09356e46a9@talpey.com>
 <c1ba07d6-ebfa-ddb9-c25e-e5c1bfbecf74@nvidia.com>
 <15e4a0c0-cadd-e549-962f-8d9aa9fc033a@talpey.com>
 <313bf82d-cdeb-8c75-3772-7a124ecdfbd5@nvidia.com>
 <2aa422df-d5df-5ddb-a2e4-c5e5283653b5@talpey.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7a68b7fc-ff9d-381e-2444-909c9c2f6679@nvidia.com>
Date:   Thu, 29 Nov 2018 17:39:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <2aa422df-d5df-5ddb-a2e4-c5e5283653b5@talpey.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543541952; bh=2Q2FI3ilHwP+AElffMhWDdG9WU0Ep1B7ExA3yThRADA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TyvpAbBVxWzHT88gpiZb5tUI8uOUzfVELsEAtVxJBTf3Q8zBc7awdzhAJ9G/w3ooL
         OXV8H39YisYBMfnF07oMgI4KhU1O7PTHzs/3Qhi/xZPoqf8LHP7l68/x5Yl8sozu4e
         /6Iep/FUn37ha02pAZdxYzsQbKZCerc89/UNU7mgTrDkEUNNgi6BY28Z7+HJUOEWqc
         a76Awj9H7lYMfHXdtLEo0i89ZaoFmBJuEloc/dGOYptLHjWiiiYC1761pRET/UI6zB
         3PyFKC9DcJsH6/UekaQyMCRX2GDMVBjD7vSr0OAB83pKUWOFBx7cfmeKiACRukSiEI
         wywdbkgLA698Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 5:59 AM, Tom Talpey wrote:
> On 11/27/2018 9:52 PM, John Hubbard wrote:
>> On 11/27/18 5:21 PM, Tom Talpey wrote:
>>> On 11/21/2018 5:06 PM, John Hubbard wrote:
>>>> On 11/21/18 8:49 AM, Tom Talpey wrote:
>>>>> On 11/21/2018 1:09 AM, John Hubbard wrote:
>>>>>> On 11/19/18 10:57 AM, Tom Talpey wrote:
>> [...]
>>> I'm super-limited here this week hardware-wise and have not been able
>>> to try testing with the patched kernel.
>>>
>>> I was able to compare my earlier quick test with a Bionic 4.15 kernel
>>> (400K IOPS) against a similar 4.20rc3 kernel, and the rate dropped to
>>> ~_375K_ IOPS. Which I found perhaps troubling. But it was only a quick
>>> test, and without your change.
>>>
>>
>> So just to double check (again): you are running fio with these parameters,
>> right?
>>
>> [reader]
>> direct=1
>> ioengine=libaio
>> blocksize=4096
>> size=1g
>> numjobs=1
>> rw=read
>> iodepth=64
> 
> Correct, I copy/pasted these directly. I also ran with size=10g because
> the 1g provides a really small sample set.
> 
> There was one other difference, your results indicated fio 3.3 was used.
> My Bionic install has fio 3.1. I don't find that relevant because our
> goal is to compare before/after, which I haven't done yet.
> 

OK, the 50 MB/s was due to my particular .config. I had some expensive debug options
set in mm, fs and locking subsystems. Turning those off, I'm back up to the rated
speed of the Samsung NVMe device, so now we should have a clearer picture of the
performance that real users will see.

Continuing on, then: running a before and after test, I don't see any significant 
difference in the fio results:

fio.conf:

[reader]
direct=1
ioengine=libaio
blocksize=4096
size=1g
numjobs=1
rw=read
iodepth=64

---------------------------------------------------------
Baseline 4.20.0-rc3 (commit f2ce1065e767), as before:

$ fio ./experimental-fio.conf 
reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.3
Starting 1 process
Jobs: 1 (f=1)
reader: (groupid=0, jobs=1): err= 0: pid=1738: Thu Nov 29 17:20:07 2018
   read: IOPS=193k, BW=753MiB/s (790MB/s)(1024MiB/1360msec)
    slat (nsec): min=1381, max=46469, avg=1649.48, stdev=594.46
    clat (usec): min=162, max=12247, avg=330.00, stdev=185.55
     lat (usec): min=165, max=12253, avg=331.68, stdev=185.69
    clat percentiles (usec):
     |  1.00th=[  322],  5.00th=[  326], 10.00th=[  326], 20.00th=[  326],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
     | 70.00th=[  326], 80.00th=[  326], 90.00th=[  326], 95.00th=[  326],
     | 99.00th=[  379], 99.50th=[  594], 99.90th=[  603], 99.95th=[  611],
     | 99.99th=[12125]
   bw (  KiB/s): min=751640, max=782912, per=99.52%, avg=767276.00, stdev=22112.64, samples=2
   iops        : min=187910, max=195728, avg=191819.00, stdev=5528.16, samples=2
  lat (usec)   : 250=0.08%, 500=99.30%, 750=0.59%
  lat (msec)   : 20=0.02%
  cpu          : usr=16.26%, sys=48.05%, ctx=251258, majf=0, minf=73
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=753MiB/s (790MB/s), 753MiB/s-753MiB/s (790MB/s-790MB/s), io=1024MiB (1074MB), run=1360-1360msec

Disk stats (read/write):
  nvme0n1: ios=220798/0, merge=0/0, ticks=71481/0, in_queue=71966, util=100.00%

---------------------------------------------------------
With patches applied:

<redforge> fast_256GB $ fio ./experimental-fio.conf
reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.3
Starting 1 process
Jobs: 1 (f=1)
reader: (groupid=0, jobs=1): err= 0: pid=1738: Thu Nov 29 17:20:07 2018
   read: IOPS=193k, BW=753MiB/s (790MB/s)(1024MiB/1360msec)
    slat (nsec): min=1381, max=46469, avg=1649.48, stdev=594.46
    clat (usec): min=162, max=12247, avg=330.00, stdev=185.55
     lat (usec): min=165, max=12253, avg=331.68, stdev=185.69
    clat percentiles (usec):
     |  1.00th=[  322],  5.00th=[  326], 10.00th=[  326], 20.00th=[  326],
     | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
     | 70.00th=[  326], 80.00th=[  326], 90.00th=[  326], 95.00th=[  326],
     | 99.00th=[  379], 99.50th=[  594], 99.90th=[  603], 99.95th=[  611],
     | 99.99th=[12125]
   bw (  KiB/s): min=751640, max=782912, per=99.52%, avg=767276.00, stdev=22112.64, samples=2
   iops        : min=187910, max=195728, avg=191819.00, stdev=5528.16, samples=2
  lat (usec)   : 250=0.08%, 500=99.30%, 750=0.59%
  lat (msec)   : 20=0.02%
  cpu          : usr=16.26%, sys=48.05%, ctx=251258, majf=0, minf=73
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=753MiB/s (790MB/s), 753MiB/s-753MiB/s (790MB/s-790MB/s), io=1024MiB (1074MB), run=1360-1360msec

Disk stats (read/write):
  nvme0n1: ios=220798/0, merge=0/0, ticks=71481/0, in_queue=71966, util=100.00%


thanks,
-- 
John Hubbard
NVIDIA
