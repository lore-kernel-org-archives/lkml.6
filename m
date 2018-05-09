Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934779AbeEILt1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:49:27 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37249 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeEILtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:49:24 -0400
X-Google-Smtp-Source: AB8JxZrXqyTyR0UO5/I0VkcGjfchgyJwAuJ1P3+xKY+FnBtBuYzh3HO6QXpdCcxaNkesGwD953TXUw==
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Message-ID: <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
Date: Wed, 9 May 2018 13:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509083919.GU13402@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2018 10:39 AM, Mark Brown wrote:
> On Wed, May 09, 2018 at 12:06:09AM +0200, Jorge Ramirez-Ortiz wrote:
>> Regmap only allows volatile access to registers when the client
>> supports both reads and writes.
>>
>> This commit bypasses that limitation and enables volatile writes to
>> selected registers while maintaining cached accesses on all reads. For
>> this, the client does not need to configure the reg_read callback.
> I don't understand what voltile access means for write only devices.
> Volatile means that we don't read the cache but go direct to the
> hardware so if we can't read the hardware that's pretty redundant, a
> volatile read that goes to the cache is just a default read.

oops, sorry will try to be a bit more clear with an example.

This patch tries to support a map that provides:

1. only cached reads: (as a consequence every regmap write must succeed).
2. cached writes: do not access the hardware unless the value differs 
from what is in the cache already or (3) applies.
3. support for selectable volatile writes: those that will always access 
the device no matter what the cache holds.

Something like this:

static const struct regmap_config foo_regmap = {
     .reg_write        = foo_write_reg,

     .reg_bits        = 32,
     .val_bits        = 32,
     .reg_stride        = 1,

     .volatile_reg        = foo_volatile_reg,

     .max_register        = CODEC_ENABLE_DEBUG_CTRL_REG,
     .reg_defaults        = foo_reg_defaults,
     .num_reg_defaults    = ARRAY_SIZE(foo_reg_defaults),
     .cache_type        = REGCACHE_RBTREE,
};


I dont think - I could be wrong- that this is something that we can 
support today since the current code seems to require that the regmap is 
readable (ie, that it implements reg_read).
But it could also be that I am missing something in my config? This is 
why I sent an RFC instead of a PATCH, because I am not 100% sure that I 
am not missing something.
