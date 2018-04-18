Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4+puAP3edj1pCOS4vIuigQ8H9jqFxNIVHBZ4Onc+tp0Q7esuiWX71EJvNluDG9vScsCDNBM
ARC-Seal: i=1; a=rsa-sha256; t=1524088370; cv=none;
        d=google.com; s=arc-20160816;
        b=Wqy9rhgDXHhu60dhkXj72N5RGGiauL+BFZ+jMLXd7Oiu0w4aRj1ieYFOVwsf6y3pmt
         k6neyPcRQtiN+yEgxKFd3iGC/VNA4oVia0dNjyT6dnJ6zJIWeZMvGsST3o7O69Be+s4N
         l/7ZNOJoS6aBQnojs9C6Jrd2dUQhmKKqpSBKyKJRNAG29xgNonmcL+xi4VvkhxYf81Ia
         4UwBoG2Jucx3TDnFaT0+TovNeh5zqi9NNiCSnXIiVqTIZmnApk0lUTq8gRBbaJW/VIFA
         LC2wwJYMPVHgtjkgxt+kjroAS3ryI1W3ArZgNbQaeHLPIw6tfbQdoC/9j7AcyKwzta22
         mLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=+eEclzzJtwMtkKcvqJkBHpSBaTR5cbgt2cDjLpchEpw=;
        b=hzKhGg2RgGnYpmETsN4oTsAXeLZHNzsu+Vi2qGCAHb8Qjhh17FJT1JlftGPWx16L6F
         TmAvCA9vP978lTFCZDWamcWuOLdN4MRPkQT2PGp4dfTQ1tn11uuOtpOFuqsJra3BwQ4s
         zDBtkczK9U8gK+WhMEdYpt9ej6Ve2nqrIRhoTscre+B0OHAvblMMipKpW1JTXj7wWMS1
         JJFU5i3tKZZNLnrMIR4q2HRRzlRkZMjJcChTimNlHhnEKT/oVSUEJlLmIthvDoc3qWyM
         Dtq2rTpFY9fjtO5KcUeMIWKDLlkJKh1yX8w3t7bI29bC3buIzVcnLhLYjUufqTSGKKr+
         a5UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 18 Apr 2018 23:52:47 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2] netns: isolate seqnums to use per-netns
 locks
Message-ID: <20180418215246.GA24000@gmail.com>
References: <20180418152106.18519-1-christian.brauner@ubuntu.com>
 <20180418152106.18519-3-christian.brauner@ubuntu.com>
 <874lk8wj1j.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lk8wj1j.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598097857058546891?=
X-GMAIL-MSGID: =?utf-8?q?1598122486316941211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 11:55:52AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > Now that it's possible to have a different set of uevents in different
> > network namespaces, per-network namespace uevent sequence numbers are
> > introduced. This increases performance as locking is now restricted to the
> > network namespace affected by the uevent rather than locking
> > everything.
> 
> Numbers please.  I personally expect that the netlink mc_list issues
> will swamp any benefit you get from this.

I wouldn't see how this would be the case. The gist of this is:
Everytime you send a uevent into a network namespace *not* owned by
init_user_ns you currently *have* to take mutex_lock(uevent_sock_list)
effectively blocking the host from processing uevents even though
- the uevent you're receiving might be totally different from the
  uevent that you're sending
- the uevent socket of the non-init_user_ns owned network namespace
  isn't even recorded in the list.

The other argument is that we now have properly isolated network
namespaces wrt to uevents such that each netns can have its own set of
uevents. This can either happen by a sufficiently privileged userspace
process sending it uevents that are only dedicated to that specific
netns. Or - and this *has been true for a long time* - because network
devices are *properly namespaced*. Meaning a uevent for that network
device is *tied to a network namespace*. For both cases the uevent
sequence numbering will be absolutely misleading. For example, whenever
you create e.g. a new veth device in a new network namespace it
shouldn't be accounted against the initial network namespace but *only*
against the network namespace that has that device added to it.

Thanks!
Christian
