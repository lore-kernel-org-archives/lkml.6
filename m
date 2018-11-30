Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB77C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC820834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RFVadNQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BC820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLAGKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:10:21 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52602 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLAGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:10:21 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 168D310C075A;
        Fri, 30 Nov 2018 11:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543604407; bh=mhIv6aro5uYNvZcfRUktwqyyAk3upyCE2TQlFkRY9yI=;
        h=From:To:CC:Subject:Date:References:From;
        b=RFVadNQTbJYD7SILq6j7brN2ZZrVZsmU16y9TIF2OLTTCqaMlXJhhIBg1wGbqSuEv
         uEaUyH5AKYL+C5NLDx3W7rUzPSDI52GnIDBRcaA+IugGp//+fyabDNfKga8c/y7EQd
         gKXE7Dchr+OhEXOyvaWh6nJKThk+KitOABiBMTA1KiK0+6r8szy8eTJvpP395qTvXX
         DkJIxfWIGpYpiEl+yPmpupym4hQhnLsYl+Ahf1Ta2ZeDeNfgXavmAuWXovjrRZ/Nor
         hJHlzw8fs8kC+F+UK+YmSvgBrSURjaxRlT6Poy10McGjYsuqmtyVz80ivgCLngjFjT
         L8amMZmVLLmWg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id CA07E5BB9;
        Fri, 30 Nov 2018 11:00:06 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 30 Nov 2018 11:00:06 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Arnd Bergmann' <arnd@arndb.de>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>
CC:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+/oo0RKKbidaU63fw0ncGEK7A==
Date:   Fri, 30 Nov 2018 19:00:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641A413@US01WEMBX2.internal.synopsys.com>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
 <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
 <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
 <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
 <CAK8P3a2mqEb4_F4wB1DvL5jJJobLhOg6-bW3ZDNGhvbv-_qW3A@mail.gmail.com>
 <3afe0e1bbf2d42d3bb178ec789553c28@AcuMS.aculab.com>
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

On 11/30/18 5:57 AM, David Laight wrote:=0A=
> There're even identical opcodes...=0A=
> The barrier() (etc) in the asm output probably stopped the optimisation.=
=0A=
>=0A=
> It also seems to have used a different type of loop to the=0A=
> other example, probably less efficient.=0A=
> (Not that I'm an expert on ARC opcodes.)=0A=
=0A=
The difference is due to ISA and ensuing ARC gcc backends. ARCompact based =
cores=0A=
don't support unaligned access and the loop there was ZOL (Zero delay loop)=
. In=0A=
ARCv2 based cores, the gcc backend has been tweaked to generate fewer ZOLs =
hence=0A=
you see the more canonical tst and branch style loop.=0A=
=0A=
-Vineet=0A=
