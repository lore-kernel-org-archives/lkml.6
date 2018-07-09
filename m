Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283C02089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UhmoKn2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283C02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGISxQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:53:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57756 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeGISxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:53:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69IhwxC144523;
        Mon, 9 Jul 2018 18:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vs1dtWJdXllV9NEAVGI4UaCHV390jV9yOa1BsmGnals=;
 b=UhmoKn2Lyfrai3uGhAvo4qFnIllNqqjVhg9k5FpnHra+8ssBSK0duBiRT3AumNuBiq1H
 QcBIJfQ84f/PwwFt53fWROyp3iwmYCps2Ywz4vOZ/XeBxmA1jHixFPBo/2vYEZFH3yhc
 kZksqwUW1TLJssDixEgz2aA5f7SIhkgKuziafq+YcYLeuoiBaEUGHub5NXO6VPpcRnp5
 MYLA0l+m0SzAZ+lWL3sAWMKOBGDRqmS7NKGzxuIPwZeADTrmJXM677gsvmQiX/0ouvy0
 MpQVeGrNJcPSC6is8GOo1cDJRop11akNoJWhCr3xUusuEscmOesoRFQAErRuX5S2280N yg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k2p7dngvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 18:52:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69IqnDr025271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 18:52:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69IqmVk006018;
        Mon, 9 Jul 2018 18:52:48 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:52:48 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E65B26A00C3; Mon,  9 Jul 2018 14:52:46 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:52:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 18/18] x86: Introduce CONFIG_X86_INTEL_MKTME
Message-ID: <20180709185246.GC17368@char.us.oracle.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
 <20180709183656.GK6873@char.US.ORACLE.com>
 <d9edff3d-64bd-be81-c9fd-52699d7da81e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9edff3d-64bd-be81-c9fd-52699d7da81e@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:44:33AM -0700, Dave Hansen wrote:
> On 07/09/2018 11:36 AM, Konrad Rzeszutek Wilk wrote:
> > On Tue, Jun 26, 2018 at 05:22:45PM +0300, Kirill A. Shutemov wrote:
> > Rip out the X86?
> >> +	bool "Intel Multi-Key Total Memory Encryption"
> >> +	select DYNAMIC_PHYSICAL_MASK
> >> +	select PAGE_EXTENSION
> > 
> > And maybe select 5-page?
> 
> Why?  It's not a strict dependency.  You *can* build a 4-level kernel
> and run it on smaller systems.

Sure, but in one of his commits he mentions that we may run in overlapping
physical memory if we use 4-level paging. Hence why not just move to 5-level
paging and simplify this.
> 
> >> +	depends on X86_64 && CPU_SUP_INTEL
> >> +	---help---
> >> +	  Say yes to enable support for Multi-Key Total Memory Encryption.
> >> +	  This requires an Intel processor that has support of the feature.
> >> +
> >> +	  Multikey Total Memory Encryption (MKTME) is a technology that allows
> >> +	  transparent memory encryption in and upcoming Intel platforms.
> > 
> > How about saying which CPUs? Or just dropping this?
> 
> We don't have any information about specifically which processors with
> have this feature to share.  But, this config text does tell someone
> that they can't use this feature on today's platforms.
> 
> We _did_ say this for previous features (protection keys stands out
> where we said it was for "Skylake Servers" IIRC), but we are not yet
> able to do the same for this feature.
