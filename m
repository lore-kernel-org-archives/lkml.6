Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495E32085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BknYr6s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfAWOg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:36:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51140 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:36:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NEXwCq085089;
        Wed, 23 Jan 2019 14:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=suvHRLubqdsMG8K+emTAPVhlspl6gAsE78o8KWMhtkA=;
 b=BknYr6s4rkDYWddJjIOR5qY/I/mN6zzAoy7lZGawv9lL/MTEzuNm/zXbocQVH87du3if
 6Fzy/ZYM8Sp3vLUCYN9pNhB4WqfTgoIp2IT6PmLuFCPzIaLA1Zlz5GFwONuyAcGEmKlZ
 78pKPioNoGgrvfPDfluHQ9LYmO4JHFPaE05bBPUgF3z7eok6AV6LJQVxv+Qo1cjFeSXk
 85jsmoT/IoW2SxUuH9LjM3d7HVYXeJhSsqjOcxzMA03qNi/wiSPxO6v9lolR2UdwV1Uy
 pKrJiBg7cpGabKWfdLpVkDTpLJVUEwRNDDwY87qbOznNsK8hclA+5+n0QFzcJXYGWqy6 sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhrt2f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:35:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEZUIr012046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:35:30 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NEZU0P023532;
        Wed, 23 Jan 2019 14:35:30 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 06:35:29 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] x86: respect memory size limiting via mem= parameter
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190122080628.7238-2-jgross@suse.com>
Date:   Wed, 23 Jan 2019 07:35:28 -0700
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Content-Transfer-Encoding: 7bit
Message-Id: <69D0866F-77A7-4529-A01E-12395106E22D@oracle.com>
References: <20190122080628.7238-1-jgross@suse.com>
 <20190122080628.7238-2-jgross@suse.com>
To:     Juergen Gross <jgross@suse.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2019, at 1:06 AM, Juergen Gross <jgross@suse.com> wrote:
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b9a667d36c55..7fc2a87110a3 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -96,10 +96,16 @@ void mem_hotplug_done(void)
> 	cpus_read_unlock();
> }
> 
> +u64 max_mem_size = -1;

This may be pedantic, but I'd rather see U64_MAX used here.

