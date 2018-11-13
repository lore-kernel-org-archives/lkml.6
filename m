Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9C6223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QD0uyUd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9C6223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeKNEEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:04:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKNEEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:04:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wADI3XB6023476;
        Tue, 13 Nov 2018 18:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=P/5T4nh566xGuBot8YsOpRVwQUG2B0eftsX5gA2JaNg=;
 b=QD0uyUd1izdzYCKZqx1WhFSJ9y3jtgwDeEzuR6ViK2f8biwOP30IDxxnSDwKRa3NY9el
 O2S6qUlyT6/AeKhjB+awD8MvGeHEA2+fD3pYV1xzyWAHAzg0GUp/R9kTq86vPZn0ZXAY
 qVNGKMAr0WZqPOAYDkGYiAZv7wxYZPeUeoXYSG/mF4IDeCg5NBMklwYt3G+VPSHxsRLX
 VJ009bavaXt5tu2VF9+OOeV3gDVQU5aeOfsrsKRIB0mirxlr5SieJYyOvf8NaJonOJt1
 4X42v9Jw9Qq7LWDhHerC7c7oMXT+KREmxa5QmPTqrb3IcX0zCCJCft4snSz9lZ5x+XB/ 3w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nnwc0meuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 18:05:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wADI4sZ8017139
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 18:04:54 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wADI4sge031624;
        Tue, 13 Nov 2018 18:04:54 GMT
Received: from [172.30.51.233] (/64.114.255.97)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 10:04:54 -0800
Subject: Re: [PATCH] mm/hugetl.c: keep the page mapping info when
 free_huge_page() hit the VM_BUG_ON_PAGE
To:     Yongkai Wu <nic.wuyk@gmail.com>, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <CAJtqMcZp5AVva2yOM4gJET8Gd_j_BGJDLTkcqRdJynVCiRRFxQ@mail.gmail.com>
 <20181113130433.GB16182@dhcp22.suse.cz>
 <CAJtqMcY98hARD-_FmGYt875Tr6qmMP+42O7OWXNny6rD8ag91A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dc39308b-1b9e-0cce-471c-64f94f631f97@oracle.com>
Date:   Tue, 13 Nov 2018 10:04:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJtqMcY98hARD-_FmGYt875Tr6qmMP+42O7OWXNny6rD8ag91A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=482
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 7:12 AM, Yongkai Wu wrote:
> Dear Maintainer,
> Actually i met a VM_BUG_ON_PAGE issue in centos7.4 some days ago.When the issue first happen,
> i just can know that it happen in free_huge_page() when doing soft offline huge page.
> But because page->mapping is set to null,i can not get any further information how the issue happen.
> 
> So i modified the code as the patch show,and apply the new code to our produce line and wait some time,
> then the issue come again.And this time i can know the whole file path which trigger the issue by using 
> crash tool to get the inode、dentry and so on,that help me to find a way to reproduce the issue quite easily
> and finally found the root cause and solve it.

Thank you for the information and the patch.

As previously stated by Michal, please add some additional information to the
change log (commit message) and fix the formatting of the patch.

Can you tell us more about the root cause of your issue?  What was the issue?
How could you reproduce it?  How did you solve it?
-- 
Mike Kravetz
