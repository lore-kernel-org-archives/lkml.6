Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeEQHMy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:12:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37359 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:12:53 -0400
X-Google-Smtp-Source: AB8JxZqfrARgCz8xWppHL4W1xjMoonJmCMkDHwHZjE+WZnKWBzWePHtOVlK4xBUpESDpt4K8xYX9Aw==
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
 <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
 <20180511020049.GD949@sirena.org.uk>
 <7cc158bb-3471-4d8e-d066-2e7f535812eb@baylibre.com>
 <20180513022202.GA17611@sirena.org.uk>
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Message-ID: <201167c6-304c-138a-358f-bee096767527@baylibre.com>
Date: Thu, 17 May 2018 09:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513022202.GA17611@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 04:22 AM, Mark Brown wrote:
> On Fri, May 11, 2018 at 12:29:42PM +0200, Jorge Ramirez-Ortiz wrote:
>> On 05/11/2018 04:00 AM, Mark Brown wrote:
>>> We don't currently suppress writes except when regmap_update_bits()
>>> notices that the modification was a noop.  You probably want to be using
>>> regmap_write_bits() here instead of regmap_update_bits(), that will
>>> always do the write.
>> but isnt that interface at a different level?
> It's at the level where we suppress writes - the write suppression isn't
> a feature of the caching, it's something that regmap_update_bits() does
> if it notices that it won't change anything.  It'll happen even if
> there's no cache at all.
>
>> I am not sure if you are asking me to review my patch or just discarding the
>> RFC and highlighting that I have a configuration problem.
> I don't understand your patch as-is.
>
>> In my use case and what triggered this RFC (config below), an 'amixer set'
>> might never reach the driver's .reg_write interface even though the register
>> is configured as volatile (to me this is not consistent since volatile_reg
>> is being silently ignored).
> I'm not seeing any inconsistency there.  Volatility means the register
> can't be cached as it might change underneath us, it doesn't have any
> impact on writes and it's happening at a lower level.  Like I say if you
> absolutely need a write to happen you should be explicitly doing a
> write, though if you need a write to happen for a noop control change it
> sounds like there's something weird with that control that's possibly a
> problem anyway.
>
>> So I dont see where/how your recommendation fits; maybe you could clarify a
>> bit more please?
> As I've been saying if you explicitly need a write to happen don't use
> regmap_update_bits(), do something that guarantees you'll get a write
> like regmap_write() or regmap_write_bits().

I do understand your point but Mark, that interface you mention sits 
above the user request (as a client the user does not call 
regmap_update_bits or regmap_write_bits or regmap_write(): none of those 
functions mean anything to the foo_regmap definition below - that is why 
we have an interface).

The client just uses this request:

static const struct regmap_config foo_regmap = {
     .reg_write           = foo_write_reg,

     .reg_bits            = 32,
     .val_bits            = 32,
     .reg_stride          = 1,

     .volatile_reg        = foo_volatile_reg,

     .max_register        = CODEC_ENABLE_DEBUG_CTRL_REG,
     .reg_defaults        = foo_reg_defaults,
     .num_reg_defaults    = ARRAY_SIZE(foo_reg_defaults),
     .cache_type          = REGCACHE_RBTREE,
};


and all this request means is that it expects foo_volatile_regs to be 
taken into consideration when accessing the reg_write callback: so 
whoever is calling the interface reg_write (be it regmap_update_bits or 
regmap_write_bits or whoever it is, I dont know) must make sure the 
volatile request applies.

the RFC patch that I submitted achieves exactly that.

does this make more sense now?
