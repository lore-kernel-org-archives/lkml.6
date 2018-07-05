Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BB9240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BB9240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeGESuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:50:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753954AbeGESuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:50:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65In1Qr010427
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 14:50:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1pupmwu7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:50:22 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 14:50:17 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 14:50:12 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65IoBwh6685396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 18:50:12 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB6AF124055;
        Thu,  5 Jul 2018 15:51:32 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A298F124058;
        Thu,  5 Jul 2018 15:51:31 -0400 (EDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 15:51:31 -0400 (EDT)
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
 <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
 <20180702181511.mv2fuiwjjdhyp43v@ninjato>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 5 Jul 2018 13:50:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702181511.mv2fuiwjjdhyp43v@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070518-0072-0000-0000-0000037A9217
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057022; UDB=6.00542281; IPR=6.00834942;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 18:50:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070518-0073-0000-0000-0000489AA816
Message-Id: <18b756ef-03d3-8103-3b52-c7bc220d4195@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2018 01:15 PM, Wolfram Sang wrote:
> Hi Eddie,
>
>>> I think this is a way too aggressive recovery. Your are doing the 9
>>> pulse toggles basically on any error while this is only when the device
>>> keeps SDA low and you want to recover from that. If SDA is not stuck
>>> low, sending a STOP should do. Or do you have a known case where this is
>>> not going to work?
>> It is aggressive, but I don't see the harm in doing this on every error.
> Well, as it happens, I just fixed such a case. Please check these patch
> series and elinux wiki pages:
>
> ===
>
> (new fault injector)
> [PATCH v2 0/2] i2c: gpio: fault-injector: add new injector
>
> (actual recovery fix)
> [PATCH 0/2] i2c: recovery: make sure pulses are not misinterpreted
>
> ===
>
> And here is the new elinux wiki page to describe my findings:
>
> https://elinux.org/Tests:I2C-bus-recovery-write-byte-fix
>
> Also, the previous pages have been updated to reflect the latest status:
>
> https://elinux.org/Tests:I2C-fault-injection
> https://elinux.org/Tests:I2C-bus-recovery
>
> To sum it up: This is a proven case where uncontrolled bus recovery can
> result into a bogus write!
>
>> There are some other error conditions with this hardware which may require
>> the clock toggling, such as "bus arbitration lost." I think this is the
> Why is that? In my understanding, recovery is *only* needed when SDA is
> stuck low. If SDA is high, sending STOP should do. If not, it needs to
> be researched why.
>
>> safest option for this hardware, and this routine has been tested for many
>> years.
> I remember having a similar argument with Joakim Tjernlund a while ago.
> I recently re-read our argument, yet I still keep my position: I don't
> want to do $random things to recover, just a tested and well understood
> procedure. And in that thread, I was never given a test case.
>
>>> Also, you implement the pulse toggling manually. Can't you just populate
>>> {get|set}_{scl|sda} and use the generic routine we have in the core?
>> I see that the generic implementation breaks the loop if it sees the clock
>> isn't high after setting it, or if SDA goes high. I think it's safer to
>> finish the reset for our hardware. Plus, we actually have different
> Why do you think it is safer? What is the test case for that? I think
> one really should do check SDA! See above, you might trigger a write
> otherwise. If this breaks something for you, I am looking forward to
> discuss it.
>
>> registers for setting 0 or 1 to the clock/data, so we save some cpu cycles
>> by doing it directly instead of implementing set_scl/sda and having to check
>> val every time :)
> Correctness comes above all here. And I am afraid your implementation is
> not correct.
>
>> If you feel very strongly that this recovery procedure needs to be reduced,
>> then I will work on that and have to do some extensive testing.
> I am open for discussion, yet I also feel strong about it. The reason
> why the recovery procedure is moved into the core is to have one working
> and understood bit-banging algorithm which all drivers can rely on. If
> all drivers implement their custom version, they might miss gory details
> like the above write_byte fix.
>
> I do understand this might cause testing effort for you, I am sorry for
> the delay it causes. However, my goal as a maintainer is to have a
> reliable recovery mechanism, for your driver as well as for all drivers.
>
> I hope this is understandable. BTW if you want this driver upstream
> soon, then it may be an idea to resend it without any bus recovery and
> then we can work on it incrementally.

Thanks for the details. I have sent up a new series which will only do 
the bus reset if SDA is low. With our current hardware configuration, 
this *should* be sufficient to recover all the possible errors. However, 
there are configurations where it will not be enough, in which case 
getting the data line stuck high or clock line stuck either high or low 
can occur, necessitating the full reset. But since I can't demonstrate 
those at the moment, I can't argue to include that now :)

Thanks again,
Eddie

>
> Kind regards and thanks,
>
>     Wolfram

