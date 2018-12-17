Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC702C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979E321473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0Lhw7apa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeLQWxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:53:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36616 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQWxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:53:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBHMiMQA061138;
        Mon, 17 Dec 2018 22:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=anvecm4kB/SnYOzJGeuhiABYsVl34mMO6V/MTuRuFyE=;
 b=0Lhw7apaU+kSCHtLOUxrt/AMIbekJ+93UUZBKfzIKjkALaCqEH42mF9azXZpChVEqInN
 8LJGHYn4Vn+x4vLXyC/RzM5qv7cNu5dHzuAZLeIddzeRJgyZ2FuWxGJ3AJaW03pw0Ma+
 hUzFAxPxPu7mgvqZHIyr8Kx028zUn4U9HS69iFFQqdW3jPVn+UugSQNp86cn6EbCx31R
 n6xOZUX8Ek394aMo/QM7pgI/9bo6LMKrC3+DJ16hN4cxEtpnRsYh/mMETzkG8fDVEBtn
 pv7unrnW+jgP/LhWWG6eWpYzXnKHRgOJrmMI5rqXUPMZpienPtASh9nZLDhaYCFs6caC cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pcq4drdxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 22:52:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBHMqtI8018369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 22:52:56 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBHMqs5e020540;
        Mon, 17 Dec 2018 22:52:54 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Dec 2018 14:52:54 -0800
Subject: Re: [PATCH] mm: Remove __hugepage_set_anon_rmap()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, jglisse@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <154504875359.30235.6237926369392564851.stgit@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6852d074-74fb-6eb7-69b0-2d1f35064b84@oracle.com>
Date:   Mon, 17 Dec 2018 14:52:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154504875359.30235.6237926369392564851.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812170198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 4:13 AM, Kirill Tkhai wrote:
> This function is identical to __page_set_anon_rmap()
> since the time, when it was introduced (8 years ago).
> The patch removes the function, and makes its users
> to use __page_set_anon_rmap() instead.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Thanks for cleaning this up!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
