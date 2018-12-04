Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34220C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D82087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AL3bRX/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0D82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLDXQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:16:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:16:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4NDGYP175519;
        Tue, 4 Dec 2018 23:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=A29KmdTt+lp5bVgAPdrFsNjIIK/fkikcCotKfh2dHkM=;
 b=AL3bRX/xrGMx3yL4wpHEEygCl97VWDFkLJs+5L9FmAsKXVmGHypd7lZx33NtrNk1tQ5+
 exH3Wp3xruhce4vLQe9q+tMH7AK0jcNfNKcTUvSFeJuPKoxBj+P3M/PZ/quk3tI+aaRb
 iDXJtxbZ4q8P6WWhxnX+yXwC9mcn4IBI5RDllp+Z++A2gaiCakkUGcEyp1b5K/K6mbZE
 WVLth5QI1p8aXsAvTndKkQZ/E6qvk0KYSci9W88ZhPvHvHc/+SS5opEU60aifZXZ5IHl
 JM3gPha7q/LppfcD7DbaTpmWhV9lbWbNdgF01bIYyjYtNrzPQYdDEJw4DR8rUEQVeJyF 5A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrfapw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 23:16:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4NGRpb012724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 23:16:27 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB4NGQK1008439;
        Tue, 4 Dec 2018 23:16:26 GMT
Received: from ubuette (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 23:16:26 +0000
Date:   Tue, 4 Dec 2018 15:16:24 -0800
From:   Larry Bassel <larry.bassel@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: RFC: revisiting shared page tables
Message-ID: <20181204231623.GA19227@ubuette>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In August 2005, Dave McCracken sent out a patch which implemented shared
page tables (http://lkml.iu.edu/hypermail/linux/kernel/0508.3/1623.html)
based on 2.6.13.

He also wrote two OLS papers about the topic
(https://landley.net/kdocs/ols/2003/ols2003-pages-315-320.pdf
and https://www.landley.net/kdocs/ols/2006/ols2006v2-pages-125-130.pdf), the
second of which was published after his patch submission.

This patch was discussed for a few days. It was not accepted.

There were several comments about technical issues (about a typo,
some questions about locking, how to search the vmas, whether one must
iterate through all of the vmas) which no doubt could be fixed, and
in fact Dave indicated that he would eventually provide a revised patch
which fixed these problems. AFAICT this never occurred.

However, there were also questions about whether sharing page tables would
provide any significant benefit.

Specifically, there were concerns about whether the patch would
improve performance at all (Dave indicated a 3% improvement on some
"large benchmarks"), especially once another change (the test at
at the beginning of copy_page_range() which prevents page table copies
in some cases) was merged (d992895ba2, which has been in the kernel since
2.6.14).

It was also suggested that the use of randomize_vm_space
might also make shared page tables uninteresting, though that objection
appeared to be addressed.

Isn't Linux kernel archaeology fun :-)

13 years have elapsed. Given the many changes in the kernel since the original
patch submission, I'd appreciate your insight into the following questions:

* Is there (still?) a need for shared page tables (and if not, why not?).
* If one were to resume work on this, is there any reason why one shouldn't
start with Dave's 2.6.13 patch (plus fixes to the known bugs in it)
and forward port it to the tip, rather than starting from scratch?

Thanks.

Larry Bassel
