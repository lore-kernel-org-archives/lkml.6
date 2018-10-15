Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE922C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE320652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAE320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ise.pw.edu.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeJOVqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:46:33 -0400
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:38197 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:46:33 -0400
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 17:46:32 EDT
Received: from [192.168.101.49] (unknown [192.168.101.49])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id D527168B01F;
        Mon, 15 Oct 2018 15:41:20 +0200 (CEST)
Reply-To: wzab@ise.pw.edu.pl
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     Linus Walleij <linus.walleij@linaro.org>,
        wzabolot@elektron.elka.pw.edu.pl
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
 <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
 <5d33d03a-5d62-c8c8-c9cc-2ccbe1b464f2@xilinx.com>
 <efcb67bf-bdf3-e3a8-5139-0f778ea00f1d@elektron.elka.pw.edu.pl>
 <CACRpkdaeBMc-wqZxh0vVXRiRMvTHDFXxOk0aaxN=swcnLBhG5w@mail.gmail.com>
From:   =?UTF-8?Q?Wojciech_Zabo=c5=82otny?= <wzab@ise.pw.edu.pl>
Message-ID: <d8faabe9-1123-3d0e-6b7d-8335cd2b6a44@ise.pw.edu.pl>
Date:   Mon, 15 Oct 2018 15:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaeBMc-wqZxh0vVXRiRMvTHDFXxOk0aaxN=swcnLBhG5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.2018 18:23, Linus Walleij wrote:
> On Sat, Oct 13, 2018 at 5:53 PM wzabolot@elektron.elka.pw.edu.pl
> <wzabolot@elektron.elka.pw.edu.pl> wrote:
>
>> The question is, if there may be any other in-tree GPIO controller
>> driver that does not initialize those flags?
> So as I said, I looked over them and they all initialize
> their flags.
>
>> Anyway the current situation is somehow dangerous.
> Not very dangerous compared to much other kernel code.
>
>> Maybe the best solution would be to initialize the automatic variable in
>> the of_find_gpio?
> Patches welcom, make sure they are tested with mainline
> code and drivers.
>
> Yours.
> Linus Walleij

OK. So I suggested correction of the Xilinx GPIO driver so that it always sets the flags:

static int xgpio_xlate(struct gpio_chip *gc,
		       const struct of_phandle_args *gpiospec, u32 *flags)
{
	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
	struct xgpio_instance *chip = container_of(mm_gc, struct xgpio_instance,
						   mmchip);
        if(flags)
              * flags = 0;

	if (gpiospec->args[1] == chip->offset)
		return gpiospec->args[0];

	return -EINVAL;
}

With best regards,
Wojtek

