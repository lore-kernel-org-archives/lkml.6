Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D752AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96514208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJOpQA5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96514208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeK1CyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:54:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35662 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeK1CyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:54:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARFsfur073737;
        Tue, 27 Nov 2018 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=wCl3OpK+JNMxgv3uFw+diZo+EoeUN/EKRtJ7Mf4YTxg=;
 b=mJOpQA5QqtOaeqGLJCJhQXP8Cx17Jh33Kld2WuavXBb9kVJb9Ag55gnXMNatfOICrd5X
 sTkwbqogY0bWKTDO8iUZAVn0mJUaeQm9eSHmoFxcywoe4X9/fPbS19yPZbdDnd+8JTMc
 tt6T6MBU1sLlYQ5CxGdhVIlHZxHnyPJZb+9vPG+L003qYcDhOi47JuJVEhAkfW4qcBWo
 O+yxLvDIhwY6Y69iHxn3aWohxABxaIhor9SIqrMvRKz7t5ohLu6XWiDlCUStfLhGsCiy
 acjUdz6HUOWE+Qd09ketF5dlKpHVK9XIisaSRO+pN4zeaAA5T6P1v1dGnQmtOVdnFVxO Fg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2u4w8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 15:55:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wARFtnHc027557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 15:55:49 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARFtnFw020401;
        Tue, 27 Nov 2018 15:55:49 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 07:55:49 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181127155213.GB27075@linux.intel.com>
Date:   Tue, 27 Nov 2018 08:55:47 -0700
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AD1CE43-3B5B-4D4B-963B-056D749F196E@oracle.com>
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
 <20181127155213.GB27075@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2018, at 8:52 AM, Sean Christopherson =
<sean.j.christopherson@intel.com> wrote:
>=20
> On Tue, Nov 27, 2018 at 09:36:03AM +0100, Heiko Carstens wrote:
>> Use pr_alert_once() instead of pr_alert() if page table misaccounting
>> has been detected.
>>=20
>> If this happens once it is very likely that there will be numerous
>> other occurrence as well, which would flood dmesg and the console =
with
>> hardly any added information. Therefore print the warning only once.
>>=20
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> ---
>> kernel/fork.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 07cddff89c7b..c887e9eba89f 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
>> 	}
>>=20
>> 	if (mm_pgtables_bytes(mm))
>> -		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: =
%ld\n",
>> -				mm_pgtables_bytes(mm));
>> +		pr_alert_once("BUG: non-zero pgtables_bytes on freeing =
mm: %ld\n",
>> +			      mm_pgtables_bytes(mm));
>=20
> I found the print-always behavior to be useful when developing a =
driver
> that mucked with PTEs directly via vmf_insert_pfn() and had issues =
with
> racing against exit_mmap().  It was nice to be able to recompile only
> the driver and rely on dmesg to let me know when I messed up yet =
again.
>=20
> Would pr_alert_ratelimited() suffice?

Actually, I really like that idea.

There are certainly times when it is useful to see a cascade of =
messages, within reason;
one there are so many they overflow the dmesg buffer they're of limited =
usefulness.

Something like a pr_alert() that could rate limit to a preset value, =
perhaps a default of
fifty or so, could prove quite useful indeed without being an all or =
once choice.

    William Kucharski=
