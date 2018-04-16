Return-Path: <jikos@kernel.org>
X-Google-Smtp-Source: AIpwx4/qdV7Ho4E0Q6OBSVzqS2tfvmxSqYbr8bhwsoUzuWLeaXvxG4mhnu7Jhg+wopUBYAeNPig2
ARC-Seal: i=1; a=rsa-sha256; t=1523910854; cv=none;
        d=google.com; s=arc-20160816;
        b=KxnFGJ+UyovYjRpMT8EN3jHZfTGWLOSR6bdzpKEqBK23TsTYLoZVBYiFNVAiShwd17
         ROWD+cyAc5EyGUttiemGs+t9Up5qi9NM1ntlSkJ4ceNk9dPav7vC+uAOxmUS/E1zTFxm
         iKtA28rzkaBn7Bc+7dsF4hrVPCKlK/oQIvpdw6RUg0T0lTdOL8Q6xa0zOeaBq5RLvpJR
         3BN9Eu6WyyVG0fGf4vpkVfC8nqEpsDo4FrXupQDoSbzm0QM8NC69TEBPYL5zng+hqDig
         3sKpVqKtTWGN8o4BSB7Ej/ljHfmKY26BTDzLdj93yHJgOanKqSFPXTYj2z0Q3mBG1xdq
         N+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=1DUiZFIl0FjE/adFFqiEjLGhAGVhPyWieqmSodfeSTU=;
        b=oAHpzehw6M86GREV+shE3+2aSz4uP7LKQMXICkRFOxB0jC9ccHP5ISiob2owHkSUOV
         SSwwXw9brMCfU4PtJPOlKHvdwhIZsd1nWINNfA0cJ5bJ1XiccqaEWfSk4Tf4j6Tfg+Er
         P1B2Gj5W+lRaK+ppMfL/9MGqKX8janECoj4/QZcyMXX/zLkSu40OXs9sS9WkvbBxW4A/
         JtRIgf34j4U1xL0C5di3DavUNucdvKKVE8q9TE17by83EFU0k2mPU0QI2wOOZ6jtyY9C
         Opcu7PE4gUp2sxye3jHUzzL2zlQCO53HP9CkOL2H0MIMUWkesqM6eCbUxODBYfOs+Dc6
         scBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 91.219.245.39 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 91.219.245.39 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Date: Mon, 16 Apr 2018 22:33:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <CA+55aFxiUhaFVBDhrTGJmgKZid2nO0efh6Mng1NQJ0JK4EHqMg@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.1804162221320.26111@gjva.wvxbf.pm>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home> <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd> <20180416164310.GF2341@sasha-vm>
 <20180416125307.0c4f6f28@gandalf.local.home> <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home> <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home> <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com> <20180416152429.529e3cba@gandalf.local.home> <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com> <20180416153816.292a5b5c@gandalf.local.home>
 <CA+55aFwXRjgfLfAWSaLBdajjzh4gt8-5M2N-bmjKt8nrJT+vWQ@mail.gmail.com> <20180416160232.2b807ff1@gandalf.local.home> <CA+55aFxiUhaFVBDhrTGJmgKZid2nO0efh6Mng1NQJ0JK4EHqMg@mail.gmail.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597921817292724457?=
X-GMAIL-MSGID: =?utf-8?q?1597936348291156192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, Linus Torvalds wrote:

> The ones who should matter most for that discussion is the distros,
> since they are the actual users of stable (as well as the people doing
> the work, of course - ie Sasha and Greg and the rest of the stable
> gang).
> 
> And I suspect that they actually do want all the noise, and all the
> stuff that isn't "critical". That's often the _easy_ choice. It's the
> stuff that I suspect the stable maintainers go "this I don't even have
> to think about", because it's a new driver ID or something.

So I am a maintainer of SUSE enterprise kernel, and I can tell you I 
personally really don't want all the noise, simply because

	(a) noone asked us to distribute it (if they did, we would do so)
	(b) the risk of regressions

We've always been very cautious about what is coming from stable, and 
actually filtering out patches we actively don't want for one reason or 
another.

And yes, there is also a history of regressions caused by stable updates 
that were painful for us ... I brought this up a multiple times at 
ksummit-discuss@ over past years.

So with the upcoming release, we've actually abandonded stable and are 
relying more on auto-processing the Fixes: tag.

That is not perfect in both ways (it doesn't cover everything, and we can 
miss complex semantical dependencies between patches even though they 
"apply"), but we didn't base our decision this time on aligning our 
schedule with stable, and so far we don't seem to be suffering. And we 
have much better overview / control over what is landing in our enterprise 
tree (of course this all is shepherded by machinery around processing 
Fixes: tag, which then though has to be *actively* acted upon, depending 
on a case-by-case human assessment of how critical it actually is).

> Because the bulk of stable tends to be driver updates, afaik. Which 
> distros very much tend to want.

For "community" distros (like Fedora, openSUSE), perhaps, yeah.

For "enterprise" kernels, quite frankly, we much rather get the driver 
updates/backports from the respective HW vedndors we're cooperating with, 
as they have actually tested and verified the backport on the metal.

> The critical stuff is hopefully a tiny tiny percentage.

But quite frankly, that's the only thing we as distro *really* want -- to 
save our users from hitting the critical issues with all the consequences 
(data loss, unbootable systems, etc). All the rest we can easily handle on 
a reactive basis, which heavily depends on the userbase spectrum (and 
that's probably completely different for each -stable tree consumer 
anyway).

This is a POV of me as an distro kernel maintainer, but mileage of others 
definitely can / will vary of course.

Thanks,

-- 
Jiri Kosina
SUSE Labs
