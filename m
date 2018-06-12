Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3D986C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E2C208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eCCVlU+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E2C208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754383AbeFLR1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:27:32 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50826 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbeFLR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:27:31 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CC2615C1305;
        Tue, 12 Jun 2018 19:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528824449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HklWwuh0cZquAYRASyqnaHZv7zNlLk5/8n9W8VNvlsk=;
        b=eCCVlU+8Mp0vuy/w/XNnCxLpRqBCdxGWrfU01SLTCXrew6kExOtrxBQnF7CuEK6gLn/F5s
        tk7CryBxOwSlOTJ6T0ztdY/jCVrtvE6UbU59YjZq0uyafVeY8I2FHLjZ4pAU6Sh6OafOTh
        yajHLh4mMwXPFNI98hpLEBDlsptcrYk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 19:27:29 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de,
        nicolas.pitre@linaro.org, keescook@chromium.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        mka@chromium.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Bernhard.Rosenkranzer@linaro.org
Subject: Re: [v2,4/6] ARM: drop no-thumb-interwork in EABI mode
In-Reply-To: <20180612171929.GA7829@roeck-us.net>
References: <20180325180959.28008-5-stefan@agner.ch>
 <20180612171929.GA7829@roeck-us.net>
Message-ID: <325243a63755a1f6ae578dae35154b17@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.34 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.24)[89.54%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2018 19:19, Guenter Roeck wrote:
> On Sun, Mar 25, 2018 at 08:09:57PM +0200, Stefan Agner wrote:
>> According to GCC documentation -m(no-)thumb-interwork is
>> meaningless in AAPCS configurations. Also clang does not
> 
> It appears that this is only correct for recent versions of gcc.
> 
> With gcc 4.9.2, this patch causes the qemu collie emulation
> to fail with collie_defconfig+CONFIG_AEABI.

Hm, interesting. However, even 4.9.0 claims this option is meaningless
when using AAPCS configurations:
https://gcc.gnu.org/onlinedocs/gcc-4.9.0/gcc/ARM-Options.html#ARM-Options

> 
> qemu-system-arm: Trying to execute code outside RAM or ROM at 0x02000000
> This usually means one of the following happened:
> ...
> 
> With gcc 7.3.0, the emulation works as expected. Reverting the patch
> fixes the problem with gcc 4.9.2. Not that it matters much to me - I can
> and will switch to gcc 7.3.0 for my testing - but effectively this means
> that older versions of gcc are no longer supported for all configurations.
> 
> Maybe $(call cc-option,-mno-thumb-interwork,) would have been safer ?

I used to have call cc-option in place, but I removed that when I
realized that gcc claims it is meaningless with AAPCS configurations.

--
Stefan

> 
> Guenter
> 
>> support the flag:
>>   clang-5.0: error: unknown argument: '-mno-thumb-interwork'
>>
>> Just drop -mno-thumb-interwork in AEABI configuration.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index e83f5161fdd8..e9e3fde3c657 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -106,7 +106,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
>>  tune-y := $(tune-y)
>>
>>  ifeq ($(CONFIG_AEABI),y)
>> -CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
>> +CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
>>  else
>>  CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
>>  endif
