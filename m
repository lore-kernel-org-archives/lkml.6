Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525879509; cv=none;
        d=google.com; s=arc-20160816;
        b=t1Bv8MsIbywDw96mXphCMfAmcJ+o/LNmt2PSQYO6nP1bX416ZiWQGQulCspv96P+oC
         FojVLIYws5f6JwN+0g17AsH9zwgM0/XB1KDLjvKC0NFxN5F1uK/P0CyeYl1h0oNp/dLQ
         BOYmJOE5KRUbnhDl64eOHXqbhCiUje3RPe+jRrKI7XMykZkPZslAX8s2YM99SVhztYRx
         yXA4b/N5MWQRXxQOmfGeedrAyJaaeh+/wsF1DGAANGRO2mOErmrK1riBu/3Rf7nPY0oH
         qk1CO/YahbHvS2q0br4zT4EE+yQv2q/AZizYU0YSgP3Ydb2b2dC1woldbqmX70BzDdpk
         p6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=t81sSv7EecYNLlSVnWY7RTWFGhFdNaZwKHs1AEgCM7Y=;
        b=PSqBPKc1xjJJC9O3DJP1KNsubXx5ycXO4tcoYnebCpStF9axW1dM8Up1fFx8ktwgbe
         tQa3R4EVjjtguq9UzB17xa5gCXDOVRVxu7T3fY+IgXTwNNbsYnp0SUdKQg1r4kAZtUn/
         mvQoYS13lneEVJXsamAJA5bHglJgMSGt/iJ7Kvs7kRHYm2ECf45x5Uf893U/3RnSGg2n
         VtBeCF9bedHA+NfqILa+DXBOg/Oe2w3dyeWrooJ5BLlKf5bCO+8wB0MZzDetK34NHG2U
         Pt+Xa+1wEYanAjzpwdyCY3Gnw3wSlL9SjrYGV5rgbAAkECrzcbQAEJ4YDm4uGYBzNN4J
         VgSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=aKkLd0Oc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=aKkLd0Oc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZopm2jSuOgFJLV1tQX4EB5KVV5rtCnGvNdShQ9o8E257uFnYMEO3/4xqI5putSRZKPT8Jm6Cg==
Date: Wed, 9 May 2018 09:25:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
Message-ID: <20180509152505.GA25559@xps15>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0y5toed.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1600000632560427924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 11:59:38PM -0500, Eric W. Biederman wrote:
> Kim Phillips <kim.phillips@arm.com> writes:
> 
> > This patch is in the context of allowing the Coresight h/w
> > trace driver suite to be loaded as modules.  Coresight uses
> > find_task_by_vpid when running in direct capture mode (via sysfs)
> > when getting/setting the context ID comparator to trigger on
> > (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
> 
> Aside from my objection about how bad an interface a pid in sysfs is.
> The implementation of coresight_vpid_to_pid is horrible.
> 
> The code should be just:
> 
> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
> {
> 	rcu_read_lock();
>         pid = pid_nr(find_vpid(vpid));
> 	rcu_read_unlock();
> 
> 	return pid;
> }
> Which takes find_task_by_vpid out of the picture.

Many thanks for pointing out the right way to do this.  When Chunyan added
this feature she broadly published her work and find_task_by_vpid() is the
function she was asked to used.

> 
> But reading further I am seeing code writing a pid to hardware.  That is
> broken.  That is a layering violation of the first order.  Giving
> implementation details like that to hardware.

This is how the feature works - as Robin pointed out tracers are designed to
match pid values with the CPU's contextID register.  The input value has no
other effect than triggering trace collection, which has absolutely no baring on
the CPU.

> 
> Any chance while you are working on this you can modify this code so
> that it does something sensible and defensible instead of every line of
> code I read be wrong in at least one detail?
> 
> Thank you,
> Eric
> 
