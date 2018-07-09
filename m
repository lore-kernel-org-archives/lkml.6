Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E8FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E340D208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X6PTDR1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E340D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGIUab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:30:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbeGIUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:30:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69KT6xm083969;
        Mon, 9 Jul 2018 20:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zPNWT6WF60sJudH/ZoNy+hy3gWFjFsyZKjwRao1QdW0=;
 b=X6PTDR1BetVxC+w51UQjoWP7ZcpqHxdGTzG2aKnDXP8Fk2StFsYMzGhd+TqTNaozuFQt
 QK0rPi2+J+chD7hkZhN9S72sLby8mi/OoZrHeS6/7qhdRZc1TmnpuxQdrJ7AidMf7BH4
 DNqg4Ag+Wn5wmSgvIwT009Yx4DAPSL/xte9Mr5PttKJmROoSBgkAc4Qiu3gjqEMO7rwk
 s26OhzKkdZrqKaq8Itlpp6HePqkhQGDWmRIz23xmX4fjshw2b+FWBXRX29cEr/LfQ6sM
 5TfYGpLNminK+4gR5blp34ModvH67Fq4SVWIWXhZsEVRmKAMaleCCQW4LPsUCtghAk14 LA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k2p7v71sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 20:30:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69KTxBn012459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 20:30:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69KTvp9024686;
        Mon, 9 Jul 2018 20:29:57 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 13:29:57 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 55C216A00C3; Mon,  9 Jul 2018 16:29:43 -0400 (EDT)
Date:   Mon, 9 Jul 2018 16:29:43 -0400
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
Message-ID: <20180709202943.GK17368@char.us.oracle.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
 <20180709183656.GK6873@char.US.ORACLE.com>
 <d9edff3d-64bd-be81-c9fd-52699d7da81e@intel.com>
 <20180709185246.GC17368@char.us.oracle.com>
 <7491deb5-c89e-cbd0-6c17-404d26c30aeb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7491deb5-c89e-cbd0-6c17-404d26c30aeb@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:59:33AM -0700, Dave Hansen wrote:
> On 07/09/2018 11:52 AM, Konrad Rzeszutek Wilk wrote:
> > On Mon, Jul 09, 2018 at 11:44:33AM -0700, Dave Hansen wrote:
> >> On 07/09/2018 11:36 AM, Konrad Rzeszutek Wilk wrote:
> >>> On Tue, Jun 26, 2018 at 05:22:45PM +0300, Kirill A. Shutemov wrote:
> >>> Rip out the X86?
> >>>> +	bool "Intel Multi-Key Total Memory Encryption"
> >>>> +	select DYNAMIC_PHYSICAL_MASK
> >>>> +	select PAGE_EXTENSION
> >>>
> >>> And maybe select 5-page?
> >>
> >> Why?  It's not a strict dependency.  You *can* build a 4-level kernel
> >> and run it on smaller systems.
> > 
> > Sure, but in one of his commits he mentions that we may run in overlapping
> > physical memory if we use 4-level paging. Hence why not just move to 5-level
> > paging and simplify this.
> 
> I'm not sure it _actually_ simplifies anything.  We still need code to
> handle the cases where we bump into the limits because even 5-level
> paging systems can hit the *architectural* limits.  We just don't think
> we'll bump into those limits any time soon in practice since they're
> 512x larger on 5-level systems.
> 
> But, a future system that needs physical address space or has a bunch
> more KeyID bits might bump into the limits.

Yikes. So when will we expand to 128-bit page fields?

> 
> It's also _possible_ that a processor could come out that supports MKTME
> but not 5-level paging, or a hypervisor would expose such a
> configuration to a guest.  We've asked our colleagues very nicely that
> Intel not make a processor that does this, but it's still possible one
> shows up.
