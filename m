Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDBNrV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:47:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750852AbeDBNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:47:20 -0400
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
To: chaitany kulkarni <ckulkarnilinux@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
 <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
From: Rodrigo Rosatti Galvao <rosattig@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 10:47:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040213-0020-0000-0000-00000DAD5618
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012044; UDB=6.00515758; IPR=6.00791316;
 MB=3.00020374; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 13:47:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040213-0021-0000-0000-000060BD9EF6
Message-Id: <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One thing that I just forgot to explain previously, but I think its 
relevant:

1. The command is failing with 4k logical block size, but works with 512B

2. With the patch, the command is working for both 512B and 4K.


Here are some extra information I could get when executing the command 
with both block sizes:


[without the patch]


# nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

#### 512 B ####

[ 3222.049211] __blkdev_issue_zeroout() - sector: 0 -- rrg
[ 3222.049375] __blkdev_issue_zeroout() - nr_sects: 9 -- rrg
[ 3222.049419] __blkdev_issue_zeroout() - bs_mask: 0 -- rrg
[ 3222.049575] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg


#### 4K #### (FAILS)

[ 4110.654424] __blkdev_issue_zeroout() - sector: 0 -- rrg
[ 4110.654601] __blkdev_issue_zeroout() - nr_sects: 9 -- rrg
[ 4110.654645] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[ 4110.654794] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 1 -- rrg



[with the patch]

nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

#### 512 B #####

[root@ltc-garrison ~]# nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

[  426.028592] __blkdev_issue_zeroout() - sector: 0 -- rrg
[  426.028779] __blkdev_issue_zeroout() - nr_sects: 8 -- rrg
[  426.028946] __blkdev_issue_zeroout() - bs_mask: 0 -- rrg
[  426.028986] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg



#### 4K ####

[  265.489219] __blkdev_issue_zeroout() - sector: 0 -- rrg
[  265.489419] __blkdev_issue_zeroout() - nr_sects: 8 -- rrg
[  265.489587] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[  265.489627] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg


On 04/02/2018 05:03 AM, chaitany kulkarni wrote:
> Please give me a couple of days, I'll look into this.
>
> On Fri, Mar 30, 2018 at 2:48 PM, Rodrigo Rosatti Galvão
> <rosattig@linux.vnet.ibm.com> wrote:
>>> Doesn't that mean your host is using this command wrong? The NLB is a
>>> 0's based value, we're supposed to +1 to get the correct block count.
>>
>> Keith, I tested passing different values to the c (number of blocks) and s
>> (64-bit LBA of first block to access) parameters, and it was failing. When I
>> removed the +1, the command worked fine.
>>
>> I used a simple script to validate this:
>>
>> for s in {0..20}
>>      do
>>              for c in {0..20}
>>              do
>>                      nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
>>              done
>>      done
>>
>>
>> Is there some other way to test it?
>>
>> --
>> Rodrigo R. Galvão
>> Intern - Linux Technology Center - IBM
>>
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Rodrigo R. Galvão
Intern - Linux Technology Center - IBM
