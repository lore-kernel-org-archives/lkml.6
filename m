Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZrEpSd5Nx+YOH42jwolYGVAldUPQv99TumKHxoj3agix62l9TUNlQtxgBepV2wvvk4GV5vc
ARC-Seal: i=1; a=rsa-sha256; t=1525193452; cv=none;
        d=google.com; s=arc-20160816;
        b=I8Bo41vGp/Rp/x/6vFkfgMv20ZWrDJd+vLT+ywvrWuxGpvzp+VCX8wiQjcoJc3FXWI
         efeZrsRFuTaI1NKgGLEBSy2bDPG1j6RT0n6E3eAJ2lLT3LO5pAOqojtTPUk2uygSpzBf
         80uYnKrulpav2s7jgejnQxluNR7lc+TWGEDg7VPaRjut+n3C9ND+/RMoPAJ8Zo5L0Oi4
         E52ZQpJhLb8BvW8mS9E8y51qMScAfs5Gw/9upXzipKRE0YASvKyW80CWbGqg+py/Gj4P
         7MDOjFjaFy/x39fv2fD4jV2+O1ouvHsMePJ2GsXLaPSvJ7ka/iHMDErXQ33UNqgTl9ac
         ZaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5MfXLKMUH8RE5VmkpeNN8vCOTPrUkxSbKX4tJgDMkds=;
        b=blcNCk9LGQZ2nkzIRMVf9yQsIp430YH/B1ETHn1UVUAnNqcbaHycurahTF8Xu5QXHA
         LhYzrc76bm4cUjlrhEDBWusjyd6mfeiu0TBUEYR9DVrUx0nKsa7nERbrkRqYR95DAyS/
         t7buubrIHeyAxEIsj7c57p9vWn24ZmUIO/BDSOa/FLJAbt68woosx/T1olmMMGgRLPYr
         VuhlX8atXEznwD/+RuIY7uJeQ/W/+OX7m6evB475YgIBm5+HKKlkC3ztqvRQNtOaD5N9
         p+RODAMyglNeSCHZFdJq5JJkQK0G2T3TTqG7bWuQVcZcqHZsNtFmUa1bnDrwK0UrJ/UD
         swXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Tue, 1 May 2018 18:50:51 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
Message-ID: <20180501165051.GA11221@1wt.eu>
References: <20180430175829.GB1544@sasha-vm>
 <20180430190918.GA8718@1wt.eu>
 <20180501161933.GB1468@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501161933.GB1468@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599281249566258888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 04:19:35PM +0000, Sasha Levin wrote:
> On Mon, Apr 30, 2018 at 09:09:18PM +0200, Willy Tarreau wrote:
> >Hi Sasha,
> >
> >On Mon, Apr 30, 2018 at 05:58:30PM +0000, Sasha Levin wrote:
> >>  - For some reason, the odds of a -rc commit to be targetted for -stable is
> >>  over 20%, while for merge window commits it's about 3%. I can't quite
> >>  explain why that happens, but this would suggest that -rc commits end up
> >>  hurting -stable pretty badly.
> >
> >Often, merge window collects work that has been done during the previous
> >cycle and which is prepared to target this merge window. Fixes that happen
> >during this period very likely tend to either be remerged with the patches
> >before they are submitted if they concern the code to be submitted, or are
> >delayed to after the work gets merged. As a result few of the pre-rc1 patches
> >get backported while the next ones mostly contain fixes. By the way, you
> >probably also noticed it when backporting patches to your stable releases,
> >the mainline commit almost never comes from a merge window.
> 
> I'm not sure I understand/agree with this explanation. You're saying
> that commits that fix issues in newly introduced features got folded in
> the feature before it was sent during the merge window, so then there
> was no need for them to be tagged for stable?

No, what I mean is that often a developer is either in development mode
or in bug-fixing mode but it's often quite hard to quickly switch between
the two. So when you're finishing what you were doing to meet the merge
window deadline and you receive bug fixes, it's natural to hold on a few
fixes because it's hard to switch to the review mode. However, if some
fixes concern the code you're about to submit, it's not bug fixing but
fixes for your development in progress and that doesn't require as much
effort, so these updates can often be remerged before being submitted.

> This would be also true for -rc cycle patches if they fix a commit that
> was introduced in that merge window: patches that fix a feature that got
> in that same merge window don't need to be tagged for stable either
> since the feature didn't exist in a previous release.

Definitely, unless the analysis is wrong and the fix addresses the tipping
part of the iceberg, as occasionally happens of course.

> The way I see it is that -stable commits fix a bug that was introduced
> in a feature that exists in a kernel that was already released. At that
> point, the fix can come in at any point in time, whether the fix was
> created during the merge window, or during an -rc cycle.

Yes, except if it requires some review by someone really busy finishing
some work for the merge window that's about to close.

> It also appears that pretty much the same ratio of commits are tagged
> for -stable accross all -rc cycles, so there are no spikes at any point
> during the cycle, which seems to suggest that there is no particular
> relationship between when a -stable commit is created to the stage in a
> release cycle of the current kernel.

Not much surprising to me. After all, -rc are "let's observe and fix",
and it's expected that bugs are randomly met and fixed during that
period.

> >I think that you'll also notice that fixes that address bugs introduced
> >during the merge window of the same version will more often introduce
> >bugs than the ones which address 6-months old bugs which require some
> >deeper thinking. In short it indicates that we tend to believe we are
> >better than we really are, especially very late at night.
> 
> I very much agree. I also think that "upper-level" maintainers, and
> Linus in particular have to stop this behavior.

Well it's easier said than done. You don't really choose when you can
become creative or efficient. For some people it's when everyone else
is asleep, for others it's when they can have 8 uninterrupted hours
in front of them to work on a complex bug. I think it's more efficient
to let people be aware of their limits than to try to overcome them.
The typical thought "I'm too stupid now, let's go to bed" followed the
next morning with a review starting to think "what did I break last
night" is already quite profitable provided people are humble enough
to think like this.

> Yes, folks who do these
> patches are often very familiar with the subsystem, but this doesn't
> mean that they don't make mistakes.

But we all do mistakes all the time. And quite frankly I find that the
recent kernels quality in the early stages after the release is much
better than what it used to be. Kernels build fine, boot fine on most
hardware, and after a few stable versions you can really start to
forget to update them because you don't meet the crashes anymore. Just
a simple example (please don't reproduce, I'm not proud of it), when
I replaced my PC, it came with 4.4.6. I thought "I'll have to upgrade
next week". But I had so many trouble with its crappy bogus BIOS that
I was afraid to reboot it. Then I had hundreds of xterms spread over
multiple displays and it was never the best moment to reboot. Finally
it happened 550 days later. Yes, the 6th maintenance release of 4.4
lasted 550 days on a developers machine doing all sort of stuff without
even a scary message in dmesg. Of course in terms of security it's
terrible. But we didn't see this level of stability in 2.6.x nor in
the early 3.x versions.

> It's as if during -rc cycles all rules are void and bug fixes are now
> no be collected and merged in as fast as humanly possible without any
> regard to how well these fixes were tested.

These stages are supposed to serve to collect fixes, and fixes are
supposed to be tested. Often it's worse to let a fix rot somewhere
than to get it. At the very least by merging it you expose it more
quickly and you have more chances to know if you missed anything.

I remember in the past some people arguing that we shouldn't backport
fixes that haven't experienced a release yet, but that would make the
situation even worse, with no stable fix for the 3 months following a
release. The overall amount of reverts in stable kernels remains very
low, which indicates to me that the overall quality is quite good,
eventhough the process causes gray hair to the involved people (well
for those still having hair).

That's overall why I think that your work can be useful to raise
awareness of what behaviours decrease the level of quality so that
everyone can try to improve a bit, but I don't think there is that
much to squeeze without hitting the wall of what a human brain can
reasonably deal with. And extra process is a mental pressure just
like dealing with bugs, so comes a point where process competes
with quality.

Willy
