Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CA5218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="LqxiRul4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfBARhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:37:39 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41460 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725797AbfBARhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:37:39 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11HWbmF031188;
        Fri, 1 Feb 2019 11:36:54 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
        by mx0a-00010702.pphosted.com with ESMTP id 2qc1m64t0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Feb 2019 11:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUG9bxXp3j5/Zlzk0MW/QeS78gb1kkQVKhuBNOPzayE=;
 b=LqxiRul44xzR/MJZpR6TnGD6h7R68v5xkHeD3mv0kmEd15ZMgLFRj8RCfpC5mgJygRCaQ667/1nyrla1+Hg8x6j+xnw4uwl0RU9ZzXxB8TYhPTzzR0ET3c1dMQ22faySsxUzJ6sfAuuxB9cBvUAjBuXr37x77LBMv7Ykv9lNpjA=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0405.namprd04.prod.outlook.com (10.173.199.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 17:36:52 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f%6]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 17:36:52 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Julien Thierry <julien.thierry@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make
 vgic_irq->irq_lock a raw_spinlock
Thread-Index: AQHUulS3ozkeZJl0akizUjBTsERiAQ==
Date:   Fri, 1 Feb 2019 17:36:51 +0000
Message-ID: <20190201173650.GC29111@jcartwri.amer.corp.natinst.com>
References: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
 <1546873577-13895-2-git-send-email-julien.thierry@arm.com>
 <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
In-Reply-To: <fa628aae-68eb-7140-0533-367cafa26ed6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.151]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR04MB0405;6:Bj4HmGLdkVnBoSNGtzik96edGN9T4QSS1rklhz4wkmNWF4htuKV5PWbiVqHxYR4DDkeZVUz88Yqj6bW3WnWrDJdekSlD9W+RaCPoVzlo3OX/8slnDu7ANj+tkNj8PvHZ6p3fpvHMiu2+0yxsW8CoKNVXQPnmg18K/Ql/wZD+6a/wsFyghscmlQ/fFzdQ3DmVEgd49P2qiHqYt265jAw4f+hcagdfYLRKYEY4NFM7+/HMEuMSaqS9rE4JIvk3JUE7VvxZhCvy3Rok0FR/NHu7bWUEPXg/IBVI8XaJUjSXT1zIApHHA/vwvkaryNECqa3FQOrZzavoOhaqghKpjMo+SL/qfOaZ+YUqvID5vBXjsrmKX8z4Zkt9Ro7sXfzfcHFYwfAv43DlfNZnPgmyoR1ISrOgVQhuxrgMKPD+XcsPr8LPg80GqRl0yBlK1V+8vMULUGoF7UHiR3otqMp/m4t/OQ==;5:2Ur2N3uqIj3HfIbi5ecw/FDgupicYU4AcVhbejfmuLCcc5qWRTa56v4BZzuOu91+feEBPG8QDS4UtuT1HutcoL6QXAIZARxHq9ney48xNbr2/zwQj9UXNGBdF91dbx2WayWdkLNduIOShiwKAwXwIRtDYQxB1nbeNq/vCAdBSqIMCjDCWGgbNwD4yaYGuTVbwUwrkwXSRIt8Ll/1+0m64Q==;7:0ObvD4M3jl14b2cgKPaCmD9Lqp4VojetldcYMOuAGpnjRtbyfZ5PyoFGpmHni5gjAGgq2bioUTblVqPqt37mREZC231WVIFSwVbjFIIFXeu/cpGospMKn4J/PC/zuSEsmlm6TgRWbH74lOw+YNMsqA==
x-ms-office365-filtering-correlation-id: d8f0b6a1-6561-4c51-ab01-08d6886bd9bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0405;
x-ms-traffictypediagnostic: BN6PR04MB0405:
x-microsoft-antispam-prvs: <BN6PR04MB0405DBAF0CB47FEFC4F8D275F4920@BN6PR04MB0405.namprd04.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(229853002)(8936002)(81156014)(52116002)(81166006)(8676002)(7736002)(305945005)(76176011)(33896004)(105586002)(14454004)(1076003)(66066001)(71200400001)(53936002)(186003)(71190400001)(386003)(53546011)(6506007)(486006)(26005)(6246003)(256004)(11346002)(14444005)(446003)(6116002)(3846002)(6512007)(6346003)(4326008)(68736007)(316002)(6436002)(33656002)(478600001)(99286004)(25786009)(102836004)(7416002)(106356001)(97736004)(6486002)(54906003)(476003)(9686003)(2906002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0405;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E0SCRGBSYOi+iTH/H6OgjoInn7nlOpUjLDwgDRr/BUOaydWV8Y43Wp85XCZ5Z8k/K/W4r7fmm2ffUMp4Bq4JNB6fgHLfei6uDkdnA0ZJBON61XDNo0koGzPgei35jrvSC30xdDmjPBg0pHxqaGBHiTAMx3mrJSWV6QrmO7WLLJgC7fj63olu3oyUkhFGsNjEtrmQHeEbd6sMO17Q9ALFDP72lXuzfYu0R2Mfp4vDSVDBtgO1Zw8O1qYcjsx3JHJXRUxK1gwLckJb9CBWyy1Zvsayj6mN+IQ5qQUDzxsVSaHHRkhye57deDd/YQ5OUG8CW2ZWjLqqZGrTiN8SSBlmhs3UbFGOVPDb8h/hjR6f0O4zEbGBFclNMTiT8vYRBZhRVZrERjFlkCqlk05A94UVhNxlOdYzi0ukjhoI5Ds+WvA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B21F09D3BD4EC84294307AC2D0DEACF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0b6a1-6561-4c51-ab01-08d6886bd9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 17:36:51.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0405
Subject: Re:  Re: [PATCH v3 1/3] KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a
 raw_spinlock
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:30:58PM +0000, Julien Grall wrote:
> Hi Julien,
>=20
> On 07/01/2019 15:06, Julien Thierry wrote:
> > vgic_irq->irq_lock must always be taken with interrupts disabled as
> > it is used in interrupt context.
>=20
> I am a bit confused with the reason here. The code mention that ap_list_l=
ock
> could be taken from the timer interrupt handler interrupt. I assume it
> speaks about the handler kvm_arch_timer_handler. Looking at the
> configuration of the interrupt, the flag IRQF_NO_THREAD is not set, so th=
e
> interrupt should be threaded when CONFIG_PREEMPT_FULL is set. If my
> understanding is correct, this means the interrupt thread would sleep if =
it
> takes the spinlock.
>=20
> Did I miss anything? Do you have an exact path where the vGIC is actually
> called from an interrupt context?

The part you're missing is that percpu interrupts are not force
threaded:

	static int irq_setup_forced_threading(struct irqaction *new)
	{
		if (!force_irqthreads)
			return 0;
		if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
			return 0;
=09
		/* ...*/
	}

   Julia
