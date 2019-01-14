Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8340C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A71204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KQ0rxsMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANR6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:58:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43465 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:58:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id z18so11054730qkj.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJ9fNvZaZwlEFd3E1QXRFZoKFDeQNfO8s60LHEBjPEQ=;
        b=KQ0rxsMZAEsuVT6T5ptEyJAZRBFkiRnDxOx2BRJ9aPbjCoypBVubc8kCfwTIRKPwu0
         yD67hp62PgvRMQWXTiTBubzMfMBnkDxoBZS4ryrJ7u3QZXorksiJVxww9AV5qjG8My05
         dm5Ix9HzYseY4RO6SmearrYl0+0FX4EfTOG6zoMU95m07EeSRgMgP9kSZjCGy8qJMdSc
         gk8D9L+fwJYrQbIzUvQsHEsc6fHr79yJQIXcY1oyRb8xVHtQsxr5UchARuJl7Zwm+/dl
         FNyA43cSxMXAjv0t5faOpYl6xng7MImeWbbaWZiLx909jGPbIjBlD0aS3mEeYLJz9mLJ
         hY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJ9fNvZaZwlEFd3E1QXRFZoKFDeQNfO8s60LHEBjPEQ=;
        b=ae0BKxcpirsN0RGJsD7Hw6zaBo822ib7ozqmCsBlCWuSPgMy53rTLyN0NIIEdKVwH3
         sF483VjnDchT+PxQibp5HCsvVtsk2ZvxEOZn+n/JR8UBs8CelzfPeHBe62+yxNtLoLRv
         UHcsWP+9WfHE9LxKKmsnAzQh/s9ZuyAAtO0ib7BGpMCv/RUgdbHopvcoiHRYYwPWEQK6
         giPtqwH7Juelz/Eh01MuaEDSV/nHnRcMaS1pYMP8voiMBCe/55u4BF+8eTUfjFNIjDhM
         Sy+tH+faeB8yj5I4BUzxpyags69MOcCRPYlLXFpOL9ZcgQmsbxAabhfWI/yZVxlxPjiu
         vVmw==
X-Gm-Message-State: AJcUukcbs6tmVraLIAoATrGIs5Opau33owgEcDmoiE2b8kzqu77n76vG
        z0wH0dtW0vx+O6Vg3jVjjqGCrOcVT9+oVQ==
X-Google-Smtp-Source: ALg8bN5ngmfSpkzB+ivfrh28U6sRMRmsfNdyDDwOMvFBhTIRn0c8fBtinU6LA9UcJoYN6B2czRBpcA==
X-Received: by 2002:a37:8b84:: with SMTP id n126mr22094704qkd.355.1547488685769;
        Mon, 14 Jan 2019 09:58:05 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y68sm17019222qkd.49.2019.01.14.09.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 09:58:05 -0800 (PST)
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     Esme <esploit@protonmail.ch>
Cc:     "dgilbert@interlog.com" <dgilbert@interlog.com>,
        David Lechner <david@lechnology.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "joeypabalinas@gmail.com" <joeypabalinas@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <864d6b85-3336-4040-7c95-7d9615873777@lechnology.com>
 <b1033d96-ebdd-e791-650a-c6564f030ce1@lca.pw>
 <8v11ZOLyufY7NLAHDFApGwXOO_wGjVHtsbw1eiZ__YvI9EZCDe_4FNmlp0E-39lnzGQHhHAczQ6Q6lQPzVU2V6krtkblM8IFwIXPHZCuqGE=@protonmail.ch>
 <c6265fc0-4089-9d1a-ba7c-b267b847747e@interlog.com>
 <UKsodHRZU8smIdO2MHHL4Yzde_YB4iWX43TaHI1uY2tMo4nii4ucbaw4XC31XIY-Pe4oEovjF62qbkeMsIMTrvT1TdCCP4Fs_fxciAzXYVc=@protonmail.ch>
 <ad591828-76e8-324b-6ab8-dc87e4390f64@interlog.com>
 <GBn2paWQ0Uy0COgTeJsgmC18Faw0x_yNIog8gpuC5TJ4kCn_IUH1EnHJW0mQeo3Qy5MMcpMzyw9Yer3lxyWYgtk5TJx8I3sJK4oVlIJh38s=@protonmail.ch>
 <5298bfcc-0cbc-01e8-85b2-087a380fd3fe@lca.pw>
 <xeAUGwo5bQoLOJ9aXeSLY9G0hlKWJzjeZ4f4M1Hr8-1ryRwQ3Y-PgQ_eAtFAjpNZnn0zQGk6yHMkoEjjoM99vdhumv4Dey9KP5y6PvSRroo=@protonmail.ch>
From:   Qian Cai <cai@lca.pw>
Message-ID: <51950f43-1daf-9192-ce9b-7a1ddae3edd2@lca.pw>
Date:   Mon, 14 Jan 2019 12:58:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <xeAUGwo5bQoLOJ9aXeSLY9G0hlKWJzjeZ4f4M1Hr8-1ryRwQ3Y-PgQ_eAtFAjpNZnn0zQGk6yHMkoEjjoM99vdhumv4Dey9KP5y6PvSRroo=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, I could not trigger any of those here both in a bare-metal and
virtual machines. All I triggered were hung tasks and soft-lockup due to fork bomb.

The only other thing I can think of is to setup kdump to capture a vmcore when
either GPF or BUG() happens, and then share the vmcore somewhere, so I might
pork around to see where the memory corruption looks like.
