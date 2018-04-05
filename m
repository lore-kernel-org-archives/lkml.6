Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDEJzs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:55:48 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:34323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752187AbeDEJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:55:32 -0400
Subject: Re: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
To: Sargun Dhillon <sargun@sargun.me>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <penguin-kernel@i-love.sakura.ne.jp>, <keescook@chromium.org>,
        <casey@schaufler-ca.com>, <jmorris@namei.org>, <sds@tycho.nsa.gov>,
        <paul@paul-moore.com>, <plautrba@redhat.com>
References: <cover.1522560550.git.sargun@sargun.me>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
Date: Thu, 5 Apr 2018 12:55:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1522560550.git.sargun@sargun.me>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/18 08:41, Sargun Dhillon wrote:
> The biggest security benefit of this patchset is the introduction of
> read-only hooks, even if some security modules have mutable hooks.
> Currently, if you have any LSMs with mutable hooks it will render all heads, and
> list nodes mutable. These are a prime place to attack, because being able to
> manipulate those hooks is a way to bypass all LSMs easily, and to create a
> persistent, covert channel to intercept nearly all calls.
> 
> 
> If LSMs have a model to be unloaded, or are compled as modules, they should mark
> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
> chain.


I'd rather consider these types of hooks:

A) hooks that are either const or marked as RO after init

B) hooks that are writable for a short time, long enough to load
additional, non built-in modules, but then get locked down
I provided an example some time ago [1]

C) hooks that are unloadable (and therefore always attackable?)

Maybe type-A could be dropped and used only as type-B, if it's
acceptable that type-A hooks are vulnerable before lock-down of type-B
hooks.

I have some doubts about the usefulness of type-C, though.
The benefit I see htat it brings is that it avoids having to reboot when
a mutable LSM is changed, at the price of leaving it attackable.

Do you have any specific case in mind where this trade-off would be
acceptable?


[1] https://lkml.org/lkml/2017/7/10/403

--
igor
