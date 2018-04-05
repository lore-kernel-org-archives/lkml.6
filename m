Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDEQ3V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:29:21 -0400
Received: from sonic310-28.consmr.mail.ne1.yahoo.com ([66.163.186.209]:36922
        "EHLO sonic310-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751425AbeDEQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:29:19 -0400
X-YMail-OSG: mC2v94QVM1ns5bBJC75Xbk81jWMOwOq_6_5PfYUgGjHZMPmTAGLet4wG2y3WZaP
 _2M7rZylWF00NbgXe41qyYkgghxBBCl.2GLKlfVxht0M_aHw7rhxP6kb71apt6rX_8CHx11iWzbt
 Q58nPdYiAofVBHOeP9J.t2n14BUCU9lpY9OUWfZPKXEeWF8Ho2n3uKI9jvZxre7gM3Rh_jFqxbHv
 6C7Dwr9jhr3Ny_44EEuHbnGjR84GNNaqx1gaJi.nN6gTJ2Nf3K70gJc0Xqiuoev1mvDZ4x0Y4RYJ
 rvVD9cVLgc9v.K26Wleg5JcfEfaE1qWWUAtXwWL2QE88flmZysjIHUxX.WBIE8XZCUKPyCkj.Q.r
 OhRpe_6_s20COQMoO9c_.rabDnbvCI8w3A3hSHI3pQz.BQV9Vl6ZdHjKZlu42SbAgRo_c7bFAExR
 lG1doQN7FM.bwo6PL2S0ADs4ZBYjXMOme5ZyniqozMP1i9WqK2cocZ0yGSQIQEgXoMCuN.aizVMP
 mDV9ssYaAgjQ6J4t0zPmYopSFK047oKqdB595VLZVKLbDG8U-
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Peter Dolding <oiaohm@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Cc: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, paul@paul-moore.com,
        plautrba@redhat.com
References: <cover.1522560550.git.sargun@sargun.me>
 <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
 <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com>
Date: Thu, 5 Apr 2018 09:29:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2018 3:31 AM, Peter Dolding wrote:
> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> On 01/04/18 08:41, Sargun Dhillon wrote:
>>> The biggest security benefit of this patchset is the introduction of
>>> read-only hooks, even if some security modules have mutable hooks.
>>> Currently, if you have any LSMs with mutable hooks it will render all heads, and
>>> list nodes mutable. These are a prime place to attack, because being able to
>>> manipulate those hooks is a way to bypass all LSMs easily, and to create a
>>> persistent, covert channel to intercept nearly all calls.
>>>
>>>
>>> If LSMs have a model to be unloaded, or are compled as modules, they should mark
>>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
>>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>>> chain.
>>
>> I'd rather consider these types of hooks:
>>
>> A) hooks that are either const or marked as RO after init
>>
>> B) hooks that are writable for a short time, long enough to load
>> additional, non built-in modules, but then get locked down
>> I provided an example some time ago [1]
>>
>> C) hooks that are unloadable (and therefore always attackable?)
>>
>> Maybe type-A could be dropped and used only as type-B, if it's
>> acceptable that type-A hooks are vulnerable before lock-down of type-B
>> hooks.
>>
>> I have some doubts about the usefulness of type-C, though.
>> The benefit I see htat it brings is that it avoids having to reboot when
>> a mutable LSM is changed, at the price of leaving it attackable.
>>
>> Do you have any specific case in mind where this trade-off would be
>> acceptable?
>>
> A useful case for loadable/unloadable LSM is development automate QA.
>
> So you have built a new program and you you want to test it against a
> list of different LSM configurations without having to reboot the
> system.  So a run testsuite with LSM off  then enabled LSM1 run
> testsuite again disable LSM1 enable LSM2. run testsuite disable
> LSM2... Basically repeating process.
>
> I would say normal production machines being able to swap LSM like
> this does not have much use.
>
> Sometimes for productivity it makes sense to be able to breach
> security.   The fact you need to test with LSM disabled to know if any
> of the defects you are seeing is LSM configuration related that
> instance is already in the camp of non secure anyhow..
>
> There is a shade of grey between something being a security hazard and
> something being a useful feature.

If the only value of a feature is development I strongly
advocate against it. The number of times I've seen things
completely messed up because it makes development easier
is astonishing. If you have to enable something dangerous
just for testing you have to wonder about the testing.
