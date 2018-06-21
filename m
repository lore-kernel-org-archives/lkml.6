Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0FDC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53026208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7iz4YyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53026208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeFUObp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:31:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44454 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeFUObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:31:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id p12-v6so1826090wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDkqXGQyahGVUCqx9LU0teoulua64IHbcN8YOfTUxVk=;
        b=B7iz4YyKEJvfkhTSZj0zohu4trSnWet1e5hqxbUA42oCE1WR0BeH91bmSLKWftYvtk
         bFSmk69EfCmjAELbZ6s7rSpKSXOKJdmQzAPAvVh58UWqFhuwg8FpjFIOwJCdptmp1rtE
         9f5et4YifzCa2pWGKoHiUwfJ/DM6vS+hqGyOcrB1jFs/wO9pFFG0FQ671VPvf6FzrGmS
         xG3mcf32GbRKtmdkojgo5dVmrK8lc83afTQbtGXEkVQfsJ5PN1MxbpQzwUv+EYL9dpeA
         VbBVc2VKyp/XBlPuAFayxcWV9NKosEeqNI7bhPW77GX78ELM4I+fSMJVE08y8EjbQ4t6
         m7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDkqXGQyahGVUCqx9LU0teoulua64IHbcN8YOfTUxVk=;
        b=E3MQh+pZc4fHaj8Bc3UDUJ0eI1mULdggmXTfbfWV+0tqP93torXgQw5YQAMEHQKTTA
         yk5Psz0+CIDrPrmEMvx/ChM17B3WqPXX6J2H7WEUtWvLSWiGtaaGoBZCPxf1+bXGHD4b
         aCsJrKdw0z2mGnEro1yg6feeUY4CLCGLbSVk8jlE77LBAXMdp3Dbt5on4F0SxthQskZP
         RBSNfhWfn0WSQW6a6YRkR0tw6qnrlkFagGyNvbF5Pv9PeHFk0TVXi2IMYvGAdnlzTgEy
         xywqrdo59ejdK2QCUasJxUezmRXRN6gr4MQb/pW1SKUHPcvBuwZusYBTb48YX9yqjUjr
         ph7w==
X-Gm-Message-State: APt69E22LLjY2koZWAsDfI/t0xMV26MHsv88Fns3VA2/YwEwgoHSSayE
        vtUMRjHdiVOZUq+VL50GdBo=
X-Google-Smtp-Source: ADUXVKJGxd3hNKiRG7HqD/yZytdNRPYixQmTrWfUXl6OqKrDVLcLFILQDefYM1A7IUJhrShfSFRF9A==
X-Received: by 2002:adf:965a:: with SMTP id c26-v6mr22096254wra.197.1529591502947;
        Thu, 21 Jun 2018 07:31:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e13-v6sm7512328wrm.45.2018.06.21.07.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 07:31:42 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:31:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] x86: optimize memcpy_flushcache
Message-ID: <20180621143140.GA14095@gmail.com>
References: <20180519052503.325953342@debian.vm>
 <20180519052631.730455475@debian.vm>
 <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com>
 <20180524182013.GA59755@redhat.com>
 <20180618132306.GA25431@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618132306.GA25431@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Snitzer <snitzer@redhat.com> wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Subject: [PATCH v2] x86: optimize memcpy_flushcache
> 
> In the context of constant short length stores to persistent memory,
> memcpy_flushcache suffers from a 2% performance degradation compared to
> explicitly using the "movnti" instruction.
> 
> Optimize 4, 8, and 16 byte memcpy_flushcache calls to explicitly use the
> movnti instruction with inline assembler.

Linus requested asm optimizations to include actual benchmarks, so it would be 
nice to describe how this was tested, on what hardware, and what the before/after 
numbers are.

Thanks,

	Ingo
