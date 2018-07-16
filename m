Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7699220779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7699220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPIqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:46:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbeGPIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:46:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G8JQkv087578
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:20:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8gg6xr8p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:20:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 16 Jul 2018 09:20:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 09:20:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G8KEhn21364892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 08:20:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECA56A4040;
        Mon, 16 Jul 2018 11:20:32 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A61A404D;
        Mon, 16 Jul 2018 11:20:29 +0100 (BST)
Received: from [9.124.31.217] (unknown [9.124.31.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 11:20:29 +0100 (BST)
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
 <20180712145849.GB15265@redhat.com>
 <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
 <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
 <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 16 Jul 2018 13:50:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071608-0012-0000-0000-0000028A991D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071608-0013-0000-0000-000020BC503B
Message-Id: <a37cc94b-5940-643c-3e81-fc375c6aada0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 07/14/2018 05:20 AM, Song Liu wrote:
> 
> Hmm... what happens when we have multiple uprobes sharing the same
> reference counter? It feels equally complicate to me. Or did I miss any
> cases here?


As far as I can think of, it should be handled by default. No special
treatment needed for this.

...

> 
> This patch tries to resolve this imbalance by passing extra flag
> "restore_insn" to probe_event_disable().
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>


Ah cool. Seems this will make them balanced. But is it fine to change
uprobe_unregister()? It's already an ABI. No other way around?

Also, one more source of imbalance is this condition:

          if (is_register)
                  flags |= VM_WRITE;

in valid_vma(). You need to take care of that as well.

Thanks,
Ravi

