Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4F20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XFD8dL/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F4F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeLCRbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:31:34 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39494 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLCRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:31:33 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A194010C0752;
        Mon,  3 Dec 2018 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543858287; bh=cwjNOLF2O1SiGXoMRRMvEo5GyTRriUa6wv6kjPUw7ys=;
        h=From:To:CC:Subject:Date:References:From;
        b=XFD8dL/daEnoxR91eJ/FUjdhmnQXgjkMkuSZs3oQFHRxMn3Cl6hufffVdnkQByLDc
         uiYvW0enVNX9xTx+3oa7JhDIHD7Z8/N+rNlnnQAIUGhRlXuitQ+lvKwJFOjMi4KCI2
         xvK0PNhKfg0KOB/soK61PpmJ50USAir11qpwlBR55U/7B2N2ywTzIv4baovKZO2kZb
         XLjYTkwn9H3LsMEO8tIwz5tOv7W8Y2sGHkCOCR12+z078+LExGfRp5H1cqK9PUQp+d
         4yunqtod72QyQtK9UzEsqnuxzIGRN8IbCMkodbiCz+zuLeVOQ7oCjJ12I69lbwhUUo
         Lz0Cy/VC9A+YQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id F0AED3F3D;
        Mon,  3 Dec 2018 09:31:25 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Mon, 3 Dec 2018 09:31:25 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Arnd Bergmann' <arnd@arndb.de>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>
CC:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+/oo0RKKbidaU63fw0ncGEK7A==
Date:   Mon, 3 Dec 2018 17:31:25 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641A923@US01WEMBX2.internal.synopsys.com>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
 <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
 <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
 <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
 <CAK8P3a2mqEb4_F4wB1DvL5jJJobLhOg6-bW3ZDNGhvbv-_qW3A@mail.gmail.com>
 <3afe0e1bbf2d42d3bb178ec789553c28@AcuMS.aculab.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641A413@US01WEMBX2.internal.synopsys.com>
 <a668562bf3cb410e90484eb0d4a436a7@AcuMS.aculab.com>
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

On 12/3/18 2:10 AM, David Laight wrote:=0A=
> From: Vineet Gupta=0A=
> ...=0A=
>>> It also seems to have used a different type of loop to the=0A=
>>> other example, probably less efficient.=0A=
>>> (Not that I'm an expert on ARC opcodes.)=0A=
>> The difference is due to ISA and ensuing ARC gcc backends. ARCompact bas=
ed cores=0A=
>> don't support unaligned access and the loop there was ZOL (Zero delay lo=
op). In=0A=
>> ARCv2 based cores, the gcc backend has been tweaked to generate fewer ZO=
Ls hence=0A=
>> you see the more canonical tst and branch style loop.=0A=
> Is this another case of the hardware implementing 'hardware' loop=0A=
> instructions that execute slower than ones made of simple instructions?=
=0A=
=0A=
Not really. ZOL allow for hardware loops with no instruction/cycle overhead=
 in=0A=
general. However as micro-arches get more complicated there are newer "gizm=
os"=0A=
added to the machinery which sometimes make it harder for the compliers to=
=0A=
optimize for all the cases. ARCv2 ISA has a new DBNZ instruction (similar t=
o x86=0A=
you refer below) to implement loops and that is preferred over the ZOL.=0A=
=0A=
> The worst example has to be the x86 'loop' (dec cx and jump nz)=0A=
> instruction which is microcoded on intel cpus.=0A=
> That makes it very difficult to use the new addx instruction to=0A=
> get two dependency chains through a loop.=0A=
=0A=
