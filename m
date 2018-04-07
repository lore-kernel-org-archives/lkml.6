Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeDGJ0h (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 05:26:37 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40192 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDGJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 05:26:35 -0400
X-Google-Smtp-Source: AIpwx496IHh/z71K3QWjQI+f5REvC00tTpZ9FDBcutO7YmYfnSwDxWRdjln58jpXct9cbexdWGkt/4wAHFmWAGr3h0Y=
MIME-Version: 1.0
In-Reply-To: <18082869-de3b-6a99-5aaf-4110c1eff707@schaufler-ca.com>
References: <cover.1522560550.git.sargun@sargun.me> <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
 <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com> <CAMp4zn95V1BLg5n0MT6F1qGdu=aHxC7_kZr36tZ=pqYB80aQ7g@mail.gmail.com>
 <CANA3KFUkk7pAuECF7H6MnGRYguSFDP3jo1xNMUJCg88NuHdBHA@mail.gmail.com> <18082869-de3b-6a99-5aaf-4110c1eff707@schaufler-ca.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Sat, 7 Apr 2018 19:26:33 +1000
Message-ID: <CANA3KFX8YkweX2wD6FvZm4CkJeRgSAct9MijHpM3_5_Kb9zESg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Sargun Dhillon <sargun@sargun.me>,
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

On Sat, Apr 7, 2018 at 2:31 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/5/2018 9:12 PM, Peter Dolding wrote:
>> On Fri, Apr 6, 2018 at 11:31 AM, Sargun Dhillon <sargun@sargun.me> wrote:
>>>
>>> On Thu, Apr 5, 2018 at 9:29 AM, Casey Schaufler <casey@schaufler-ca.com>
>>> wrote:
>>>> On 4/5/2018 3:31 AM, Peter Dolding wrote:
>>>>> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com>
>>>>> wrote:
>>>>>> On 01/04/18 08:41, Sargun Dhillon wrote:
>>>>>>> The biggest security benefit of this patchset is the introduction of
>>>>>>> read-only hooks, even if some security modules have mutable hooks.
>>>>>>> Currently, if you have any LSMs with mutable hooks it will render all
>>>>>>> heads, and
>>>>>>> list nodes mutable. These are a prime place to attack, because being
>>>>>>> able to
>>>>>>> manipulate those hooks is a way to bypass all LSMs easily, and to
>>>>>>> create a
>>>>>>> persistent, covert channel to intercept nearly all calls.
>>>>>>>
>>>>>>>
>>>>>>> If LSMs have a model to be unloaded, or are compled as modules, they
>>>>>>> should mark
>>>>>>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE
>>>>>>> macro
>>>>>>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>>>>>>> chain.
>>>>>> I'd rather consider these types of hooks:
>>>>>>
>>>>>> A) hooks that are either const or marked as RO after init
>>>>>>
>>>>>> B) hooks that are writable for a short time, long enough to load
>>>>>> additional, non built-in modules, but then get locked down
>>>>>> I provided an example some time ago [1]
>>>>>>
>>>>>> C) hooks that are unloadable (and therefore always attackable?)
>>>>>>
>>>>>> Maybe type-A could be dropped and used only as type-B, if it's
>>>>>> acceptable that type-A hooks are vulnerable before lock-down of type-B
>>>>>> hooks.
>>>>>>
>>>>>> I have some doubts about the usefulness of type-C, though.
>>>>>> The benefit I see htat it brings is that it avoids having to reboot
>>>>>> when
>>>>>> a mutable LSM is changed, at the price of leaving it attackable.
>>>>>>
>>>>>> Do you have any specific case in mind where this trade-off would be
>>>>>> acceptable?
>>>>>>
>>>>> A useful case for loadable/unloadable LSM is development automate QA.
>>>>>
>>>>> So you have built a new program and you you want to test it against a
>>>>> list of different LSM configurations without having to reboot the
>>>>> system.  So a run testsuite with LSM off  then enabled LSM1 run
>>>>> testsuite again disable LSM1 enable LSM2. run testsuite disable
>>>>> LSM2... Basically repeating process.
>>>>>
>>>>> I would say normal production machines being able to swap LSM like
>>>>> this does not have much use.
>>>>>
>>>>> Sometimes for productivity it makes sense to be able to breach
>>>>> security.   The fact you need to test with LSM disabled to know if any
>>>>> of the defects you are seeing is LSM configuration related that
>>>>> instance is already in the camp of non secure anyhow..
>>>>>
>>>>> There is a shade of grey between something being a security hazard and
>>>>> something being a useful feature.
>>>> If the only value of a feature is development I strongly
>>>> advocate against it. The number of times I've seen things
>>>> completely messed up because it makes development easier
>>>> is astonishing. If you have to enable something dangerous
>>>> just for testing you have to wonder about the testing.
>>>>
>> Casey Schaufler we have had different points of view before.
>
> That's OK. I'm not always right.
>
>> I will
>> point out some serous issues here.  If you look a PPA
>
> Sorry, my acronym processor was seriously damaged in 1992.
> What's "PPA" in this context?
>

Personal Package Archives the ubuntu term sorry.


>>  and many other
>> locations you will find no LSM configuration files.
>>
>> Majority of QA servers around the place run with LSM off.   There is a
>> practical annoying reason.   No point running application with new
>> code with LSM on at first you run with LSM off to make sure program
>> works.
>
> You're right. We have different points of view.
>
> Can someone tell me why it makes sense to develop a program
> that they know is going to run in a secured environment in
> an unsecured environment? The fact that it may be easier to
> make the program "work" in the unsecured environment is the
> reason you should never ever ever EVER do that. All you're
> doing is setting up the security to be the bad guy when your
> release is late.

it makes sense when you have programs adding features that result in
breaking the security policy.  If that patch happens without any LSM
fail conformance suite no point changing the LSM settings.

So lets say you do develop in secured first.   New patch fails to
breaking security policy you update policy so that you can run test
suite then you find out in the test suite that the patch does not work
then human error creeps in and you fail to reverse the security policy
change.

There is a very good reason at least  on a QA server for the first
past to be without LSM.  Failure without LSM active is total failure
reject the patch.   If program test suite passes then you active the
LSM and run again what is mostly selinux.

> YES! Your entire workflow is fundamentally flawed.
> The fact that the program works as desired running as root
> with SELinux in permissive mode is no indication that it
> will do so without privilege and/or with SELinux in
> enforcing mode. Why would anyone think it would? And yet,
> people continue to advocate this completely broken
> development mindset. It drives me nuts!

Part of this is how hard it to run a multi test.   So start in
permissive mode as root then ren
>
>> Reality enabling LSM module loading and unloading on the fly on QA
>> servers will not change their security 1 bit because they are most
>> running without LSM at all.
>
> More to the point, a QA server is a special case environment,
> where you know you're going to be changing all sorts of configuration
> on the fly.
>
>> Making it simple to implement LSM
>> configuration testing on QA servers will reduce the number of times
>> end users at told to turn LSM off on their machines that will effect
>> over all security.
>
> Well, fixing the workflow would be the right way to do that.
>
>> So we need to make the process of testing LSM configurations against
>> applications on the QA servers way smoother.
>
> Regardless of the workflow argument, this is a worthy goal.
>

>
> SELinux does not allow you to load "on the fly". SELinux allows you
> to unload, but only if policy has never been loaded. The only case
> this supports is "I have SELinux installed, but don't want to use it
> and can't get to the boot command line to disable it". Removing the
> ability to unload SELinux is on the SELinux team's todo list.

Even if you don't unload SELinux you can run you test suite with
SELInux unconfigured then configure SELinix latter.
>
> That's right. Only SELinux allows deletion, and only if it's never
> been initialized. None of the other security modules saw a need to
> provide the facility, and none, SELinux included, can do it once
> they've started allocating attribute data.

Basically this leads you to problem.  Person has run 2 tests one
without SELinux enabled with with SELinux enabled then they reboot.
Then don't test any other LSM becuase this can be done in a VM count
of 1.  If there is a issue in permissive before selinux is setup you
can unload and run test locating if it linked to SELinux at all.

This workflow is absolutely no use to other LSM modules.   This is the
problem you end up with.  Each workflow end up per LSM that is not
good.

>> So if lets say selinux fits
>> technically fits use case better and all vendor is providing is
>> apparmour profiles they are going to be tempted to reinvent the wheel
>> so it is important to improve testing process.
>
> An AppArmor profile to SELinux policy converter program.
> There must be some available on NPM. ( - NO! I'm not serious! - )
> Although I have had people ask for an SELinux policy to Smack
> rule converter.
>
> The point is that if you could do an automatic conversion
> there would be no point in having the different security
> modules. Which is why I agree with you that testing needs
> to be done in the deployment environment.

QA server setups can have limited VM instances.   This means testing
and maintaining multi LSM security configurations does not happen.
>
>> Even implement a custom hard coded LSM will gain from ability to build
>> load test unload and be able to repeat cycle in development stage.
>
> I agree that would be valuable for the test environment,
> but for different reasons.
>
>> We don't have a LSM that takes like apparmour/selinux/seccomp
>> configuration builds that into a single optimised kernel module.
>
> I am working on that.

Nice look forward to it.
>
>> Most LSM are design around the idea that they need configuration files
>> when you look at deployed systems you see something.    The  LSM
>> configuration files don't get touched for years at time in production
>> systems.  Maybe LSM having to read configuration files is completely
>> wrong.
>
> In the 1980's we implemented hard coded policies.
> We did Bell & LaPadula sensitivity and Biba integrity.
> Nobody liked that (except the US DoD, who only liked it a little)
> because it "doesn't meet our security policy". That's why
> we have programmable policies.

Yes I know about this early stuff.   I have a horrible felling we went
the wrong way.

Yes the early hard code policies were a problem because administrators
were not given effective tools to modify them.   The we went to
programmable polices that is basically give module bytecode or
something is to process.

There is kind of a half way bit.   Where you have like the
programmable policies files as a true compiler acceptable source.   So
this is performance vs configuration.   Early raw C written polices
where not easy reading.
>
>> Maybe the right answer is that configuration files for LSM
>> should basically be source code to build a module being processed once
>> run many this would allow a lot more optimisation.
>
> SELinux policy is compiled.
>
SELinux policy is like complied python where it converted to a
bytecode then it still interpreted by selinux kernel module.   When I
say built to a module I mean built to a real .ko file and able to
perform proper link time optimisation and get it as tight with the
least overhead possible on all the hooks as possible..

>> Its not like
>> apparmour/selinux forbid reloading configuration.
>>
>> With LSM loading and unloading formally allowed there is option to
>> move to where a LSM can safely hand over control to another LSM
>> without leaving a unhooked time this would be useful for hard coded
>> LSM for updating configuration..
>
> I think that what you'd really like is stacked security namespaces.
>
If this will make it possible to have 1 VM instance and build program
test against no LSM and all commonly used LSM with made policies and
generate a report saying this patch works but X Y ans Z  LSM policies
need looking at with consideration if this security expand is
acceptable or this patch does not work at all even without LSM so
reject it out right for being totally bad or hopefully just reported
everything works perfectly these are the results I want.

This 1 VM limit is your worst case QA limitation.   If we have a test
workflow that is effective with a 1VM it will be hard to justify not
doing it.

It is quite important to know before playing with security policies if
the code works at all this is where the idea of develop in secure
environment for secured environment fails it leads to worse written
security polices as the human errors of policy editing stacks up from
editing where a patch fails due to LSM policy then with modified
policy turns out to fail test suite and then the LSM policy edit does
not end up reversed.  So its a important to detect patch is failed as
soon as possible with the least amount of work performed.   If
something is modified humans have a bad habit of forgetting reverse
it.

Peter Dolding
