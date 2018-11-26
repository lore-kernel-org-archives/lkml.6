Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E52C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL8Bha0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeK0ENZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeK0ENZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:13:25 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D23A20672;
        Mon, 26 Nov 2018 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543252719;
        bh=lrj9ahwHOd/wzj+Ut8sjCGAOH+1/JNl0hmJ1YfS4XL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL8Bha0AVJ1qGjurRElOSY6OyEU4OvuizG4O7WHGg99HLxyy9oGKer19I345WV3GF
         nkdLCMJVZq1R7pWuvHQk88Xlxzy8Tc/S9+ENCOkH8NkA69gYdTdTkXB8lmLM5lTTfr
         jTSzW8vDivHo2mJx5bE8G0fhSJosVOWgvubr2oig=
Date:   Mon, 26 Nov 2018 12:18:36 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Matt Hart <matthew.hart@linaro.org>
Cc:     boris.brezillon@bootlin.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, nicolas.ferre@microchip.com,
        rainyfeeling@outlook.com, johan@kernel.org
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Message-ID: <20181126171836.GB100860@sasha-vm>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
 <20181126160840.1c702e87@bbrezillon>
 <20181126151601.GA100860@sasha-vm>
 <CAH+k93GJjYB75Z+zkrzdkbabUaTSzWCfLGXuuVRuu8ML=6yY6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH+k93GJjYB75Z+zkrzdkbabUaTSzWCfLGXuuVRuu8ML=6yY6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:39:03PM +0000, Matt Hart wrote:
>On Mon, 26 Nov 2018 at 15:16, Sasha Levin <sashal@kernel.org> wrote:
>>
><snip>
>
>> >>
>> >> /drivers/mtd/nand/atmel/nand-controller.c: In function
>> >> 'atmel_hsmc_nand_controller_legacy_init':
>> >> /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
>> >> declaration of function 'of_get_compatible_child'; did you mean
>> >> 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
>> >>    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
>> >
>> >Looks like of_get_compatible_child() has been introduced in 4.18, hence
>> >this error.
>> >
>> >Greg, can you drop this patch from 4.14.y?
>>
>> Interesting, none of the kernelci builds caught this? hmm
>
>They did, a few arm defconfigs failed to build because of this error.
>https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.83-64-gd81d0be7d560/

Indeed, and it was even removed from a few (but not all) of the branches
it failed on. I retract my kernelci comments :)

--
Thanks,
Sasha
