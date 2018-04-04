Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDDXsy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:48:54 -0400
Received: from mail.siteground.com ([67.19.240.234]:36712 "EHLO
        mail.siteground.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeDDXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:48:48 -0400
Subject: Re: [PATCH] uts_namespace: Move boot_id in uts namespace
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <1522408620-10578-1-git-send-email-kernel@kyup.com>
 <87vad7hsdb.fsf@xmission.com>
From: Marian Marinov <kernel@kyup.com>
Openpgp: preference=signencrypt
Organization: Kyup Ltd.
Message-ID: <e6fe4cc7-eed0-fbe2-98af-31c95e35805a@kyup.com>
Date: Thu, 5 Apr 2018 02:43:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87vad7hsdb.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.siteground.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [0 0]
X-AntiAbuse: Sender Address Domain - kyup.com
X-Get-Message-Sender-Via: mail.siteground.com: none
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 07:02 PM, Eric W. Biederman wrote:
> Angel Shtilianov <kernel@kyup.com> writes:
> 
>> Currently the same boot_id is reported for all containers running
>> on a host node, including the host node itself. Even after restarting
>> a container it will still have the same persistent boot_id.
>>
>> This can cause troubles in cases where you have multiple containers
>> from the same cluster on one host node. The software inside each
>> container will get the same boot_id and thus fail to join the cluster,
>> after the first container from the node has already joined.
>>
>> UTS namespace on other hand keeps the machine specific data, so it
>> seems to be the correct place to move the boot_id and instantiate it,
>> so each container will have unique id for its own boot lifetime, if
>> it has its own uts namespace.
> 
> Technically this really needs to use the sysctl infrastructure that
> allows you to register different files in different namespaces.  That
> way the value you read from proc_do_uuid will be based on who opens the
> file not on who is reading the file.

Ok, so would you accept a patch that reimplements boot_id trough the sysctl infrastructure?

> Practically why does a bind mount on top of boot_id work?  What makes
> this a general problem worth solving in the kernel?  Why is hiding the
> fact that you are running the same instance of the same kernel a useful
> thing? That is the reality.

The problem is, that the distros do not know that they are in container and don't know that they have to bind mount something on top of boot_id.
You need to tell Docker, LXC/LXD and all other container runtimes that they need to do this bind mount for boot_id.
I consider this to be a general issue, that lacks good general solution in userspace.
The kernel is providing this boot_id interface, but it is giving wrong data in the context of containers.
Proposing to fix this problem in userspace seams like ignoring the issue.
You could have said to the Consul guys, that they should simply stop using boot_id, because it doesn't work correctly on containers.

Marian

> 
> Eric
> 
> 
> 
> 
>> Signed-off-by: Angel Shtilianov <kernel@kyup.com>
>> ---
>>  drivers/char/random.c   | 4 ++++
>>  include/linux/utsname.h | 1 +
>>  kernel/utsname.c        | 4 +++-
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>> index ec42c8bb9b0d..e05daf7f38f4 100644
>> --- a/drivers/char/random.c
>> +++ b/drivers/char/random.c
>> @@ -1960,6 +1960,10 @@ static int proc_do_uuid(struct ctl_table *table, int write,
>>  	unsigned char buf[64], tmp_uuid[16], *uuid;
>>  
>>  	uuid = table->data;
>> +#ifdef CONFIG_UTS_NS
>> +	if (!!uuid && (uuid == (unsigned char *)sysctl_bootid))
>> +		uuid = current->nsproxy->uts_ns->sysctl_bootid;
>> +#endif
>>  	if (!uuid) {
>>  		uuid = tmp_uuid;
>>  		generate_random_uuid(uuid);
>> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
>> index c8060c2ecd04..f704aca3e95a 100644
>> --- a/include/linux/utsname.h
>> +++ b/include/linux/utsname.h
>> @@ -27,6 +27,7 @@ struct uts_namespace {
>>  	struct user_namespace *user_ns;
>>  	struct ucounts *ucounts;
>>  	struct ns_common ns;
>> +	char sysctl_bootid[16];
>>  } __randomize_layout;
>>  extern struct uts_namespace init_uts_ns;
>>  
>> diff --git a/kernel/utsname.c b/kernel/utsname.c
>> index 913fe4336d2b..f1749cdcd341 100644
>> --- a/kernel/utsname.c
>> +++ b/kernel/utsname.c
>> @@ -34,8 +34,10 @@ static struct uts_namespace *create_uts_ns(void)
>>  	struct uts_namespace *uts_ns;
>>  
>>  	uts_ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
>> -	if (uts_ns)
>> +	if (uts_ns) {
>>  		kref_init(&uts_ns->kref);
>> +		memset(uts_ns->sysctl_bootid, 0, 16);
>> +	}
>>  	return uts_ns;
>>  }
> 


-- 
Marian Marinov
Co-founder & CTO of Kyup.com
Jabber/GTalk: hackman@jabber.org
IRQ: 7556201
IRC: hackman @ irc.freenode.net
Mobile: +359 886 660 270
