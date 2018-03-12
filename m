Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeCLUyx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:54:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932326AbeCLUyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:54:52 -0400
Subject: Re: [PATCH v4 2/6] proc/sysctl: Check for invalid flags bits
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-3-git-send-email-longman@redhat.com>
 <20180312204614.GZ4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2621ea58-174f-bfe9-8c34-12501bb775fa@redhat.com>
Date: Mon, 12 Mar 2018 16:54:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312204614.GZ4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:46 PM, Luis R. Rodriguez wrote:
> On Mon, Mar 12, 2018 at 04:15:40PM -0400, Waiman Long wrote:
>> Checking code is added to check for invalid flags in the ctl_table
>> and return error if an unknown flag is used.
> This should be merged with the first patch otherwise there are atomic
> points in time on the commit log history where invalid values are allowed
> and that makes no sense.
>
> This can probably be expanded to verify semantics further. Details
> below.
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  fs/proc/proc_sysctl.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 493c975..67c0c82 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -1092,6 +1092,16 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
>>  	return err;
>>  }
>>  
>> +static int sysctl_check_flags(const char *path, struct ctl_table *table)
>> +{
>> +	int err = 0;
>> +
>> +	if (table->flags & ~CTL_TABLE_FLAGS_ALL)
>> +		err = sysctl_err(path, table, "invalid flags");
> What if a range for the upper limit is set but not the lower limit and
> the user goes over the lower limit?
>
> How about the inverse?
>
> Do we need both ranges set?
>
>   Luis

This check is just to make sure that no invalid flag bit is set. Range
clamping is just one of flag bits, though this is the only one currently
supported. In fact, it is allowed that the minimum or maximum can be
left unspecified. In this case, no minimum or maximum checking will be
done. So I don't see anything related to range checking should be put here.

Cheers,
Longman
