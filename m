Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2230FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThI2LMYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfAQJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:45:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfAQJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:45:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H9hrBT104240;
        Thu, 17 Jan 2019 09:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JZ4+uuCbWEKD+AzWkkQsCNQAdBQEfHqJ/SbPT98MjO4=;
 b=ThI2LMYJZNVdulwyxTcoH1ZlKpm7rDvt7jHfB20BeBbhXwXg9JeO4PghOKooVjG+FAHy
 Zg3Z5tf7EcBkVctRlQPhhhLBWiYdGA/WKUJNXJuuxKTGu/kFcToZoxfH7cbPu/LhIDQs
 V0uKJZIVwC1TfePuBm3qso6SiDZR3w2mfDa8R0D2ta/lah1J0PYQw8A6us7Q4/DNs0r5
 Ps1SzXEsltHzeByRX1qi3wzVIqnc8RUyK8OInTuXaNXs4qd7WlzchcLwH6aYFKzmZLn5
 VELqph8EaGdo4JHzbtNp7EEp32GcYgS+VHA0ff4bwmK9AL8A37JIxEXSa+Ym3sKMeKcR tQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2pybjnxv4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 09:45:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0H9ix4a007710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 09:44:59 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0H9ix68032400;
        Thu, 17 Jan 2019 09:44:59 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 01:44:58 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <6fa27824-d86d-f642-db7c-a13faaac527d@oracle.com>
Date:   Thu, 17 Jan 2019 02:44:58 -0700
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00575D78-10FE-4A05-9BAB-5A2992AB401D@oracle.com>
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
 <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
 <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
 <97e179e1-8a3a-5acb-78c1-a4b06b33db4c@oracle.com>
 <20190116233207.GA5868@hori1.linux.bs1.fc.nec.co.jp>
 <6fa27824-d86d-f642-db7c-a13faaac527d@oracle.com>
To:     Jane Chu <jane.chu@oracle.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2019, at 6:07 PM, Jane Chu <jane.chu@oracle.com> wrote:
>=20
> It's just coding style I'm used to, no big deal.
> Up to you to decide. :)

Personally I like a (void) cast as it's pretty long-standing syntactic =
sugar to cast a call that returns a value we don't care about to (void) =
to show we know it returns a value and we don't care.

Without it, it may suggest we either didn't know it returned a value or =
that we neglected to check the return value.

However, in current use elsewhere (e.g. in send_sig_all() and =
__oom_kill_process()), no such (void) cast is added, so it seems better =
to match current usage elsewhere in the kernel.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
