Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84403C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37275222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QW7XapRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395520AbfBNLBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:01:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49474 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfBNLBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:01:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EAwecb195540;
        Thu, 14 Feb 2019 11:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=oBoYKrHmkB0DE74B1po/8VDjK8Xr/YU8KGJgp6PsWoo=;
 b=QW7XapRi9UF3HwATVM8EisoJD4kQ6XotQFX1LnXN6HmumbHSkpdH8Ay94BmR4UIasXhY
 NBM0J62c1Ldk3UlG0iaMpIHQDnx7wd2HHiLpW4G9apLA1TFx55ka5XKHZsOwG1ZzjA4Z
 p+S+iHraR3p9tQoExUD+sN7hOKiOmQT4GGpzwnBKhzOm3JU6sa860zS9MSXTwFZJ9n3V
 bqZ9VxsYuvl+LpwvX06ThKUR+M+U9uke0mKsj/FvHWgaTwdrab4xi/M5r6V/9/IemGwC
 n8Xzb0cZ0nqW22TH77Sfc5T+voDJwlRaZQJSMkPflW8oMtTvVcHTEM4mr3PhEMeADZsZ +g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree7brc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 11:00:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1EB0d4H014736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 11:00:39 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1EB0d14012698;
        Thu, 14 Feb 2019 11:00:39 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 11:00:39 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v3 1/2] x86: respect memory size limiting via mem=
 parameter
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190214104240.24428-2-jgross@suse.com>
Date:   Thu, 14 Feb 2019 04:00:37 -0700
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Content-Transfer-Encoding: 7bit
Message-Id: <A93A19ED-0121-4E88-B24E-1593BEBD3384@oracle.com>
References: <20190214104240.24428-1-jgross@suse.com>
 <20190214104240.24428-2-jgross@suse.com>
To:     Juergen Gross <jgross@suse.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2019, at 3:42 AM, Juergen Gross <jgross@suse.com> wrote:
> 
> When limiting memory size via kernel parameter "mem=" this should be
> respected even in case of memory made accessible via a PCI card.
> 
> Today this kind of memory won't be made usable in initial memory
> setup as the memory won't be visible in E820 map, but it might be
> added when adding PCI devices due to corresponding ACPI table entries.
> 
> Not respecting "mem=" can be corrected by adding a global max_mem_size
> variable set by parse_memopt() which will result in rejecting adding
> memory areas resulting in a memory size above the allowed limit.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

