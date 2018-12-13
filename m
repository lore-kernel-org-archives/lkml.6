Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDE8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fARB5zXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C7420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeLMRWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:22:50 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41008 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbeLMRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:22:49 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6FB7724E2447;
        Thu, 13 Dec 2018 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544721769; bh=JGXz0eK9bsy6yQXx4w6fV/Q0LpM0PjVtOBL1qqullrU=;
        h=From:To:CC:Subject:Date:References:From;
        b=fARB5zXySuzqRT0+1loCuFiLK+SXZfzZ6kgjAU9Xo2sAdIyEp04zWXHDY+clHOH2B
         QHi15k+D2NmPjIdpORJOrQh1qVts7JliW/N30ZNejE9h53WhMKXEAlKx9qWqumdf21
         ZGhxh7k5fbFmovkdtzGRLux+JvxY7da/G8U502YSKpgJnqdTEZGkKVylm0CCHGbHuO
         HekknpGh/G0O0R6urMxXsixPx6R9TIZze8NYF3IxsFCA+oEBJv1z4rKw9c0m1mJv+2
         +VJLwHirceXoMW+ZDVBLFj9H5kqV+ocKwFx1AvxdCp67uVotM5jy8RXtOzi9fbYYwG
         9y06YIr1gkckw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4E060545A;
        Thu, 13 Dec 2018 09:22:49 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 13 Dec 2018 09:22:49 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 4/4] ARC: perf: avoid kernel killing where it is
 possible
Thread-Topic: [PATCH v2 4/4] ARC: perf: avoid kernel killing where it is
 possible
Thread-Index: AQHUkwTZDe0O9rumH0iW9HwwEK2kbw==
Date:   Thu, 13 Dec 2018 17:22:48 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641F690@US01WEMBX2.internal.synopsys.com>
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
 <20181213165621.20817-5-Eugeniy.Paltsev@synopsys.com>
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

On 12/13/18 8:56 AM, Eugeniy Paltsev wrote:=0A=
> No, not gonna die tonight.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
Applied.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
