Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E0CC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39721A27
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39721A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbeGDMKY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:10:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932745AbeGDMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:10:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64C9mbQ179648
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 08:10:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0untnwxf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:10:21 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 13:10:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 13:10:16 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64CAFJl22020284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 12:10:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48055AE04D;
        Wed,  4 Jul 2018 15:10:17 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68AD8AE057;
        Wed,  4 Jul 2018 15:10:16 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.81.200])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 15:10:16 +0100 (BST)
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 04 Jul 2018 08:10:03 -0400
In-Reply-To: <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
         <1530550839.3709.46.camel@linux.vnet.ibm.com>
         <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070412-4275-0000-0000-0000029515ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070412-4276-0000-0000-0000379C9A27
Message-Id: <1530706203.3452.74.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=580 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 19:32 +0300, Jarkko Sakkinen wrote:
> On Mon, 2018-07-02 at 13:00 -0400, Mimi Zohar wrote:
> > On Mon, 2018-07-02 at 11:24 -0400, Stefan Berger wrote:
> > > Rather than accessing the TPM functions by passing a NULL pointer for
> > > the tpm_chip, which causes a lookup for a suitable chip every time, get a
> > > hold of a tpm_chip and access the TPM functions using it. Also get rid of
> > > the ima_used_chip variable and use the new ima_tpm_chip variable instead
> > > for determining whether to call TPM functions.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > 
> > Jarkko, would you mind staging this patch with the rest of the patch
> > set?
> 
> Yes, sure, I can do that. Any additional tag?

Thanks, just these.

Mimi

