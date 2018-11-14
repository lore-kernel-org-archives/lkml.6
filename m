Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA979C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF02145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XWfsunv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFF02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKOIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:55:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:55:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAEMieTl052968;
        Wed, 14 Nov 2018 22:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=j6I3/OKLpdcgfUv3FZujrd6ExYOYUnfCgzQRd684uJs=;
 b=XWfsunv2GZYtzIX5WV3bb/FT3wzeDf3+MaLhjJssLnjwKVLVKG/wEy2RGqNies6wwmEP
 Y5QPiNfQMBTkgmL5YpulcJcirflsQbGEZrfiGlDNDJY8NK3EKPPCfF3ChHbQDYL0nljA
 yUXlEf43Z7jIuIVoiUKrl3m0ErAsIxnJY2v09SOmih+G9qZu/OPKw74RZoKaGNBPRahM
 zQkMx41814wo62hGyvekm6X1Id5RM/zObR+2hk+ET9V/exGJtdR6ifh/3r0yIUSNZFyV
 NJY6yMH2xllWiCaj3S8AnAgMSJbDqBU7CKjtlFw03cAhhfHviyKhY/Jx002Yo3CH0nT4 ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nr7cs6e0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 22:50:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAEMo7oH025936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 22:50:07 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAEMo6uP016990;
        Wed, 14 Nov 2018 22:50:06 GMT
Received: from [192.168.0.102] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 14:50:06 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <50baa4900e55b523f18eea2759f8efae@codeaurora.org>
Date:   Wed, 14 Nov 2018 15:50:05 -0700
Cc:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>, crecklin@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <816A9750-D2A3-4BC8-88A6-41BFAA6A1540@oracle.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
 <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
 <5dcd06a0f84a4824bb9bab2b437e190d@AcuMS.aculab.com>
 <7C54170F-DE66-47E0-9C0D-7D1A97DCD339@oracle.com>
 <50baa4900e55b523f18eea2759f8efae@codeaurora.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
X-Mailer: Apple Mail (2.3445.101.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9077 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 14, 2018, at 10:32 AM, isaacm@codeaurora.org wrote:
>=20
> Thank you and David for your feedback. The check_bogus_address() =
routine is only invoked from one place in the kernel, which is =
__check_object_size(). Before invoking check_bogus_address, =
__check_object_size ensures that n is non-zero, so it is not possible to =
call this routine with n being 0. Therefore, we shouldn't run into the =
scenario you described. Also, in the case where we are copying a page's =
contents into a kernel space buffer and will not have that buffer =
interacting with userspace at all, this change to that check should =
still be valid, correct?

Having fixed more than one bug resulting from a "only called in one =
place" routine later being called elsewhere,
I am wary, but ultimately it's likely not worth the performance hit of a =
check or BUG_ON().

It's a generic math check for overflow, so it should work with any =
address.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
