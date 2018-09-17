Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A106EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4849B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="v0pIH0/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4849B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeIRAuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:50:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57530 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:50:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AA6E85C021F;
        Mon, 17 Sep 2018 21:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537212121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/FIpbY5R8/nPoPMWiq8TV1BX00JHPCOUHqSODxV3l0=;
        b=v0pIH0/5EjZqLpEcJP7KQX7wwprS+SxvQ8rb2pNWBx7Ac8dCr9Ww8s4MyMkNJiNf7s1A2e
        xID/N2mk9qPJv+GwgpHun8cIi4a/kPhr1kBpY8s9Og02K6fg8iYypKd66k3ztz4VOxVnYS
        EnVZCgfB4peSIRNmo41ut7n04YzWn88=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 12:22:01 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
In-Reply-To: <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux> <20180916151513.GA10200@flashbox>
 <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
Message-ID: <6cae089a39c7423be9837b89ca50c8e9@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2018 09:52, Nick Desaulniers wrote:
> On Sun, Sep 16, 2018 at 8:15 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
>> > On Fri, 14 Sep 2018 22:25:11 -0700
>> > Nathan Chancellor <natechancellor@gmail.com> wrote:
>> >
>> > > Clang warns when an enumerated type is implicitly converted to another.
>> > >
>> > > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
>> > > enumeration type 'enum max9611_conf_ids' to different enumeration type
>> > > 'enum max9611_csa_gain' [-Wenum-conversion]
>> > >                         *csa_gain = gain_selectors[i];
>> > >                                   ~ ^~~~~~~~~~~~~~~~~
>> > > 1 warning generated.
>> > >
>> > > Change the type of the variable 'gain_selectors' to int so that Clang
>> > > understands this is expected behavior.
>> > >
>> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > How does this interact with the patch that Stefan Agner sent for
>> > the same issue last week?
> 
> + Stefan in case he has additional thoughts.  I don't feel strongly
> about one patch vs the other.
> 

FWIW, only one is needed.

I prefer mine slightly over Nicks since it continues to use struct max9611_conf_ids which is the type required by the max9611_read_single() function..

I don't have a strong opinion though, and did not look deeper into why the driver makes the differentiation between struct max9611_conf_ids and ax9611_csa_gain...

--
Stefan


>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
>> >
>> > Thanks,
>> >
>> > Jonathan
>> >
>>
>> Hi Jonathan,
>>
>> Sorry for the overlap. My patch is not necessary. I was working off
>> of linux-next so I didn't catch this. I'll be better about checking
>> maintainer trees before sending patches in the future.
>>
>> Thanks for the quick response!
>> Nathan
>>
>> > > ---
>> > >  drivers/iio/adc/max9611.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
>> > > index 0538ff8c4ac1..3c358b16a8fa 100644
>> > > --- a/drivers/iio/adc/max9611.c
>> > > +++ b/drivers/iio/adc/max9611.c
>> > > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>> > >                                 u16 *adc_raw,
>> > >                                 enum max9611_csa_gain *csa_gain)
>> > >  {
>> > > -   enum max9611_conf_ids gain_selectors[] = {
>> > > +   int gain_selectors[] = {
>> > >             CONF_SENSE_1x,
>> > >             CONF_SENSE_4x,
>> > >             CONF_SENSE_8x
>> >
