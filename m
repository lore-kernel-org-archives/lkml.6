Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeDFQb6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:31:58 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34559
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbeDFQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:31:56 -0400
X-YMail-OSG: yDdXFqsVM1lJ8xE9WDwfyxHCiBnENh7KZv0ouWFprK6V7cy3KMLE6qkAYqELK5P
 DdDJ774iPmWvQVHZm09VKN2dSSeBQ5Pc58J2jWxntCZZfagXRQjipnDS_jrAUC9lcTEbn.MmKr72
 t9hJX1KM6OskHGzSMn0QlYBzt.ABCVmy3mVmXHRfEuA2IbrAYDlVcskcZ82Y3cUoZhaIZtFdqscF
 mvB9m83oJ_wQUOWZa0cngQf89MEftdpS89AHbd5amTX67sIMNbgdxZyRvxc3Olr1D.RmK2aZ8J02
 jgzemnu.7scIxiE2Zm9IObmlcH9oYfQe4FCJgGNIljo2zWqiY4AX8adU0kG22f7Wzwq9kPjObKmN
 NXtwb.8FzBV5ddHmswnq29XS4oo.qWYrhgQDC95JVLn2eMmlySuDa1Xm.9frnS5gt.FqjaTpVWP4
 5jV4i4RBjXyVOwFyTV1czYyzKFfpTzXFq0GoBrglORF85T1WY3ro0FAvOSWa1BV00k5sZtBpjEqW
 fLIBFMvxEQeYCSL0QP.w8HZMu5ksJN5vMesMnkgv6CbTYf0WGGBKBD2CHqt.UEYufWs6pwNxlv7v
 WPKWbl9j6r0UNyQPcoJiJIPnOTmiB
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Peter Dolding <oiaohm@gmail.com>, Sargun Dhillon <sargun@sargun.me>
Cc: Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
        plautrba@redhat.com
References: <cover.1522560550.git.sargun@sargun.me>
 <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
 <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com>
 <CAMp4zn95V1BLg5n0MT6F1qGdu=aHxC7_kZr36tZ=pqYB80aQ7g@mail.gmail.com>
 <CANA3KFUkk7pAuECF7H6MnGRYguSFDP3jo1xNMUJCg88NuHdBHA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <18082869-de3b-6a99-5aaf-4110c1eff707@schaufler-ca.com>
Date: Fri, 6 Apr 2018 09:31:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANA3KFUkk7pAuECF7H6MnGRYguSFDP3jo1xNMUJCg88NuHdBHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2018 9:12 PM, Peter Dolding wrote:
> On Fri, Apr 6, 2018 at 11:31 AM, Sargun Dhillon <sargun@sargun.me> wrote:
>>
>> On Thu, Apr 5, 2018 at 9:29 AM, Casey Schaufler <casey@schaufler-ca.com>
>> wrote:
>>> On 4/5/2018 3:31 AM, Peter Dolding wrote:
>>>> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com>
>>>> wrote:
>>>>> On 01/04/18 08:41, Sargun Dhillon wrote:
>>>>>> The biggest security benefit of this patchset is the introduction of
>>>>>> read-only hooks, even if some security modules have mutable hooks.
>>>>>> Currently, if you have any LSMs with mutable hooks it will render all
>>>>>> heads, and
>>>>>> list nodes mutable. These are a prime place to attack, because being
>>>>>> able to
>>>>>> manipulate those hooks is a way to bypass all LSMs easily, and to
>>>>>> create a
>>>>>> persistent, covert channel to intercept nearly all calls.
>>>>>>
>>>>>>
>>>>>> If LSMs have a model to be unloaded, or are compled as modules, they
>>>>>> should mark
>>>>>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE
>>>>>> macro
>>>>>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>>>>>> chain.
>>>>> I'd rather consider these types of hooks:
>>>>>
>>>>> A) hooks that are either const or marked as RO after init
>>>>>
>>>>> B) hooks that are writable for a short time, long enough to load
>>>>> additional, non built-in modules, but then get locked down
>>>>> I provided an example some time ago [1]
>>>>>
>>>>> C) hooks that are unloadable (and therefore always attackable?)
>>>>>
>>>>> Maybe type-A could be dropped and used only as type-B, if it's
>>>>> acceptable that type-A hooks are vulnerable before lock-down of type-B
>>>>> hooks.
>>>>>
>>>>> I have some doubts about the usefulness of type-C, though.
>>>>> The benefit I see htat it brings is that it avoids having to reboot
>>>>> when
>>>>> a mutable LSM is changed, at the price of leaving it attackable.
>>>>>
>>>>> Do you have any specific case in mind where this trade-off would be
>>>>> acceptable?
>>>>>
>>>> A useful case for loadable/unloadable LSM is development automate QA.
>>>>
>>>> So you have built a new program and you you want to test it against a
>>>> list of different LSM configurations without having to reboot the
>>>> system.  So a run testsuite with LSM off  then enabled LSM1 run
>>>> testsuite again disable LSM1 enable LSM2. run testsuite disable
>>>> LSM2... Basically repeating process.
>>>>
>>>> I would say normal production machines being able to swap LSM like
>>>> this does not have much use.
>>>>
>>>> Sometimes for productivity it makes sense to be able to breach
>>>> security.   The fact you need to test with LSM disabled to know if any
>>>> of the defects you are seeing is LSM configuration related that
>>>> instance is already in the camp of non secure anyhow..
>>>>
>>>> There is a shade of grey between something being a security hazard and
>>>> something being a useful feature.
>>> If the only value of a feature is development I strongly
>>> advocate against it. The number of times I've seen things
>>> completely messed up because it makes development easier
>>> is astonishing. If you have to enable something dangerous
>>> just for testing you have to wonder about the testing.
>>>
> Casey Schaufler we have had different points of view before.   

That's OK. I'm not always right.

> I will
> point out some serous issues here.  If you look a PPA

Sorry, my acronym processor was seriously damaged in 1992.
What's "PPA" in this context?

>  and many other
> locations you will find no LSM configuration files.
>
> Majority of QA servers around the place run with LSM off.   There is a
> practical annoying reason.   No point running application with new
> code with LSM on at first you run with LSM off to make sure program
> works.   

You're right. We have different points of view.

Can someone tell me why it makes sense to develop a program
that they know is going to run in a secured environment in
an unsecured environment? The fact that it may be easier to
make the program "work" in the unsecured environment is the
reason you should never ever ever EVER do that. All you're
doing is setting up the security to be the bad guy when your
release is late.

> If program works and you have the resources then transfer to
> another machine/reboot to test with LSM this creates a broken
> workflow.   

That's right. It's a broken workflow. If you want a program
to work in secured environment it should be developed in that
secured environment. It saves everyone time and effort.
Except for the guy who's all set to blame security for making
the release late.

> When customer gets untested LSM configuration files and
> they don't work what do support straight up recommend turning the LSM
> off.

YES! Your entire workflow is fundamentally flawed.
The fact that the program works as desired running as root
with SELinux in permissive mode is no indication that it
will do so without privilege and/or with SELinux in
enforcing mode. Why would anyone think it would? And yet,
people continue to advocate this completely broken
development mindset. It drives me nuts!

> Reality enabling LSM module loading and unloading on the fly on QA
> servers will not change their security 1 bit because they are most
> running without LSM at all.   

More to the point, a QA server is a special case environment,
where you know you're going to be changing all sorts of configuration
on the fly.

> Making it simple to implement LSM
> configuration testing on QA servers will reduce the number of times
> end users at told to turn LSM off on their machines that will effect
> over all security.

Well, fixing the workflow would be the right way to do that.

> So we need to make the process of testing LSM configurations against
> applications on the QA servers way smoother.

Regardless of the workflow argument, this is a worthy goal.

>> So, first, this gives us a security benefit for LSMs which do not have
>> unloadable hooks. For those, they will always be able to load at boot-time,
>> and get protected hooks. Given that we can't really remove
>> security_delete_hooks until this SELinux removes their dependency on it, I'm
>> not sure we that this happy accident of safe (un)loading should be
>> sacrificed.
>>
>> I think having LSMs that are loadable after boot is extremely valuable. In
>> our specific use case, we've wanted to implement specific security policies
>> which are not capable of being implemented on the traditional LSMs. We have
>> the capability of deploying a Linux Kernel Module throughout our fleet.
>> Recent examples include issues with specific networking address families,
>> IPTables (over netlink API). It's not easy to block out RDS across the
>> system while it's running, even if seccomp can do it.
>>
>> We have other use cases -- like being able to run systemd in unprivileged
>> user namespaces. This comes at the cost of giving the container
>> CAP_SYS_ADMIN. We want to be able to give PID 1 in the user namespace
>> CAP_SYS_ADMIN, but we want to revoke these capbilities across execve,
>> without having to control the user's installation of systemd in their
>> container.
>>
>> Other times, it's about performance. There is a measureable overhead with
>> seccomp, and apparmor. LSMs fit better for doing some of the filtering we're
>> forced to do in seccomp, or apparmor for containers. The performance gain by
>> implementing purpose-built policies in custom LSMs is significant.
>>
>> My suggestion is to change security_delete_hooks() to return -EPERM by
>> default. Hook unloading can then be disabled by a Kconfig feature. If we
>> need to get "more secure", we can disable unloading via cmdline, or proc /
>> securityfs at boot time.
> Yes this is a different usage case there is a peer review issue to it..
>
> https://elixir.bootlin.com/linux/latest/source/include/linux/lsm_hooks.h#L1999
>
> Selinux is the only one that allows you to load and unload it on fly.

SELinux does not allow you to load "on the fly". SELinux allows you
to unload, but only if policy has never been loaded. The only case
this supports is "I have SELinux installed, but don't want to use it
and can't get to the boot command line to disable it". Removing the
ability to unload SELinux is on the SELinux team's todo list.

>  It also one of the reasons why you have a few applications that ship
> with dependable Selinux profiles because they are turning selinux on
> and off on the QA servers.   If you look at security_delete_hooks()
> design if you can or cannot unload a LSM module is purely left to the
> security module.

That's right. Only SELinux allows deletion, and only if it's never
been initialized. None of the other security modules saw a need to
provide the facility, and none, SELinux included, can do it once
they've started allocating attribute data.

> First step make if LSM can be unloaded or not generic including what
> LSM set to block unloading.

I suggest that the first step would be to identify how a security
module can ensure that all its state and data can be cleaned up
safely during the removal process.

> Second step provide some generic way that can be integrated into test
> suites to test LSM configurations.

That would be stacked security namespaces.

> Sargun Dhillon issue would also partly link to the fact applications
> are not tested with more LSM options.   

These days it seems that few developers even know what file mode bits
do, much less the implications of a security module. If you don't
believe me, ask them what umask is for. Which winds us back to the
workflow issue.

> So if lets say selinux fits
> technically fits use case better and all vendor is providing is
> apparmour profiles they are going to be tempted to reinvent the wheel
> so it is important to improve testing process.

An AppArmor profile to SELinux policy converter program.
There must be some available on NPM. ( - NO! I'm not serious! - )
Although I have had people ask for an SELinux policy to Smack
rule converter.

The point is that if you could do an automatic conversion
there would be no point in having the different security
modules. Which is why I agree with you that testing needs
to be done in the deployment environment. 

> Even implement a custom hard coded LSM will gain from ability to build
> load test unload and be able to repeat cycle in development stage.

I agree that would be valuable for the test environment,
but for different reasons.

> We don't have a LSM that takes like apparmour/selinux/seccomp
> configuration builds that into a single optimised kernel module.

I am working on that.

> Most LSM are design around the idea that they need configuration files
> when you look at deployed systems you see something.    The  LSM
> configuration files don't get touched for years at time in production
> systems.  Maybe LSM having to read configuration files is completely
> wrong.   

In the 1980's we implemented hard coded policies.
We did Bell & LaPadula sensitivity and Biba integrity.
Nobody liked that (except the US DoD, who only liked it a little)
because it "doesn't meet our security policy". That's why
we have programmable policies.

> Maybe the right answer is that configuration files for LSM
> should basically be source code to build a module being processed once
> run many this would allow a lot more optimisation.   

SELinux policy is compiled.

> Its not like
> apparmour/selinux forbid reloading configuration.
>
> With LSM loading and unloading formally allowed there is option to
> move to where a LSM can safely hand over control to another LSM
> without leaving a unhooked time this would be useful for hard coded
> LSM for updating configuration..

I think that what you'd really like is stacked security namespaces.

> Peter Dolding

Thanks for the discussion. I owe you (another?) beer.
