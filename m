Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8AAC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813E720879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ylyQcqMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813E720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeLEPyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:54:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38070 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeLEPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:54:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so10259973plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=392UV8beoUasC1QsWmvdHjNMQmpl1CoCyfHmO/0uTmo=;
        b=ylyQcqMw9j+b4BL38Wg1nZB76lTbCWoe3t6/bCr363B6z5lcq/DVpqFpzyrArmY4QY
         Lqe8Hn4o8ENQOrPLyxh+w9/BtbmhzMtwjsVm91TcnPnKxc4GRN00FCeLiBvNbIMNVA8H
         KbxhlTvNUpshXXYdVjZZPzuiF4ldoSZ7lQfp8PN3lASdtNDob+HGUELCZGSdueNxHywV
         a95U9p50JQgWrJ/OShmk2+tKvuFl31AGk4ysROQ926UA4NxdnmH2P3mCNv1/7VaBW2FH
         wvLGiMF5xVMwwN0o6G7Pg8TWaCiGC744rseRJuq91WCyddNRfqNFatNvktWoS+FoTcU9
         EKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=392UV8beoUasC1QsWmvdHjNMQmpl1CoCyfHmO/0uTmo=;
        b=JDgX6Tg7rtEnVPiu7UBt+Dpa835LzlyQXG3VAsGxcaHWB1z0hZvQqjvmkv8tYdDHDH
         /1MCVoGBnA5x49VtOm1sKR9cRHzdD5ceG87+Md+PMx+GRyXwLwRgqN09hxXm09H2U5Bu
         bDygS70WodNKYtyj10Hkn3G4Dopha8HFkTe7AA4MePJIiWRz9g1BAl6y5WfzDBG9jqHy
         I6aAJ81p+MeegERPUE1OM7rfdMd72ei0LoBnIWwYLgn3rfJd/f6smRMNQRaLUCXfxDGN
         sHtyJzvTv/CAjFiYXrjj8th4+Jvvbk02Z7azGKhXFb8mHrpQRDC2t5zmKmycyXjg7k1l
         /02w==
X-Gm-Message-State: AA+aEWbH8XPh6aE9Cy1KU/42DDoaqJ+22+wAk5Tq5XyM+QGSbLCLWnkX
        QD+3oRxpw4DvxGwgIxobLLDHPQ==
X-Google-Smtp-Source: AFSGD/UgMsz4FzFXYZHsWTfS9QDiJ4jHQBbc2QTiEAm0C5NL1NKXycQ9/jEXwFFFgONk70kccdGVjw==
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr25460830pln.229.1544025254174;
        Wed, 05 Dec 2018 07:54:14 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:683f:7a90:8a4d:4c99? ([2601:646:c200:7429:683f:7a90:8a4d:4c99])
        by smtp.gmail.com with ESMTPSA id w184sm22949391pgd.34.2018.12.05.07.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:54:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181205152336.GA31197@linux.intel.com>
Date:   Wed, 5 Dec 2018 07:54:11 -0800
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C853E326-E758-4B9B-98DF-73C00D5244B6@amacapital.net>
References: <cover.1542841400.git.luto@kernel.org> <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org> <20181122084119.GA44720@gmail.com> <20181127153202.GA27075@linux.intel.com> <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com> <20181205152336.GA31197@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +       err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]", NULL)=
;
> +       err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   , NULL)=
;
> +       err_str_append(error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR, N=
ULL,
> +                                                         "[READ]");

Ah, I see the issue.  OTOH, printing [READ] [INSTR] wouldn=E2=80=99t be so b=
ad, either.

