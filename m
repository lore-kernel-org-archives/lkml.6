Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91810C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402B120811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A0gHO6nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402B120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeLMSXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:23:20 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41512 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeLMSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:23:20 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AB55F10C0C0E;
        Thu, 13 Dec 2018 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544725399; bh=eQ9omTdtGI8YPXkxucnTGpLTuTupiotPXtk1FfrUFMs=;
        h=From:To:CC:Subject:Date:References:From;
        b=A0gHO6nzfz/CHKgdu5WhMwgWRsczgeHPzyxuBBbDQqEVZuX6HX4USYM8e7QPD3qoV
         HE/wXLeVLPaG5vZS04uBmReEcurzIPNCm3dBBaV1nG7uLoGTgyxZp+se9jn+xxdFeh
         /jnCJmt6l7Aw33E3zb9fTiAc6v+l3Xg8T875KqAdXJm5yM/T/bX8iZDpzqWjGnDdPa
         IRqxhd0LRBsoo+oGMo1mWM4CcoynPkDSwIXf8Kj3Zen0pWaz3r+1nD0jr2dT//M+hK
         M95aKGQyzs83uYiN4y52fc1+PxFU0LsWK9EiJOW238kT18MxSXwvh5lylg7PFn7cM0
         HMGMU0LNqV/5w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9FEB33B22;
        Thu, 13 Dec 2018 10:23:19 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 10:23:19 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: fix __ffs return value to avoid build warnings
Thread-Topic: [PATCH] ARC: fix __ffs return value to avoid build warnings
Thread-Index: AQHUkvqJxXSvGyNzLkuvtcEIj0Ff0w==
Date:   Thu, 13 Dec 2018 18:23:18 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641F6E3@US01WEMBX2.internal.synopsys.com>
References: <20181213154257.23033-1-Eugeniy.Paltsev@synopsys.com>
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

On 12/13/18 7:43 AM, Eugeniy Paltsev wrote:=0A=
> Change __ffs return value from 'int' to 'unsigned long' as it=0A=
> is done in other implementations (like asm-generic, x86, etc...)=0A=
> to avoid build-time warnings in places where type is strictly=0A=
> checked.=0A=
>=0A=
> As __ffs may return values in [0-31] interval changing return=0A=
> type to unsigned is valid.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
Can you please paste a couple of lines of offending output !=0A=
=0A=
-Vineet=0A=
