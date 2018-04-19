Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeDSPgO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:36:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeDSPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:36:12 -0400
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        tycho@docker.com, serge@hallyn.com, sunyuqiong1988@gmail.com,
        david.safford@ge.com, mkayaalp@cs.binghamton.edu,
        James.Bottomley@HansenPartnership.com, Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
 <87sh8lcecn.fsf@xmission.com> <1523636702.3272.63.camel@linux.vnet.ibm.com>
 <d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
 <1524081472.3272.319.camel@linux.vnet.ibm.com> <87wox4s282.fsf@xmission.com>
 <8895cb9c-7b9e-2f82-e3d8-a15f5fc26e25@canonical.com>
 <2103bbb9-3f2a-78f8-f7ad-28859659973f@linux.vnet.ibm.com>
From: John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <f84ae8af-fa5b-9f31-fbef-5a49f90dd45a@canonical.com>
Date: Thu, 19 Apr 2018 08:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2103bbb9-3f2a-78f8-f7ad-28859659973f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:03 AM, Stefan Berger wrote:
> On 04/18/2018 05:32 PM, John Johansen wrote:
>> On 04/18/2018 01:12 PM, Eric W. Biederman wrote:
>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>>
>>>> On Wed, 2018-04-18 at 09:09 -0700, John Johansen wrote:
>>>>> On 04/13/2018 09:25 AM, Mimi Zohar wrote:
>>>>>> [Cc'ing John Johansen]
>>>>>>
>>>>>> On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
>>>>>> [...]
>>>>>>> As such I expect the best way to create the ima namespace is by simply
>>>>>>> writing to securityfs/imafs.  Possibly before the user namespace is
>>>>>>> even unshared.  That would allow IMA to keep track of things from
>>>>>>> before a container is created.
>>>>> I do think this is generally the right approach for LSMs when looking
>>>>> forward to LSM stacking and more LSMs.
>>>>>
>>>>>
>>>>>> My initial thought was to stage IMA namespacing with just IMA-audit
>>>>>> first, followed by either IMA-measurement or IMA-appraisal.  This
>>>>>> would allow us to get the basic IMA namespacing framework working and
>>>>>> defer dealing with the securityfs related namespacing of the IMA
>>>>>> policy and measurement list issues to later.
>>>>>>
>>>>>> By tying IMA namespacing to a securityfs ima/unshare file, we would
>>>>>> need to address the securityfs issues first.
>>>>>>
>>>>> well it depends on what you want to do. It would be possible to have
>>>>> a simple file (not a jump link) within securityfs that IMA could use
>>>>> without having to deal with all the securityfs issues first. However it
>>>>> does require that securityfs (not necessarily imafs) be visible within
>>>>> the mount namespace of the task doing the setup.
>>>> Eric, would you be OK with that?
>>> Roughly.  My understanding is that you have to have a write to some
>>> filesystem to set the ima policy.
>>>
>>> I was expecting having to write an "create ima namespace" value
>>> to the filesystem would not be any special effort.
>>>
>>> Now it sounds like providing the "create an ima namespace" is going to
>>> be a special case, and that does not sound correct.
>>>
>> not necessarily special case, but they do need to settle on an interface
>> that will work for them, and will work with the order they want to land
>> things. I was just trying to point out that there are fs solutions that
>> can work without having deal with the full securityfs/imafs namespacing
>> solution landing first.
>>
>> While create a file directly in securityfs that lives along side the imafs
>> dir.
>> ima_create_ns
>> ima/
>> does feel like a special case. It could work
>>
>> what I was thinking of when I proposed a simple is to do it within the ima
>> dir, say
>> ima/create_ns
> 
> Having looked at SELinux and how Steve does it, I chose 'unshare' as the filename and put it into the neighborhood of  existing IMA securityfs files: /sys/kernel/security/ima/unshare. Write a '1' to it and you'll have an IMA namespace upon the next fork()/clone().
> 
>>
>> For now its just a single file but once imafs becomes "virtualized" to a
>> namespace view, each dir that imafs jumplinks to contains a instance of the
>> file.
> 
> Right. We need to virtualize our IMA securityfs entries pretty soon afterwards so that we can start setting policies in an IMA namespace. At the beginning we would not be able to create nested IMA namespaces if a user namespace is involved. My current patches that attempt to do this basically implement it by getting out of securityfs for namespace support and hooking it onto sysfs. On the host we would still use securityfs.
> 
>>
>>
>> Or they could avoid securityfs/imafs entirely and leverage a file in
>> procfs
> 
> If we want to it that way for all other subsystems that do not use a clone() flag, we should maybe decide on that now...
> 

It sounds like its already decided, with ima and selinux going with an unshare file within their own fs.

AppArmor went a different route already, splitting namespace creation (mkdir in the apparmorfs policy/namespace dir) and the task entering the namespace with a write apparmor's equiv of setexeccon.
