Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43636C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC3208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4u5oa5We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DC3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933774AbeGISd0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:33:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbeGISdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:33:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69ISPCH127920;
        Mon, 9 Jul 2018 18:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5e+8MgpEQ9qLN34WX51G5cXiRwNWnoPOjGMdQpBy+SI=;
 b=4u5oa5We9kz+D+DvgHFCAQNCqjbcbs/2FRLIxR/rqNSlEg07vQgIDIEKqY8oyxstpwFd
 1NGKEwcDOZqjBMmMym5EQ5646k+6UQjuolGlXZS+/JaK5RnhGgq6N3V+o5iG1V0sKA2u
 niZf5A4OM+LZt/2HEI8hwFt8gJye6K/Q2+Wcj4aannuVdAsdASV7tNamMWIK0WEwlLSU
 UJyB+Xz3NJ07yAolDj+PQEhGRcIz5cAyR4HBCSYYv4RlWV/0CBkkKaZdL2KucK8ixTsT
 r7zi9yf7WHK/flg3t42c7m4oOj9DqgmyMtlDsVSfltOd0AOGRoa5VHDUYszI54FrYRK5 +A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k2p75nf5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 18:32:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69IWsY1013458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 18:32:54 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69IWqp0024983;
        Mon, 9 Jul 2018 18:32:52 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:32:52 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1A3B86A00C3; Mon,  9 Jul 2018 14:32:51 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:32:50 -0400
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
Subject: Re: [PATCHv4 15/18] x86/mm: Calculate direct mapping size
Message-ID: <20180709183250.GJ6873@char.US.ORACLE.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626142245.82850-16-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=695
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:22:42PM +0300, Kirill A. Shutemov wrote:
> The kernel needs to have a way to access encrypted memory. We have two
> option on how approach it:
> 
>  - Create temporary mappings every time kernel needs access to encrypted
>    memory. That's basically brings highmem and its overhead back.
> 
>  - Create multiple direct mappings, one per-KeyID. In this setup we
>    don't need to create temporary mappings on the fly -- encrypted
>    memory is permanently available in kernel address space.
> 
> We take the second approach as it has lower overhead.
> 
> It's worth noting that with per-KeyID direct mappings compromised kernel
> would give access to decrypted data right away without additional tricks
> to get memory mapped with the correct KeyID.
> 
> Per-KeyID mappings require a lot more virtual address space. On 4-level
> machine with 64 KeyIDs we max out 46-bit virtual address space dedicated
> for direct mapping with 1TiB of RAM. Given that we round up any
> calculation on direct mapping size to 1TiB, we effectively claim all
> 46-bit address space for direct mapping on such machine regardless of
> RAM size.
> 
> Increased usage of virtual address space has implications for KASLR:
> we have less space for randomization. With 64 TiB claimed for direct
> mapping with 4-level we left with 27 TiB of entropy to place
> page_offset_base, vmalloc_base and vmemmap_base.
> 
> 5-level paging provides much wider virtual address space and KASLR
> doesn't suffer significantly from per-KeyID direct mappings.
> 
> It's preferred to run MKTME with 5-level paging.


Why not make this a config dependency then?
