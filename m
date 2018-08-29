Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195320847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rQ+ow6iK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2195320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeH2OI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:08:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52164 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2OI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:08:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TABrSR167873;
        Wed, 29 Aug 2018 10:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=KDOjQyToVomFMXh5AtOujkrA86txlb8F6Dk13IN4/qA=;
 b=rQ+ow6iKIvFGOk7CHr6ioUN7onVYW6Epkm/YhXLeeJIiwa3VXCiPXw6Me0A2qSneRLJO
 QKKtyJhZqjtrFjSaSSCjao98cniOGoNZMY6LkuefSkYFjWE85cQms+kqB72V3rO/COgD
 Vc3H1FSveeRgIkzUjYW/Q+9naUzeaOqlh1GkNvEHlXguUwC+kPc9kJ7T9q8nmzHWld/a
 QTsXpmcWzVT4fdm/SunYx3Aiwt6e5O5rfD/RPNW4puPsX0XWoZUKv9OkAxEhros2rSpa
 IRq4PDQrNaWTujk/hHS8DB68aHjWMsn+Nw5UaEzJ4t4Kvv3VfuQfmSaUcYjVVnQBXoW3 SQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhtrwvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:12:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7TACDP9014994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:12:13 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TACC5w005200;
        Wed, 29 Aug 2018 10:12:12 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 03:12:12 -0700
Date:   Wed, 29 Aug 2018 13:12:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180829101205.jsp53e2wq7fc6ukd@mwanda>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > 1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 0cefba2..86e933c 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > 	rcu_read_lock();
> > 	map = rcu_dereference(kvm->arch.apic_map);
> > 
> > +	if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < min))
> > +		goto out;
> 
> I personally think “if ((min + __fls(ipi_bitmap_low)) > map->max_apic_id)” is more readable.
> But that’s just a matter of taste :)

That's an integer overflow.

But I do prefer to put the variable on the left.  The truth is that some
Smatch checks just ignore code which is backwards written because
otherwise you have to write duplicate code and the most code is written
with the variable on the left.

	if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))

Shouldn't this be >= instead?  It looks off by one.

regards,
dan carpenter

