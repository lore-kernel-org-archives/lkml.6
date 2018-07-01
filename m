Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44CF23C31
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44CF23C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeGAJ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:28:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751504AbeGAJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:28:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w619Nt7R148352
        for <linux-kernel@vger.kernel.org>; Sun, 1 Jul 2018 05:28:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jxq3gpy08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 05:28:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Sun, 1 Jul 2018 10:28:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 1 Jul 2018 10:28:09 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w619S8N437486830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Jul 2018 09:28:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B32CE11C052;
        Sun,  1 Jul 2018 10:27:53 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E67211C04C;
        Sun,  1 Jul 2018 10:27:53 +0100 (BST)
Received: from localhost.localdomain (unknown [9.199.32.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  1 Jul 2018 10:27:53 +0100 (BST)
From:   Chandan Rajendra <chandan@linux.vnet.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     darrick.wong@oracle.com, lkml <linux-kernel@vger.kernel.org>,
        allison.henderson@oracle.com, hch@lst.de,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-xfs@vger.kernel.org
Subject: Re: xfs: Deadlock between fs_reclaim and sb_internal
Date:   Sun, 01 Jul 2018 15:00:01 +0530
In-Reply-To: <1583499.AKrs7invYa@localhost.localdomain>
References: <ee795573-6ab3-361a-d076-b464293bdcc4@linux.ibm.com> <1583499.AKrs7invYa@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18070109-4275-0000-0000-00000293DDF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070109-4276-0000-0000-0000379B53BC
Message-Id: <1635784.85vFEPy9OU@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807010113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 29, 2018 11:48:39 AM IST Chandan Rajendra wrote:
> On Thursday, June 28, 2018 9:31:32 AM IST Ravi Bangoria wrote:
> > Hello Darrick,
> > 
> > Lockdep is reporting a deadlock with following trace. Saw this on my
> > powerpc vm with 4GB of ram, running Linus/master kernel. Though, I
> > don't have exact testcase to reproduce it. Is this something known?
> 
> I am able to recreate this issue on a ppc64le guest. I will debug this
> and provide updates.
> 

Ravi,

The issue has already been reported earlier. See 
https://www.spinics.net/lists/linux-xfs/msg20036.html.
I am not familiar with Lockdep code and hence won't be able to help here.

-- 
chandan

