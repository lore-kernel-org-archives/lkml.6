Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965012AbeCGUXx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:23:53 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:40070
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964783AbeCGUXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:23:51 -0500
X-YMail-OSG: ofDZZVgVM1kLHtKnElEuiVwg3ea_WTCNdmO7JTk4kxUheBGTnajMUf7PB_bWoTM
 dXCBxygUpuL.j0EwtjdUctiJaHa3TKOLdN1HI1qxJt.CN.YEunPer9OrSXbk_BLUKpnbSWUHTYYc
 ZbGmxMmCPTULEjFh.1XJoVsZINFrDsfNlPf.rUXCQasWipVEYMUhyqPjGJf.JtsZLKiXW2MQtzc.
 gNer5IjxpS1ESs5qgAR3vsUpMYtJXZUUa_ICJqIorpeBQk3ipRbzBaX0ZqtS6rjXVmCH7_9JV_yI
 comQjh_JhLlkV47DW0jNP04dBartk78bO.t2R6M0hGgZiGsbNTWr3m3BOb5N6ecdCSbEZugUgT9E
 xkCDYd4.DGUAN3qo6cZqOlFV5Ih8nwOvhQOLd9Z1j10z3E1uLo4mdfp5zdV1yScgFnV7Dz1OL6Ip
 U76soze0_r2c.SMLsr7NiaIrxe2PXFJs1TIcN6SljzdxrYwkO_0BfyvP6kBeAxwxyGkzpVYXHx48
 TSDNLJZfWO6uIaSYtVZqU.1YkymtyMN71hDSdpjy4f287PZKCf8uh1jDLnlpyz496
Subject: Re: [PATCH v4 1/3] security: Refactor LSM hooks into an array and
 enum
To: Sargun Dhillon <sargun@sargun.me>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
References: <cover.1520407240.git.sargun@sargun.me>
 <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
 <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
 <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6326ecfe-83f9-13d8-d59a-58d567726b07@schaufler-ca.com>
Date: Wed, 7 Mar 2018 12:23:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2018 11:18 AM, Sargun Dhillon wrote:
> On Wed, Mar 7, 2018 at 9:45 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
>>> This commit should have no functional change. It changes the security hook
>>> list heads struct into an array. Additionally, it exposes all of the hooks
>>> via an enum. This loses memory layout randomization as the enum is not
>>> randomized.
>> Please explain why you want to do this. I still dislike it.
>>
> Do you dislike it because of the loss of randomization, or some other reason?

I dislike a huge array of untyped function pointers.
I dislike the loss of type checking in security.c

> The reason for not just having a second list_heads is that it's
> somewhat ugly having to replicate that structure twice -- once for
> dynamic hooks, and once for 'static' hooks.

There was discussion about this some time ago. In the case
where you don't allow dynamic hooks, you mark the lists ro_after_init
whereas in the case with them you don't, but use the locking.


> Instead, we have one enum that LSMs can use and two arrays of heads
> rather than an entire unrolled set of list_heads.

But how is this better? What is the advantage?

>
> If we had a way to randomize this, would it make you comfortable?
>
