Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeEBRtm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:49:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46902 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEBRti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:49:38 -0400
X-Google-Smtp-Source: AB8JxZrIZQG0/W3fB22bJ+0KINSuIDJFuP2zoa1o9ao+V9194yITjiBxVoYZeg9nL/qI2w/PONvRHg==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd> <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org>
 <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
 <20180502162653.GB3461@thunk.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <3851ac8b-357d-3c82-2195-936e3c459212@redhat.com>
Date: Wed, 2 May 2018 10:49:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502162653.GB3461@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 09:26 AM, Theodore Y. Ts'o wrote:
> On Wed, May 02, 2018 at 07:09:11AM -0500, Justin Forbes wrote:
>> Yes, Fedora libgcrypt is carrying a patch which makes it particularly
>> painful for us, we have reached out to the libgcrypt maintainer to
>> follow up on that end. But as I said before, even without that code
>> path (no dracut-fips) we are seeing some instances of 4 minute boots.
>> This is not really a workable user experience.  And are you sure that
>> every cloud platform and VM platform offers, makes it possible to
>> config virtio-rng?
> 
> Unfortunately, the answer is no.  Google Compute Engine, alas, does
> not currently support virtio-rng.  With my Google hat on, I can't
> comment on future product features.  With my upstream developer hat
> on, I'll give you three guesses what I have been advocating and
> pushing for internally, and the first two don't count.  :-)
> 
> That being said, I just booted a Debian 9 (Stable, aka Stretch)
> standard kernel, and then installed 4.17-rc3 (which has the
> CVE-2018-1108 patches).  The crng_init=2 message doesn't appear
> immediately, and it does appear quite a bit later comapred to
> the standard 4.9.0-6-amd64 Debian 9 kernel.  However, the lack of a
> fully initialized random pool doesn't prevent the standard Debian 9
> image from booting:
> 
> May  2 15:33:42 localhost kernel: [    0.000000] Linux version 4.17.0-rc3-xfstests (tytso@cwcc) (gcc version 7.3.0 (Debian 7.3.0-16)) #169 SMP Wed May 2 11:28:17 EDT 2018
> May  2 15:33:42 localhost kernel: [    1.456883] random: fast init done
> May  2 15:33:46 rng-testing systemd[1]: Startup finished in 3.202s (kernel) + 5.963s (userspace) = 9.166s.
> May  2 15:33:46 rng-testing google-accounts: INFO Starting Google Accounts daemon.
> May  2 15:44:39 rng-testing kernel: [  661.436664] random: crng init done
> 
> So it really does appear to be something going on with Fedora's
> userspace; can you help try to track down what it is?
> 
> Thanks,
> 
> 						- Ted
> 

It is a Fedora patch we're carrying
https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.6.2-fips-ctor.patch#_23
so yes, it is a Fedora specific use case.
 From talking to the libgcrypt team, this is a FIPS mode requirement
to run power on self test at the library constructor and the self
test of libgrcypt ends up requiring a fully seeded RNG. Citation
is in section 9.10 of
https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402IG.pdf

The response was this _could_ be fixed in libgcrypt but it needs
to be done carefully to ensure nothing actually gets broken. So in
the mean time we're stuck with userspace getting blocked whenever
some program decides to use libgcrypt too early.

Thanks,
Laura
