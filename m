Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3122620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkzzSq2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3122620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeK3BnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:43:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50612 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbeK3BnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:43:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEYY1A038243;
        Thu, 29 Nov 2018 14:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hR0fklHb+ZaqoM+BYuO3NMItPMYV0jbbaNLHEKqfGRY=;
 b=EkzzSq2V5h4IdrDVtIjUclqqVlNQlL7BZTCPtiC+T2dkycn/1xtpNE7ax9slX3gwdQUQ
 ipQu3Sy2oX8S3v6DCj5Ntc/N59eHxAd8Dxt98jR5UtQLtfiDhKF3r8TuYclOBW3Bvo1s
 /LRpRLK+BN8z9NU4EWjRMIVfmrBvVphJy1n3/RZ6LT/eYwotXOkc1PeDyhXj2j08qJCT
 6ir5xSce00HK1P2O/cZ+WlCiin4y2av11vfCIeVrtsLR5BAYNrZQVl/plZrbtp/JfLtz
 FETszKE+1VZ+yLSUV1JK7DHW4FmyemnSQUxpVZOF3GGAHZe5wf0eSS2oFA7OfV8SA4s8 Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9rgga2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:37:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATEb8BJ024010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:37:08 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATEb7Eu028030;
        Thu, 29 Nov 2018 14:37:07 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:37:07 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 0CD206A00FB; Thu, 29 Nov 2018 09:37:04 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:37:03 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 06/28] x86/speculation: Rename SSBD update functions
Message-ID: <20181129143703.GG32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.058866968@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185004.058866968@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:34PM +0100, Thomas Gleixner wrote:
> During context switch, the SSBD bit in SPEC_CTRL MSR is updated according
> to changes of the TIF_SSBD flag in the current and next running task.
> 
> Currently, only the bit controlling speculative store bypass disable in
> SPEC_CTRL MSR is updated and the related update functions all have
> "speculative_store" or "ssb" in their names.
> 
> For enhanced mitigation control other bits in SPEC_CTRL MSR need to be
> updated as well, which makes the SSB names inadequate.
> 
> Rename the "speculative_store*" functions to a more generic name.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
