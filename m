Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E926C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E166025AAC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E166025AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965179AbeF0Ncz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:32:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934003AbeF0Ncx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:32:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RDU1Zf124561
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:32:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvbcwrj1h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:32:53 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 07:32:52 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 07:32:47 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RDWkqY9634066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 06:32:46 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB0EB136053;
        Wed, 27 Jun 2018 07:32:46 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99D47136051;
        Wed, 27 Jun 2018 07:32:45 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 07:32:45 -0600 (MDT)
Subject: Re: [PATCH v10 7/7] i2c: fsi: Add bus recovery
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 27 Jun 2018 08:32:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18062713-0016-0000-0000-000009001545
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009263; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053076; UDB=6.00539913; IPR=6.00831000;
 MB=3.00021878; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 13:32:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062713-0017-0000-0000-00003F6DB780
Message-Id: <c9d0b0c8-268f-04af-7c43-6fec0e272a9d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 09:38 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:19PM -0500, Eddie James wrote:
>> Bus recovery should reset the engine and force clock the bus 9 times
>> to recover most situations.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/i2c/busses/i2c-fsi.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
>> index d6cab4b..940b198 100644
>> --- a/drivers/i2c/busses/i2c-fsi.c
>> +++ b/drivers/i2c/busses/i2c-fsi.c
>> @@ -611,6 +611,24 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
>>   		I2C_FUNC_SMBUS_BLOCK_DATA;
>>   }
>>   
>> +static int fsi_i2c_recover_bus(struct i2c_adapter *adap)
>> +{
>> +	int rc;
>> +	struct fsi_i2c_port *port = adap->algo_data;
>> +	struct fsi_i2c_master *master = port->master;
>> +
>> +	mutex_lock(&master->lock);
>> +
>> +	rc = fsi_i2c_reset(master, port->port);
>> +
>> +	mutex_unlock(&master->lock);
>> +	return rc;
>> +}
>> +
>> +static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
>> +	.recover_bus = fsi_i2c_recover_bus,
>> +};
>> +
> This all won't have any effect since you never call i2c_recover_bus
> which calls back into i2c_bus_recovery_info callbacks.

Ah, I thought there would be some use of this in the core or in client 
drivers, or some ioctl interface. Would there be any outside users of 
these callbacks in the future?


