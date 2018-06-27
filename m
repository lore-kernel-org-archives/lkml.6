Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4659C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8822416A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8822416A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965341AbeF0Nsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:48:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752898AbeF0Nsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:48:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RDiKNp063437
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:48:40 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jv9yyncxp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:48:40 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 07:48:39 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 07:48:35 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RDmZlL58196064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 06:48:35 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAB61136053;
        Wed, 27 Jun 2018 07:48:34 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D678A136060;
        Wed, 27 Jun 2018 07:48:33 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 07:48:33 -0600 (MDT)
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023849.op4rimmsnlv4rgwg@ninjato>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 27 Jun 2018 08:48:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626023849.op4rimmsnlv4rgwg@ninjato>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18062713-0004-0000-0000-0000145ABF0A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009263; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053082; UDB=6.00539916; IPR=6.00831006;
 MB=3.00021878; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 13:48:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062713-0005-0000-0000-000087E2D212
Message-Id: <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 09:38 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:16PM -0500, Eddie James wrote:
>> Add abort procedure for failed transfers. Add engine and bus reset
>> procedures to recover from as many faults as possible.
> I think this is a way too aggressive recovery. Your are doing the 9
> pulse toggles basically on any error while this is only when the device
> keeps SDA low and you want to recover from that. If SDA is not stuck
> low, sending a STOP should do. Or do you have a known case where this is
> not going to work?

It is aggressive, but I don't see the harm in doing this on every error. 
There are some other error conditions with this hardware which may 
require the clock toggling, such as "bus arbitration lost." I think this 
is the safest option for this hardware, and this routine has been tested 
for many years.

>
> Also, you implement the pulse toggling manually. Can't you just populate
> {get|set}_{scl|sda} and use the generic routine we have in the core?

I see that the generic implementation breaks the loop if it sees the 
clock isn't high after setting it, or if SDA goes high. I think it's 
safer to finish the reset for our hardware. Plus, we actually have 
different registers for setting 0 or 1 to the clock/data, so we save 
some cpu cycles by doing it directly instead of implementing set_scl/sda 
and having to check val every time :)

If you feel very strongly that this recovery procedure needs to be 
reduced, then I will work on that and have to do some extensive testing.

Thanks!
Eddie

>

