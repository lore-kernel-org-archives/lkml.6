Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39642063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VAnh9Vx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfANPpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:45:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:45:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so26934764qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kiaQ2QabqQBjsVXUnVQX+7B/Z47M0O6A1TckQ7qMiEE=;
        b=VAnh9Vx9ddzHtSCZiQdxTZlSaaQjZU03B2QGjeJlWGqMWOLJoIEkOxFTGoyMO0mFwC
         dq8wlpT9dnheEVCpdbIMDrNhrKawK529G6FcgCQxWYCqVeqzPa2xPFGXUXg8dmcLUUfX
         xoTbY66KR532jmIc4w0C0S654un1i6Q84yBfBbKbVv4/cj1JA1BuNzBfbcTwyuuhtWmL
         na3DpAfvY8c9RlwaEXzaYwrYIl4mZNJgeH9I9eY/6WJ6owEuUr2Nv95U9tBJ2CkuonZu
         oLNwXCU6yyh51txEEb17NZnF9x8MHnwH0EKg9pnSDWUSLGt3EIsMI2NtYqMDFopDmxHU
         27mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiaQ2QabqQBjsVXUnVQX+7B/Z47M0O6A1TckQ7qMiEE=;
        b=hOtIN8F/36+6Cd1Wm4cApmuTjW55jU327sIhdI/0gOj5SBEKFmYg6U1jGes3XKAqQE
         blCN4ujrpt+PnTgoRQwA2n0m3ED+5JEDzlOdjxlDvDZ9WKsgWi9qDR546OFICQ5GCLFV
         fsoYkMePV4QCSqEOMwkoLLVf5aLi73o+MSQPy/PRF5UoVxFA/hsMe5jq3+kk3HdKHvLR
         IKUhnX72erEowCcBYvue8gqXaqWhHUmkjKY0DFi5x+ZXXRGaEHzR9QkfeF4MZ8UYH9NN
         ZtoFsBDaNd/PCjSSlWKNJxSitER61p3EyIm0OLlLyFjkjFBcgGH6yHbsXkHzRGQofqAP
         jrsw==
X-Gm-Message-State: AJcUukeY+OMz1P6Q/1I692VMrTXAts3/WGC1ZVQHcpkscS+iPIt35ZhS
        PuyWeQPypqmmI0+P4z6ww3uASSAezfqHnQ==
X-Google-Smtp-Source: ALg8bN7bfjbKE6MNaw4fHvqJGXu3pqcXNC6HVTjdi6v4IHrQSqLsW7PTJJEEDpysUIWJdpvvn7pdfw==
X-Received: by 2002:ac8:5344:: with SMTP id d4mr24014029qto.372.1547480744014;
        Mon, 14 Jan 2019 07:45:44 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f143sm2513536qka.73.2019.01.14.07.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:45:43 -0800 (PST)
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     Esme <esploit@protonmail.ch>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>
Cc:     David Lechner <david@lechnology.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "joeypabalinas@gmail.com" <joeypabalinas@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <20190111205843.25761-1-cai@lca.pw>
 <a783f23d-77ab-a7d3-39d1-4008d90094c3@lechnology.com>
 <CANN689G0zbk7sMbQ+p9NQGQ=NWq-Q0mQOOjeFkLp19YrTfgcLg@mail.gmail.com>
 <864d6b85-3336-4040-7c95-7d9615873777@lechnology.com>
 <b1033d96-ebdd-e791-650a-c6564f030ce1@lca.pw>
 <8v11ZOLyufY7NLAHDFApGwXOO_wGjVHtsbw1eiZ__YvI9EZCDe_4FNmlp0E-39lnzGQHhHAczQ6Q6lQPzVU2V6krtkblM8IFwIXPHZCuqGE=@protonmail.ch>
 <c6265fc0-4089-9d1a-ba7c-b267b847747e@interlog.com>
 <UKsodHRZU8smIdO2MHHL4Yzde_YB4iWX43TaHI1uY2tMo4nii4ucbaw4XC31XIY-Pe4oEovjF62qbkeMsIMTrvT1TdCCP4Fs_fxciAzXYVc=@protonmail.ch>
 <ad591828-76e8-324b-6ab8-dc87e4390f64@interlog.com>
 <GBn2paWQ0Uy0COgTeJsgmC18Faw0x_yNIog8gpuC5TJ4kCn_IUH1EnHJW0mQeo3Qy5MMcpMzyw9Yer3lxyWYgtk5TJx8I3sJK4oVlIJh38s=@protonmail.ch>
From:   Qian Cai <cai@lca.pw>
Message-ID: <5298bfcc-0cbc-01e8-85b2-087a380fd3fe@lca.pw>
Date:   Mon, 14 Jan 2019 10:45:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <GBn2paWQ0Uy0COgTeJsgmC18Faw0x_yNIog8gpuC5TJ4kCn_IUH1EnHJW0mQeo3Qy5MMcpMzyw9Yer3lxyWYgtk5TJx8I3sJK4oVlIJh38s=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 1:23 AM, Esme wrote:
> I did not yet verify the previous branches but did tune out kmemleak (CONFIG_DEBUG_MEMLEAK no longer set) as it seemed a bit obtrusive in this matter, this is what I see now (note redzone?).
> /Esme
> 
>   114.826116] =============================================================================
> [  114.828121] BUG kmalloc-64 (Tainted: G        W        ): Padding overwritten. 0x000000006913c65d-0x000000006e410492
> [  114.830551] -----------------------------------------------------------------------------
> [  114.830551]
> [  114.832755] INFO: Slab 0x0000000054f47c55 objects=19 used=19 fp=0x          (null) flags=0x1fffc0000010200
> [  114.835063] CPU: 0 PID: 6310 Comm: x Tainted: G    B   W         5.0.0-rc2 #15
> [  114.836829] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1ubuntu1 04/01/2014
> [  114.838847] Call Trace:
> [  114.839497]  dump_stack+0x1d8/0x2c6
> [  114.840274]  ? dump_stack_print_info.cold.1+0x20/0x20
> [  114.841402]  slab_err+0xab/0xcf
> [  114.842103]  ? __asan_report_load1_noabort+0x14/0x20
> [  114.843244]  ? memchr_inv+0x2c1/0x330
> [  114.844059]  slab_pad_check.part.50.cold.87+0x27/0x81

Confused again. Those slab_pad_check() looks like only with SLUB, but you said
you used SLAB. What else did you change?
