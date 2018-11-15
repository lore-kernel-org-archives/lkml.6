Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B263E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B263E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeKOOMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:12:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbeKOOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:12:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAF43ixi117778
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:06:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrw9q8k1n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:06:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 15 Nov 2018 04:06:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 04:06:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAF46W9l6553870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 04:06:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F9BA52051;
        Thu, 15 Nov 2018 04:06:32 +0000 (GMT)
Received: from [9.124.35.153] (unknown [9.124.35.153])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2391A52054;
        Thu, 15 Nov 2018 04:06:28 +0000 (GMT)
Subject: Re: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
 <20181114160600.GD13885@redhat.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 15 Nov 2018 09:36:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114160600.GD13885@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111504-4275-0000-0000-000002E13020
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111504-4276-0000-0000-000037EE4688
Message-Id: <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 11/14/18 9:36 PM, Oleg Nesterov wrote:
> On 11/14, Ravi Bangoria wrote:
>>
>> syzbot reported a kernel crash with delayed_uprobe_remove():
>>   https://lkml.org/lkml/2018/11/1/1244
>>
>> Backtrace mentioned in the link points to a race between process
>> exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
>> before calling delayed_uprobe_remove() from put_uprobe().
> 
> The patch looks good to me, but could you update the changelog?
> 
> Please explain that the exiting task calls uprobe_clear_state() which
> can race with delayed_uprobe_remove(). IIUC this is the only problem
> solved by this patch, right?

Right. Is this better:

There could be a race between task exit and probe unregister:

  exit_mm()
  mmput()
  __mmput()                     uprobe_unregister()
  uprobe_clear_state()          put_uprobe()
  delayed_uprobe_remove()       delayed_uprobe_remove()

put_uprobe() is calling delayed_uprobe_remove() without taking
delayed_uprobe_lock and thus the race sometimes results in a
kernel crash. Fix this by taking delayed_uprobe_lock before
calling delayed_uprobe_remove() from put_uprobe().

Detailed crash log can be found at:
  https://lkml.org/lkml/2018/11/1/1244

