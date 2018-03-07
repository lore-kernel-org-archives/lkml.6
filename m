Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeCGRfj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:35:39 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:28245 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933642AbeCGRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:35:34 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515456000";
   d="scan'208";a="80800534"
Date: Wed, 7 Mar 2018 09:26:00 -0800 (PST)
From: Victor Kamensky <kamensky@cisco.com>
To: Rob Landley <rob@landley.net>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Taras Kondratiuk <takondra@cisco.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v3 15/15] selinux: delay sid population for rootfs till
 init is complete
In-Reply-To: <d23913a5-2a18-4d2a-60ae-bfa1ba8aaa0c@landley.net>
Message-ID: <alpine.LRH.2.00.1803070855550.64437@sjc-ads-6991.cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com> <1518813234-5874-19-git-send-email-takondra@cisco.com> <1519152994.14218.15.camel@tycho.nsa.gov> <d23913a5-2a18-4d2a-60ae-bfa1ba8aaa0c@landley.net>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2018, Rob Landley wrote:

> On 02/20/2018 12:56 PM, Stephen Smalley wrote:
>> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>>> From: Victor Kamensky <kamensky@cisco.com>
>>>
>>> With initramfs cpio format that supports extended attributes
>>> we need to skip sid population on sys_lsetxattr call from
>>> initramfs for rootfs if security server is not initialized yet.
>>>
>>> Otherwise callback in selinux_inode_post_setxattr will try to
>>> translate give security.selinux label into sid context and since
>>> security server is not available yet inode will receive default
>>> sid (typically kernel_t). Note that in the same time proper
>>> label will be stored in inode xattrs. Later, since inode sid
>>> would be already populated system will never look back at
>>> actual xattrs. But if we skip sid population for rootfs and
>>> we have policy that direct use of xattrs for rootfs, proper
>>> sid will be filled in from extended attributes one node is
>>> accessed and server is initialized.
>>>
>>> Note new DELAYAFTERINIT_MNT super block flag is introduced
>>> to only mark rootfs for such behavior. For other types of
>>> tmpfs original logic is still used.
>>
>> (cc selinux maintainers)
>>
>> Wondering if we shouldn't just do this always, for all filesystem
>> types.  Also, I think this should likely also be done in
>> selinux_inode_setsecurity() for consistency.

Sorry, I did not have time to try out Stephen's suggestion,
especially given that core initramfs xattrs acceptance and dicussion
looks a bit stalled, and for my use case it is dependency before
SELinux changes.

I will look for both suggestion this week. Hope to see initramfs
xattrs patch series review going again.

> I don't understand what selinux thinks it's doing here.
>
> Initramfs is special because it's populated early, ideally early enough drivers
> can load their firmware out of it. This is guaranteed to be before any processes
> have launched, before any other filesystems have been mounted. I'm surprised
> selinux is trying to do anything this early because A) what is there for it to
> do, B) where did it get a ruleset?
>
> This isn't really a mount flag, this is a "the selinux subsystem isn't
> functionally initialized yet" flag. We haven't launched init. In a modular
> system the module probably isn't loaded. There are no processes, and the only
> files anywhere are the ones we're in the process of extracting. What's there
> fore selinux to do?
>
> When a filesystem is mounted, none of these cached selinux "we already looked at
> the xattrs" inode fields are populated yet, correct? It can figure that out when
> something accesses the file and do it then, so the point is _not_ doing this now
> and thus not cacheing the wrong info. That's what the mount flag is doing,
> telling selinux "not yet". So why does selinux not already _know_ "not yet"?
>
> Why doesn't load_policy flush the cache of the old default contexts? What
> happens if you mount an ext2 root and then init reads a dozen files before it
> gets to the load_policy?

I need to check whether security context caching happens on all
file operations, or when setxattr is executed. If latter, 
setxattr operation before policy load may not be very common use case.

Also note there is a second SELinux related patch and 
corresponding Stephen's comment: if SELinux is enabled
in kernel, but policy is not loaded yet, setxattr for security.selinux
extended attribute will go for check to SELinux LSM callback, it will
be denied. My other patch was relaxing above for "rootfs" only,
i.e covering initramfs xattrs case. Stephen's point was that
maybe it needs to be relaxed for
all cases if policy not loaded yet. I need some time to look
at the code and think about what can go wrong, if rule relaxed
for all cases.

> Do those doesn't files have bad default contexts forever now?
>
> Where does the selinux ruleset come from during the cpio extract?

Yes, in our use case SELinux policy file 
(/etc/selinux/*/policy/policy.*) comes from cpio initramfs itself.
So it is chicken and egg problem.

> Was it
> hardwired into the driver? It certainly didn't come out of a file, and it wasn't
> a process that loaded it. Why is selinux trying to evaluate and cache the
> security context of files before it has any rules?

Note for ext2 case there is no setxattr first as we have in initramfs
xattrs case, so extended attributes values are read from backing
persitent storage as they were put there before, and there would not
be discrepency what is cached in security context inode data scructure
and real "security.selinux" extended attribute value in file system.

Thanks,
Victor

> (It has xattr annotations,
> but they have no _meaning_ without rules...?
>
> Confused,
>
> Rob
>
