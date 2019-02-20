Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0782C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46020851
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y5OzlUMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBTLgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:36:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBTLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:36:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KBT3WJ014886;
        Wed, 20 Feb 2019 11:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=izfia1KiuXgUV8A8PGApopJeIHuPLnpjxsKgv4nNIEQ=;
 b=y5OzlUMKcL34moZoGjuZxugW6eYBGvN01DyzDcz5j4fe9Jfu6dIOTZjOLnBLrwI1d644
 5zbUk+/GzwSLsv2Ig6Ss4cTsjkbKT2oEn0vYXMXn1NEsasImkzTz4NQ10Sb1+ICr4Jjy
 e2uLSU8r//T7/Qq7owqDFpkBPXwoy8n0SrhG/RG28/s46bkFbDvuF+SQCeko4u43KPrZ
 CC4T/41kdMMVjY2m+p1fVr2HqP1gFaiI1ocSBKqNfxh4H56BIWPwGKHvrMx2o0dZU/7D
 h0BCVGKp9wyn7kCyCrX+tPX/8BjDhaUetryDaI9180HNnI9H0S2emmpOxn4jquOcWEvV OQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81e95a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 11:35:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KBZESM026861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 11:35:15 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KBZDKx017732;
        Wed, 20 Feb 2019 11:35:13 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 03:35:13 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190215170235.23360-7-steven.price@arm.com>
Date:   Wed, 20 Feb 2019 04:35:11 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
To:     Steven Price <Steven.Price@arm.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 10:02 AM, Steven Price <Steven.Price@arm.com> wrote:
> 
> The pte_hole() callback is called at multiple levels of the page tables.
> Code dumping the kernel page tables needs to know what at what depth
> the missing entry is. Add this is an extra parameter to pte_hole().
> When the depth isn't know (e.g. processing a vma) then -1 is passed.
> 
> Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
> natural numbers as levels 2/3/4.

Nit: Could you add a comment noting this for anyone wondering how to
calculate the level numbers in the future?

Thanks!
