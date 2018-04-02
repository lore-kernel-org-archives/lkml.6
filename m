Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeDBPSt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:18:49 -0400
Received: from aer-iport-1.cisco.com ([173.38.203.51]:35468 "EHLO
        aer-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeDBPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:18:46 -0400
X-IronPort-AV: E=Sophos;i="5.48,395,1517875200";
   d="scan'208";a="2955471"
Subject: Re: [PATCH] connector: add parent pid and tgid to coredump and exit
 events
To: David Miller <davem@davemloft.net>
Cc: zbr@ioremap.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, jderehag@hotmail.com,
        matt.helsley@gmail.com, minipli@googlemail.com
References: <20180329141247.20943-1-sstrogin@cisco.com>
 <20180330.125921.653839794312978457.davem@davemloft.net>
From: Stefan Strogin <sstrogin@cisco.com>
Message-ID: <7d976488-6375-b3a8-e9d7-dc86b4c51b86@cisco.com>
Date: Mon, 2 Apr 2018 18:18:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180330.125921.653839794312978457.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I don't see how it breaks UAPI. The point is that structures
coredump_proc_event and exit_proc_event are members of *union*
event_data, thus position of the existing data in the structure is
unchanged. Furthermore, this change won't increase size of struct
proc_event, because comm_proc_event (also a member of event_data) is
of bigger size than the changed structures.

If I'm wrong, could you please explain what exactly will the change
break in UAPI?


On 30/03/18 19:59, David Miller wrote:
> From: Stefan Strogin <sstrogin@cisco.com>
> Date: Thu, 29 Mar 2018 17:12:47 +0300
> 
>> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
>> index 68ff25414700..db210625cee8 100644
>> --- a/include/uapi/linux/cn_proc.h
>> +++ b/include/uapi/linux/cn_proc.h
>> @@ -116,12 +116,16 @@ struct proc_event {
>>  		struct coredump_proc_event {
>>  			__kernel_pid_t process_pid;
>>  			__kernel_pid_t process_tgid;
>> +			__kernel_pid_t parent_pid;
>> +			__kernel_pid_t parent_tgid;
>>  		} coredump;
>>  
>>  		struct exit_proc_event {
>>  			__kernel_pid_t process_pid;
>>  			__kernel_pid_t process_tgid;
>>  			__u32 exit_code, exit_signal;
>> +			__kernel_pid_t parent_pid;
>> +			__kernel_pid_t parent_tgid;
>>  		} exit;
>>  
>>  	} event_data;
> 
> I don't think you can add these members without breaking UAPI.
> 
