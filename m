Return-Path: <kernel-hardening-return-11893-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226sKrjTgFzo6em1KvVYWH4j6DsVNKXSp23um2fyZd5xUSUJ2yUJFyjK2pomI+p8XSK5UffT
ARC-Seal: i=1; a=rsa-sha256; t=1519293285; cv=none;
        d=google.com; s=arc-20160816;
        b=iijfGf0IxZeZdy46Q+cdunaVMXRctSlY1kpeUWFj8FoI3Cyk2EuSLKARklKbHewjLD
         tEeUfBUaKL09CG8wkzcegdMD5Qt92JXq05DOhDdrRTKwgbE9WFkBO42nRXA/QXLv0Aph
         AFzAIWuADKYHBWEwKEx1OS/DYOq15luuVYI6xGgVEct5SEQo9kB+TZe86J3mfUWrYpMV
         nNo7K0MwgSD6NIyhKUkYcWyLsNZD/gs99L3IJRPdG4whnixSLxVFahkj0VYYHB5Z5wWN
         9KvW6L/KAPyt1cD17th0N/5zYbAcq5U1vUKtkloHFKF6ath2+EKvELn/v4r/nk/7nixG
         vYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Dfr2DnraVs5spxIyQw/auCmYIvGHu5s/AesMN90txYA=;
        b=W+kBFAX3jf4a3Cw2/pMq0WBvzLFp/21jfOc2Hsf70lT/GTEEmprAq0TZ/SY38wLMlY
         dQYSdYXFva5ks/kET5XaYtCuwn83aj/AvKtV8Qm3uqL/6WLq9D5KG7INzRDpxr8FE9MA
         IjSppJNb6mOpigIe03RKDwiwirUO8iU2MchiWr9chwzl7jU20clFf8Q9p29QA2RUT2MH
         4be7VX3tGSqswUbYFhWFHSj8+1WqbU576p1UF40XaK4oPC4fsP+qPD1S7FQIPHLm+D9i
         MX9DLGsqj/2WkO5vBuTyFqgBBbtYpgYgvCWnPXyWxiielfQZChJZQJ2hhtLjIv2o+2gM
         M85g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11893-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11893-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11893-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11893-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 22 Feb 2018 09:53:03 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@kernel.org>,
	Laura Abbott <labbott@redhat.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] fork: Unconditionally clear stack on fork
Message-ID: <20180222095303.jeepikc5qlbjsal7@techsingularity.net>
References: <20180221021659.GA37073@beast>
 <20180221102933.GD2231@dhcp22.suse.cz>
 <20180221125914.dc95830eada5fb958c13e36b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180221125914.dc95830eada5fb958c13e36b@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592975104699087561?=
X-GMAIL-MSGID: =?utf-8?q?1593094476543269043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 12:59:14PM -0800, Andrew Morton wrote:
> On Wed, 21 Feb 2018 11:29:33 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Tue 20-02-18 18:16:59, Kees Cook wrote:
> > > One of the classes of kernel stack content leaks[1] is exposing the
> > > contents of prior heap or stack contents when a new process stack is
> > > allocated. Normally, those stacks are not zeroed, and the old contents
> > > remain in place. In the face of stack content exposure flaws, those
> > > contents can leak to userspace.
> > > 
> > > Fixing this will make the kernel no longer vulnerable to these flaws,
> > > as the stack will be wiped each time a stack is assigned to a new
> > > process. There's not a meaningful change in runtime performance; it
> > > almost looks like it provides a benefit.
> > > 
> > > Performing back-to-back kernel builds before:
> > > 	Run times: 157.86 157.09 158.90 160.94 160.80
> > > 	Mean: 159.12
> > > 	Std Dev: 1.54
> > > 
> > > and after:
> > > 	Run times: 159.31 157.34 156.71 158.15 160.81
> > > 	Mean: 158.46
> > > 	Std Dev: 1.46
> > 
> > /bin/true or similar would be more representative for the worst case
> > but it is good to see that this doesn't have any visible effect on
> > a more real usecase.
> 
> Yes, that's a pretty large memset.  And while it will populate the CPU
> cache with the stack contents, doing so will evict other things.
> 

The lines will also bounce on the child. I expect the zeroing will be a
relatively small percentage of the overall cost. The cost is all elsewhere
such as the the full search that fork does for queueing a task on a CPU
for the first time. Using perf will mask the issue unless the performance
governor is used in this case. Otherwise you hit the weird corner case
whereby perf itself increases CPU utilisation and the cpufreq governor
(even if it's HWP or another hardware-based scheme) will increase the
p-state and it'll appear to run faster.

> So some quite careful quantitative testing is needed here, methinks.

With an emphasis on careful.

-- 
Mel Gorman
SUSE Labs
