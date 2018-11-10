Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC0C20855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gS9xqXau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC0C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKJJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:49:37 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37318 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKJJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:49:37 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8334F10C0F63;
        Fri,  9 Nov 2018 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541808400; bh=wXrYLWdoHfNgE1DR6cCC9Eg5umfNCO6zH4cuut8eTEs=;
        h=From:To:CC:Subject:Date:References:From;
        b=gS9xqXauwoFGyC1UC/JQ00ubQ1cuuIIJuheYhvKjsYGAMYjDnogXfr6M53bD+dPEs
         utWiSaAp4rgivMFHbbfEta3eXuQGhTc46eeZM58Ikg9wNfEwQ/z0o4eytdlW5XUdBK
         SGH3mP5Q1tSLC8wycF5ZvlphbiVEST2/lyJy0iWDvsJ6cfivG7ybU83YepuCZsMr3u
         7GkOA5t15DQtrgkXKsUk6PtZQ38Jzr8Qdc9wpy5NSxgONsP38koo1DqlrOq4/8eDvb
         VdLzHWjlKxMscxnePgoJs5g8nY76/5Omlq4wBvqKs0KBMqgOPgI/rJDXUeymxIXuJW
         PelvRjIsuYDbg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6B0B83096;
        Fri,  9 Nov 2018 16:06:40 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 9 Nov 2018 16:06:40 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
CC:     Elvira Khabirova <lineprinter@altlinux.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13 v3] arc: define syscall_get_arch()
Thread-Topic: [PATCH 06/13 v3] arc: define syscall_get_arch()
Thread-Index: AQHUeIeOhVRqiRAxTEmMOa5dZntzWA==
Date:   Sat, 10 Nov 2018 00:06:39 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A592577@us01wembx1.internal.synopsys.com>
References: <20181109031605.GF21511@altlinux.org>
 <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
 <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
 <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
 <C6CF3942-3307-431F-B76C-B550BB48F472@amacapital.net>
 <215d66fd9a197b631973c9ff75943b4c1216b899.camel@synopsys.com>
 <CALCETrXCcBBTzcL_yz3agNhby1huZSn2UGtJ9Soo=8n8_rj1Tg@mail.gmail.com>
 <20181109233342.GC2710@altlinux.org>
 <C2D7FE5348E1B147BCA15975FBA23075013A59253C@us01wembx1.internal.synopsys.com>
 <20181109235426.GD2710@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 3:54 PM, Dmitry V. Levin wrote:=0A=
> syscall_get_arch() is required to be implemented on all architectures=0A=
> that use tracehook_report_syscall_entry() in order to extend=0A=
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.=0A=
>=0A=
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
