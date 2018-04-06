Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDFEM2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:12:28 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44482 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeDFEM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:12:26 -0400
X-Google-Smtp-Source: AIpwx4/EmmhS9WFr6ph0TTPxTRS4V9Daia+HJIa0G6G8WLmPFXdYnQK0xi6kceltt+7KP5oQBecz3PqQWgnqQb/I7eA=
MIME-Version: 1.0
In-Reply-To: <CAMp4zn95V1BLg5n0MT6F1qGdu=aHxC7_kZr36tZ=pqYB80aQ7g@mail.gmail.com>
References: <cover.1522560550.git.sargun@sargun.me> <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
 <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com> <CAMp4zn95V1BLg5n0MT6F1qGdu=aHxC7_kZr36tZ=pqYB80aQ7g@mail.gmail.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Fri, 6 Apr 2018 14:12:23 +1000
Message-ID: <CANA3KFUkk7pAuECF7H6MnGRYguSFDP3jo1xNMUJCg88NuHdBHA@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Sargun Dhillon <sargun@sargun.me>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
        plautrba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 11:31 AM, Sargun Dhillon <sargun@sargun.me> wrote:
>
>
> On Thu, Apr 5, 2018 at 9:29 AM, Casey Schaufler <casey@schaufler-ca.com>
> wrote:
>>
>> On 4/5/2018 3:31 AM, Peter Dolding wrote:
>> > On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com>
>> > wrote:
>> >> On 01/04/18 08:41, Sargun Dhillon wrote:
>> >>> The biggest security benefit of this patchset is the introduction of
>> >>> read-only hooks, even if some security modules have mutable hooks.
>> >>> Currently, if you have any LSMs with mutable hooks it will render all
>> >>> heads, and
>> >>> list nodes mutable. These are a prime place to attack, because being
>> >>> able to
>> >>> manipulate those hooks is a way to bypass all LSMs easily, and to
>> >>> create a
>> >>> persistent, covert channel to intercept nearly all calls.
>> >>>
>> >>>
>> >>> If LSMs have a model to be unloaded, or are compled as modules, they
>> >>> should mark
>> >>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE
>> >>> macro
>> >>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>> >>> chain.
>> >>
>> >> I'd rather consider these types of hooks:
>> >>
>> >> A) hooks that are either const or marked as RO after init
>> >>
>> >> B) hooks that are writable for a short time, long enough to load
>> >> additional, non built-in modules, but then get locked down
>> >> I provided an example some time ago [1]
>> >>
>> >> C) hooks that are unloadable (and therefore always attackable?)
>> >>
>> >> Maybe type-A could be dropped and used only as type-B, if it's
>> >> acceptable that type-A hooks are vulnerable before lock-down of type-B
>> >> hooks.
>> >>
>> >> I have some doubts about the usefulness of type-C, though.
>> >> The benefit I see htat it brings is that it avoids having to reboot
>> >> when
>> >> a mutable LSM is changed, at the price of leaving it attackable.
>> >>
>> >> Do you have any specific case in mind where this trade-off would be
>> >> acceptable?
>> >>
>> > A useful case for loadable/unloadable LSM is development automate QA.
>> >
>> > So you have built a new program and you you want to test it against a
>> > list of different LSM configurations without having to reboot the
>> > system.  So a run testsuite with LSM off  then enabled LSM1 run
>> > testsuite again disable LSM1 enable LSM2. run testsuite disable
>> > LSM2... Basically repeating process.
>> >
>> > I would say normal production machines being able to swap LSM like
>> > this does not have much use.
>> >
>> > Sometimes for productivity it makes sense to be able to breach
>> > security.   The fact you need to test with LSM disabled to know if any
>> > of the defects you are seeing is LSM configuration related that
>> > instance is already in the camp of non secure anyhow..
>> >
>> > There is a shade of grey between something being a security hazard and
>> > something being a useful feature.
>>
>> If the only value of a feature is development I strongly
>> advocate against it. The number of times I've seen things
>> completely messed up because it makes development easier
>> is astonishing. If you have to enable something dangerous
>> just for testing you have to wonder about the testing.
>>
Casey Schaufler we have had different points of view before.   I will
point out some serous issues here.  If you look a PPA and many other
locations you will find no LSM configuration files.

Majority of QA servers around the place run with LSM off.   There is a
practical annoying reason.   No point running application with new
code with LSM on at first you run with LSM off to make sure program
works.   If program works and you have the resources then transfer to
another machine/reboot to test with LSM this creates a broken
workflow.   When customer gets untested LSM configuration files and
they don't work what do support straight up recommend turning the LSM
off.

Reality enabling LSM module loading and unloading on the fly on QA
servers will not change their security 1 bit because they are most
running without LSM at all.   Making it simple to implement LSM
configuration testing on QA servers will reduce the number of times
end users at told to turn LSM off on their machines that will effect
over all security.

So we need to make the process of testing LSM configurations against
applications on the QA servers way smoother.

> So, first, this gives us a security benefit for LSMs which do not have
> unloadable hooks. For those, they will always be able to load at boot-time,
> and get protected hooks. Given that we can't really remove
> security_delete_hooks until this SELinux removes their dependency on it, I'm
> not sure we that this happy accident of safe (un)loading should be
> sacrificed.
>
> I think having LSMs that are loadable after boot is extremely valuable. In
> our specific use case, we've wanted to implement specific security policies
> which are not capable of being implemented on the traditional LSMs. We have
> the capability of deploying a Linux Kernel Module throughout our fleet.
> Recent examples include issues with specific networking address families,
> IPTables (over netlink API). It's not easy to block out RDS across the
> system while it's running, even if seccomp can do it.
>
> We have other use cases -- like being able to run systemd in unprivileged
> user namespaces. This comes at the cost of giving the container
> CAP_SYS_ADMIN. We want to be able to give PID 1 in the user namespace
> CAP_SYS_ADMIN, but we want to revoke these capbilities across execve,
> without having to control the user's installation of systemd in their
> container.
>
> Other times, it's about performance. There is a measureable overhead with
> seccomp, and apparmor. LSMs fit better for doing some of the filtering we're
> forced to do in seccomp, or apparmor for containers. The performance gain by
> implementing purpose-built policies in custom LSMs is significant.
>
> My suggestion is to change security_delete_hooks() to return -EPERM by
> default. Hook unloading can then be disabled by a Kconfig feature. If we
> need to get "more secure", we can disable unloading via cmdline, or proc /
> securityfs at boot time.

Yes this is a different usage case there is a peer review issue to it..

https://elixir.bootlin.com/linux/latest/source/include/linux/lsm_hooks.h#L1999

Selinux is the only one that allows you to load and unload it on fly.
 It also one of the reasons why you have a few applications that ship
with dependable Selinux profiles because they are turning selinux on
and off on the QA servers.   If you look at security_delete_hooks()
design if you can or cannot unload a LSM module is purely left to the
security module.

First step make if LSM can be unloaded or not generic including what
LSM set to block unloading.
Second step provide some generic way that can be integrated into test
suites to test LSM configurations.

Sargun Dhillon issue would also partly link to the fact applications
are not tested with more LSM options.   So if lets say selinux fits
technically fits use case better and all vendor is providing is
apparmour profiles they are going to be tempted to reinvent the wheel
so it is important to improve testing process.

Even implement a custom hard coded LSM will gain from ability to build
load test unload and be able to repeat cycle in development stage.

We don't have a LSM that takes like apparmour/selinux/seccomp
configuration builds that into a single optimised kernel module.
Most LSM are design around the idea that they need configuration files
when you look at deployed systems you see something.    The  LSM
configuration files don't get touched for years at time in production
systems.  Maybe LSM having to read configuration files is completely
wrong.   Maybe the right answer is that configuration files for LSM
should basically be source code to build a module being processed once
run many this would allow a lot more optimisation.   Its not like
apparmour/selinux forbid reloading configuration.

With LSM loading and unloading formally allowed there is option to
move to where a LSM can safely hand over control to another LSM
without leaving a unhooked time this would be useful for hard coded
LSM for updating configuration..

Peter Dolding
