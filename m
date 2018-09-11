Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0FBC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24772086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24772086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIKTen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:34:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31965 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbeIKTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:34:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BETcwx178249
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:35:05 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2medw55akg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:35:04 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bryantly@linux.ibm.com>;
        Tue, 11 Sep 2018 10:35:02 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 10:34:59 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BEYwqk33161432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 14:34:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B624112062;
        Tue, 11 Sep 2018 10:34:28 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25423112061;
        Tue, 11 Sep 2018 10:34:28 -0400 (EDT)
Received: from bryants-mbp-4.rchland.ibm.com (unknown [9.10.79.137])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Sep 2018 10:34:28 -0400 (EDT)
Subject: Re: [PATCH] scsi: ibmvscsis: Fix a stringop-overflow warning
To:     Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
References: <20180910223723.25357-1-labbott@redhat.com>
 <CAGXu5j+-RNeEr+FUc6maamvzYpY7W0VJ-yYGDHnFTuNPeOUMFw@mail.gmail.com>
From:   "Bryant G. Ly" <bryantly@linux.ibm.com>
Date:   Tue, 11 Sep 2018 09:34:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+-RNeEr+FUc6maamvzYpY7W0VJ-yYGDHnFTuNPeOUMFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091114-0064-0000-0000-0000034B3C28
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009703; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086789; UDB=6.00561139; IPR=6.00866800;
 MB=3.00023231; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 14:35:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091114-0065-0000-0000-00003A9B2431
Message-Id: <36c9adee-fbe8-f58d-e407-bbd57fdb1959@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 6:30 PM, Kees Cook wrote:

> On Mon, Sep 10, 2018 at 3:37 PM, Laura Abbott <labbott@redhat.com> wrote:
>> There's currently a warning about string overflow with strncat:
>>
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
>> bound 64 equals destination size [-Werror=stringop-overflow=]
>>   strncat(vscsi->eye, vdev->name, MAX_EYE);
>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Switch to using strlcat which correctly accounts for lengths that
>> are equal to the destination buffer.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> index fac377320158..53d344d8dc43 100644
>> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> @@ -3475,7 +3475,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>>                 vscsi->dds.window[REMOTE].liobn);
>>
>>         strcpy(vscsi->eye, "VSCSI ");
>> -       strncat(vscsi->eye, vdev->name, MAX_EYE);
>> +       strlcat(vscsi->eye, vdev->name, MAX_EYE);
> Can this just get switched to snprintf() instead?
>
> snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);

Either works for me. 

>
>>         vscsi->dds.unit_id = vdev->unit_address;
>>         strncpy(vscsi->dds.partition_name, partition_name,
> And does this strncpy need a NUL-termination and/or trailing padding?
>
Yes, good catch, it does need NUL-termination. 

-Bryant


