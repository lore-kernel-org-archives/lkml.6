Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeEKK3r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:29:47 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33433 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeEKK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:29:45 -0400
X-Google-Smtp-Source: AB8JxZpv9T8Bx5HtITOy46BATQKSuoIsrOZqroQMcmRxYajIzo/VzYdEc+e8qTWk6jPDkj4UV+32sg==
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
 <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
 <20180511020049.GD949@sirena.org.uk>
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Message-ID: <7cc158bb-3471-4d8e-d066-2e7f535812eb@baylibre.com>
Date: Fri, 11 May 2018 12:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511020049.GD949@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 04:00 AM, Mark Brown wrote:
> On Wed, May 09, 2018 at 01:49:21PM +0200, Jorge Ramirez-Ortiz wrote:
>> On 05/09/2018 10:39 AM, Mark Brown wrote:
>>> I don't understand what voltile access means for write only devices.
>>> Volatile means that we don't read the cache but go direct to the
>>> hardware so if we can't read the hardware that's pretty redundant, a
>>> volatile read that goes to the cache is just a default read.
>> 1. only cached reads: (as a consequence every regmap write must succeed).
>> 2. cached writes: do not access the hardware unless the value differs from
>> what is in the cache already or (3) applies.
>> 3. support for selectable volatile writes: those that will always access the
>> device no matter what the cache holds.
> We don't currently suppress writes except when regmap_update_bits()
> notices that the modification was a noop.  You probably want to be using
> regmap_write_bits() here instead of regmap_update_bits(), that will
> always do the write.

but isnt that interface at a different level?
I am not sure if you are asking me to review my patch or just discarding 
the RFC and highlighting that I have a configuration problem.

In my use case and what triggered this RFC (config below), an 'amixer 
set' might never reach the driver's .reg_write interface even though the 
register is configured as volatile (to me this is not consistent since 
volatile_reg is being silently ignored).

So I dont see where/how your recommendation fits; maybe you could 
clarify a bit more please?

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
