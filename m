Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9D20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JCEa5qWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A9D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934059AbeGISLV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:11:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55580 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbeGISLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:11:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69HwhcH105495;
        Mon, 9 Jul 2018 18:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=z+o+uOf7s8paatB0R72lV3uZamsTWRB26/K6KviTcWw=;
 b=JCEa5qWBqGRix734VrXU33uTJICWlE6mhEPJs35cUlWTSQTGesaqhaHlRnOMVq0P7GzP
 ELY+gDMFOoLSYbYEn9HR5rJGrqVFKCASZTrTVsDf69wTWfVqCLWnl0eb2wKJdoWU8aZ4
 mzDpG7QpC5SjsLGVXuQNQZf3g6LnHGOM40rqYLC8vm/wJmO/bTjySwHyJd5TX6PYEMjj
 5+QVJCKAIU5m68zOWzaybk22c/MQwED7xm/3obtXhqrqPqlPKW6uV20c/ARkWE2IbkFT
 HxzaJLeVFAaz/iyYzmcFuwfw+55UWhuIlqQkf1R9c4RZzfXKshnF1cNzthSd4eY9X7Ue xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p75nccj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 18:09:53 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69I9p08025859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 18:09:52 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69I9oe5025774;
        Mon, 9 Jul 2018 18:09:51 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:09:50 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 7F2006A00C3; Mon,  9 Jul 2018 14:09:49 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:09:49 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 07/18] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180709180949.GH6873@char.US.ORACLE.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-8-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626142245.82850-8-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 4b101dd6e52f..4ebee899c363 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> +
> +obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o

Any particular reason to have x86 in the CONFIG?

> diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> new file mode 100644
> index 000000000000..467f1b26c737
> --- /dev/null
> +++ b/arch/x86/mm/mktme.c
> @@ -0,0 +1,5 @@
> +#include <asm/mktme.h>
> +
> +phys_addr_t mktme_keyid_mask;
> +int mktme_nr_keyids;
> +int mktme_keyid_shift;
> -- 
> 2.18.0
> 
