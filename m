Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1178320C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDpSysdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1178320C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeHTVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeHTVVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:21:39 -0400
Received: from mail-yb0-f171.google.com (mail-yb0-f171.google.com [209.85.213.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C395B2173A;
        Mon, 20 Aug 2018 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534788300;
        bh=s50m4qIOmVl3tL/myuUTjQ5nXLnfjr9of9al0dUhJWw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vDpSysdrvQGvRjYSRR//92vyZLrwaoTDRqvgC21QJ7p/MN5PLV1GIqukODI3E8D7h
         CXqIZ+uCqiik5TTo0CYdvPQmnJzKXskesjPw7bnmg57UP44b6ZPBG/3K+sVWG1OaDy
         8A33e5axu9ZANi4W1Ftbx3KxE6jRPs54WRRPJ83k=
Received: by mail-yb0-f171.google.com with SMTP id d34-v6so4947356yba.3;
        Mon, 20 Aug 2018 11:05:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlHw+WBy8A2+sCa8SlY6YfeZhje5U9A9oBhRhGVAtdUkTJl5iHlh
        Vz8Um1UQ6/CJOT7ACTOPwYBoEH92uxx0tuVNfPA=
X-Google-Smtp-Source: AA+uWPybximRdwcjUMlc8Ag+iS3ixTtwaHmc8kpL3EHjtTZk9lthd+oOG8R4Brg/TlW8GAbkQc6rKK5xz4Xj9bvIDKc=
X-Received: by 2002:a25:5446:: with SMTP id i67-v6mr9247341ybb.222.1534788300050;
 Mon, 20 Aug 2018 11:05:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81c4:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 11:04:19
 -0700 (PDT)
In-Reply-To: <20180820175425.zoxnbcz3ziutxaq5@derp-derp.local>
References: <20180820171818.7710-1-mdf@kernel.org> <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
 <20180820175425.zoxnbcz3ziutxaq5@derp-derp.local>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 20 Aug 2018 13:04:19 -0500
X-Gmail-Original-Message-ID: <CANk1AXS9qVMGfdsFGYNe08q60n1keo7FnfwgGYYR4djR+Fd-wg@mail.gmail.com>
Message-ID: <CANk1AXS9qVMGfdsFGYNe08q60n1keo7FnfwgGYYR4djR+Fd-wg@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: dfl: region: Restory symmetry in probe()/remove()
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:54 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Hi Alan,
>
> On Mon, Aug 20, 2018 at 12:46:32PM -0500, Alan Tull wrote:
>> On Mon, Aug 20, 2018 at 12:18 PM, Moritz Fischer <mdf@kernel.org> wrote:
>>
>> Hi Moritz,
>>
>> > Replace dev_get_drvdata() with platform_get_drvdata() to
>> > match the platform_set_drvdata() in the probe function of
>> > the platform driver.
>> >
>> > Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
>> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> > ---
>> >
>> > Changes from v1:
>> > - Still compile after change ...
>> >
>> > ---
>> >  drivers/fpga/dfl-fme-region.c | 2 +-
>>
>> Thanks for catching this.  of-fpga-region.c does a similar thing and
>> needs s/dev_set_drvdata/platform_set_drvdata/ in the probe.  Could you
>> fix it here too?

Actually I should have said something more like
s/dev_set_drvdata(dev/platform_set_drvdata(pdev/

>
> Yeah, can do in a v3 series ... Will add your Suggested-by: ...

Thanks!

>
> Cheers,
>
> Moritz
