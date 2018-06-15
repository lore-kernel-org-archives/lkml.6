Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D18208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMhJw+76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D18208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966184AbeFOTjV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:39:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964930AbeFOTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:39:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FJYUnW083711;
        Fri, 15 Jun 2018 19:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=1OxXpDGRUBzcrQo7KVwMv+tOO70hK8yKExRkpXN7lYI=;
 b=LMhJw+76XL3JRQnmFCMOEQEg3qfvfLPsFNtfu5Ee1C00j9Dd64NAEYABMbXTObzREbs4
 eA9fUwWJyCQ77u9n1Y2FtyZYzqWwO3ZWy8lC5//aXhKwJlENpjjblYnYDgk+k6UPvfrh
 6y7t3kYH61rz4l/H93lT/mjPaAkF/aIgdzy2yiKYiHJOItKfptMA+t5OzPDjcpn04S0r
 G0wWtwXRfz1SdYT9v+0PvRkJbQZ/ThptcuDlrGZ/wO2xHNunPjZLgJOl59KJDY8gHydn
 6pqGyog95oXajvZ12y/7SsBIIMF38VjZaXCR2yPccBo76ytUl+/bt9iyOGGyTvMNnwOP rA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrj74e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 19:38:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FJceT2030679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 19:38:40 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5FJcdsq016820;
        Fri, 15 Jun 2018 19:38:39 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 12:38:39 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 8F4F16A00DD; Fri, 15 Jun 2018 15:38:37 -0400 (EDT)
Date:   Fri, 15 Jun 2018 15:38:37 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>, alexandre.chartre@oracle.com
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        andrew.cooper3@citrix.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from
 CPU vendor to CPU features
Message-ID: <20180615193837.GA20921@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-4-konrad.wilk@oracle.com>
 <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com>
 <20180611140116.GA26199@char.us.oracle.com>
 <5090fe69-61fd-99cb-f9d0-908cd6250d25@amd.com>
 <alpine.DEB.2.21.1806152057020.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806152057020.1582@nanos.tec.linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=688
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 08:57:40PM +0200, Thomas Gleixner wrote:
> On Tue, 12 Jun 2018, Tom Lendacky wrote:
> > On 6/11/2018 9:01 AM, Konrad Rzeszutek Wilk wrote:
> > >> I think you will have to keep the case statements and explicitly check for
> > >> X86_FEATURE_AMD_SSBD before using SPEC_CTRL.
> > > 
> > > .. we could or alternatively add an extra check for X86_FEATURE_AMD_SSBD ?
> > 
> > Whichever you feel is best, so long as we only use SPEC_CTRL for SSBD on
> > AMD when X86_FEATURE_AMD_SSBD is present.
> 
> Is there anyone working on a fix or has this been forgotten?

I have it on my TODO.

But a bit busy with the fpu lazy so will get to it done next week.

Maybe along with the X86_FEATURE_IA32_ARCH_CAPS Bit(1): IBRS_ALL to disable
retpoline on those machines.

CCing Alex

> 
> Thanks,
> 
> 	tglx
