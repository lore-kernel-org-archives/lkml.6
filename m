Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41272C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56CF20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eeWjaNnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56CF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJaNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:55:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbeJaNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:55:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9V4n7Nw182910;
        Wed, 31 Oct 2018 04:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UQ7wziBZBYuApOnmuB0hEtVdlPN6VQcE7Q3mVcT1+sI=;
 b=eeWjaNnB83gdFRLgkhYFSEvXkcppvUkSnBdTjndKEXWv2SKD6WHV/zLiAFKhU/1CcIbQ
 dH1j++uKUnugAVz25ek4RMm5HMaUf+gTo0ti5aPTLBORdq9KHZYLiQJPQefk7C83Ad0V
 YdKRFqXhxD6FI/ljmd2DxJ+AFhxW9ZvV2MoNHvwFcFrso9r448KjZY0FOmFHS6HCsgbh
 gEO9Yk+kSYxMHP+0emqtJw3WnzstBj15hl1+ugT3O9A7fF/4OfNmSFPy+otQAnm0Shsw
 hWSiE37skUAeh2a3TwfDKpyUEba56QNQXbxHCroKwBY2glzcLyOA8l+dkI9o2wyYJtBE yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ncgnr0bpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 04:57:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9V4vmOd008432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 04:57:48 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9V4vjcX005814;
        Wed, 31 Oct 2018 04:57:45 GMT
Received: from [10.191.22.95] (/10.191.22.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 21:57:45 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH 1/3] retpolines: Only enable retpoline when compiler
 support it
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        luto@kernel.org, konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, daniel@iogearbox.net, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, hpa@zytor.com
References: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
 <20181030083210.GA1459@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <ac84aa90-2c20-a380-eb1b-be317b409cf8@oracle.com>
Date:   Wed, 31 Oct 2018 12:58:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030083210.GA1459@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=671
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 16:32, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 11:55:04PM -0700, Zhenzhong Duan wrote:
>> Since retpoline capable compilers are widely available, make
>> CONFIG_RETPOLINE hard depend on it.
>>
>> Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
>> CONFIG_RETPOLINE which is used by kernel.
>>
>> With all that stuff, the check of RETPOLINE is changed to
>> CONFIG_RETPOLINE.
> 
> So what happens when we select CONFIG_RETPOLINE but do not have
> RETPOLINE_SUPPORT ? From a quick reading we'll silently build a
> !retpoline kernel. I would expect a build failure.

CONFIG_RETPOLINE is only defined when CONFIG_RETPOLINE_SUPPORT is 
selected. See below chunk.

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -221,9 +221,10 @@ KBUILD_CFLAGS += -Wno-sign-compare
  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables

  # Avoid indirect branches in kernel to deal with Spectre
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_RETPOLINE_SUPPORT
  ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DCONFIG_RETPOLINE
+  KBUILD_AFLAGS += -DCONFIG_RETPOLINE
  endif
  endif


Thanks
Zhenzhong
