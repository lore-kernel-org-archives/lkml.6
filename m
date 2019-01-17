Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB25C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xrKDs/KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfAQJRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:17:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfAQJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:17:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H9DrkR087298;
        Thu, 17 Jan 2019 09:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=17gCzCsVba/t/B3wS0SMg4RzfPAP4ovajvLZ0tomFJ4=;
 b=xrKDs/KUfJR/ZLp+FuLTmI6Nv4y/Mu8gu1NgqOQ1fJ0KcJjbIO5AMaPuSMgRTXhpMBjY
 ygvJInce/KCLuN6t1S5K8wA1rqwXcC2Wd1x0y5eA4sYgHMD/eOJrePX83YTkPtwptSGE
 qVUcdHeU0Rh55vdkv+OAFxE7pPaDFPBkmM/CQhBrTT5t4FlUZXMr8wCl18t5yE1BDFsp
 r3v5AJbZq8nB9Fc2Ds6ZpsCHtYWxpRcVSv1RGpknQcA3tSVgFFxx00AkXh3dy+Bpk66r
 FTI99lIcWjPCYWIsOUhAHF7RTfBKTxyLze6XVdIiDnB3byN6LNXeQvnd5wiv+zr1czdT KQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjseq2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 09:17:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0H9H49i003943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 09:17:04 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0H9H290008422;
        Thu, 17 Jan 2019 09:17:03 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 01:17:02 -0800
Date:   Thu, 17 Jan 2019 12:16:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
Message-ID: <20190117091646.GA11828@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
 <20190117070227.GM4504@kadam>
 <1547714827.5079.19.camel@Centos6.3-64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547714827.5079.19.camel@Centos6.3-64>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=926
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:47:07PM +0800, Ching Huang wrote:
> On Thu, 2019-01-17 at 10:59 +0300, Dan Carpenter wrote:
> > On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> > > >From Ching Huang <ching2048@areca.com.tw>
> > > 
> > > Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> > > 
> > 
> > What does this look like from a user perspective?  Does it fail every
> > time or does it only fail sometimes?
> > 
> > What's the bug exactly?
> > 
> > There is no Fixes tag...
> >From user's perspective, hibernate/resume are OK.
> But following IO may cause 'isr get an illegal ccb command' in
> log/messages sometime.
> > 


You will need to resend with that information included in the commit
message.

> > > Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> > > ---
> > > 
> > > diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> > > index a94c513..b98c632 100755
> > > --- a/drivers/scsi/arcmsr/arcmsr.h
> > > +++ b/drivers/scsi/arcmsr/arcmsr.h
> > > @@ -508,9 +508,9 @@ struct MessageUnit_A
> > >  struct MessageUnit_B
> > >  {
> > >  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > 
> > There is a well known rule of thumb that when someone uses "volatile"
> > in the kernel it means there is a locking problem...  Is this __iomem or
> > something?
> The done_qbuffer was a command completion queue, it was an area written
> by IO processor and read by device driver. So, ...

I'm not totally positive I understand this sentence.  I can find a bunch
of places which read from this buffer, but I haven't immediately found
which place writes to it.  Can you give me a function name that I should
read?

> > 
> > >  	uint32_t	postq_index;
> > > -	uint32_t	doneq_index;
> > > +	volatile uint32_t	doneq_index;

The volatile here is not right.  It's just normal memory.

regards,
dan carpenter
