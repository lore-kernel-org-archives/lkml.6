Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4+pIBW4ZNYgLhCCPflUwdQwR7u1R9Q8Z/SMzRmdkTo1bf3vNMlVHxCNqDFIIVhb+VrFscbV
ARC-Seal: i=1; a=rsa-sha256; t=1524232591; cv=none;
        d=google.com; s=arc-20160816;
        b=lF1gIwT2Z8V/UTlAqzTlwZYlyqVc2qr5eWNT/q/EOG/5fSB2Z0u3G97CQkFpSTVzjf
         dqrRxapLp2EWDDbOt7GQjCaW2IDF9Q5POzMzghAlh8FX0XKD8WUAP0ze8XpMe8wtSii/
         o2BGgk+ZdXD9wcaTkaX9nTbmbao47rT/TqSX/leuoVl2QoDtrJxQ1RmHi7EHIGU8AWtQ
         xOC5pWBEhGTeLN7Fo73M5079+aNlxod1UhYdEDxk95VNhC4E89b4U1zyeXU/HawPXVdy
         lLWRKprzjicpQQkF5EKjNjrKhifV2HFdeZ93Mc6S9mQy3//yE7InyRkV2MF3z33YQkC7
         sudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:date:from:arc-authentication-results;
        bh=bmzOUM5MwNM00WZ0dzT1Z+4ANyOdQzJANb5E1RVXwws=;
        b=kidEPhiKGKzthuD31tpB2unIGsHCWG3HUJLzMwZ9Z5T3dix1Kua+/taD3OpCHKGBdi
         gTJwN2ZMuIVOTt7J2rNe98STbi4JUWt0V52N6oT4dVC6kSlLzyw2XZJJ6XQiWBlQLDaL
         h3UysUwAvdr3o7CjPTGtBdnLUiMHI/TM83b3seVFrqVdw0IrsBzIveLHb9NmYcl4VlOa
         5VJ8h4e3lTQSsF65vB/pYbq+MQq5kBLVmX1FVWjDS90O9ALDjQ2q13ixgblkt44a1j/6
         tn5MRHcHKT5Z5217RlMQCehbFJb7M3ze2SjxPv1pVj422cRUL1RHvi1AaXpQgeGJV1BQ
         Pz9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 20 Apr 2018 15:56:28 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns
 locks
Message-ID: <20180420135627.GA8350@gmail.com>
References: <20180418152106.18519-1-christian.brauner@ubuntu.com>
 <20180418152106.18519-3-christian.brauner@ubuntu.com>
 <874lk8wj1j.fsf@xmission.com>
 <20180418215246.GA24000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418215246.GA24000@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598273713252551471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 11:52:47PM +0200, Christian Brauner wrote:
> On Wed, Apr 18, 2018 at 11:55:52AM -0500, Eric W. Biederman wrote:
> > Christian Brauner <christian.brauner@ubuntu.com> writes:
> > 
> > > Now that it's possible to have a different set of uevents in different
> > > network namespaces, per-network namespace uevent sequence numbers are
> > > introduced. This increases performance as locking is now restricted to the
> > > network namespace affected by the uevent rather than locking
> > > everything.
> > 
> > Numbers please.  I personally expect that the netlink mc_list issues
> > will swamp any benefit you get from this.
> 
> I wouldn't see how this would be the case. The gist of this is:
> Everytime you send a uevent into a network namespace *not* owned by
> init_user_ns you currently *have* to take mutex_lock(uevent_sock_list)
> effectively blocking the host from processing uevents even though
> - the uevent you're receiving might be totally different from the
>   uevent that you're sending
> - the uevent socket of the non-init_user_ns owned network namespace
>   isn't even recorded in the list.
> 
> The other argument is that we now have properly isolated network
> namespaces wrt to uevents such that each netns can have its own set of
> uevents. This can either happen by a sufficiently privileged userspace
> process sending it uevents that are only dedicated to that specific
> netns. Or - and this *has been true for a long time* - because network
> devices are *properly namespaced*. Meaning a uevent for that network
> device is *tied to a network namespace*. For both cases the uevent
> sequence numbering will be absolutely misleading. For example, whenever
> you create e.g. a new veth device in a new network namespace it
> shouldn't be accounted against the initial network namespace but *only*
> against the network namespace that has that device added to it.

Eric, I did the testing. Here's what I did:

I compiled two 4.17-rc1 Kernels:
- one with per netns uevent seqnums with decoupled locking
- one without per netns uevent seqnums with decoupled locking

# Testcase 1:
Only Injecting Uevents into network namespaces not owned by the initial user
namespace.
- created 1000 new user namespace + network namespace pairs
- opened a uevent listener in each of those namespace pairs
- injected uevents into each of those network namespaces 10,000 times meaning
  10,000,000 (10 million) uevents were injected. (The high number of
  uevent injections should get rid of a lot of jitter.)
- Calculated the mean transaction time.
- *without* uevent sequence number namespacing:
  67 μs
- *with* uevent sequence number namespacing:
  55 μs
- makes a difference of 12 μs

# Testcase 2:
Injecting Uevents into network namespaces not owned by the initial user
namespace and network namespaces owned by the initial user namespace.
- created 500 new user namespace + network namespace pairs
- created 500 new network namespace pairs
- opened a uevent listener in each of those namespace pairs
- injected uevents into each of those network namespaces 10,000 times meaning
  10,000,000 (10 million) uevents were injected. (The high number of
  uevent injections should get rid of a lot of jitter.)
- Calculated the mean transaction time.
- *without* uevent sequence number namespacing:
  572 μs
- *with* uevent sequence number namespacing:
  514 μs
- makes a difference of 58 μs

So there's performance gain. The third case would be to create a bunch
of hanging processes that send SIGSTOP to themselves but do not actually
open a uevent socket in their respective namespaces and then inject
uevents into them. I expect there to be an even more performance
benefits since the rtnl_table_lock() isn't hit in this case because
there are no listeners.

Christian
