Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCAAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3316208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="afMqltMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3316208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeG0Pwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:52:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39673 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0Pwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:52:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180727143024euoutp014868e2ba8b3a76902cbcdc4d087b6d13~FQDBbppJb0454204542euoutp01s;
        Fri, 27 Jul 2018 14:30:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180727143024euoutp014868e2ba8b3a76902cbcdc4d087b6d13~FQDBbppJb0454204542euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532701824;
        bh=ok+ParegWWntGjOA43lGXoWAu477wHsesX9/25oRQB0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=afMqltMtTDOYeOtjr0cYT90NlsJ6awIZpNoe72J+gAafgZYlfiPkhujiTywXH6p+9
         jjQ2EExjXNPGrhRxomYvgOYFoWQRR8ZSIO2TbCA5L0ov4vgPIF/9pYR1IO7ezd3e/i
         bjCXqK2KrYNeg/NFFYilLydzqhUiTukyJcGyXoDA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180727143024eucas1p1009329e34ba96276a232b362337fb1f7~FQDBG9PrI2741727417eucas1p1C;
        Fri, 27 Jul 2018 14:30:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.09.05751.F7C2B5B5; Fri, 27
        Jul 2018 15:30:23 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180727143023eucas1p1adfe1860327829e7cf39bcdd3290d11c~FQDAW0CFh2741727417eucas1p1B;
        Fri, 27 Jul 2018 14:30:23 +0000 (GMT)
X-AuditID: cbfec7f4-c2dff70000001677-a1-5b5b2c7fe813
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.84.04178.F7C2B5B5; Fri, 27
        Jul 2018 15:30:23 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCJ00HDH4ANMI90@eusync4.samsung.com>; Fri, 27 Jul
        2018 15:30:23 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
Date:   Fri, 27 Jul 2018 16:30:22 +0200
Message-id: <1926566.4EVPFnjd9v@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <e9452238-319e-ad4b-5e9a-df3cd0d25ae8@ti.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87r1OtHRBpPnW1rMv3KN1eLU9iYm
        i8u75rBZzF7Sz2LxufcIo8WTh31sDmweO2fdZfdYvOclk8fxG9uZPD5vkgtgieKySUnNySxL
        LdK3S+DKaPjdxFxwhrfiy9cjLA2M77m6GDk5JARMJBqutbJ3MXJxCAmsYJRYOnkVC4TzmVHi
        at8vdpiq6WffsUEkljFKXJs4jwkkISTwm1Hi1zItEJtNwEpiYvsqRhBbREBOYsrX6SwgNrPA
        YkaJ/l5uEFtYIEJieuN/ZhCbRUBV4nv3OTCbV0BTovXfU1YQW1TAS2LLvnaw+ZxAMxdv3cUO
        USMo8WPyPaiZ8hL79k9lhbB1JM4eW8cIcpyEwBo2iXdbvrJCXO0i8e3TeihbWOLV8S1Q38hI
        dHYcZIJomM4o8ebXUhYIZz2jxJozx5ggqqwlDh+/CLWCT2LStulAp3IAxXklOtqEIEo8JKbM
        P8oKCZZXjBLTvz5gn8AoMwvJtbOQXDsLybULGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn
        525iBMb/6X/Hv+xg3PUn6RCjAAejEg9vwOvIaCHWxLLiytxDjBIczEoivMIq0dFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeaV9IqKFBNITS1KzU1MLUotgskwcnFINjP4/dBYt2fXm6D/Fv9fO
        rKn996z7nABDsMhZM/ELkr+N5E6xmjf/Cl21jt3QZlG856X0LO/bS+8ec5nXl+OzyojRI/NT
        bod6yk1GP6ONRyIanjGvcdx86rjV9J8ZwRKvX95gyK+yePh35ZuWP0q261S8bP7xWjsFx6k2
        rXqb6y68tL91achFayWW4oxEQy3mouJEAKOX5gX7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t/xa7r1OtHRBp/miFvMv3KN1eLU9iYm
        i8u75rBZzF7Sz2LxufcIo8WTh31sDmweO2fdZfdYvOclk8fxG9uZPD5vkgtgieKySUnNySxL
        LdK3S+DKaPjdxFxwhrfiy9cjLA2M77m6GDk5JARMJKaffcfWxcjFISSwhFHixK7nzBDOX0aJ
        J+cuMIJUsQlYSUxsXwVmiwjISUz5Op0FpIhZYDGjxLcFf1hBEsICERKrvk9gAbFZBFQlvnef
        YwaxeQU0JVr/PQWrERXwktiyr50JxOYEGrp46y52iG3TGCV2nvzNBtEgKPFj8j2wQcwC8hL7
        9k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
        eLcd+7l5B+OljcGHGAU4GJV4eANeR0YLsSaWFVfmHmKU4GBWEuEVVomOFuJNSaysSi3Kjy8q
        zUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cCYLB+56ZiT+rWCriPM0/Z6909Y
        +ZZNiVel+ceKLye8PgiEzTqvIHom6IvlDck9K+t/uvTsK5NWuP2oI/5kSvNfodf2HgZJkbMD
        C7NDjH4zTnty4PO6vvc36lfU35n0WSb27IXTeY9a/wTv45L/xfA09aBX4ESPvqlCajqiRzSW
        K9+Zqr5lQ6yqEktxRqKhFnNRcSIAebjuXloCAAA=
X-CMS-MailID: 20180727143023eucas1p1adfe1860327829e7cf39bcdd3290d11c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180727143023eucas1p1adfe1860327829e7cf39bcdd3290d11c
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <2243156.HcYyxvpmOE@amdc3058> <e9452238-319e-ad4b-5e9a-df3cd0d25ae8@ti.com>
        <CGME20180727143023eucas1p1adfe1860327829e7cf39bcdd3290d11c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 27, 2018 10:13:51 AM Keerthy wrote:
> 
> On Wednesday 25 July 2018 07:57 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday, July 11, 2018 07:49:41 AM J, KEERTHY wrote:
> >>
> >> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> .report_temperature is not set in dra752_data which
> >>> results in temperature updates not being propagated by
> >>> ti_bandgap_talert_irq_handler() (it doesn't make much
> >>> sense to handle TALERT IRQ without reporting temperature
> >>> updates to the thermal core). Fix it.
> >>
> >> ATM no one is using TALERT as the thermal software polls on the 
> >> temperature. No real benefit from TALERT.
> >>
> >> TALERT is set at different temperature and software polling thresholds 
> >> come from Device tree and i believe its best for software to go by 
> >> polling and then act on trip points.
> > 
> > Could you please explain what do you mean by "no one is using
> > TALERT"?
> > 
> > The code in ti_bandgap_probe() sets TALERT thresholds and requests
> > IRQ if the TI_BANDGAP_FEATURE_TALERT feature flag is set (and this
> > flag is set in omap4460_data, omap4470_data, omap5430_data and
> > dra752_data).
> 
> The software thresholds and the polling takes care of reducing the
> temperature. What i actually meant was we never relied on talert and the
> polling takes care of keeping a check on the temperature.

OK I see, maybe TALERT handling can be removed altogether?

If not can we make TALERT behavior on DRA752 consistent with other
chipsets supporting TALERT (this is useful for code unification
between OMAP5430 and DRA752)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

