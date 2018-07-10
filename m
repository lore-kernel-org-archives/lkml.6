Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723EDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362C2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362C2208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeGJTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:15:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732502AbeGJTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:15:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AJDjVR013721
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:15:03 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k4yhmj603-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:15:03 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 13:15:02 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 13:14:58 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AJEvTv60621048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 12:14:57 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAD256A04F;
        Tue, 10 Jul 2018 13:14:57 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C6F6A04D;
        Tue, 10 Jul 2018 13:14:45 -0600 (MDT)
Received: from oc6728276242.ibm.com (unknown [9.80.208.154])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 13:14:45 -0600 (MDT)
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Tue, 10 Jul 2018 14:14:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710185042.x3slnms5wzocobqu@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071019-0020-0000-0000-00000E3C283C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009346; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059430; UDB=6.00543726; IPR=6.00837350;
 MB=3.00022090; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 19:15:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071019-0021-0000-0000-0000623C4E58
Message-Id: <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 01:50 PM, Wolfram Sang wrote:
>>>> +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
>>> I just noticed this and wonder: Don't you need the LSB of the address?
>>> It is not the RW flag, this is encoded in msg->flags.
>> So, the hardware interprets the LSB as the RW flag. It wouldn't be possible
>> to have a device addressed with the LSB set on this I2C master.
> But msg->addr is 7 bit and LSB aligned. If I am not horribly wrong, with
> the above code, an EEPROM at 0x50 would show up as 0x28 with your
> driver?

Sorry, what do you mean "show up as"? Yes, we could first shift all our 
addresses in user-space before passing them to the driver, so that the 
msg->addr field is exactly what the hardware expects already... This 
would be non-trivial for our users considering all our documentation 
represents the addresses as the top 7 bits of a byte :(

>
>> Indeed, real 10-bit addresses require some additional manipulation of this
>> I2C master in order to work. We don't support it right now.
> Then you should remove the associated FUNC flag.

Ah, but due to the addressing situation, tools like i2cget don't work 
with our addresses unless the 10 bit flag is specified. For example, we 
may want to access 0xA0.

>

