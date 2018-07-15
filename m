Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0AECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A820882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeGOH6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 03:58:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbeGOH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 03:58:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6F7Txpr115578
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 03:36:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k7xdqnpek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 03:36:02 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Sun, 15 Jul 2018 08:36:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Jul 2018 08:35:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6F7ZwbU34013276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Jul 2018 07:35:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F1D5AE053;
        Sun, 15 Jul 2018 10:36:17 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E274DAE051;
        Sun, 15 Jul 2018 10:36:15 +0100 (BST)
Received: from [9.79.225.171] (unknown [9.79.225.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 15 Jul 2018 10:36:15 +0100 (BST)
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20180713183756.gfddtn3gbwkwpqbj@treble>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Sun, 15 Jul 2018 13:05:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713183756.gfddtn3gbwkwpqbj@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071507-0012-0000-0000-0000028A4EB1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071507-0013-0000-0000-000020BC0240
Message-Id: <dbd9bdf6-7cb1-cde1-5f7d-d3a5449c560d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807150092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 July 2018 12:07 AM, Josh Poimboeuf wrote:
>> We bail out during patch registration for architectures, those don't
>> support reliable stack trace.
> 
> Does anybody know if that change was intentional?  I thought the plan
> was to allow non-consistency-model arches to still use livepatch, and
> that they'd just have to 'force' patches to completion instead.  That
> seems a little more forgiving.
> 

The initial proposal was to allow 'force' feature on architectures
without HAVE_RELIABLE_STACKTRACE support and use pr_notice() to warn
user about the non-availability of consistency model. It was argued
against, as it will encourage people to use it as an alternative instead
of adding HAVE_RELIABLE_STACKTRACE support to the kernel.

-- 
cheers,
Kamalesh.

