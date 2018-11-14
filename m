Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5212086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xr+s3A/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5212086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeKNVtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:49:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56122 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeKNVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:49:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAEBiBHt041514;
        Wed, 14 Nov 2018 11:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=wau0gGAVNLyYp+1AedDjz3rJQSwsbnKSZcLCLZkH7Mc=;
 b=Xr+s3A/nbHR3uzgEe4wPfLi97ECNdGGl+wNpkJrtvcd7oKMw6Grw7B7PWeAwKGCa7iAD
 XnBDYgqwgzDAy1ZEjg4kXnNVbdl7HDIW60fVsiGsK1p/RpxZCMAPo0Zf+isk9iTKLDHG
 mR3KYbzlzVB2rwRlwuLIhsmJ8V4dRxCWGkQKb9n6bs/zIQ48J1JkjYfC7G42m7M/LdBD
 2zcK+hTuv1sRAaLFn+8XhjRWbvU7mE44YvcqVNi2HPmVteNd4YzfUqufbYvBou23PMvx
 B5a0QwJmDlqEPYrj2hHcvuHhqjotLgAiEEOuhb36c/QNYy/ethxW6VAboEl6UehezYMp FA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nr7cs2wuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 11:46:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAEBkKAV020641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 11:46:20 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAEBkJRe028043;
        Wed, 14 Nov 2018 11:46:19 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 03:46:19 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <5dcd06a0f84a4824bb9bab2b437e190d@AcuMS.aculab.com>
Date:   Wed, 14 Nov 2018 04:46:18 -0700
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C54170F-DE66-47E0-9C0D-7D1A97DCD339@oracle.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
 <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
 <5dcd06a0f84a4824bb9bab2b437e190d@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 14, 2018, at 4:09 AM, David Laight <David.Laight@ACULAB.COM> =
wrote:
>=20
> From: William Kucharski
>> Sent: 14 November 2018 10:35
>>=20
>>> On Nov 13, 2018, at 5:51 PM, Isaac J. Manjarres =
<isaacm@codeaurora.org> wrote:
>>>=20
>>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>>> index 852eb4e..0293645 100644
>>> --- a/mm/usercopy.c
>>> +++ b/mm/usercopy.c
>>> @@ -151,7 +151,7 @@ static inline void check_bogus_address(const =
unsigned long ptr, unsigned long n,
>>> 				       bool to_user)
>>> {
>>> 	/* Reject if object wraps past end of memory. */
>>> -	if (ptr + n < ptr)
>>> +	if (ptr + (n - 1) < ptr)
>>> 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr =
+ n);
>>=20
>> I'm being paranoid, but is it possible this routine could ever be =
passed "n" set to zero?
>>=20
>> If so, it will erroneously abort indicating a wrapped address as (n - =
1) wraps to ULONG_MAX.
>>=20
>> Easily fixed via:
>>=20
>> 	if ((n !=3D 0) && (ptr + (n - 1) < ptr))
>=20
> Ugg... you don't want a double test.
>=20
> I'd guess that a length of zero is likely, but a usercopy that =
includes
> the highest address is going to be invalid because it is a kernel =
address
> (on most archs, and probably illegal on others).
> What you really want to do is add 'ptr + len' and check the carry =
flag.

The extra test is only a few extra instructions, but I understand the =
concern. (Though I don't
know how you'd access the carry flag from C in a machine-independent =
way. Also, for the
calculation to be correct you still need to check 'ptr + (len - 1)' for =
the wrap.)

You could also theoretically call gcc's __builtin_uadd_overflow() if you =
want to get carried away.

As I mentioned, I was just being paranoid, but the passed zero length =
issue stood out to me.

    William Kucharski=
