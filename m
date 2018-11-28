Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC71C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D6A20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tT3Ehiha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D6A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK1MF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:05:56 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46780 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeK1MF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:05:56 -0500
Received: by mail-yb1-f196.google.com with SMTP id i17-v6so9915712ybp.13;
        Tue, 27 Nov 2018 17:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oEKw5XAazEQBN9tvsv+EkVGZCeB7omnmnmXVeDUn3ik=;
        b=tT3EhihaMUgBIIgedRmXq2B9B2y0EzQAZYnkFH2z1TD2a+KcniQFwbikqGSDP6Nmzk
         52j9FmIigPYVFeUkbVLvAMG0PMgW36ojYo0d04TChZc/Zpi1qU98yWk8SpHIUDs2UoC8
         Xzxg3MlsUFy0iA9c6Ln8OeIfmqOvspAZACZuX7OmyKynNWJw2pnDqmAL7ULNC4v4x4gO
         GoQ8kHSp/9AIaZ43MruF1eSp4nui0LJLopdDpnopKFZjcfimwy7vEG6MAJ/YI/e4wLlm
         2XvJ+GXbaFeiVdd3IC5CJBZ4uS5vNrLAWLie27Mrw5oz/b68KRDJE3C9eSIWDJpTUnBy
         f9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oEKw5XAazEQBN9tvsv+EkVGZCeB7omnmnmXVeDUn3ik=;
        b=f2HveFFlH6nbp0+/v+BhLOQyiWiamiJOCslWhoC9OY/FFiwREb6oeJ+KQll1Q0sorq
         l3W2tlOO6kdrLl0PrtFStSBzQ4ei9Xr67fVRLGx5kG8JAYuBXTSiVuMc5ZiHUrA63DcA
         7Rk4AApQ+R5tqYc6w9FqNjDll8xxoQZp8ltijabOmzs8wlfNCc3cOAweFMzku+wJF2UK
         h2Vta8ezr8X04jMrZWKhQNRjvjmiDBhXMFF8Dp6yurw64Q9919HugOc99TA4xptMGlzD
         4Zf4A/j456P/0xpmjfxBAC8yMjKs45nlxMtgu7EDquilDOBJURRrN/Cf1zcAc5Gr2cyl
         Wffw==
X-Gm-Message-State: AA+aEWY28RwKcwe4fiYappMyDbraMhwsa3rYkw2oCXclkOPUid99d244
        ckuMjg+CH5qs6MLO8EAMhas=
X-Google-Smtp-Source: AFSGD/V7yWe9/bdo7r9LW4WTexMnxJVGhdWXPJxYkTpkkfnTy1LJF2sBttJFB0M1i2/KCiizclZWKw==
X-Received: by 2002:a25:2206:: with SMTP id i6-v6mr34828443ybi.151.1543367170280;
        Tue, 27 Nov 2018 17:06:10 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id x4sm7876302ywj.80.2018.11.27.17.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:06:09 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH_0/2=5D_Don=E2=80=99t_leave_executable_TL?=
 =?utf-8?Q?B_entries_to_freed_pages?=
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
Date:   Tue, 27 Nov 2018 17:06:05 -0800
Cc:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com, kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDB8B7C1-FD55-44AD-9B71-B3A750BF5489@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>=20
> Sometimes when memory is freed via the module subsystem, an executable
> permissioned TLB entry can remain to a freed page. If the page is =
re-used to
> back an address that will receive data from userspace, it can result =
in user
> data being mapped as executable in the kernel. The root of this =
behavior is
> vfree lazily flushing the TLB, but not lazily freeing the underlying =
pages.=20
>=20
> There are sort of three categories of this which show up across =
modules, bpf,
> kprobes and ftrace:
>=20
> 1. When executable memory is touched and then immediatly freed
>=20
>   This shows up in a couple error conditions in the module loader and =
BPF JIT
>   compiler.

Interesting!

Note that this may cause conflict with "x86: avoid W^X being broken =
during
modules loading=E2=80=9D, which I recently submitted.

