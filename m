Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeCHT5M convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:57:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750926AbeCHT5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:57:10 -0500
Subject: Re: [PATCH v3 4/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-5-git-send-email-longman@redhat.com>
 <20180308183140.GI4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <deaeacc7-96a3-1c93-8565-cdce5ece6876@redhat.com>
Date: Thu, 8 Mar 2018 14:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308183140.GI4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:31 PM, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 12:43:38PM -0500, Waiman Long wrote:
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed in the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/sysctl.h |  3 +++
>>  kernel/sysctl.c        | 52 ++++++++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 448aa72..3db57af 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -130,11 +130,14 @@ struct ctl_table
>>   * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
>>   *	flexibly clamped to min/max range in case the user provided
>>   *	an incorrect value.
>> + * @CTL_FLAGS_OOR_WARNED: Set to indicate that an out of range warning
>> + * 	had been issued for that entry.
>>   *
>>   * At most 16 different flags will be allowed.
>>   */
>>  enum ctl_table_flags {
>>  	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
>> +	CTL_FLAGS_OOR_WARNED		= BIT(1),
>>  };
> Ugh, no. Now I see why you had to set this flag later.
>
> You are not using this flag to "warn" but rather for an internal
> status checker if you have warned or not. Internal flags should
> not be something the user sets. If we want a flag for warning
> that's one thing. If we need a flag to keep tabs if we have
> warned or not that needs to be kept separately and internally,
> nothing the user has to do set or reset.
>
>   Luis

What I want to do is a printk_once for each sysctl parameter. So the
flag is used as a marker that a warning has been printed.

I do understand that it gets somewhat ugly in the case of msgmni and
shmmni because of the copying back of the flag. Another alternative that
had been suggested by Kees is to use prink_ratelimited. That we don't
need that flag at all.

Cheers,
Longman
