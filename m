Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0883C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfANS0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:26:21 -0500
Received: from smtp.infotech.no ([82.134.31.41]:58790 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANS0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:26:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 563292041D4;
        Mon, 14 Jan 2019 19:26:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SFJEaAsa9cXk; Mon, 14 Jan 2019 19:26:16 +0100 (CET)
Received: from [192.168.48.23] (host-192.252-161-233.dyn.295.ca [192.252.161.233])
        by smtp.infotech.no (Postfix) with ESMTPA id 7F38920417C;
        Mon, 14 Jan 2019 19:26:14 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     Qian Cai <cai@lca.pw>, Esme <esploit@protonmail.ch>
Cc:     David Lechner <david@lechnology.com>,
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
 <51950f43-1daf-9192-ce9b-7a1ddae3edd2@lca.pw>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <1d749c95-542f-e65d-4f1b-41d905952d77@interlog.com>
Date:   Mon, 14 Jan 2019 13:26:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <51950f43-1daf-9192-ce9b-7a1ddae3edd2@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-14 12:58 p.m., Qian Cai wrote:
> Unfortunately, I could not trigger any of those here both in a bare-metal and
> virtual machines. All I triggered were hung tasks and soft-lockup due to fork bomb.
> 
> The only other thing I can think of is to setup kdump to capture a vmcore when
> either GPF or BUG() happens, and then share the vmcore somewhere, so I might
> pork around to see where the memory corruption looks like.

Another question that I forgot to ask, what type of device is /dev/sg0 ?
On a prior occasion (KASAN, throw spaghetti ...) it was a SATA device
and the problem was in libata.

Doug Gilbert

