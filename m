Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF66222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w1WCXLd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405439AbfBNLSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:18:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfBNLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:18:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EBE9IS013286;
        Thu, 14 Feb 2019 11:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=pxT21No+zAo92Lt8izw0UGg1JN7hZwHAao7k9nslps4=;
 b=w1WCXLd3IIOE4a8WApeNxTUjUJ8gFSeYZv7b8jsilBPlNaFTpx3qeeKAScZH5H990BBN
 KeC3QOcrrGIj+kX1FiBTB2KZyzqXnHWrpETeX2anz+y6KId5Ct+KxYegUXj2bG/aVVyG
 7yqw6uNj8yWGnCauyZKabrZ0RK1aPqI8gyqNj981q9JOODzUeOBSSUWcZwIDIdo0meJa
 vXUSQaSAAkytALtAN9KXxQUaAdNfxYEa1ZsTSl613Dc0RtrB85v18e/kmcXsU/leynpD
 8nZRpyy73ABFsF/rLGnMt5uetm30dtN+WEMGmOXh35GURDYbNNcLwrTXXA1/mYoKKNey qQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhree7ehq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 11:18:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1EBITwE029134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 11:18:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1EBIQ7a026969;
        Thu, 14 Feb 2019 11:18:26 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 03:18:26 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH] mm/shmem: make find_get_pages_range() work for huge page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190212235743.GB95899@google.com>
Date:   Thu, 14 Feb 2019 04:18:24 -0700
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <404C0A0A-F145-4622-B3EB-492D0FFB7CB6@oracle.com>
References: <20190110030838.84446-1-yuzhao@google.com>
 <A7BE64E0-8F88-46AC-A330-E1AB23A50073@oracle.com>
 <20190212235743.GB95899@google.com>
To:     Yu Zhao <yuzhao@google.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=859 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 12, 2019, at 4:57 PM, Yu Zhao <yuzhao@google.com> wrote:
> 
> It seems to me it's pefectly fine to use fields of xas directly,
> and it's being done this way throughout the file.

Fair enough.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

