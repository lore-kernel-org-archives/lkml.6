Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFAM0L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:26:11 -0400
Received: from 61.239-255-62.static.virginmediabusiness.co.uk ([62.255.239.61]:57179
        "EHLO office.gblabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFAM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:26:09 -0400
X-Footer: Z2JsYWJzLmNvLnVr
Subject: Re: mlock() confusing 1 half of system RAM limit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c43ad840-dcab-b86f-bf15-ffb26b66d37b@gblabs.co.uk>
 <20180601114425.GA15686@dhcp22.suse.cz>
From: Alex Richman <alex.r@gblabs.co.uk>
Message-ID: <3e33edd7-89dd-1c09-77df-a2ae23c208f1@gblabs.co.uk>
Date: Fri, 1 Jun 2018 13:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180601114425.GA15686@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a shm MAP_SHARED, along these lines:
 > shm_fd = shm_open(handle, (O_RDWR | O_CREAT), (S_IRWXU | S_IRWXG | 
S_IRWXO));
 > ftruncate(shm_fd, channel->sled_size)
 > channel->sled = mmap(NULL, channel->sled_size, (PROT_READ | 
PROT_WRITE), (MAP_SHARED | MAP_NORESERVE), shm_fd, 0);
 > mlock(channel->sled, channel->sled_size) /* Fails with ENOMEM. */

But shmmax is unlimited on my box:
# sysctl -a | grep shm
kernel.shm_next_id = -1
kernel.shm_rmid_forced = 0
kernel.shmall = 18446744073692774399
kernel.shmmax = 18446744073692774399
kernel.shmmni = 4096

Any ideas?

Many thanks,
- Alex.


On 01/06/18 12:44, Michal Hocko wrote:
> On Fri 01-06-18 10:53:57, Alex Richman wrote:
>> Hi,
>>
>> I'm seeing a 1/2 of system RAM limit when calling mlock().  mlock(2) says:
>>> ENOMEM (Linux 2.4 and earlier) the calling process tried to lock more than
>> half of RAM.
>> Which implies to me that the 1 half of system RAM limit should be only Linux
>> 2.4 and earlier, but I'm running linux 4.4.127 and still seeing the limit.
>>
>> This is on a system with 66007168 KB total memory, locking 33794621440 bytes
>> works, locking 33795653632 bytes does not work.
> I assume you are doing mlock on MAP_SHARED resp. on mmap of shmem
> file. You are likely to hit the shmem limit. This is half of the
> available memory by default.

-- 
Alex Richman
alex.r@gblabs.co.uk
Engineering
GB Labs
2 Orpheus House,
Calleva park,
Reading
RG7 8TA
Tel:+44 (0)118 455 5000
www.gblabs.com



The information contained in this message and any attachment may be proprietary, confidential and privileged.
If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering
this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying
of this communication is strictly prohibited. If you received this communication in error, please contact me immediately,
and delete the communication (including attachments, if applicable) from any computer or network system.
