Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74734C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B2C21EF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B2C21EF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934150AbeGCQj0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:39:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933999AbeGCQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:39:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63GdEIn115955
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 12:39:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k09dha9dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:39:18 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 12:39:18 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 12:39:14 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63GdDcK9044330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 16:39:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B9BBAE060;
        Tue,  3 Jul 2018 12:38:56 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5897AAE05F;
        Tue,  3 Jul 2018 12:38:51 -0400 (EDT)
Received: from [9.79.197.55] (unknown [9.79.197.55])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 12:38:51 -0400 (EDT)
Subject: Re: Oops in kmem_cache_free() via bioset_exit() (was Re:
 [next-20180601][nvme][ppc] Kernel Oops is triggered when creating lvm
 snapshots on nvme disks)
From:   Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        sim <sim@linux.vnet.ibm.com>,
        manvanth <manvanth@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Date:   Tue, 03 Jul 2018 22:09:06 +0530
In-Reply-To: <87a7rf55vy.fsf@concordia.ellerman.id.au>
References: <1530003645.24245.7.camel@abdul.in.ibm.com>
         <87d0wd7jph.fsf@concordia.ellerman.id.au>
         <1530176707.24245.12.camel@abdul.in.ibm.com>
         <87a7rf55vy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070316-0052-0000-0000-00000308756B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056019; UDB=6.00541679; IPR=6.00833941;
 MB=3.00021978; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 16:39:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070316-0053-0000-0000-00005D3B4A55
Message-Id: <1530635946.24245.15.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 00:42 +1000, Michael Ellerman wrote:
> Kent, Jens,
> 
> This looks like it might be related to the recent bioset changes?
> 
> cheers
> 
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > On Tue, 2018-06-26 at 23:36 +1000, Michael Ellerman wrote:
> >> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> ...
> > I was able to reproduce again with slub_debug=FZP and DEBUG_INFO enabled
> > on 4.17.0-rc7-next-20180601, but not much traces other than the Oops stack trace
> 
> Are you still testing on that revision? It's nearly a month old.
> 
> Please try to reproduce on mainline or today's linux-next.

Problem is not reproducible on 4.18.0-rc3 mainline and today's next
kernel

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



