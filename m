Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CEEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDBB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDBB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeK0TLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:11:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbeK0TLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:11:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR84J03016082
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:13:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p10bfvvqr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:13:58 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 27 Nov 2018 08:13:56 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 08:13:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAR8Dqt257409542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 08:13:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F2BA4053;
        Tue, 27 Nov 2018 08:13:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6531A4051;
        Tue, 27 Nov 2018 08:13:51 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Nov 2018 08:13:51 +0000 (GMT)
Date:   Tue, 27 Nov 2018 09:13:50 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Wang <liwang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
 <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
 <20181031073149.55ddc085@mschwideX1>
 <20181031100944.GA3546@osiris>
 <20181031103623.6ykzsjdenrpeth7x@kshutemo-mobl1>
 <20181127073411.GA3625@osiris>
 <20181127080515.py6naga4gsi2yad2@kshutemo-mobl1>
MIME-Version: 1.0
In-Reply-To: <20181127080515.py6naga4gsi2yad2@kshutemo-mobl1>
X-TM-AS-GCONF: 00
x-cbid: 18112708-0028-0000-0000-000003220AF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112708-0029-0000-0000-000023DE1263
Message-Id: <20181127081350.GC3625@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:05:15AM +0300, Kirill A. Shutemov wrote:
> > E.g. something like the below. If there aren't any objections, I will
> > provide a proper patch with changelog, etc.
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 07cddff89c7b..d7aeec03c57f 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
> >  	}
> >  
> >  	if (mm_pgtables_bytes(mm))
> > -		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> > -				mm_pgtables_bytes(mm));
> > +		printk_once(KERN_ALERT "BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> > +			    mm_pgtables_bytes(mm));
> 
> You can be the first user of pr_alert_once(). Don't miss a chance! ;)

I didn't expect that that one exists. ;) Will do.

