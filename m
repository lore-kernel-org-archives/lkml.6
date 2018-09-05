Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60FAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9B2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E9B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIEVBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:01:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbeIEVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:01:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85GP0lM002633
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:30:16 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2majbp147g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:30:16 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 10:30:16 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 10:30:14 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85GUCO820971582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 09:30:13 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B068F7805E;
        Wed,  5 Sep 2018 10:30:12 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B47C67805C;
        Wed,  5 Sep 2018 10:30:10 -0600 (MDT)
Received: from [192.168.42.231] (unknown [9.80.226.106])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 10:30:10 -0600 (MDT)
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 05 Sep 2018 17:30:07 +0100
In-Reply-To: <yq15zzj3o99.fsf@oracle.com>
References: <1536137722.4813.66.camel@gmx.de>
         <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
         <yq15zzj3o99.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090516-0004-0000-0000-0000148485B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083963; UDB=6.00559437; IPR=6.00863964;
 MB=3.00023129; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 16:30:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0005-0000-0000-000088B5728B
Message-Id: <1536165007.3627.13.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 12:25 -0400, Martin K. Petersen wrote:
> Jens,
> 
> > I bet it's the host busy change from Ming, which I already
> > reported as being the culprit for another test failure I had. For
> > some reason it's not merged yet, nudge nudge Martin.
> 
> I reverted the two offending changes last week. James just hasn't
> sent Linus a pull request yet...

Yes, I did, just before packing up my board and kit and saying goodbye
to the carefree days of summer on the beach:

https://marc.info/?l=linux-scsi&m=153613531415018&w=2

I'm actually at heathrow now and should be home tomorrow, so things
should be back to normal next week.

James

