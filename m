Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06372C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0082082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="akPRnskk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0082082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHaDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:02:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:02:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so7724216edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uh3rUbTA72ffcOfk4+7Wim6CAVUdnooZ3OV3XmFX0ew=;
        b=akPRnskkWlL0YubPfZjzM6Gac4ybAivfL7vQdxXlpQ05xcII4IDeRVWED/XFa20ONY
         auE2PQM31MqcSRbwdt3SRPvo5urvMKgk8dGyluG8CvSSUtAKxFPKO3jidaym0AHfoxx1
         a9g4/MIdC+u6qG+1J9I+KBq/XEjc8iFVN9oTFIBPvgCkijKks6VCY7ClcJ5Aehh6sru7
         BRYdyvnBF5HtmRnb8nR2HQPdgz7EG0CYsyXddBpjljs+saMaWLT/u0pwrWi8+kqvL4Nj
         0yUixJWCcVK9tQr10rr8oU6qMY+iTK3up7sQAJnjdGwp3NBItKkNc4U055qf+ybAjiz/
         8HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uh3rUbTA72ffcOfk4+7Wim6CAVUdnooZ3OV3XmFX0ew=;
        b=PuYNP/0w6+6BYVHUNi9+LnjYf+EI1N8jz7QttqOPHKcsSNFqvbPDKhZ/TeFTfDx2nW
         BU5w/5ybyPrE5C6C13USdLzNvbIoUbtbAIRHaJgqwTIkSKgrOeakxeM4nZlgrauiwjAf
         B+ftuDsEYjw11edIXOPT4e56P8VnIO6L2A50gZychTv5FrhDk50XrGv1uNHWJGU9K8tL
         T6649AHMdJKyiA54TD24TjaNi4eS2adP4rZMisnkEepKHTQK1BZpVJmy8hJsNfRr+BoJ
         xVe0L4oufX6UJK6t9BDhvfjmOaKz0vndtskbOylPcS80uwWds72RKq18xje0unQlbcQc
         uVjA==
X-Gm-Message-State: APzg51AeHliZZKqvrrNPtdGOcfaet6n7e5pF2W16SG154n37NKiA0xeg
        l4VpftAfO0dNaj+ioW59cWwMqQ==
X-Google-Smtp-Source: ANB0VdYbMzK24GQSfE9RwLBMpddSh2ldd9s/dz2tn7OEdOwQUBfC7+p7uIK6rydx7hTBwNFF1CL58g==
X-Received: by 2002:a50:8e09:: with SMTP id 9-v6mr14593840edw.101.1535669874900;
        Thu, 30 Aug 2018 15:57:54 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x32-v6sm4289847eda.81.2018.08.30.15.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 15:57:54 -0700 (PDT)
Message-ID: <1535669872.23560.73.camel@arista.com>
Subject: Re: [PATCH 05/23] selftest: vm: add unlikely() to BUG_ON()
From:   Dmitry Safonov <dima@arista.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Igor Stoppa <igor.stoppa@huawei.com>, Shuah Khan <shuah@kernel.org>
Date:   Thu, 30 Aug 2018 23:57:52 +0100
In-Reply-To: <20180830223429.30051-6-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
         <20180830223429.30051-6-igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Fri, 2018-08-31 at 01:34 +0300, Igor Stoppa wrote:
> BUG_ON() is unlikely() to BUG()

This selftest runs in userspace..
So, we should define the macro somehow, as i.e:
rseq/rseq.h:#define rseq_unlikely(x)    __builtin_expect(!!(x), 0)

Otherwise,
[selftests]$ make vm/map_populate
cc     vm/map_populate.c   -o vm/map_populate
vm/map_populate.c: In function ‘parent_f’:
vm/map_populate.c:26:7: warning: implicit declaration of function
‘unlikely’; did you mean ‘unlinkat’? [-Wimplicit-function-declaration]
   if (unlikely(condition)) {     \
       ^
vm/map_populate.c:38:2: note: in expansion of macro ‘BUG_ON’
  BUG_ON(ret <= 0, "read(sock)");
  ^~~~~~
/tmp/cc7evGVG.o: In function `parent_f':
map_populate.c:(.text+0x3d): undefined reference to `unlikely'
map_populate.c:(.text+0xbb): undefined reference to `unlikely'
map_populate.c:(.text+0x135): undefined reference to `unlikely'
map_populate.c:(.text+0x1b0): undefined reference to `unlikely'

Not sure if we care for this at all for userspace test.
I don't mind as it runs each time by kbuild robot and cumulatively may
save something. But it's better be at least compile-tested.

-- 
            Dima
