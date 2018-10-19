Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5438CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F1321476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4SD+Qck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F1321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJTCIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:08:32 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33175 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJTCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:08:32 -0400
Received: by mail-vk1-f194.google.com with SMTP id l186so7700297vke.0;
        Fri, 19 Oct 2018 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXUe+vCIjZVN66VlsPa5mayeZ6twOSSkH0KDmFwTV0E=;
        b=j4SD+Qck2O17wW/TEoXUc7gYv3Dn14wwUV4kYPFHIwvxBZ2ch/hPDbQishiD+rnxMM
         CYMoJpU3S/CKPmhPUUg2grYB/OchBMC6EsqWDFoEixT6fYKQZ+pdLi0MjX8qj52jlcRG
         r0wHT6bvmrdATiOZBmxmE1qQfebu0dBMWDJHJ3Gnt2MxzqaT5s9kVimaqqRBK/XG8oIp
         Kglc8N/2jDa6ditWhyPjgPLocN5TmlyF5oAhTAe8o2MksL1HlNteiHZIktggFYSL04uM
         caqaDQfY8ZVz6izKL1rOXdrthq6gOUB763l1K8LJx2VojP0qaphV4mbDeI3/ZwJ2Jl1y
         p0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXUe+vCIjZVN66VlsPa5mayeZ6twOSSkH0KDmFwTV0E=;
        b=YeeDLUV0eVhu2i9Yb5obWPETcinZOkDd5EB8Mif7k3W5nX5u5n1nQBuX9f4evlnsc8
         OsK33TeTyV7PUB70UKVln1sxO8K8iB49kg8nCkH3VHC99nZeTAVvRSki8C9Bh9QK2idT
         dknI9RQw7qBxpghiYvJ6x6yq0xndqDGpckfPyLuBFrnL8qbdc7E8+/3ztTpjQZypEXTt
         2zUu6X4dfZn98afTyM7PLQdXUI836DzqxuqflTxOJ6L2ii7pjN1GklGJFGJ5/IHoqQfW
         lfmIA/Dk8YHiI6NTi5DqWAe5BVDIrWG8YxUPJJR10s1ApFkME6nPORMrM29oas2RieZ7
         FKYQ==
X-Gm-Message-State: ABuFfoiBrQFhbuRdP+aqCtJenhKFa5df6Kzo8c98TU86mWArmCgqbjJA
        gu5hpGVUPHIY0JGthHBhTUdqwOziClWKSbBscNRHUwa+
X-Google-Smtp-Source: ACcGV60Iwnmf7be0oJZL55M2HcMAhbyJij3/NaVF0chKg2JhZZdGxxT9LoLvPKvWoQYxKYbxAzvFNakiBEqlvYK8cUQ=
X-Received: by 2002:a1f:cfc7:: with SMTP id f190-v6mr15199059vkg.11.1539972083204;
 Fri, 19 Oct 2018 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181019142436.2955-1-anders.roxell@linaro.org>
In-Reply-To: <20181019142436.2955-1-anders.roxell@linaro.org>
From:   Y Song <ys114321@gmail.com>
Date:   Fri, 19 Oct 2018 11:00:46 -0700
Message-ID: <CAH3MdRV+pBOq_KqH2dY2cVUvaRwb1545-jWuZyoH7bwR_X5VJQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: add missing executables to .gitignore
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 7:25 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Fixes: 371e4fcc9d96 ("selftests/bpf: cgroup local storage-based network counters")
> Fixes: 370920c47b26 ("selftests/bpf: Test libbpf_{prog,attach}_type_by_name")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Yonghong Song <yhs@fb.com>
