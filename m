Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB81C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B8620835
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JyEieC8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B8620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeH2Ovb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:51:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2Ovb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:51:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TAqbVZ033587;
        Wed, 29 Aug 2018 10:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=4k+m9UXjowgCUEOZUOZssP3wAPD18Lcch7g4AX9iUec=;
 b=JyEieC8M63Nst3gHk7w5uwMAXLZnXGxR/0hkAKg0xCIPzuL0kVPD/siKc4e77SrimhK5
 g/w/O12d/aIeoNU6zFRCBfSMAUMUAcuPEGjDJTOg0JLaGth1dlDiESAaWYhFJ1y+dQtr
 har2gTwDXY2TaJW/GfwFDt9OzemaobrVXOl7dQWnM+MHW0f7RKVyDXIel/SdbcXHvK5L
 eV9FUn6vB/diZbsmxhxi95GWaT1+rQk+DRm15ord9EnPylT5bHKc/ABB0wD3anIuluB1
 +dI7laDOhhNsSCk1tgrrFgPPs1bIFITIWKgTqZ8+1YoSBv/e76uixrkAqxjw8wwIRA+7 Sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m2y2ph28x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:55:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7TAt7I6026722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:55:07 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TAt7YZ024938;
        Wed, 29 Aug 2018 10:55:07 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 03:55:06 -0700
Date:   Wed, 29 Aug 2018 13:54:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180829105459.q6f74vprs4cvbg7r@mwanda>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
 <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
 <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda>
 <CANRm+CwszD_9xsHjxQPSuDQ00P1+rsx8vTWoyp-kespeUK1YqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRm+CwszD_9xsHjxQPSuDQ00P1+rsx8vTWoyp-kespeUK1YqA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:42:42PM +0800, Wanpeng Li wrote:
> On Wed, 29 Aug 2018 at 18:29, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
> > > On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > > > > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > > > > index 0cefba2..86e933c 100644
> > > > > > > --- a/arch/x86/kvm/lapic.c
> > > > > > > +++ b/arch/x86/kvm/lapic.c
> > > > > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > > > > > >   rcu_read_lock();
> > > > > > >   map = rcu_dereference(kvm->arch.apic_map);
> > > > > > >
> > > > > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < min))
> > > > > > > +         goto out;
> > > > > >
> > > > > > I personally think “if ((min + __fls(ipi_bitmap_low)) > map->max_apic_id)” is more readable.
> > > > > > But that’s just a matter of taste :)
> > > > >
> > > > > That's an integer overflow.
> > > > >
> > > > > But I do prefer to put the variable on the left.  The truth is that some
> > > > > Smatch checks just ignore code which is backwards written because
> > > > > otherwise you have to write duplicate code and the most code is written
> > > > > with the variable on the left.
> > > > >
> > > > >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
> > > >
> > > > Wait, the (s32) cast doesn't make sense.  We want negative min values to
> > > > be treated as invalid.
> > >
> > > In v2, how about:
> > >
> > > if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) >
> > > map->max_apic_id))
> > >     goto out;
> >
> > That works, too.  It still has the off by one and we should set
> 
> Sorry, why off by one?

Sorry, my bad.  I looked at the code and > is correct.  (At first, I
thought it should be >= but I hadn't looked at the context).

regards,
dan carpenter

