Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A39C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125792086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NQ1tJ0mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393433AbfBMRyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:54:39 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:12512
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393391AbfBMRyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pDO6PcCUizzZaA6wrzfQk3h4mIUB/IfC6eIOWAVzs=;
 b=NQ1tJ0mTgKv+RSJ6H0DcffESkTvTRhE2JHt7XtXKSyrH6m9aaUt8dNJGknhqyHu4HF7kpEudAbyj7jUXjgvf0ffVbgDoNfI5EYyG6UeUfaWrR4ZPfDB9oXhiPyF4y/4ozDnOPh73X2qHzXDT+R+8dLIjX4EQtmcXmdQtqeMH6TA=
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com (10.167.211.15) by
 VI1PR0801MB1917.eurprd08.prod.outlook.com (10.173.73.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Wed, 13 Feb 2019 17:54:32 +0000
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa]) by VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 17:54:32 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Kristina Martsenko <Kristina.Martsenko@arm.com>
CC:     Amit Kachhap <Amit.Kachhap@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v5 5/5] arm64/kvm: control accessibility of ptrauth key
 registers
Thread-Topic: [PATCH v5 5/5] arm64/kvm: control accessibility of ptrauth key
 registers
Thread-Index: AQHUttcIXMlYMTNtLUi7qKmd4qbM7KXeF2wAgAAFOoA=
Date:   Wed, 13 Feb 2019 17:54:31 +0000
Message-ID: <20190213175428.GR32634@e103592.cambridge.arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-6-git-send-email-amit.kachhap@arm.com>
 <6ddfa9ae-5c98-540e-b4aa-8149c8515c9e@arm.com>
In-Reply-To: <6ddfa9ae-5c98-540e-b4aa-8149c8515c9e@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::34) To VI1PR0801MB1599.eurprd08.prod.outlook.com
 (2603:10a6:800:19::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c5d73e0-139c-41f3-36c5-08d691dc4e8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1917;
x-ms-traffictypediagnostic: VI1PR0801MB1917:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;VI1PR0801MB1917;20:OpAFND329mqx4I1wIEWwZ0SVTK2kX9/HxjmN//Eyj/UzpRhVmIs4EBG96aovk8wYRnbE12S2u/Bn2fUtfOTNJA2jxjWFWGO85HJRIz9b4t7DoFl6xmvqSVMo6COBqOP6pT+Gamt6UWsy0/v9V+ndxYG1ZNHJCmk6d9dDgFEklIY=
x-microsoft-antispam-prvs: <VI1PR0801MB1917425A8DE9BF5B1C88619BFE660@VI1PR0801MB1917.eurprd08.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(40434004)(99286004)(53546011)(6306002)(6506007)(105586002)(11346002)(486006)(966005)(71200400001)(72206003)(71190400001)(6636002)(478600001)(76176011)(386003)(54906003)(476003)(256004)(5024004)(14444005)(1076003)(6436002)(6862004)(106356001)(446003)(97736004)(4326008)(86362001)(6512007)(58126008)(53936002)(229853002)(6486002)(6246003)(316002)(2906002)(305945005)(8676002)(33656002)(81166006)(102836004)(81156014)(7736002)(52116002)(186003)(14454004)(25786009)(26005)(3846002)(6116002)(66066001)(8936002)(68736007)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1917;H:VI1PR0801MB1599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTgyqczUbE7DYXwPq4ZBJ1ZRc0291fVW9EBBSYkUcfunDdHsW4r1Qj+8ztGEC5jV63wVmmpu+/UfysYYniE+sHjKxTJjyZeEknqYm9Vtp4NjbC/E104Z+0U2XaMeGxafHbt4cEZPaw27HkO9VCYg8EdaSVInbLy7Du72LIQfCMPTmmNY1CVGY5S17/dScImTSmfh6F0y5pGQzyxBsc4tt9+JRX+us5CMgw34Iul96ToeF476YR8A+1rdRRKMwS6O2dsjtQ9yRA1RGBszsJR9SdQmeEAYSwQCFLFNgRdDkmBIoK8f7j5odNmN2xWVI4W8GNBJ5Ja1zAPP28EnZfftVorYwpVYXZnxUPNgWr7AwE2TZ5qVxb/z9hfwuhE34fcIDrG6MUe3PuuKQjphsZxehol14cAULeKsBLVaORt17hY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CCFAA3A6CDAE249A322E913752952E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d73e0-139c-41f3-36c5-08d691dc4e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 17:54:31.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:35:46PM +0000, Kristina Martsenko wrote:
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> > According to userspace settings, ptrauth key registers are conditionall=
y
> > present in guest system register list based on user specified flag
> > KVM_ARM_VCPU_PTRAUTH.
> >
> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> > Cc: kvmarm@lists.cs.columbia.edu
> > Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  Documentation/arm64/pointer-authentication.txt |  3 ++
> >  arch/arm64/kvm/sys_regs.c                      | 42 ++++++++++++++++++=
+-------
> >  2 files changed, 34 insertions(+), 11 deletions(-)
> >

[...]

> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c

[...]

> > @@ -2487,18 +2493,22 @@ static int walk_one_sys_reg(const struct sys_re=
g_desc *rd,
> >  }
> >
> >  /* Assumed ordered tables, see kvm_sys_reg_table_init. */
> > -static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
> > +static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind,
> > +const struct sys_reg_desc *desc, unsigned int len)
> >  {
> >  const struct sys_reg_desc *i1, *i2, *end1, *end2;
> >  unsigned int total =3D 0;
> >  size_t num;
> >  int err;
> >
> > +if (desc =3D=3D ptrauth_reg_descs && !kvm_arm_vcpu_ptrauth_allowed(vcp=
u))
> > +return total;
> > +
> >  /* We check for duplicates here, to allow arch-specific overrides. */
> >  i1 =3D get_target_table(vcpu->arch.target, true, &num);
> >  end1 =3D i1 + num;
> > -i2 =3D sys_reg_descs;
> > -end2 =3D sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
> > +i2 =3D desc;
> > +end2 =3D desc + len;
> >
> >  BUG_ON(i1 =3D=3D end1 || i2 =3D=3D end2);
> >
> > @@ -2526,7 +2536,10 @@ unsigned long kvm_arm_num_sys_reg_descs(struct k=
vm_vcpu *vcpu)
> >  {
> >  return ARRAY_SIZE(invariant_sys_regs)
> >  + num_demux_regs()
> > -+ walk_sys_regs(vcpu, (u64 __user *)NULL);
> > ++ walk_sys_regs(vcpu, (u64 __user *)NULL, sys_reg_descs,
> > +ARRAY_SIZE(sys_reg_descs))
> > ++ walk_sys_regs(vcpu, (u64 __user *)NULL, ptrauth_reg_descs,
> > +ARRAY_SIZE(ptrauth_reg_descs));
> >  }
> >
> >  int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *ui=
ndices)
> > @@ -2541,7 +2554,12 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu=
 *vcpu, u64 __user *uindices)
> >  uindices++;
> >  }
> >
> > -err =3D walk_sys_regs(vcpu, uindices);
> > +err =3D walk_sys_regs(vcpu, uindices, sys_reg_descs, ARRAY_SIZE(sys_re=
g_descs));
> > +if (err < 0)
> > +return err;
> > +uindices +=3D err;
> > +
> > +err =3D walk_sys_regs(vcpu, uindices, ptrauth_reg_descs, ARRAY_SIZE(pt=
rauth_reg_descs));
> >  if (err < 0)
> >  return err;
> >  uindices +=3D err;
> > @@ -2575,6 +2593,7 @@ void kvm_sys_reg_table_init(void)
> >  BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
> >  BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs)));
> >  BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys=
_regs)));
> > +BUG_ON(check_sysreg_table(ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_de=
scs)));
> >
> >  /* We abuse the reset function to overwrite the table itself. */
> >  for (i =3D 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
> > @@ -2616,6 +2635,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
> >
> >  /* Generic chip reset first (so target could override). */
> >  reset_sys_reg_descs(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
> > +reset_sys_reg_descs(vcpu, ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_de=
scs));
> >
> >  table =3D get_target_table(vcpu->arch.target, true, &num);
> >  reset_sys_reg_descs(vcpu, table, num);
>
> This isn't very scalable, since we'd need to duplicate all the above
> code every time we add new system registers that are conditionally
> accessible.

Agreed, putting feature-specific checks in walk_sys_regs() is probably
best avoided.  Over time we would likely accumulate a fair number of
these checks.

> It seems that the SVE patches [1] solved this problem by adding a
> check_present() callback into struct sys_reg_desc. It probably makes
> sense to rebase onto that patch and just implement the callback for the
> ptrauth key registers as well.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send=
-email-Dave.Martin@arm.com/

Note, I'm currently refactoring this so that enumeration through
KVM_GET_REG_LIST can be disabled independently of access to the
register.  This may not be the best approach, but for SVE I have a
feature-specific ID register to handle too (ID_AA64ZFR0_EL1), which
needs to be hidden from the enumeration but still accessible with
read-as-zero behaviour.

This changes the API a bit: I move to a .restrictions() callback which
returns flags to say what is disabled, and this callback is used in the
common code so that you don't have repeat your "feature present" check
in every accessor, as is currently the case.

I'm aiming to post a respun series in the next day or two.  The code
may of course change again after it gets reviewed...


Basing on [1] is probably a reasonable starting point, though.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
