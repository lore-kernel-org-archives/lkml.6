Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45484C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38223CE3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B38223CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934569AbeGCTGf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:06:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932825AbeGCTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:06:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63J3jsP140833
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 15:06:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0dpdk29x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:06:32 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 13:06:32 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 13:06:28 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63J6R4S4718876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 12:06:27 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2149C78067;
        Tue,  3 Jul 2018 13:06:27 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E93278064;
        Tue,  3 Jul 2018 13:06:25 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.176.219])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 13:06:24 -0600 (MDT)
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until
 module shutdown
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Date:   Tue, 03 Jul 2018 12:06:23 -0700
In-Reply-To: <alpine.LRH.2.21.1807040450340.32123@namei.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
         <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
         <1530631615.3142.6.camel@linux.vnet.ibm.com>
         <20180703165102.GB19800@linux.intel.com>
         <alpine.LRH.2.21.1807040450340.32123@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18070319-0016-0000-0000-000009038497
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009302; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056067; UDB=6.00541708; IPR=6.00833990;
 MB=3.00021979; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 19:06:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070319-0017-0000-0000-00003F81061A
Message-Id: <1530644783.3142.37.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=862 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 04:51 +1000, James Morris wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> > On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> > 
> > OK, I was not sure how that discussion went. I could add myself as
> > co-maintainer to MAINTAINERS because I anyway need to go through
> > all of these.
> > 
> > If anyone does not vote against, I'll send a patch.
> > 
> 
> For Keys?  That would would be useful to help reduce the workload on 
> David.

Well, no, this was for trusted keys, which is the part of the key
infrastructure that goes via the TPM: The KEYS-TRUSTED part in the
MAINTAINERs file.  There's still KEYS-ENCRYPTED, KEYS/KEYRING and
ASYMETRIC KEYS, which don't use the TPM.

However, I've no objection to consolidating the lot under a larger set
of maintainers ... I recently agreed to look at the asymmetric key TPM
patch because it's my area, but it also strays over into crypto,
keyring and asymmetric keys.

James

