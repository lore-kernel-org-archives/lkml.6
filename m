Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D30B20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kjHxkrMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbfAPK6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:58:24 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13629 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:58:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3f0e2e0000>; Wed, 16 Jan 2019 02:57:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Jan 2019 02:58:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 16 Jan 2019 02:58:20 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 10:58:18 +0000
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     <kernel@martin.sperl.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7ffb7c42-a7e1-edf2-2d0e-86d2240b5c9e@nvidia.com>
Date:   Wed, 16 Jan 2019 10:58:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547636270; bh=E9pETKwL6by7SepPKDa5Svi1R6K9HgA6c5Yyt6Z6v/M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kjHxkrMuDNUrV2iPULtfl3trFMpjhGFT8hZOAKNZRxJQ0G9LZ16hyCDQnWC5X7nT6
         S33KuKDuDEQsBGCl/8TUHDGuSKfD2Qtl+UWtCkWBWEA6Ygm9YGWpLfcVWmJAHQGVd9
         ula1VLISBCOCONgBDV/AHbpB7tOHKcTWoQloDeRGbg24QQhKXRuL/wMfKqKyrGe151
         ZOUdFtWtoK0LuSGiLMsGmAfTPzwY8rtuddi2s44HBD94+VtB+Z9bK+OStKAwjUyiZt
         zyzPLDhowLwg6PmeIcCVHoAgFq/2jHaKtlLZV1+eB27uTpSnWagpxCxwuXkzhMB/1Q
         9voOhGJfmp6Xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/01/2019 17:39, kernel@martin.sperl.org wrote:
> Hi John!
>=20
>> On 15.01.2019, at 15:26, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Looks as if there is something missing in spi_stop_queue that=20
>>> would wake the worker thread one last time without any delays
>>> and finish the hw shutdown immediately - it runs as a delayed
>>> task...
>>>
>>> One question: do you run any spi transfers in
>>> your test case before suspend?
>>
>> No and before suspending I dumped some of the spi stats and I see no
>> tranfers/messages at all ...
>>
>> Stats for spi1 ...
>> Bytes: 0
>> Errors: 0
>> Messages: 0
>> Transfers: 0
>=20
> This...
>=20
>>> /sys/class/spi_master/spi1/statistics/messages gives some
>>> counters on the number of spi messages processed which
>>> would give you an indication if that is happening.
>>>
>>> It could be as easy as adding right after the first lock=20
>>> in spi_stop_queue:
>>> kthread_mod_delayed_work(&ctlr->kworker,
>>>  &ctlr->pump_idle_teardown, 0);
>>> (plus maybe a yield or similar to allow the worker to=20
>>> quickly/reliably run on a single core machine)
>>>
>>> I hope that this initial guess helps.
>>
>> Unfortunately, the above did not help and the issue persists.
>>
>> Digging a bit deeper I see that now the 'ctlr->queue' is empty but
>> 'ctlr->busy' flag is set and this is causing the 'could not stop message
>> queue' error.
>>
>> It seems that __spi_pump_messages() is getting called several times
>> during boot when registering the spi-flash, then after the spi-flash has
>> been registered, about a 1 sec later spi_pump_idle_teardown() is called
>> (as expected), but exits because 'ctlr->running' is true. However,
>=20
> and this contradicts each other!
> If there is a call to message pump, then we should process a message
> and the counters should increase.
>=20
> If those counters do not increase then there is something strange.

Actually no, this is nothing strange here at all. If you look Tegra has
it's own 'transfer_one_message' handler (tegra_spi_transfer_one_message
in drivers/spi/spi-tegra114.c) and this does not update any of the
statistics. Looks like the statistics are not updated if a SPI
controller has it own transfer_one_message hander which is a shame.

> If we are called without anything to do then the pump should trigger a
> tear down and stop.

>> spi_pump_idle_teardown() is never called again and when we suspend we
>> are stuck in the busy/running state. In this case should something be
>> scheduling spi_pump_idle_teardown() again? Although even if it does I
>> don't see where the busy flag would be cleared in this path?
>>
>=20
> I am wondering where busy/running would be set in the first place
> if there are no counters...

Looks like running is set true on initialising the queue and busy is set
true in __spi_pump_messages().

> Is it possible that the specific flash is not using the =E2=80=9Cnormal=
=E2=80=9D=20
> spi_pump_message, but spi_controller_mem_ops operations?=20

I definitely see __spi_pump_messages() being called which in turn calls
tegra_spi_transfer_one_message().

> Maybe we are missing the teardown in that driver or something is
> changing flags there.
>=20
> grepping a bit:
>=20
> I see spi_mem_access_start calling spi_flush_queue, which is calling
> pump_message, which - if there is no transfer - will trigger a delayed
> tear-down, while it maybe should not be doing that.
>=20
> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?
>=20
> Unfortunately this is theoretical work and quite a lot of guesswork
> without an actual device available for testing...

Looking some more I think that the problem is ...

1. The controller is put into the 'running' state when spi_start_queue()
is called (which itself is called during the registration of the spi
controller).
2. After sending some messages to initialise the SPI flash,
spi_pump_idle_teardown() is called but exits early because the
controller is in the 'running' state and this prevents 'busy' from being
cleared.
3. On entering suspend spi_stop_queue() is called but the controller is
still in the 'busy' state and so fails to stop.

So the problem I see is that 'busy' is never cleared and before it was.
Furthermore, because 'busy' is never cleared, I see that the SPI
controller is never pm-runtime suspended and cannot be suspended, and so
this will have an impact on power.

With your patch after booting I see ...

$ cat /sys/class/spi_master/spi1/device/power/runtime_status
active

Reverting your patch, after booting I see ...

$ cat /sys/class/spi_master/spi1/device/power/runtime_status
suspended

Does the device you are testing with support runtime-pm? If so what do
you see?

Cheers
Jon

--=20
nvpublic
