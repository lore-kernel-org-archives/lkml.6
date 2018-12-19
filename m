Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2104C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC67218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jsOuf2//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeLSRgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:36:37 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:43796 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeLSRgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:36:36 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6098410C1DDE;
        Wed, 19 Dec 2018 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545240996; bh=reRGgPCEX8ayZQuwDeyDe/Ot6+K0H9uyGd13ecuL8WU=;
        h=From:To:CC:Subject:Date:References:From;
        b=jsOuf2//1N6dEd2dRvitb19NE1pP1xarPvLXkBt2VhJkiDvOh58XvLq8JV7rOzS+L
         m7KzIUHMt4Ty80KXzIIbYAy3dqye5C4h/O6oe2bjT0OXQ1rT7aphwQdgKuvGCHUsEQ
         MeztA8QEHsfxWSJd5aoZECGWU5+DYBfmNhPuW/4rLihtvbpNo52mGSsDHZn1V2vTZ9
         Tga4Y3x/eCCY9twvtK5k7mqeeh4gHb89fTYyOzj3bIsImnEKTUiN4+3COsZeDRhJ5A
         hjS218QP3UQedEszvW/1tw8OFFHp1xg+fT6x7AU0KKGjlUvbqI7IgW7IhRy1Wn1bSe
         I2TNAJQjiWtUw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 458133ADA;
        Wed, 19 Dec 2018 09:36:36 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 19 Dec 2018 09:36:36 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Topic: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Index: AQHUlwMR8PfsxZ55lUuwqgC40oqmmA==
Date:   Wed, 19 Dec 2018 17:36:35 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642226B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
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

On 12/19/18 9:04 AM, Eugeniy Paltsev wrote:=0A=
> Just curious: isn't that enough to use GFP_NOWAIT instead=0A=
> of GFP_KERNEL when we allocate page in show_regs()?=0A=
>=0A=
> As I can see x86 use print_vma_addr() in their show_signal_msg()=0A=
> function which allocate page with __get_free_page(GFP_NOWAIT);=0A=
=0A=
I'm not sure if lockdep will be happy with it still.=0A=
=0A=
At any rate, as explained in changelog, this still has merit, since the buf=
fer is=0A=
only needed for nested d_path calls, which are better served with a smaller=
=0A=
on-stack buffer. For cases such as kernel crash, we want lesser code/traces=
 in=0A=
fault path to sift thru !=0A=
=0A=
-Vineet=0A=
