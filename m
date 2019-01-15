Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CBB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="I8RQ8Dkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfAOFbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:31:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35971 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:31:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so1765936qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0+BFmS8gMTsuE/WiAl8/AvypSE7lqHoSKA/VjxHFrGA=;
        b=I8RQ8DkzOBs8WNHOupnmRbipu7H7HC+8ySov3sBfxqkuY3O/rCK3zJ58xGr+U96d6F
         pyhK6YG3E2qTSOKCQR8EvsKO7eNtBsUtXvslpDghDa6r0AoOQRAdOaDVTrF2jdBGO9n/
         q6Ucbvb9h/vIKMm2zsebkGWROjfkIUXXIlvE07g5lEmXR9Vgb6KwMJXQ95BdRzCUa+uw
         0u/CwCXb27C7UHTPl3f/CAAdciWluz8/41sRl0+PiKfeUYn3k+3CC/jiOv+VwMSFGxM3
         Lyt9sGOXIzEuYAWrJ+9KQwSozXfuglqfkN2hN+OOSlMV4kIl24UNv11nbPSLPja7UQW+
         xnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0+BFmS8gMTsuE/WiAl8/AvypSE7lqHoSKA/VjxHFrGA=;
        b=mudxQmjeKxxtPKzpDo2etnfJrSdmSTThNhkuhySrnVTQ4U/uAPm6sgKKx2car/6+4w
         YV4FBv57JB7xN6UhTx3AKoBd/8YGqrMJSSvFLeM5Wq57OGouVZ9RPdCjvQFL5sp5DR8c
         ewehKUnGag2FtosdCaHOSwp2EMxhTTIFccvmko7M1Y20vw5Z8BFB+mNVxkaSETk81yA3
         QsrapCOa4zpE4oGAiWYafYv06O7J9soZbqbB1SEmQHztG9xYmNvC7ZsOsVl3y5t1ynkg
         pcLXeP/3RKx8nARSrhCMGAWoOmSiRXvaW3keYWdERMbQy+BEykvxCXqJ4hIa6sF710ws
         Wygw==
X-Gm-Message-State: AJcUukdP6xDwVLiJkc89KOk5fEly9C16UNVUvnC6N44dHqQMI+jOaD/E
        g/12ElVOIxx0A5BNoIMDWBqt5L1B2R5LXg==
X-Google-Smtp-Source: ALg8bN7fNi4nzmkPstzcsdTHr7A3R7/gpZ6zaLfO6fTPaMk/AfDeTvX4oUXNN1nJs+VlyGGbX22fiQ==
X-Received: by 2002:ac8:254c:: with SMTP id 12mr1532407qtn.88.1547530282219;
        Mon, 14 Jan 2019 21:31:22 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x199sm30581809qkb.39.2019.01.14.21.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 21:31:21 -0800 (PST)
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
Message-ID: <dac115ca-d6ed-dfc0-161a-8e51a7f93e00@lca.pw>
Date:   Tue, 15 Jan 2019 00:31:20 -0500
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


> [  114.913404] Padding 000000006913c65d: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.915437] Padding 000000002d53f25c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.917390] Padding 0000000078f7d621: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.919402] Padding 0000000063547658: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.921414] Padding 000000001a301f4e: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.923364] Padding 0000000046589d24: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.925340] Padding 0000000008fb13da: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.927291] Padding 00000000ae5cc298: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.929239] Padding 00000000d49cc239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.931177] Padding 00000000d66ad6f5: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.933110] Padding 00000000069ad671: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.934986] Padding 00000000ffaf648c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.936895] Padding 00000000c96d1b58: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.938848] Padding 00000000768e4920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.940965] Padding 000000000d06b43c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.942890] Padding 00000000af5ae9fa: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.944790] Padding 000000006b526f1e: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  114.946727] Padding 000000009c8dffe3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

Another testing angle,

It might be something is doing __GFP_ZERO and overwriting those slabs. This also
matched the red root corruption, since RB_RED is bit 0.

One thing to try is to enable page_owner=on in the command-line, and then obtain
sorted_page_owner.txt before and after running the reproducer.

$ cd tools/vm
$ make page_owner_sort

$ cat /sys/kernel/debug/page_owner > page_owner_full.txt
$ grep -v ^PFN page_owner_full.txt > page_owner.txt
$ ./page_owner_sort page_owner.txt sorted_page_owner.txt
