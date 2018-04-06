Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDFBu6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:50:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39195 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeDFBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:50:56 -0400
X-Google-Smtp-Source: AIpwx489a6pTm728JJSFuXHNCH9AuEfZHhAToYk1cDuZsCs+YV6JHOO9POlOo5I/ZToVAxufzD+B6xGYqtqKiEL2o44=
MIME-Version: 1.0
In-Reply-To: <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com>
References: <cover.1522560550.git.sargun@sargun.me> <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com> <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com>
From: Sargun Dhillon <sargun@sargun.me>
Date: Thu, 5 Apr 2018 18:50:14 -0700
Message-ID: <CAMp4zn9W1-28tnEC-SH0wH2y5HLNWmb8TB7kBAy75JGHhH1=bA@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Peter Dolding <oiaohm@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>,
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

On Thu, Apr 5, 2018 at 9:29 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 4/5/2018 3:31 AM, Peter Dolding wrote:
> > On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> >> On 01/04/18 08:41, Sargun Dhillon wrote:
> >>> The biggest security benefit of this patchset is the introduction of
> >>> read-only hooks, even if some security modules have mutable hooks.
> >>> Currently, if you have any LSMs with mutable hooks it will render all heads, and
> >>> list nodes mutable. These are a prime place to attack, because being able to
> >>> manipulate those hooks is a way to bypass all LSMs easily, and to create a
> >>> persistent, covert channel to intercept nearly all calls.
> >>>
> >>>
> >>> If LSMs have a model to be unloaded, or are compled as modules, they should mark
> >>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
> >>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
> >>> chain.
> >>
> >> I'd rather consider these types of hooks:
> >>
> >> A) hooks that are either const or marked as RO after init
> >>
> >> B) hooks that are writable for a short time, long enough to load
> >> additional, non built-in modules, but then get locked down
> >> I provided an example some time ago [1]
> >>
> >> C) hooks that are unloadable (and therefore always attackable?)
> >>
> >> Maybe type-A could be dropped and used only as type-B, if it's
> >> acceptable that type-A hooks are vulnerable before lock-down of type-B
> >> hooks.
> >>
> >> I have some doubts about the usefulness of type-C, though.
> >> The benefit I see htat it brings is that it avoids having to reboot when
> >> a mutable LSM is changed, at the price of leaving it attackable.
> >>
> >> Do you have any specific case in mind where this trade-off would be
> >> acceptable?
> >>
> > A useful case for loadable/unloadable LSM is development automate QA.
> >
> > So you have built a new program and you you want to test it against a
> > list of different LSM configurations without having to reboot the
> > system.  So a run testsuite with LSM off  then enabled LSM1 run
> > testsuite again disable LSM1 enable LSM2. run testsuite disable
> > LSM2... Basically repeating process.
> >
> > I would say normal production machines being able to swap LSM like
> > this does not have much use.
> >
> > Sometimes for productivity it makes sense to be able to breach
> > security.   The fact you need to test with LSM disabled to know if any
> > of the defects you are seeing is LSM configuration related that
> > instance is already in the camp of non secure anyhow..
> >
> > There is a shade of grey between something being a security hazard and
> > something being a useful feature.
>
> If the only value of a feature is development I strongly
> advocate against it. The number of times I've seen things
> completely messed up because it makes development easier
> is astonishing. If you have to enable something dangerous
> just for testing you have to wonder about the testing.
>
>
[Sorry for the double post]
So, first, this gives us a security benefit for LSMs which do not have
unloadable hooks. For those, they will always be able to load at
boot-time, and get protected hooks. Given that we can't really remove
security_delete_hooks until this SELinux removes their dependency on
it, I'm not sure we that this happy accident of safe (un)loading
should be sacrificed.

I think having LSMs that are loadable after boot is extremely
valuable. In our specific use case, we've wanted to implement specific
security policies which are not capable of being implemented on the
traditional LSMs. We have the capability of deploying a Linux Kernel
Module throughout our fleet. Recent examples include issues with
specific networking address families, IPTables (over netlink API).
It's not easy to block out RDS across the system while it's running,
even if seccomp can do it.

We have other use cases -- like being able to run systemd in
unprivileged user namespaces. This comes at the cost of giving the
container CAP_SYS_ADMIN. We want to be able to give PID 1 in the user
namespace CAP_SYS_ADMIN, but we want to revoke these capbilities
across execve, without having to control the user's installation of
systemd in their container.

Other times, it's about performance. There is a measureable overhead
with seccomp, and apparmor. LSMs fit better for doing some of the
filtering we're forced to do in seccomp, or apparmor for containers.
The performance gain by implementing purpose-built policies in custom
LSMs is significant.

My suggestion is to change security_delete_hooks() to return -EPERM by
default. Hook unloading can then be disabled by a Kconfig feature. If
we need to get "more secure", we can disable unloading via cmdline, or
proc / securityfs at boot time.
