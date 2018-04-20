Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZrOJNLvVa7nPY8vqvjsV0TlXXaWXj1ms8QfJwkIN0329FRfVJlXyKYlOPAu86w2Eoi84e0l
ARC-Seal: i=1; a=rsa-sha256; t=1524241006; cv=none;
        d=google.com; s=arc-20160816;
        b=j1XDc/wcKOd34nsb0FL5m8lkgOADnRMc2xkgHf4Jl4yAddTfL0BkrmMbhb03hY5pLp
         expcrTfM06335awnfFMvju6F6IfSmwaTja9I3CPuCLHhH+rrEPRU/5Arh/4yk2g6ZEJ6
         81VBSS/35O0lOGT2e48eFLFqmrmGOOg72X4KB1t2jpW/isLwksQqssCD/7uAb2fkkG0r
         NuiqTpNP1mIV89+Xly1V8dQvJK0ABRoxGxJLkcu8AAXQ3i6YiX9Evrf0QNUF/j4hA6yS
         G1RalN4NDgg2TxbQDhg09y0hyfW+ut1HNirRYoAMPI/Gyheh1p01sPPiplKq2cHZ7Tzm
         fa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:date:from:arc-authentication-results;
        bh=OlZh0QmuXePFahTwnZriE4pjZTguQxsjKOScuSMwCL0=;
        b=XQGor5ST03gt3u4gzRKlnCuENzrVmvEoT4EnjDP6fSQknd3Moz/hInsN7NbhjZAxJa
         Cqo891d+nDKt03HDRnCcs5HeZNrJa4xv3Gydr0GYd2atsZqChrpX9UmYS1vkoU2yc0fu
         YKJenIIUws8mVOE4NrUm7x30eYiwpvR1cIwVtH/m0fzQ/zgNG16eM/7vR1oNTVNRhzLd
         3T1f85XsNyZ6tnYO/2GvYE3oWGq/oKw4miHHraXKDo6ANkFUXmXYZemI/9PYCDrfp0zP
         mMPcMNEchc2IIzclNwXdPiaPRE7GG6eDnaDbYuIVX786TF56m0h5wrW+7vWy2qCtIU6r
         nD/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 20 Apr 2018 18:16:44 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns
 locks
Message-ID: <20180420161643.GA15182@gmail.com>
References: <20180418152106.18519-1-christian.brauner@ubuntu.com>
 <20180418152106.18519-3-christian.brauner@ubuntu.com>
 <874lk8wj1j.fsf@xmission.com>
 <20180418215246.GA24000@gmail.com>
 <20180420135627.GA8350@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420135627.GA8350@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598282537851661151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:56:28PM +0200, Christian Brauner wrote:
> On Wed, Apr 18, 2018 at 11:52:47PM +0200, Christian Brauner wrote:
> > On Wed, Apr 18, 2018 at 11:55:52AM -0500, Eric W. Biederman wrote:
> > > Christian Brauner <christian.brauner@ubuntu.com> writes:
> > > 
> > > > Now that it's possible to have a different set of uevents in different
> > > > network namespaces, per-network namespace uevent sequence numbers are
> > > > introduced. This increases performance as locking is now restricted to the
> > > > network namespace affected by the uevent rather than locking
> > > > everything.
> > > 
> > > Numbers please.  I personally expect that the netlink mc_list issues
> > > will swamp any benefit you get from this.
> > 
> > I wouldn't see how this would be the case. The gist of this is:
> > Everytime you send a uevent into a network namespace *not* owned by
> > init_user_ns you currently *have* to take mutex_lock(uevent_sock_list)
> > effectively blocking the host from processing uevents even though
> > - the uevent you're receiving might be totally different from the
> >   uevent that you're sending
> > - the uevent socket of the non-init_user_ns owned network namespace
> >   isn't even recorded in the list.
> > 
> > The other argument is that we now have properly isolated network
> > namespaces wrt to uevents such that each netns can have its own set of
> > uevents. This can either happen by a sufficiently privileged userspace
> > process sending it uevents that are only dedicated to that specific
> > netns. Or - and this *has been true for a long time* - because network
> > devices are *properly namespaced*. Meaning a uevent for that network
> > device is *tied to a network namespace*. For both cases the uevent
> > sequence numbering will be absolutely misleading. For example, whenever
> > you create e.g. a new veth device in a new network namespace it
> > shouldn't be accounted against the initial network namespace but *only*
> > against the network namespace that has that device added to it.
> 
> Eric, I did the testing. Here's what I did:
> 
> I compiled two 4.17-rc1 Kernels:
> - one with per netns uevent seqnums with decoupled locking
> - one without per netns uevent seqnums with decoupled locking
> 
> # Testcase 1:
> Only Injecting Uevents into network namespaces not owned by the initial user
> namespace.
> - created 1000 new user namespace + network namespace pairs
> - opened a uevent listener in each of those namespace pairs
> - injected uevents into each of those network namespaces 10,000 times meaning
>   10,000,000 (10 million) uevents were injected. (The high number of
>   uevent injections should get rid of a lot of jitter.)
> - Calculated the mean transaction time.
> - *without* uevent sequence number namespacing:
>   67 μs
> - *with* uevent sequence number namespacing:
>   55 μs
> - makes a difference of 12 μs
> 
> # Testcase 2:
> Injecting Uevents into network namespaces not owned by the initial user
> namespace and network namespaces owned by the initial user namespace.
> - created 500 new user namespace + network namespace pairs
> - created 500 new network namespace pairs
> - opened a uevent listener in each of those namespace pairs
> - injected uevents into each of those network namespaces 10,000 times meaning
>   10,000,000 (10 million) uevents were injected. (The high number of
>   uevent injections should get rid of a lot of jitter.)
> - Calculated the mean transaction time.
> - *without* uevent sequence number namespacing:
>   572 μs
> - *with* uevent sequence number namespacing:
>   514 μs
> - makes a difference of 58 μs
> 
> So there's performance gain. The third case would be to create a bunch
> of hanging processes that send SIGSTOP to themselves but do not actually
> open a uevent socket in their respective namespaces and then inject
> uevents into them. I expect there to be an even more performance
> benefits since the rtnl_table_lock() isn't hit in this case because
> there are no listeners.

I did the third test-case as well so:
- created 500 new user namespace + network namespace pairs *without
  uevent listeners*
- created 500 new network namespace pairs *without uevent listeners*
- injected uevents into each of those network namespaces 10,000 times meaning
  10,000,000 (10 million) uevents were injected. (The high number of
  uevent injections should get rid of a lot of jitter.)
- Calculated the mean transaction time.
- *without* uevent sequence number namespacing:
  206 μs
- *with* uevent sequence number namespacing:
  163 μs
- makes a difference of 43 μs

So this test-case shows performance improvement as well.

Thanks!
Christian
