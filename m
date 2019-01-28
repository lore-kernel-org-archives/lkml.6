Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F5D21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ttffg+nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfA1Il1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:41:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51800 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1Il1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:41:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0S8cq6F031540;
        Mon, 28 Jan 2019 08:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jGyKWhEIcdqSmY/XpVC3JxpBMGgFQLDY82WtcM7NvCY=;
 b=ttffg+nDEYncqKExs2sFaW+YPjHWO6Vci2CZcwpFBK4D355eP5iwjVzk97zWU1x/f1gQ
 Y0sEqnCbHnOu4hmx9r2xKmOZymfL3CACdIljuvr4J2/SAVxgYHmV7jkStvNz7ZxYLTSr
 4mHtxrQQ6AUZBO/JtNIrTvhR7/Ysn82thymhp/dtZo06wgOfH7kmnX9iRT5ArQE7MFR+
 PfEbSQ9oV+SnRZS7To0kP5vqR4IhCeA0Ep7kZgBcorP9HAUD8iTt4AWS7Uw7kZ/kyjt3
 tfI79cBxpcqNnZ9pBW42IZOL5FlOp1QPlTmsuD9K+7jthMUkA1/nAfQ8Malk14ugIlEt iA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2dvukn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 08:41:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0S8f6GX030294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 08:41:06 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0S8f50s002609;
        Mon, 28 Jan 2019 08:41:06 GMT
Received: from [192.168.0.118] (/171.117.190.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 00:41:05 -0800
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb barrier
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, srinivas.eeda@oracle.com,
        bp@suse.de, tim.c.chen@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
References: <48a105d3-fa32-40e4-9775-37d49f42eac0@default>
 <alpine.DEB.2.21.1901231335570.1628@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901251637480.1622@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901251858280.1622@nanos.tec.linutronix.de>
 <0aa09e77-1454-9eaf-ef67-b00518e6f2d2@oracle.com>
 <alpine.DEB.2.21.1901280934270.1622@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <26c4fb45-eaa1-9520-bd35-1cf8ca673e30@oracle.com>
Date:   Mon, 28 Jan 2019 16:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901280934270.1622@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=324
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/28 16:36, Thomas Gleixner wrote:
> On Mon, 28 Jan 2019, Zhenzhong Duan wrote:
>> On 2019/1/26 2:03, Thomas Gleixner wrote:
>>> Bah, nonsense. Brain was clearly still out for lunch and I confused IBPB
>>> and STIBP for a moment. cond_ibpb() is the thing issues in switch_mm() and
>>> that is not leaving a stale MSR around because we only write to it when we
>>> need the barrier. The bit is not stale because the barrier is only issued
>>> with the write. The bit has not to be cleared.
>>>
>>> So the only 'issue' what happens is that switch_to() either issues a
>>> barrier too much or misses one. That's really not a problem.
>>
>> Ok, yes, the purpose of this patch is to avoid the one missed barrier.
> 
> And that missed barrier is not worth it to do extra work in switch_to/mm
> simply because it's a one off event and there is no way to exploit that
> reliably.

Got it.

Thanks
Zhenzhong
