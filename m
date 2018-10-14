Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E3C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF03C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3saD1Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF03C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJNRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:01:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:01:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9E9JMlx173978;
        Sun, 14 Oct 2018 09:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=05aD9b0I3N3/wDsl3G63PtCqLhzcjnbZvj4TP1v3z6Q=;
 b=a3saD1UhUdXuDuQCVlXFzaHb7xL1UeEvThQ7j1YSnEJm+Ss1x9YNtelHPEM9jbraqyhG
 sWDN18+GZeG702VM3IhGAInbg/wcS4i55KReLkR8EQT+ZSA8U8WyTdKOCoghnIeeGaoR
 qepHpaPBPyPtvACg199H3ipuM80R5RgInxENp4Lqu/YjzSmJGI6iRcFw1vrKUJ66uvfc
 UFolgaJyJEmvozuzcmPlkLovOhPOn8fa+jc/sB6UjHT89wtShMDKaNZvESdZ6hcO2oDS
 jcff5EXhRLYFXrSWroeJhyYZPDI0P2RkzQ6L7dmOPH98Ge8ARUcATCc/Igu81D3TYufb Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n384tmv5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 09:20:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9E9KKUX011508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 09:20:21 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9E9KAq9004060;
        Sun, 14 Oct 2018 09:20:12 GMT
Received: from [192.168.14.112] (/79.182.224.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Oct 2018 09:20:10 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
Date:   Sun, 14 Oct 2018 12:20:00 +0300
Cc:     lantianyu1986@gmail.com, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9045 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810140091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Sun, 14 Oct 2018, Liran Alon wrote:
>>> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
>>>=20
>>> +
>>> +static inline bool kvm_available_flush_tlb_with_range(void)
>>> +{
>>> +	return kvm_x86_ops->tlb_remote_flush_with_range;
>>> +}
>>=20
>> Seems that kvm_available_flush_tlb_with_range() is not used in this =
patch=E2=80=A6
>=20
> What's wrong with that?=20
>=20
> It provides the implementation and later patches make use of it. It's =
a
> sensible way to split patches into small, self contained entities.
>=20
> Thanks,
>=20
> 	tglx
> =09

I guess it=E2=80=99s a matter of taste, but I prefer to not add =
dead-code for patches
in order for each commit to compile nicely without warnings of declared =
and unused functions.
I would prefer to just add this utility function on the patch that =
actually use it.

-Liran

