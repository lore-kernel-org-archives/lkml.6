Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeCMSt6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:49:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752375AbeCMSt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:49:56 -0400
Subject: Re: [PATCH v4 1/6] sysctl: Add flags to support min/max range
 clamping
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-2-git-send-email-longman@redhat.com>
 <87r2onzx4k.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <52de4b97-6d97-e91c-3e11-ddbbb7207155@redhat.com>
Date: Tue, 13 Mar 2018 14:49:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87r2onzx4k.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 01:46 PM, Eric W. Biederman wrote:
> Waiman Long <longman@redhat.com> writes:
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
> What use cases?  Who will break.  Examples would be good.

See my response to the 4/6 patch.

>> To provide this less restrictive form of range checking, a new flags
>> field is added to the ctl_table structure.
>>
>> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
>> entry, any update from the userspace will be clamped to the given
>> range without error if either the proc_dointvec_minmax() or the
>> proc_douintvec_minmax() handlers is used.
> As this is constructed it will increase the size of ctl_table for
> everyone.  Better would be to add a new function that behaves similary
> but differently than to burden struct ctl_table for the rest of time.

If you have concern about increasing the size of the ctl_table, I can
revert it back to use unsigned short for flag which will fit into the
hole left by the 16-bit mode field. I thought increasing the size of
ctl_table a bit isn't a big problem, I may be wrong on that.

Adding the new flags field will afford us the ability to better
customize the sysctl parameters to different needs that may arise in the
future.

Cheers,
Longman
