Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC00C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65D626F0C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g44ZldtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65D626F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754926AbeFZSbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:31:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54534 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeFZSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:31:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QISTFi093913;
        Tue, 26 Jun 2018 18:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=5mNhj+kUDYwGZvMJ6A7SVANZvW6G0lBdmIRIMbD8vCU=;
 b=g44ZldtQ05NrCniM1Kug1VcDHAWuuHUMVAuR62D7gi47x6AdYTL6KQv29SvB2gCZXyD3
 cvnWzkW8wMO+6tEVvId4Mx/20Wr0QncAzg50ODPL1kEB88ifcW0+ybLs84ZA08AKExWd
 xiCmTpp8LMvwDVCPowbUDnHLNPLThxiN1fQA13sz2SkPpl3JFHnxZ9zF6s9EFGPQq4Ve
 TDYEjyuK+VlKpS2qVdBEjpGuDPHrT+y5hnkXqGw9JbU2QyEGd/urL4t6kwNLmey8DyJV
 jmlxECZtwtp5z9FMhO1swbtSt/WkyJBN3+WMBo6jxImhlFy7PO8JNk/cjuh5LeMHxD4/ Ow== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jukmtsvj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 18:31:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5QIVMBc011323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 18:31:23 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QIVM1B019733;
        Tue, 26 Jun 2018 18:31:22 GMT
Received: from [10.175.202.73] (/10.175.202.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 11:31:22 -0700
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
 <20180626164338.GH2458@hirez.programming.kicks-ass.net>
From:   Allan Xavier <allan.x.xavier@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=allan.x.xavier@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jycc5aNW5OOSmgYj
Message-ID: <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
Date:   Tue, 26 Jun 2018 19:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626164338.GH2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=613
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 26/06/18 17:43, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 05:20:45PM +0100, Allan Xavier wrote:
>> 0000000000000500 g     F .text  0000000000000034 nmi_panic
>> 0000000000000528 l     F .text  000000000000000c nmi_panic.cold.7
>>
>> This doesn't happen with -freorder-functions in the first example as the
>> symbols don't overlap. 
> 
> Urgh and I don't suppose we can 'fix' the overlap in read_symbols() ?
> 

It should be fixable in read_symbols too if you don't mind sym->len not being
the same as sym->st_size in the ELF.

Is there a particular concern you're trying to address by having the logic there
instead?

Will have a look into reworking the patch in any case.

Thanks,
Allan
