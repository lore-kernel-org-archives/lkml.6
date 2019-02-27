Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1940E2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k5of6qjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfB0SS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:18:29 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:46802 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfB0SS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:18:29 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 6D16C24E0DA5;
        Wed, 27 Feb 2019 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551291508; bh=3Izw665ZZgQEjbSE8CmRnZ9pKkiBA01cgGaMPRuksQg=;
        h=From:To:CC:Subject:Date:References:From;
        b=k5of6qjcnGOCE4OtuX4syNNcfm+iwtEFk9QAcd4ySNtJfthcWh+Wg3RlWca/WsOVP
         k8xz8fO/Cn1BTWUZ2Y2ASE7uzAVVal9+kgVtXEAlDPDMt5QGPlSnTXIR/xwWrCd0ki
         yH01k1BOznXaY9OjjzjQRn08rSX/zVgw4teD4hvhPGtKB14TtyzovQRYsVyqCiPtmK
         qsPJQbl5Wa3VJPR54SAiYzTk24F+ZPq+rYneCxVtXioAhpr5mHmVT5dbQXIDGYPk5B
         yZQ2hBH8zd3O73ODMl9wSVGh1X6et1XThvERgZXkw0RnT37ftIXJohr4GhSVZci0aA
         uODcwlEL/C2NA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BA747A005D;
        Wed, 27 Feb 2019 18:18:24 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Wed, 27 Feb 2019 10:18:04 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v3 02/34] arc: mm: Add p?d_large() definitions
Thread-Topic: [PATCH v3 02/34] arc: mm: Add p?d_large() definitions
Thread-Index: AQHUzr7PbHQ5S+UVlUyl9IbMWKnRrQ==
Date:   Wed, 27 Feb 2019 18:18:03 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146437D4C@US01WEMBX2.internal.synopsys.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-3-steven.price@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 9:06 AM, Steven Price wrote:=0A=
> walk_page_range() is going to be allowed to walk page tables other than=
=0A=
> those of user space. For this it needs to know when it has reached a=0A=
> 'leaf' entry in the page tables. This information will be provided by the=
=0A=
> p?d_large() functions/macros.=0A=
>=0A=
> For arc, we only have two levels, so only pmd_large() is needed.=0A=
>=0A=
> CC: Vineet Gupta <vgupta@synopsys.com>=0A=
> CC: linux-snps-arc@lists.infradead.org=0A=
> Signed-off-by: Steven Price <steven.price@arm.com>=0A=
=0A=
Acked-by: vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
