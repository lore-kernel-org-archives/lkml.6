Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B020878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13B020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeJBQN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:13:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbeJBQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:13:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w929Pk7D054042
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 05:31:04 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv4g2bx2n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 05:31:04 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 03:31:03 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 03:31:01 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w929V01q25755724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 02:31:00 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54201136051;
        Tue,  2 Oct 2018 03:31:00 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8013136053;
        Tue,  2 Oct 2018 03:30:56 -0600 (MDT)
Received: from [9.79.181.195] (unknown [9.79.181.195])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  2 Oct 2018 03:30:56 -0600 (MDT)
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
 <20181002004248.GC23753@linux.intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Tue, 2 Oct 2018 14:58:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181002004248.GC23753@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100209-0004-0000-0000-000014959CA7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009808; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096720; UDB=6.00567117; IPR=6.00876762;
 MB=3.00023585; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 09:31:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100209-0005-0000-0000-00008902B7B5
Message-Id: <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2018 06:12 AM, Jarkko Sakkinen wrote:
> On Sat, Sep 29, 2018 at 01:30:20AM +0300, Tomas Winkler wrote:
>> Move tpm1_pcr_extend to tpm1-cmd.c and remove
>> unused pcrextend_header structure and
>> EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
>> defines.
>>
>> Fixes warning:
>> drivers/char/tpm/tpm-interface.c:609:38: warning: ‘pcrextend_header’ defined but not used [-Wunused-const-variable=]
>>   static const struct tpm_input_header pcrextend_header = {
>>                                        ^~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Would need help with this from someone with a working IMA setup
> on testing.


My test system is down for now.. I think it will be up later in this 
week. I can test it then.

Thanks & Regards,
     - Nayna


>
> /Jarkko
>

