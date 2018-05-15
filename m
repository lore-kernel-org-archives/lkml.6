Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeEOUSY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:18:24 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:40950 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeEOUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:18:21 -0400
X-Google-Smtp-Source: AB8JxZrmd5resHQqMINLdBWuNvolcNqIpwygTPRTXBOZG3LnVy5R+wRMBmdfAtlJm5r/wCZuIhdptJuXa8gpfTSxt+U=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180515031612.3k4hzaihrr6rmnhz@madcap2.tricolour.ca>
References: <20180515130619.2e9e033c@canb.auug.org.au> <20180515031612.3k4hzaihrr6rmnhz@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 May 2018 16:18:19 -0400
Message-ID: <CAHC9VhS02=ectGbx2EFQiZayR=vv9-scrN_mf9whT1KN5NWV8Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with the selinux tree
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:16 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-05-15 13:06, Stephen Rothwell wrote:
>> Hi Paul,
>>
>> Today's linux-next merge of the audit tree got a conflict in:
>>
>>   security/selinux/selinuxfs.c
>>
>> between commit:
>>
>>   4195ed425d3c ("audit: normalize MAC_STATUS record")
>>
>> from the selinux tree and commits:
>>
>>   cdfb6b341f0f ("audit: use inline function to get audit context")
>>   d141136f523a ("audit: normalize MAC_POLICY_LOAD record")
>>
>> from the audit tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>
> This was expected...  It looks ok.

Agreed.  I had to apply the same patch to my testing kernels.

>> --
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc security/selinux/selinuxfs.c
>> index c0cadbc5f85c,35fd77737c59..000000000000
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@@ -167,13 -167,11 +167,13 @@@ static ssize_t sel_write_enforce(struc
>>                                     NULL);
>>               if (length)
>>                       goto out;
>> -             audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
>> +             audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
>>  -                    "enforcing=%d old_enforcing=%d auid=%u ses=%u",
>>  +                    "enforcing=%d old_enforcing=%d auid=%u ses=%u"
>>  +                    " enabled=%d old-enabled=%d lsm=selinux res=1",
>>                       new_value, old_value,
>>                       from_kuid(&init_user_ns, audit_get_loginuid(current)),
>>  -                    audit_get_sessionid(current));
>>  +                    audit_get_sessionid(current),
>>  +                    selinux_enabled, selinux_enabled);
>>               enforcing_set(state, new_value);
>>               if (new_value)
>>                       avc_ss_reset(state->avc, 0);
>> @@@ -303,12 -299,10 +303,12 @@@ static ssize_t sel_write_disable(struc
>>               length = selinux_disable(fsi->state);
>>               if (length)
>>                       goto out;
>> -             audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
>> +             audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
>>  -                    "selinux=0 auid=%u ses=%u",
>>  +                    "enforcing=%d old_enforcing=%d auid=%u ses=%u"
>>  +                    " enabled=%d old-enabled=%d lsm=selinux res=1",
>>  +                    enforcing, enforcing,
>>                       from_kuid(&init_user_ns, audit_get_loginuid(current)),
>>  -                    audit_get_sessionid(current));
>>  +                    audit_get_sessionid(current), 0, 1);
>>       }
>>
>>       length = count;
>> @@@ -581,8 -575,8 +581,8 @@@ static ssize_t sel_write_load(struct fi
>>       length = count;
>>
>>   out1:
>> -     audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
>> +     audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
>>  -            "policy loaded auid=%u ses=%u",
>>  +            "auid=%u ses=%u lsm=selinux res=1",
>>               from_kuid(&init_user_ns, audit_get_loginuid(current)),
>>               audit_get_sessionid(current));
>>   out:
>
>
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635



-- 
paul moore
www.paul-moore.com
