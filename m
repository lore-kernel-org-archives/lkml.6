Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934420AbeB1R4r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:56:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933283AbeB1R4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:56:46 -0500
Subject: Re: [PATCH v2 4/5] ipc: Clamp msgmni and shmmni to the real IPCMNI
 limit
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-5-git-send-email-longman@redhat.com>
 <20180228010100.GA14069@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <adeb1e42-6b59-bdcf-67f6-f8a9b6ae0742@redhat.com>
Date: Wed, 28 Feb 2018 12:56:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180228010100.GA14069@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 08:01 PM, Luis R. Rodriguez wrote:
> On Tue, Feb 27, 2018 at 03:49:50PM -0500, Waiman Long wrote:
>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>> index 8ad93c2..e4ab272 100644
>> --- a/ipc/ipc_sysctl.c
>> +++ b/ipc/ipc_sysctl.c
>> @@ -41,12 +41,17 @@ static int proc_ipc_dointvec(struct ctl_table *table, int write,
>>  static int proc_ipc_dointvec_minmax(struct ctl_table *table, int write,
>>  	void __user *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> +	int ret;
>>  	struct ctl_table ipc_table;
>>  
>>  	memcpy(&ipc_table, table, sizeof(ipc_table));
>>  	ipc_table.data = get_ipc(table);
>>  
>> -	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
>> +	ret = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
>> +
>> +	table->flags |= ipc_table.flags; /* Copy back any change in flags */
> This seems fragile, why are we requiring this to be done by the users of
> CTL_FLAGS_CLAMP_RANGE ?
>
>   Luis

I should have just copied back the CTL_FLAGS_OOR_WARNED flag. That will
clarify what it is for.

Cheers,
Longman
