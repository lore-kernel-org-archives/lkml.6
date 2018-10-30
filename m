Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EE020870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l3wptRdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EE020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJaA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:59:56 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35030 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaA7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:59:55 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C3F7C24E1056;
        Tue, 30 Oct 2018 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540915551; bh=CHCKeUD2lFBeui0FSrELj4dT6AT5144glo5YAxnhHwA=;
        h=From:To:CC:Subject:Date:References:From;
        b=l3wptRdKoo242r2DjT1aMZtTrOuXf/4yVrF8lwQmgXqx/YPy8IJiFnKZr+FR0oR5A
         75DTKQHcEOdmjsliDUtWqT2yj710sZlBEQ1FvYuof+ueRcPATYQGEkVuUruRRoMlqt
         2AF9C3i4fynIHaXR3wadRUS4DgHdvqgPlZj2Hugp/5ByX035r02q/vZr8dYxxLi3FX
         uwci68HM4BVyk0sI7uWUehNkbICxhuS8Fp+17yCsYyI3m05TgKX+QI+26hRS3mOKZp
         fe5aRUH9tMNSbqGNuNFyyCoPRWxvNydtJUd5hIylkxQPsFRMTzn3P5Fiv4HwXHX4tD
         U6+vwnz5+UsEg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id B2AFD5A3F;
        Tue, 30 Oct 2018 09:05:51 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 30 Oct 2018 09:05:51 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH v2] ARC: IOC: panic if kernel was started with
 previously enabled IOC
Thread-Topic: [PATCH v2] ARC: IOC: panic if kernel was started with
 previously enabled IOC
Thread-Index: AQHUcC4rsYY5HtVEO0ekS8lnQMQtuw==
Date:   Tue, 30 Oct 2018 16:05:51 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A5892D6@us01wembx1.internal.synopsys.com>
References: <20181030085421.7657-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 1:54 AM, Eugeniy Paltsev wrote:=0A=
> If IOC was already enabled (due to bootloader) it technically needs to=0A=
> be reconfigured with aperture base,size corresponding to Linux memory=0A=
> map which will certainly be different than uboot's. But disabling and=0A=
> reenabling IOC when DMA might be potentially active is tricky business.=
=0A=
> To avoid random memory issues later, just panic here and ask user to=0A=
> upgrade bootloader to one which doesn't enable IOC.=0A=
>=0A=
> This was actually seen as issue on some of the HSDK board with a version=
=0A=
> of uboot which enabled IOC. There were random issues later with starting=
=0A=
> of X or peripherals etc.=0A=
>=0A=
> Also while I'm at it, replace hardcoded bits in ARC_REG_IO_COH_PARTIAL=0A=
> and ARC_REG_IO_COH_ENABLE registers by definitions.=0A=
>=0A=
> Inspired by: https://lkml.org/lkml/2018/1/19/557=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> Changes v1->v2:=0A=
>  * Fix regression: check for IOC existence before accessing to any IOC=0A=
>    register.=0A=
>=0A=
...=0A=
...=0A=
>  		arc_slc_disable();=0A=
>  =0A=
> -	if (is_isa_arcv2() && ioc_enable)=0A=
> +	if (is_isa_arcv2() && ioc_exists)=0A=
>  		arc_ioc_setup();=0A=
=0A=
Folded this hunk into existing patch in for-curr.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
