Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD6CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687021A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687021A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeHFQfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:35:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731257AbeHFQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:35:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76ENi9J062929
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 10:26:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpn6hftcc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:26:30 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tuliom@linux.ibm.com>;
        Mon, 6 Aug 2018 10:26:29 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 10:26:25 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76EQON29961886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 14:26:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B1E6112064;
        Mon,  6 Aug 2018 10:26:06 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD35112062;
        Mon,  6 Aug 2018 10:26:05 -0400 (EDT)
Received: from linux.ibm.com (unknown [9.85.161.40])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 10:26:05 -0400 (EDT)
From:   Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
To:     Florian Weimer <fweimer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>
Cc:     Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
In-Reply-To: <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com> <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com> <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com> <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.3.1 (x86_64-redhat-linux-gnu)
Date:   Mon, 06 Aug 2018 11:26:22 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18080614-0064-0000-0000-000003360408
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009495; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070349; UDB=6.00550807; IPR=6.00849549;
 MB=3.00022537; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 14:26:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080614-0065-0000-0000-00003A3511A7
Message-Id: <87h8k7h8q9.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=499 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> writes:

> On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
>> There's plenty of memcpy's in the graphics stack. No one will be rewriting
>> all the graphics drivers because of tiny market share that ARM has in
>> desktop computers. So if you refuse to fix things and blame everyone else,
>> you can as well announce that you don't want to have PCIe graphics on ARM
>> at all.
>
> The POWER toolchain maintainers said pretty much the same thing not too 
> long ago.  I wonder how many architectures need to fail until the 
> graphics stack is finally fixed.

Unfortunately, it is not just the graphics stack.
This is being used in other userspace programs that benefit from GPUs and
accelerators.

But can we say they're are nonportable programs?
I'm not convinced yet.

-- 
Tulio Magno

