Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C58AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qoscDJ4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfAOO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:26:08 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2523 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:26:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3ded6f0000>; Tue, 15 Jan 2019 06:25:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 06:26:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 06:26:05 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 14:26:04 +0000
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     Martin Sperl <kernel@martin.sperl.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
Date:   Tue, 15 Jan 2019 14:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547562351; bh=0HIGGipEtEYa/0GmsMEH1E8GbB0IUtS3PEf84XrRXvw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qoscDJ4SpBxkf8t7n8Z2MEeFE7Hs4RA2j4fa9R1Tz14WzSG3ASztR2itCzT8dVYVC
         F3dv2GQOawHG4YNanGzWzP51qTMHP5dweQEQ9sfoZVprkQqi9BFkNEWc7/uO9+Akik
         AVKnn5J9EYkVRNPKQ0g/dfQdTqAlvcyUgCGS+3jodAjmOby2cglAaT794C9z8xgzTV
         NtqQzGYAt1NeroPMBeASpLwW+PR7CPahBxL9638Gnlcwkq9D0r14pGFeNjYv52TyNq
         7Y4aQd9crZEKe6A9ziOul1Kj0oezCFC7cO2zk7oTF3RjY5dvgdXmUo4rkHOwwi9jic
         DWwQjvcjXQR9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 14/01/2019 22:01, Martin Sperl wrote:
> Hi Jon,
>=20
> On 14.01.2019, at 16:35, Jon Hunter <jonathanh@nvidia.com
> <mailto:jonathanh@nvidia.com>> wrote:
>=20
>> Hi Martin, Mark,
>>
>> [ =C2=A0=C2=A058.222033] spi_master spi1: could not stop message queue
>> [ =C2=A0=C2=A058.222038] spi_master spi1: queue stop failed
>> [ =C2=A0=C2=A058.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x5=
4
>> returns -16
>> [ =C2=A0=C2=A058.222052] PM: Device 7000da00.spi failed to suspend: erro=
r -16
>> [ =C2=A0=C2=A058.222057] PM: Some devices failed to suspend, or early wa=
ke event
>> detected
>=20
> Unfortunately I have not been able to reproduce this in=C2=A0
> my test cases=C2=A0with the hw available to me.

Looking at both boards that fail, tegra30-cardhu-a04 and
tegra124-jetson-tk1 they both have a spi-flash. The compatible strings
for the spi flashes are "winbond,w25q32" and "winbond,w25q32dw",
respectively which interestingly are not documented/used anywhere in the
kernel. It appears that there was a patch to fix this a few years back
but never got applied [0]. However, applying this patch does not fix the
issue. Furthermore, without this patch applied I see that the spi flash
is detected fine ...

[    2.540395] m25p80 spi1.0: w25q32dw (4096 Kbytes)

So this is not related but the main point is occurs with a spi flash device=
.

> Looks as if there is something missing in=C2=A0spi_stop_queue that=C2=A0
> would wake the worker thread one last time without any delays
> and finish the hw shutdown immediately - it runs as a delayed
> task...
>=20
> One question: do you run any spi transfers in
> your test case before suspend?

No and before suspending I dumped some of the spi stats and I see no
tranfers/messages at all ...

Stats for spi1 ...
Bytes: 0
Errors: 0
Messages: 0
Transfers: 0

> /sys/class/spi_master/spi1/statistics/messages=C2=A0gives some
> counters=C2=A0on the number=C2=A0of spi messages processed which
> would give you an=C2=A0indication if that is happening.
>=20
> It could be as easy as adding right after the first lock=C2=A0
> in spi_stop_queue:
> kthread_mod_delayed_work(&ctlr->kworker,
> =C2=A0&ctlr->pump_idle_teardown, 0);
> (plus maybe a yield or similar to allow the worker to=C2=A0
> quickly/reliably=C2=A0run on a single core machine)
>=20
> I hope that this initial guess helps.

Unfortunately, the above did not help and the issue persists.

Digging a bit deeper I see that now the 'ctlr->queue' is empty but
'ctlr->busy' flag is set and this is causing the 'could not stop message
queue' error.

It seems that __spi_pump_messages() is getting called several times
during boot when registering the spi-flash, then after the spi-flash has
been registered, about a 1 sec later spi_pump_idle_teardown() is called
(as expected), but exits because 'ctlr->running' is true. However,
spi_pump_idle_teardown() is never called again and when we suspend we
are stuck in the busy/running state. In this case should something be
scheduling spi_pump_idle_teardown() again? Although even if it does I
don't see where the busy flag would be cleared in this path?

Cheers
Jon


[0] https://patchwork.kernel.org/patch/7021961/
--=20
nvpublic
