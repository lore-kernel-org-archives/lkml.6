Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC94C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5DA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="stvg59CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfBVWWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:22:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVWWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:22:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1MMIu7V034884;
        Fri, 22 Feb 2019 22:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=jWIrh7d6XTW5kBiYUt0OQY8AAkCG9FOUyj2Fmvls/G4=;
 b=stvg59CIySH0kDi5xBfpge9/iru/QixBmmfu81NoP13bszB6GzQYKvzDPX4LdWupANZ1
 oVAopGDzicyKtY8XXv28CYNdULvu3ppNDD5HOzMPrb3XIeDGG2J5rr+fgBJ7FmvVYzJR
 bbDU0bVnNXGvhy6srbxpGJiW9/FekIvKp6WcN1xn6hXkQDJe8ttlIFl7p3KnMoIeTRqe
 dsUPPeVliAJHx0WjvCFG9MK98zb7iCZql8vnX4+ksaZpPLQQxuUSEU8xTsxDDQm1lQje
 qy3qV+a55KBHnCqFGTNJPyXw01r3oU1IvD+Lzv69XsqZ09sf5h+hoDSol3oLB5B08CFe yg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xuhtg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 22:22:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1MMMCG6028916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 22:22:12 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1MMMBdu030372;
        Fri, 22 Feb 2019 22:22:11 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 14:22:11 -0800
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM ATTEND] MM track: contig allocation, thp numa, userfaultfd
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a47b26e8-0048-e360-1f69-a296acf222f5@oracle.com>
Date:   Fri, 22 Feb 2019 14:22:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9175 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=502 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is space available, I would like to attend the MM track of LSF/MM
this year.  This is a somewhat lame request as I have not proposed a topic,
and my mm contributions this past year have been somewhat limited to finding
and fixing bugs hugetlbfs.

Topics in which I am interested and could contribute:
- Contiguous memory allocation.  This seems to be an ongoing feature
  request.  John Hubbard wants a reliable and efficient method to
  obtain provide huge pages.  Zi Yan has put out a bunch of code to
  support an alternate approach.
- THP and huge pages in general.
  - Specific interest in Andrea's NUMA remote THP vs NUMA local non-THP
    under MADV_HUGEPAGE proposal.
- Userfaultfd and Peter Xu approach to write protect support.

-- 
Mike Kravetz
