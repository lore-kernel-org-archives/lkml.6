Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC48C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47A32178F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47A32178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbeHGONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727572AbeHGONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:13:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77Bx3Eh146591
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 07:59:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kq9604cgt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:59:41 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 7 Aug 2018 12:59:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 12:59:34 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77BxXnS20381940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 11:59:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD62F11C054;
        Tue,  7 Aug 2018 14:59:40 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 620A411C04C;
        Tue,  7 Aug 2018 14:59:40 +0100 (BST)
Received: from localhost (unknown [9.152.212.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Aug 2018 14:59:40 +0100 (BST)
Date:   Tue, 7 Aug 2018 13:59:31 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for
 every Makefile
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
 <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
 <20180806180740.GI4238@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806180740.GI4238@tassilo.jf.intel.com>
X-TM-AS-GCONF: 00
x-cbid: 18080711-0020-0000-0000-000002B35FBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080711-0021-0000-0000-000021006605
Message-Id: <your-ad-here.call-01533643171-ext-1234@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 11:07:40AM -0700, Andi Kleen wrote:
> On Mon, Aug 06, 2018 at 03:17:44PM +0200, Vasily Gorbik wrote:
> > Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
> > compiler flag support is tested for every Makefile.
> 
> Good catch.  Does it make a measurable compile time difference?
> 

A bit more than couple of seconds, but it does make a difference for a
delta build:
with patch:
real    0m9.405s
user    0m6.966s
sys     0m2.287s

without:
real    0m12.153s
user    0m9.058s
sys     0m3.026s

with -j48 on s390 24 cores lpar:
with patch:
real    0m1.949s
user    0m7.034s
sys     0m2.400s

without:
real    0m2.255s
user    0m9.243s
sys     0m3.266s

> > 
> > Top 4 cc-option usages:
> >     511 -mrecord-mcount

