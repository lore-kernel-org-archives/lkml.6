Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8966C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116D20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZtWj7PlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeKJEzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:55:40 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34480 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJEzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:55:40 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4233324E0C6C;
        Fri,  9 Nov 2018 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541790824; bh=Vcdhe8R88kwv7D7J9tmH9NkBzU2i0AfwKuMAJoSXsCk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ZtWj7PlWbHv13S8pze1Ob0M+qXo746TEIMQfieuy4gLgYFBptt1NXELSPQukm7pkv
         Nzy9bCubwlPgV7J0LAnv4dwaO+oEUHyDTFsnGYooIx4l43Zs3G4nIQMUtazvL4iMAt
         8TIv9XNx6voMGBpusgKGC/idJlNAfDb/SlMCoASlNsk9BHZ1FhnsRq55QV2a2HqmK4
         ow9KZPAsroKyyh8eONpI2alhFEO7oTEL+NT/NEkpXSRQm6+QT2zRjdasYovD3cYUyC
         qGwew/5lG41crtuq+yoSAR6f3Ys+arHmL8Jr9dPyhqoDfJcvQjaBnsirU9IxFUCVeX
         MAaQv4UmjUj8w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id E6A7A3C7F;
        Fri,  9 Nov 2018 11:13:43 -0800 (PST)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 11:13:43 -0800
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 10 Nov 2018 00:43:40 +0530
Received: from [10.10.161.72] (10.10.161.72) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 10 Nov 2018 00:43:40 +0530
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
To:     Andy Lutomirski <luto@amacapital.net>
CC:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "Elvira Khabirova" <lineprinter@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc,gmane.linux.redhat.security.audit
References: <20181109031605.GF21511@altlinux.org>
 <C2D7FE5348E1B147BCA15975FBA23075013A59239B@us01wembx1.internal.synopsys.com>
 <6C398ED8-30BC-4483-B5CF-1EB2F2699B0D@amacapital.net>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <f5858051-57fa-dc3f-158a-6afe7fc04ca4@synopsys.com>
Date:   Fri, 9 Nov 2018 11:13:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6C398ED8-30BC-4483-B5CF-1EB2F2699B0D@amacapital.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.72]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 11:03 AM, Andy Lutomirski wrote:
>> Does ptrace (or user of this API) need a unique value per arch. Otherwise instead
>> of adding the boilerplate code to all arches, they could simply define AUDIT_ARCH
>> and common code could return it. Also the EM_xxx are not there in
>> include/uapi/linux/elf.h to begin with since libc elf.h already defines them.
>>
> A lot of architectures allow multiple audit_arches at runtime due to compat support and similar features, so it really does want to be a function.  The goal of this patch set is to get it supported everywhere.
> 

I was wondering if we could have a common syscall_get_arch() simply returning an
per-arch AUDIT_ARCH. But seems like the function itself needs to be per arch
anyways due to the nuances above.

