Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDEBXF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 21:23:05 -0400
Received: from mail.siteground.com ([67.19.240.234]:38495 "EHLO
        mail.siteground.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeDEBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 21:23:04 -0400
Subject: Re: [PATCH] uts_namespace: Move boot_id in uts namespace
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <1522408620-10578-1-git-send-email-kernel@kyup.com>
 <87vad7hsdb.fsf@xmission.com> <e6fe4cc7-eed0-fbe2-98af-31c95e35805a@kyup.com>
 <876056bicd.fsf@xmission.com>
From: Marian Marinov <kernel@kyup.com>
Openpgp: preference=signencrypt
Organization: Kyup Ltd.
Message-ID: <49d8b5b1-6f10-d9d8-9778-eb71556bc98d@kyup.com>
Date: Thu, 5 Apr 2018 04:23:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <876056bicd.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.siteground.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kyup.com
X-Get-Message-Sender-Via: mail.siteground.com: none
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 03:35 AM, Eric W. Biederman wrote:
> Marian Marinov <kernel@kyup.com> writes:
> 
>> On 04/04/2018 07:02 PM, Eric W. Biederman wrote:
>>> Angel Shtilianov <kernel@kyup.com> writes:
>>>
>>>> Currently the same boot_id is reported for all containers running
>>>> on a host node, including the host node itself. Even after restarting
>>>> a container it will still have the same persistent boot_id.
>>>>
>>>> This can cause troubles in cases where you have multiple containers
>>>> from the same cluster on one host node. The software inside each
>>>> container will get the same boot_id and thus fail to join the cluster,
>>>> after the first container from the node has already joined.
>>>>
>>>> UTS namespace on other hand keeps the machine specific data, so it
>>>> seems to be the correct place to move the boot_id and instantiate it,
>>>> so each container will have unique id for its own boot lifetime, if
>>>> it has its own uts namespace.
>>>
>>> Technically this really needs to use the sysctl infrastructure that
>>> allows you to register different files in different namespaces.  That
>>> way the value you read from proc_do_uuid will be based on who opens the
>>> file not on who is reading the file.
>>
>> Ok, so would you accept a patch that reimplements boot_id trough the sysctl infrastructure?
> 
> Assuming I am convinced this makes sense to do on the semantic level.
> 
>>> Practically why does a bind mount on top of boot_id work?  What makes
>>> this a general problem worth solving in the kernel?  Why is hiding the
>>> fact that you are running the same instance of the same kernel a useful
>>> thing? That is the reality.
>>
>> The problem is, that the distros do not know that they are in
>> container and don't know that they have to bind mount something on top
>> of boot_id.  You need to tell Docker, LXC/LXD and all other container
>> runtimes that they need to do this bind mount for boot_id.
> 
> Yes.  Anything like this is the responsibility of the container runtime
> one way or another.   Magic to get around fixing the small set of
> container runtimes you care about is a questionable activity.
> 
>> I consider this to be a general issue, that lacks good general
>> solution in userspace.  The kernel is providing this boot_id
>> interface, but it is giving wrong data in the context of containers.
> 
> I disagree.  Namespaces have never been about hiding that you are on a
> given machine or a single machine.  They are about encapsulating global
> identifers so that process migration can happen, and so that processes
> can be better isolated.  The boot_id is not an identify of an object in
> the kernel at all, and it is designed to be trully globally unique
> across time and space so I am not at all certain that it makes the least
> bit of sense to do anything with a boot_id.
> 
> 
> That said my memory of boot_id is that was added so that emacs (and
> related programs) could create lock files on nfs and could tell if the
> current machine owns the file, and if so be able to tell if the owner
> of the lock file is alive.
> 
> So there is an argument to be made that boot_id is to coarse.  That
> argument suggest that boot_id is a pid_namespace property.
> 
> I have not looked at the users of boot_id, and I don't have a definition
> of boot_id that makes me think it is too coarse.
> 
> If you can provide a clear description of what the semantics are and
> what they should be for boot_id showing how boot_id fits into a
> namespace, making it clear what should happen with checkpoint/restart.
> We can definitely look at changing how the kernel supports boot_id.
> 
> The reason I suggested the bind mount is there are lots of cases where
> people want to lie to applications about the reality of what is going on
> for whatever reason, and we leave those lies to userspace.  Things
> like changing the contents of /proc/cpuinfo.

Even thou previously we have sent patches that are supposed to lie to the software running inside a container, this one is not of this sort.

You are pointing to Emacs and I'm talking about Consul https://www.consul.io/
Systemd is also using boot_id. "journalctl --list-boots" actually uses the boot_id to distinguish between different boots.

  -2 caf0524a1d394ce0bdbcff75b94444fe Tue 2015-02-03 21:48:52 UTC—Tue 2015-02-03 22:17:00 UTC
  -1 13883d180dc0420db0abcb5fa26d6198 Tue 2015-02-03 22:17:03 UTC—Tue 2015-02-03 22:19:08 UTC
   0 bed718b17a73415fade0e4e7f4bea609 Tue 2015-02-03 22:19:12 UTC—Tue 2015-02-03 23:01:01 UTC

There may be a lot of other software, that we don't know about, that is using boot_id as a good mechanism to distinguish uniqueness of machines.

In case of consul, it uses the boot_id as a unique ID for the node.
On our systems, we have multiple containers residing on the same host node, that may be part of the same Consul setup.
One option would be to tell each customer that installs consul, to setup bind mounts for the boot_id. However for the customer, finding out that boot_id is the actual problem, is non-trivial task.
And also if the user is using systemd, setting up bind mount after the container has started is partly useless, since the log already has the wrong boot_id.

Another option would be to generate unique ID before starting each container and bind mounting that on top of boot_id, during the boot of each container.
But this means that each runtime should know that it has to do that, or at least the admin should be aware that such a problem may exists.

Fixing this inside the kernel, at least how I see it, is a trivial job. I don't understand why the kernel would not cooperate with the userspace.

I really don't care if it is inside the pid or the uts namespace, as long as it is per-namespace.



> 
>> Proposing to fix this problem in userspace seams like ignoring the
>> issue.  You could have said to the Consul guys, that they should
>> simply stop using boot_id, because it doesn't work correctly on
>> containers.
> 
> I don't know the Consul guys.   From a quick google search I see that
> Consul is an open source project that is aims to be distributed and
> highly available.  It seems a reasonable case to look at to motivate
> changes to boot_id.
> 
> That said if I want to be highly available I would find every node
> having the same boot_id to be very worrying, and very useful.  It allows
> detecting if no hardware redundancy is present in a situation.  That
> certainly seems like a good thing.
> 
> If you just want to test Consul then hacking boot_id with a bind mount
> seems the right thing.  If you really want to run Consul in production
> I am curious to know how removing the ability to detect if you are on
> the same kernel as another piece of Consul is a good thing.
> 
> Eric
> 


-- 
Marian Marinov
Co-founder & CTO of Kyup.com
Jabber/GTalk: hackman@jabber.org
IRQ: 7556201
IRC: hackman @ irc.freenode.net
Mobile: +359 886 660 270
