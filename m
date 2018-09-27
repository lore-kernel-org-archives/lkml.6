Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89311C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444D0216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gbtlE8Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444D0216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeI0WGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:06:43 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:58656 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeI0WGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538063270;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=V3Hi6RUl2kVNzb8iAHSoJhIPoOlipUckfREYymvc/lM=;
        b=gbtlE8QwhR67KnPYF+XHeipqONMGvvAN7j7XYCgzS0dbc3VCJDelWgAKIcLHDvli
        vEtt4oObYbZw3Qb+5wuMCQ+/sj5thj6j5JerD+sUkp/83rSEgOZH/zU2FzOLfbc5eth
        kySqr20udFczJt3FO36O5/BJxflFm6XjTKzu4cic=
Date:   Thu, 27 Sep 2018 15:47:50 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
In-Reply-To: <CACT4Y+aDFD6O48nV5J9UpXLiNpTPuSFoBQ4HVC+Kg1tM_KFEiQ@mail.gmail.com>
Message-ID: <010001661bb70227-d4c9d54f-3870-403f-8103-0296caf0b76d-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com> <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com> <20180924184158.GA156847@dtor-ws> <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com> <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com>
 <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com> <010001661b631a3e-f398fc0a-127c-4c6e-b6ca-b2bd63bc4a9a-000000@email.amazonses.com> <CACT4Y+biYtFUV7hK2ne2RfrbZjMt=4FK4deE0B6WykwT2qSt2g@mail.gmail.com>
 <010001661b9fad1d-cdbfabdb-5553-446f-bcde-585e42837415-000000@email.amazonses.com> <CACT4Y+aDFD6O48nV5J9UpXLiNpTPuSFoBQ4HVC+Kg1tM_KFEiQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.27-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Dmitry Vyukov wrote:

> > Please post on the mailing list
>
> It is on the  mailing lists:
> https://lkml.org/lkml/2018/9/27/802


Ok then lets continue the discussion there.
