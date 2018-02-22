Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBVACP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:02:15 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40075 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBVACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:02:14 -0500
X-Google-Smtp-Source: AH8x2250370iA3011dugUr0tlV9gPyJjwVxxQh4P94L5+Qkq3tY2Zcl9OkyAZjWlpI6UMtcx2C195PUsknZ5rVQ4wX0=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhQnVHgX99k2wTWyyxdaep-6k1WBnJ7t-AZmMNZJc_SN0A@mail.gmail.com>
References: <2000f6951431b4f19947d7aa41bb8efd2fe3f15b.1519196084.git.rgb@redhat.com>
 <CAHC9VhQnVHgX99k2wTWyyxdaep-6k1WBnJ7t-AZmMNZJc_SN0A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2018 19:02:11 -0500
Message-ID: <CAHC9VhQ0QEJ9Gt=0em_u=sSHze-Af2AVbf72ARoAAoHf33_-Og@mail.gmail.com>
Subject: Re: [PATCH] audit: return on memory error to avoid null pointer dereference
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:49 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 21, 2018 at 4:30 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> If there is a memory allocation error when trying to change an audit
>> kernel feature value, the ignored allocation error will trigger a NULL
>> pointer dereference oops on subsequent use of that pointer.  Return
>> instead.
>>
>> Passes audit-testsuite.
>> See: https://github.com/linux-audit/audit-kernel/issues/76
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> ---
>>  kernel/audit.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Thanks, merged.
>
> In the future a "[PATCH v2]" prefix would be appreciated for patches
> like this, it makes things a little easier in my inbox.

After merging this I went through all the other callers to see if they
suffered the same mistake and everyone except for IMA was checking the
returned pointer for NULL.  Upon looking at the IMA code, and the
audit code which is called, I realized we are actually "ok" as
audit_log_task_info(), audit_log_format(), audit_log_end(), and others
all check for a NULL audit_buffer at the very top of the functions.
I'm going to leave this patch merged, it's a good practice after all,
but I don't believe that unpatched systems are in any danger of
oops'ing here.

>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 5c25449..2de74be 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -1059,6 +1059,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>>                 return;
>>
>>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
>> +       if (!ab)
>> +               return;
>>         audit_log_task_info(ab, current);
>>         audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
>>                          audit_feature_names[which], !!old_feature, !!new_feature,
>> --
>> 1.8.3.1

-- 
paul moore
www.paul-moore.com
