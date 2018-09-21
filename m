Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92492150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gh9jgvOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92492150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbeIUWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:45:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42052 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=08oZhVAsrOzYwrbCYvThD4RKeGUmXuT6FdhAm1zidfg=; b=Gh9jgvOZdui0JxmUTjjL3k/9xc
        vxmNrOdGb2RF9ekhRD+RV8BaebwXs4tARAFXqWT1Zam0zf3i+f11Pqvggqe51+MzPwTb+E6KwiOil
        8tF8ZTZjXA3UwsnpG2azt6qVUz1UGb3y0ne0mx9vWfqZ8Wjyrpq2f3fJVOkDZbY0xVmeVoU4/+m+V
        KkszmlW8RGn6P8HSW8HbqS/O0oHKYZoa3Y4GDZg3O9MyA/xsL8QxfmcIQvFUAvEdz8hA4Vfjvq1k3
        9DpAKx0Uilf+ZDupwvsM/t0kUt4c9F1ElZrBZLG08PCNjzPvZMJ1CUuxRBk48F7OZs6VTsGMHbnzt
        +Og0SnnA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3Ohx-0000xV-97; Fri, 21 Sep 2018 16:55:09 +0000
Subject: Re: [RFC PATCH v4 23/27] mm/map: Add Shadow stack pages to memory
 accounting
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-24-yu-cheng.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8c18fabf-170f-9010-3075-238e34c9f09b@infradead.org>
Date:   Fri, 21 Sep 2018 09:55:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921150351.20898-24-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/18 8:03 AM, Yu-cheng Yu wrote:
> Add shadow stack pages to memory accounting.
> Also check if the system has enough memory before enabling CET.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu.intel.com>

oops. typo above.

> ---
>  mm/mmap.c | 5 +++++
>  1 file changed, 5 insertions(+)


-- 
~Randy
