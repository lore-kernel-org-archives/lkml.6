Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeEaVIZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:08:25 -0400
Received: from sonic301-28.consmr.mail.gq1.yahoo.com ([98.137.64.154]:39657
        "EHLO sonic301-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750981AbeEaVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:08:19 -0400
X-YMail-OSG: 4m5ehwsVM1nGy80gE4k.U3KM8.rYrkRXLUQcLWFO.VrVESmKF6Vy1FYOJqvEWcz
 VbDderKsyQXTFtUcguFXGEcXAIqqgTU185p.GFSGx2pgSHJQn5o8xgSVbAf2vHjymvB9C9zxUSWb
 0RRVO.WBPVLHkpmimOJ0rA1rOsfvce_Y3P.V1kfLz4C2I0tusBxjZljspXl1.hpEVxsSev7ev0hF
 5LYAuQcwrRmP7yfDbm4gsAEXU_40LTU5OzshQ7lmoSoXnK5LjcmB6Qy0dj9nuW7G4b0mF80kRsaP
 HE.wElxcxsETatluHpWy9t9OUvMjk90YWg8YCO4saSvCpbzBELviMFsS3iVpdgY2A4QRxvQFvTAI
 2maEYhXBPjKMPEJFqQ5TTO37w97WDN0K85O.nEKyVsFxa_Ykw2.2LcLI0a5Qki4IRwkEXHI1bkid
 .rK2SFpg9XMcXnqT_iFPXvXY3XjqeIRgqX_eVkJ4uXPwLjMnAGJZNlXIPQBxAFglnZ5G4NdSu3I6
 VXvDOC2l9dzNWih5cSRXG17sbiOM_J9oCwf7cpCXiNeqy58ElJeKXBi8871WnYXDzWfUSyjRP9is
 XOfLYstXCYE2ZC_LdM_jDghGtO_4kGEf_W7rn.dmMtZoxvBhaYwUzDheFfngwLyG.1SzNfJi_yTq
 YwhCogwnAvFLb7gIT_T286fj87vJDC.mUx5boBeNsWtHLfG9vNy2cKpt9JPuKWsrGLWOXiiJE7V1
 EpVvBISBbBj3CrlFcTalDbTXPArUG70kz28aJ754d
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>, gregkh@linuxfoundation.org,
        tj@kernel.org, bfields@fieldses.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        cpgs@samsung.com, sireesha.t@samsung.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <cae274dd-e9e5-39b1-8b7b-aec1b3e76fe9@schaufler-ca.com>
 <87po1ba6hv.fsf@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9fb8de9d-3a9a-706b-50a9-11e768f72851@schaufler-ca.com>
Date: Thu, 31 May 2018 14:08:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87po1ba6hv.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2018 1:57 PM, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> On 5/31/2018 2:28 AM, CHANDAN VN wrote:
>>> From: "sireesha.t" <sireesha.t@samsung.com>
>>>
>>> Leak is caused because smack_inode_getsecurity() is allocating memory
>>> using kstrdup(). Though the security_release_secctx() is called, it
>>> would not free the allocated memory. Calling security_release_secctx is
>>> not relevant for this scenario as inode_getsecurity() does not provide a
>>> "secctx".
>>>
>>> Similar fix has been mainlined:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=57e7ba04d422c3d41c8426380303ec9b7533ded9
>>>
>>> The fix is to replace the security_release_secctx() with a kfree()
>>>
>>> Below is the KMEMLEAK dump:
>>> unreferenced object 0xffffffc025e11c80 (size 64):
>>>   comm "systemd-tmpfile", pid 2452, jiffies 4294894464 (age 235587.492s)
>>>   hex dump (first 32 bytes):
>>>     53 79 73 74 65 6d 3a 3a 53 68 61 72 65 64 00 00  System::Shared..
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   backtrace:
>>>     [<ffffff80081be770>] __save_stack_trace+0x28/0x34
>>>     [<ffffff80081bedb8>] create_object+0x130/0x25c
>>>     [<ffffff80088c82f8>] kmemleak_alloc+0x30/0x5c
>>>     [<ffffff80081b3ef0>] __kmalloc_track_caller+0x1cc/0x2a8
>>>     [<ffffff800818673c>] kstrdup+0x3c/0x6c
>>>     [<ffffff80082d78b0>] smack_inode_getsecurity+0xcc/0xec
>>>     [<ffffff80082d78f4>] smack_inode_getsecctx+0x24/0x44
>>>     [<ffffff80082d5ea0>] security_inode_getsecctx+0x50/0x70
>>>     [<ffffff800823bbcc>] kernfs_security_xattr_set+0x74/0xe0
>>>     [<ffffff80081eafec>] __vfs_setxattr+0x74/0x90
>>>     [<ffffff80081eb088>] __vfs_setxattr_noperm+0x80/0x1ac
>>>     [<ffffff80081eb238>] vfs_setxattr+0x84/0xac
>>>     [<ffffff80081eb374>] setxattr+0x114/0x178
>>>     [<ffffff80081eb44c>] path_setxattr+0x74/0xb8
>>>     [<ffffff80081ebdcc>] SyS_lsetxattr+0x10/0x1c
>>>     [<ffffff800808310c>] __sys_trace_return+0x0/0x4
>>>
>>> Signed-off-by: sireesha.t <sireesha.t@samsung.com>
>>> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
>> Why not:
>>
>>  static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>>  {
>> -	int len = 0;
>> -	len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, true);
>> +	int len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, false);
>>
> The practical difference here is the true vs the false in the call
> to smack_inode_getsecurity?

That is correct. The author of smack_inode_getsecctx() has a SELinux
background and appears to have missed that Smack is careful not to
allocate memory and make copies of labels when it doesn't need to.

>
>>  	if (len < 0)
>>  		return len;
>>
> Eric
>
