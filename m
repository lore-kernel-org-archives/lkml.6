Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A221C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4310D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfAWQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:14:57 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:52075 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:14:57 -0500
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gmLAv-0002Jf-4z; Wed, 23 Jan 2019 16:14:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 16:14:49 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, thierry.reding@gmail.com,
        boris.brezillon@free-electrons.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: pwm: suppress EPROBE_DEFER error message
In-Reply-To: <20190123160405.GD7503@sirena.org.uk>
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
 <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
 <20190123160405.GD7503@sirena.org.uk>
Message-ID: <afa9ed378b7fa62e81662363fdaf7543@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-23 16:04, Mark Brown wrote:
> On Mon, Jan 21, 2019 at 07:37:23PM +0100, Martin Blumenstingl wrote:
>> Suppress the "Failed to get PWM" error output if the actual error code
>> is EPROBE_DEFER. This makes the behavior of the pwm-regulator driver
>> consistent with what most other drivers do (which is: print all errors
>> except EPROBE_DEFER).
>> 
>> An example where this cleans up the kernel log are the 32-bit Amlogic
>> Meson boards:
>> multi_v7_defconfig has CONFIG_REGULATOR_PWM=y and CONFIG_PWM_MESON=m.
> 
> This also cleans up the kernel log in the case where you've not got a
> driver enabled that you need (or it's not loading for some reason) 
> which
> isn't super helpful when you're trying to figure out why the driver
> won't probe.  There's not even anything at debug level, that would
> probably be fine.
> 
> The ideal thing here would be to work on setting up the dependency
> information based on DT and using that to try to sort initialization
> order so we try things in an order that minimizes the number of failed
> tries.

Hmm, would it be useful to have a devfs file which holds the last probe 
code?
