Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeDEAg5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:36:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55183 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeDEAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:36:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Marian Marinov <kernel@kyup.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <1522408620-10578-1-git-send-email-kernel@kyup.com>
        <87vad7hsdb.fsf@xmission.com>
        <e6fe4cc7-eed0-fbe2-98af-31c95e35805a@kyup.com>
Date: Wed, 04 Apr 2018 19:35:46 -0500
In-Reply-To: <e6fe4cc7-eed0-fbe2-98af-31c95e35805a@kyup.com> (Marian Marinov's
        message of "Thu, 5 Apr 2018 02:43:00 +0300")
Message-ID: <876056bicd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3sta-0008Ua-5l;;;mid=<876056bicd.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19R/iUiPWB/nJ51aNLE2yc3Qdw3sJsFwRo=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marian Marinov <kernel@kyup.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 339 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (1.0%), b_tie_ro: 2.5 (0.7%), parse: 1.18 (0.3%),
        extract_message_metadata: 17 (5.0%), get_uri_detail_list: 4.2 (1.3%),
        tests_pri_-1000: 9 (2.6%), tests_pri_-950: 1.59 (0.5%), tests_pri_-900: 1.25
        (0.4%), tests_pri_-400: 30 (8.8%), check_bayes: 29 (8.4%), b_tokenize: 11
        (3.3%), b_tok_get_all: 9 (2.6%), b_comp_prob: 3.6 (1.1%), b_tok_touch_all:
        2.8 (0.8%), b_finish: 0.71 (0.2%), tests_pri_0: 264 (77.9%),
        check_dkim_signature: 0.60 (0.2%), check_dkim_adsp: 3.9 (1.1%),
        tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] uts_namespace: Move boot_id in uts namespace
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marian Marinov <kernel@kyup.com> writes:

> On 04/04/2018 07:02 PM, Eric W. Biederman wrote:
>> Angel Shtilianov <kernel@kyup.com> writes:
>> 
>>> Currently the same boot_id is reported for all containers running
>>> on a host node, including the host node itself. Even after restarting
>>> a container it will still have the same persistent boot_id.
>>>
>>> This can cause troubles in cases where you have multiple containers
>>> from the same cluster on one host node. The software inside each
>>> container will get the same boot_id and thus fail to join the cluster,
>>> after the first container from the node has already joined.
>>>
>>> UTS namespace on other hand keeps the machine specific data, so it
>>> seems to be the correct place to move the boot_id and instantiate it,
>>> so each container will have unique id for its own boot lifetime, if
>>> it has its own uts namespace.
>> 
>> Technically this really needs to use the sysctl infrastructure that
>> allows you to register different files in different namespaces.  That
>> way the value you read from proc_do_uuid will be based on who opens the
>> file not on who is reading the file.
>
> Ok, so would you accept a patch that reimplements boot_id trough the sysctl infrastructure?

Assuming I am convinced this makes sense to do on the semantic level.

>> Practically why does a bind mount on top of boot_id work?  What makes
>> this a general problem worth solving in the kernel?  Why is hiding the
>> fact that you are running the same instance of the same kernel a useful
>> thing? That is the reality.
>
> The problem is, that the distros do not know that they are in
> container and don't know that they have to bind mount something on top
> of boot_id.  You need to tell Docker, LXC/LXD and all other container
> runtimes that they need to do this bind mount for boot_id.

Yes.  Anything like this is the responsibility of the container runtime
one way or another.   Magic to get around fixing the small set of
container runtimes you care about is a questionable activity.

> I consider this to be a general issue, that lacks good general
> solution in userspace.  The kernel is providing this boot_id
> interface, but it is giving wrong data in the context of containers.

I disagree.  Namespaces have never been about hiding that you are on a
given machine or a single machine.  They are about encapsulating global
identifers so that process migration can happen, and so that processes
can be better isolated.  The boot_id is not an identify of an object in
the kernel at all, and it is designed to be trully globally unique
across time and space so I am not at all certain that it makes the least
bit of sense to do anything with a boot_id.


That said my memory of boot_id is that was added so that emacs (and
related programs) could create lock files on nfs and could tell if the
current machine owns the file, and if so be able to tell if the owner
of the lock file is alive.

So there is an argument to be made that boot_id is to coarse.  That
argument suggest that boot_id is a pid_namespace property.

I have not looked at the users of boot_id, and I don't have a definition
of boot_id that makes me think it is too coarse.

If you can provide a clear description of what the semantics are and
what they should be for boot_id showing how boot_id fits into a
namespace, making it clear what should happen with checkpoint/restart.
We can definitely look at changing how the kernel supports boot_id.

The reason I suggested the bind mount is there are lots of cases where
people want to lie to applications about the reality of what is going on
for whatever reason, and we leave those lies to userspace.  Things
like changing the contents of /proc/cpuinfo.

> Proposing to fix this problem in userspace seams like ignoring the
> issue.  You could have said to the Consul guys, that they should
> simply stop using boot_id, because it doesn't work correctly on
> containers.

I don't know the Consul guys.   From a quick google search I see that
Consul is an open source project that is aims to be distributed and
highly available.  It seems a reasonable case to look at to motivate
changes to boot_id.

That said if I want to be highly available I would find every node
having the same boot_id to be very worrying, and very useful.  It allows
detecting if no hardware redundancy is present in a situation.  That
certainly seems like a good thing.

If you just want to test Consul then hacking boot_id with a bind mount
seems the right thing.  If you really want to run Consul in production
I am curious to know how removing the ability to detect if you are on
the same kernel as another piece of Consul is a good thing.

Eric
