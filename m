Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3071ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767EC20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767EC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeKIBGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:06:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbeKIBGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:06:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8FFKUC035248
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 10:30:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nmpqh3ks5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:30:10 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 8 Nov 2018 15:30:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 15:30:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8FU5qr6947214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:30:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5251DA4054;
        Thu,  8 Nov 2018 15:30:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F6CDA405B;
        Thu,  8 Nov 2018 15:30:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.140])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 15:30:03 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Ken Goldman <kgold@linux.vnet.ibm.com>,
        Kenneth Goldman <kgoldman@us.ibm.com>
Date:   Thu, 08 Nov 2018 10:29:53 -0500
In-Reply-To: <20181108152124.GE14072@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
         <20181106150159.1136-2-roberto.sassu@huawei.com>
         <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
         <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
         <086944ab-dd56-5522-af26-e9bb545556fd@linux.ibm.com>
         <20181108152124.GE14072@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110815-0016-0000-0000-000002233D4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110815-0017-0000-0000-0000327B92B5
Message-Id: <1541690993.4502.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 17:21 +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 08, 2018 at 07:20:51PM +0530, Nayna Jain wrote:
> > Based on a discussion with Ken, the count in the TPML_PCR_SELECTION returns
> > the number of possible algorithms supported. In the example below, two
> > possible algorithms - SHA1 and SHA256 - are returned.
> > 
> > # /usr/local/bin/tssgetcapability -cap 5
> > 2 PCR selections
> >     hash TPM_ALG_SHA1
> >     TPMS_PCR_SELECTION length 3
> >     ff ff ff
> >     hash TPM_ALG_SHA256
> >     TPMS_PCR_SELECTION length 3
> >     00 00 00
> > 
> > The pcr_select fields - "ff ff ff" and "00 00 00" - are bit masks for the
> > enabled PCRs. The SHA1 bank is enabled for all PCRs (0-23), while the SHA256
> > bank is not enabled.
> > 
> > The current code works, but it unnecessarily extends some banks. Instead of
> > basing the number of active banks on the number of algorithms returned, it
> > should be based on the pcr_select field.
> > 
> >    - Mimi & Nayna
> 
> I would just allocate array of the size of possible banks and grow
> nr_active_banks for active algorithms to keep the code simple because
> we are talking about insignificant amount of wasted space (might be
> even zero bytes given how kernel allocators works)>

That's fine.  Remember the memory is just one concern, but the other
concerns are the performance of calculating the unneeded hash and the
TPM performance of including it in the PCR extend.

Mimi

