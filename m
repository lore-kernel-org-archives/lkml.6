Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE0BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1178F21502
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1178F21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeHUKFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:05:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbeHUKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:05:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7L6i5tV069817
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:47:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0dp985uf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:47:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 21 Aug 2018 07:46:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 07:46:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7L6ks4c20185236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 06:46:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E838611C05C;
        Tue, 21 Aug 2018 09:46:54 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C414C11C052;
        Tue, 21 Aug 2018 09:46:53 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 21 Aug 2018 09:46:53 +0100 (BST)
Date:   Mon, 20 Aug 2018 23:46:52 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kobject: Access kobject name with caution if state is
 not initialized
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180820192247.GA20101@kroah.com>
 <CAKdAkRT3OfvcvHdNC4Jn1RfM76TUHohcXVFDA0QfsSPdTW348Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKdAkRT3OfvcvHdNC4Jn1RfM76TUHohcXVFDA0QfsSPdTW348Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082106-0028-0000-0000-000002ED817B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082106-0029-0000-0000-000023A6BD33
Message-Id: <20180821064652.GB33230@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2018-08-20 12:33:50]:

> On Mon, Aug 20, 2018 at 12:22 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 20, 2018 at 10:39:47PM +0530, Srikar Dronamraju wrote:
> > Lots of stupid modules can do dumb things.  Just don't do that.  The
> > kernel is not built to keep you from doing stupid things in kernel code
> > :)
> >
> > So I fail to see why this patch is needed.  What in-kernel code path is
> > trying to print a kobject's name before it is initialized?  Why not fix
> > that obvious bug instead of forcing the kernel core to protect from
> > stupid code?
> 
> Kay decided to add some guards in:
> 
> commit 0f4dafc0563c6c49e17fe14b3f5f356e4c4b8806
> Author: Kay Sievers <kay.sievers@vrfy.org>
> Date:   Wed Dec 19 01:40:42 2007 +0100
> 
>    Kobject: auto-cleanup on final unref
> ...
> 
> +       if (!kobj->state_initialized) {
> +               printk(KERN_ERR "kobject '%s' (%p): tried to add an "
> +                      "uninitialized object, something is seriously wrong.\n",
> +                      kobject_name(kobj), kobj);
> +               dump_stack();
> +               return -EINVAL;
> 
> Given that we have dump_stack() we can probably simply drop
> kobject_name(kobj) instead of building even more elaborate checks. Or
> just drop the whole check. Adding kobjects is somewhat uncommon
> operation, plus "gabage in, garbage out".
> 

Dropping the kobject_name(kobj) should also be okay.

