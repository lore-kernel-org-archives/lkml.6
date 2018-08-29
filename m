Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF02C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D920858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAWdRbvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeH2OZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:25:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35448 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2OZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:25:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TAOOFL010528;
        Wed, 29 Aug 2018 10:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=lDwxGjGIc5tOR3cXBBnlJsEDEIYK/FeB6siv9Yoarzw=;
 b=hAWdRbvo8okSvx6C2IKdrcj0sKkrUHuuPeLz56gkyaSQk0GgaV/K0FPLr46u3u23AEqb
 OBd1d7XxoUxsnO8aVEgpgpOvhnbusL1AbKT9diCFdwW97vs08Wae0+0WXRi7Y5fPmVwx
 bSU/V9cARMn44gsV+r0MeM4Ruq1GZk50psrwPSSjrn3IDSa/CTPC+2UJLD9hyFlEiwZ+
 I+Og83y5jQn0ZiHlCMT+d1pr74wXrGFIjTHAwrKMW3/B14d5nSak8jG5SfaGDknH+35v
 0DOHQNnpspid7GGLyUe0KnVTEWuF5ADaF6iIXrOKQm/NunhCIRz5sIZIHXQud3XR8F17 7Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m2y2pgy5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:29:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TATJGd022533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:29:19 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7TATIru018242;
        Wed, 29 Aug 2018 10:29:18 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 03:29:17 -0700
Date:   Wed, 29 Aug 2018 13:29:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180829102910.rkyato47chayt22s@mwanda>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
 <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
 <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
> On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > > index 0cefba2..86e933c 100644
> > > > > --- a/arch/x86/kvm/lapic.c
> > > > > +++ b/arch/x86/kvm/lapic.c
> > > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > > > >   rcu_read_lock();
> > > > >   map = rcu_dereference(kvm->arch.apic_map);
> > > > >
> > > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < min))
> > > > > +         goto out;
> > > >
> > > > I personally think “if ((min + __fls(ipi_bitmap_low)) > map->max_apic_id)” is more readable.
> > > > But that’s just a matter of taste :)
> > >
> > > That's an integer overflow.
> > >
> > > But I do prefer to put the variable on the left.  The truth is that some
> > > Smatch checks just ignore code which is backwards written because
> > > otherwise you have to write duplicate code and the most code is written
> > > with the variable on the left.
> > >
> > >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
> >
> > Wait, the (s32) cast doesn't make sense.  We want negative min values to
> > be treated as invalid.
> 
> In v2, how about:
> 
> if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) >
> map->max_apic_id))
>     goto out;

That works, too.  It still has the off by one and we should set
"count = -KVM_EINVAL;".

Is the unlikely() really required?  I don't know what the fast paths are
in KVM, so I don't know.

regards,
dan carpenter

