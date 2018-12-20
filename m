Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99C206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2IIYV4Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeLTQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:09:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51152 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:09:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBKG8aJs075412;
        Thu, 20 Dec 2018 16:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZZBH8OmoiEQXBnwtGvz+7E4ttJCo24R/AJbB/L9OlZA=;
 b=2IIYV4Nmy7e1nJLev6Kl7+soZxasiSH6bdjPtWGxyAl4j9d5S62rMlnIWpCk7COKAyAt
 lBVCXKGxQM1Ho4jjX9GJWhUbLiSY1DTmyCMs79XD3CYlavbK6vKq4hZnuP4ImojbsDJ/
 DsDjCbav2b3MpznntCagpmUuSMpcjVnf1CpfEXirlm6xbzS1mk0tH7k9MB7Wbsz5mk3K
 7yG5X30eGbrkM7YeXZ4bibKZBYc/+JP4cnxgDb7ASI8utTK6P/wgIVSHOcuQo4Z9FwI0
 FYvhkYT8QssZfcdUbJ0vE3aHRe7054Gp9txAs3aUymIvdSxX7n2FdW6tFzUm9GY/tR/J Ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pf8gfhr2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 16:09:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBKG8uor024351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 16:08:56 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBKG8tQD005218;
        Thu, 20 Dec 2018 16:08:55 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 08:08:54 -0800
Subject: Re: PROBLEM: Xen paging-request boot failure since 4.19.5
To:     Ken Pizzini <kkpp@explicate.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
References: <20181219212537.GA25174@144vak35.msa.explicate.org>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <fea48b7a-443a-11ac-a3c2-9d26af808f87@oracle.com>
Date:   Thu, 20 Dec 2018 11:12:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181219212537.GA25174@144vak35.msa.explicate.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 4:25 PM, Ken Pizzini wrote:
> Since 4.19.5 I have not been able to boot kernels on my Xen-hosted VM on
> a system with an Intel Xeon L5520 processor (microcode 0x1d).
>
> 4.19.4 worked fine; I've tried kernels 4.19.5, 4.19.6, 4.19.7 4.19.9, 4.19.10,
> 4.20-rc7, and they all throw:
>      BUG: unable to handle kernel paging request at ffff88903fffc000
>      PGD 1c0c067 P4D 1c0c067 PUD 0
>      Oops: 0000 [#1] PREEMPT SMP NOPTI
>      ... [register dump and call trace omitted, since I believe I located the
>           offending source code]
>      Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>      Kernel Offset: disabled
> early in the system boot (fine details might differ; I did not carefully
> record the result of each test).
>
> I finally had time to do some bisection, and the problem traces back to commit
>     d52888aa2753e3063a9d3a0c9f72f94aa9809c15
>     in tree fbbb33771ac6c392caeb283163a594f1a7e6d04d
> (x86/mm: Move LDT remap out of KASLR region on 5-level paging).
>
> After backing-out this one commit, I have successfully built and booted
> 4.19.5, 4.19.10 and 4.20-rc7 (I haven't bothered trying other versions).
> (The VM is currently running my patched 4.19.10 without any apparent problem.)
>
> Notes: all 4.19.* builds are of Gentoo's "gentoo-sources" tree (which include
> standard Gentoo patches), plus wireguard; the 4.20-rc7 build was unpatched.
> I have been successfully running a different build of each 4.19.* version
> on my laptop (with many more device drivers enabled), so the problem
> is unlikely to be due to the build toolchain (which is common to both
> of my build trees).
>
>
> Let me know if there is more information that you would find helpful,
> or if you have patches that you'd like me to test.
>
> 		--Ken Pizzini


This is addressed by https://lkml.org/lkml/2018/12/11/266 but has not
been merged yet.

(Next time for Xen issues please copy xen-devel@lists.xenproject.org)


-boris
