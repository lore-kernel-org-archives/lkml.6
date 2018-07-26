Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34207C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECBF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKoISWRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECBF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbeGZUgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:36:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeGZUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:36:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJE7pM113190;
        Thu, 26 Jul 2018 19:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D69gkHeYvmhKO4ZANgYQmQAzMPEes3s0R7ceWSvjdLE=;
 b=HKoISWRimouAbl8hUd3k4zoHHPxK8A1nZtJ0TZAAJx4GWke7FexLsWkuCCoUmsNWPzZI
 VE4IDW+TuAmH+a0nXfYIG+H5Q5CYKtI/vVBD9TSTHUAeSLli04rznT9Imx1tquaCvYw1
 qZXwoq8OUNT0dPcx+62Pcimv4gWbOM0zPgtAnVMH7NRhrt6LSKicJaXUccYS2zdrnN8y
 s7vhTy327lAMebz2Whmh85ZlaTFlMrQjw72sEMXm4vNUZiOR3Js1vYkfqJhSIkQyxPQU
 FlYXoYdrsh49qn4HokoL/+1zmea68oKfGEMf16E8z1XP9OY2bQc/IilmItvBUif/gdCZ cg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfq4f8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:16:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJGbGx000510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:16:37 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QJGZ4x016078;
        Thu, 26 Jul 2018 19:16:35 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:16:35 -0700
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Michael Ellerman <mpe@ellerman.id.au>, Alex Ghiti <alex@ghiti.fr>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
 <87tvomgqyv.fsf@concordia.ellerman.id.au>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <99473e0d-12d8-bbea-fe9c-4e3738ab7f5a@oracle.com>
Date:   Thu, 26 Jul 2018 12:16:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tvomgqyv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=629
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 04:46 AM, Michael Ellerman wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
>> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>>> Does anyone have any suggestion about those patches ?
>>
>> I only took a quick look.  From the hugetlb perspective, I like the
>> idea of moving routines to a common file.  If any of the arch owners
>> (or anyone else) agree, I can do a review of the series.
> 
> The conversions look pretty good to me. If you want to give it a review
> then from my point of view it could go in -mm to shake out any bugs.

Nothing of significance found in a review.  As others have suggested,
the (cross)compiler may be better at finding issues than human eyes.

I also suggest it be added to -mm.
-- 
Mike Kravetz
