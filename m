Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CFC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4A6204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4A6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeKGVhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:37:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbeKGVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:37:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7C4VLx102033
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 07:07:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nkxhdb65e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:07:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 7 Nov 2018 12:07:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 12:07:34 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7C7XZk4391392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 12:07:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC22C4C044;
        Wed,  7 Nov 2018 12:07:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D644C046;
        Wed,  7 Nov 2018 12:07:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.109])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 12:07:32 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
In-Reply-To: <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
         <20181106150159.1136-2-roberto.sassu@huawei.com>
         <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 07 Nov 2018 06:10:30 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110712-0020-0000-0000-000002E31622
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110712-0021-0000-0000-000021329285
Message-Id: <1541589030.4619.21.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-07 at 11:44 +0530, Nayna Jain wrote:
> On 11/06/2018 08:31 PM, Roberto Sassu wrote:


> > @@ -878,11 +877,14 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >   	if (rc)
> >   		goto out;
> >
> > -	count = be32_to_cpup(
> > +	chip->nr_active_banks = be32_to_cpup(
> >   		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> 
> 
> As per my understanding, the count in the TPML_PCR_SELECTION represent 
> the number of possible banks and not the number of active banks.
> TCG Structures Spec for TPM 2.0 - Table 102 mentions this as explanation 
> of #TPM_RC_SIZE.

Instead of storing the result in a local variable, the only change
here is saving the result in the chip info (nr_active_banks).
 Everything else remains the same.


> >
> > -	if (count > ARRAY_SIZE(chip->active_banks)) {
> > -		rc = -ENODEV;
> > +	chip->active_banks = kmalloc_array(chip->nr_active_banks,
> > +					   sizeof(*chip->active_banks),
> > +					   GFP_KERNEL);

With this change, the exact number of banks can be allocated, as done
here.  Nice! 

Mimi

> > +	if (!chip->active_banks) {
> > +		rc = -ENOMEM;
> >   		goto out;
> >   	}
> >
> 

