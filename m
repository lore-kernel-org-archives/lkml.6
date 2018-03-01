Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162362AbeCAVyV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:54:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162136AbeCAVyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:54:19 -0500
Subject: Re: [PATCH v3 3/6] sysctl: Add flags to support min/max range
 clamping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-4-git-send-email-longman@redhat.com>
 <20180301133117.1d4b27e327f8e51275c82489@linux-foundation.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <af969ff8-96f7-3414-b451-df5e2471d0d4@redhat.com>
Date: Thu, 1 Mar 2018 16:54:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180301133117.1d4b27e327f8e51275c82489@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 04:31 PM, Andrew Morton wrote:
> On Thu,  1 Mar 2018 12:43:37 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> When minimum/maximum values are specified for a sysctl parameter in
>> the ctl_table structure with proc_dointvec_minmax() handler, update
>> to that parameter will fail with error if the given value is outside
>> of the required range.
>>
>> There are use cases where it may be better to clamp the value of
>> the sysctl parameter to the given range without failing the update,
>> especially if the users are not aware of the actual range limits.
>> Reading the value back after the update will now be a good practice
>> to see if the provided value exceeds the range limits.
>>
>> To provide this less restrictive form of range checking, a new flags
>> field is added to the ctl_table structure. The new field is a 16-bit
>> value that just fits into the hole left by the 16-bit umode_t field
>> without increasing the size of the structure.
>>
>> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table entry,
>> any update from the userspace will be clamped to the given range
>> without error.
>>
>> ...
>>
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -116,6 +116,7 @@ struct ctl_table
>>  	void *data;
>>  	int maxlen;
>>  	umode_t mode;
>> +	uint16_t flags;
> It would be nice to make this have type `enum ctl_table_flags', but I
> guess there's then no reliable way of forcing it to be 16-bit.
> I guess this is the best we can do...
>
> --- a/include/linux/sysctl.h~sysctl-add-flags-to-support-min-max-range-clamping-fix
> +++ a/include/linux/sysctl.h
> @@ -116,7 +116,7 @@ struct ctl_table
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> -	uint16_t flags;
> +	uint16_t flags;			/* enum ctl_table_flags */
>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
> @@ -125,7 +125,7 @@ struct ctl_table
>  } __randomize_layout;
>  
>  /**
> - * enum ctl_table_flags - flags for the ctl table
> + * enum ctl_table_flags - flags for the ctl table (struct ctl_table.flags)
>   *
>   * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
>   *	flexibly clamped to min/max range in case the user provided

The flags field is actually a bit mask of various bits defined in the
enum type. So I will not change the type of flags to enum
ctl_table_flags as it is not strictly an enum type. However, I can
certainly add the suggested comment change in the next version of the patch.

Cheers,
Longman
