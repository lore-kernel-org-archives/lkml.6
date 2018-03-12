Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeCLVHt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:07:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932215AbeCLVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:07:47 -0400
Subject: Re: [PATCH v4 3/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-4-git-send-email-longman@redhat.com>
 <20180312205001.GA4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0307d95f-8b2f-0cdc-913c-656a9f2dec7f@redhat.com>
Date: Mon, 12 Mar 2018 17:07:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312205001.GA4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:50 PM, Luis R. Rodriguez wrote:
> On Mon, Mar 12, 2018 at 04:15:41PM -0400, Waiman Long wrote:
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed into the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>>
>> The pr_warn_ratelimited() macro is used to limit the number of warning
>> messages that can be printed within a given period of time.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/sysctl.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 3d65f41..14aca92 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2505,6 +2505,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>   * @min: pointer to minimum allowable value
>>   * @max: pointer to maximum allowable value
>>   * @flags: pointer to flags
>> + * @name: sysctl parameter name
>>   *
>>   * The do_proc_dointvec_minmax_conv_param structure provides the
>>   * minimum and maximum values for doing range checking for those sysctl
>> @@ -2514,31 +2515,48 @@ struct do_proc_dointvec_minmax_conv_param {
>>  	int *min;
>>  	int *max;
>>  	unsigned int *flags;
>> +	const char *name;
>>  };
>>  
>> +#ifdef pr_fmt
>> +#undef pr_fmt
>> +#endif
>> +#define pr_fmt(fmt)	"sysctl: " fmt
> No. This needs to be defined at the top of the file, please look
> at other uses on kernel/*.c and just use:
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> The filename already provides the name we want.

Right. That is the right way to do it.

Cheers,
Longman
