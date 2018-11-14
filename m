Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7043C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0D62145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t0/l3Xsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0D62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeKNUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:02:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57154 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:02:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE9weNN159031;
        Wed, 14 Nov 2018 09:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=T6Z8fBfHeRT6+usV6FpaXa7WbjNdiUej4rn3OsfYNwU=;
 b=t0/l3Xslg3HOuL7kS3KirFiQE4ELjpMWumKrFpoKEx3pibowJO9gP38RRFpKgEYoodZR
 /GfVl83KdFVuuxsli4CQQUsg74paAhM3DQbQkx3PaNv81u8a+XWCmMA8OV2v3PFMPppd
 hOIukwxiy9UwpS/Jjn+s2hCjsK6cc7DRQbew4OlZu/u0bejy3pChXej2W6c6M3a1qXf+
 KOeeJ5josK2AMXSg+ulD6TselkDqX3nlRCltppOXCqzRNeIaaq+5Xh+wR1CWfzSAsGAw
 ycnrdjc1XCUWTTuJncJsaGCvlWJ7mBsrA67YdOzhHrVm9kOKEe3GexhijnIgG+x+Isdy 2A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nr7cs2ctm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:59:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAE9xEVn018670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:59:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAE9xCcE008203;
        Wed, 14 Nov 2018 09:59:12 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 01:59:12 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <CAFqt6zbwwkvuZypssKQtsKdfZKk3DEQXpA7Qw6yDNakpu=Jv1w@mail.gmail.com>
Date:   Wed, 14 Nov 2018 02:59:11 -0700
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, vbabka@suse.cz,
        riel@redhat.com, rppt@linux.ibm.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EAE1409-DF80-4A9A-8936-C6E9BC7C9604@oracle.com>
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
 <CAFqt6zbwwkvuZypssKQtsKdfZKk3DEQXpA7Qw6yDNakpu=Jv1w@mail.gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=662
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 13, 2018, at 10:13 PM, Souptick Joarder <jrdr.linux@gmail.com> =
wrote:
>=20
> On Tue, Nov 6, 2018 at 5:33 PM Souptick Joarder <jrdr.linux@gmail.com> =
wrote:
>>=20
>> Page fault handlers are supposed to return VM_FAULT codes,
>> but some drivers/file systems mistakenly return error
>> numbers. Now that all drivers/file systems have been converted
>> to use the vm_fault_t return type, change the type definition
>> to no longer be compatible with 'int'. By making it an unsigned
>> int, the function prototype becomes incompatible with a function
>> which returns int. Sparse will detect any attempts to return a
>> value which is not a VM_FAULT code.
>>=20
>> VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
>> to avoid conflict with other VM_FAULT codes.
>>=20
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>=20
> Any further comment on this patch ?

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

