Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C10ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE79A2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pztfraTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE79A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJYWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:38:30 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:62168
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727475AbeJYWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5coQN84oyFhjfHOpy+gklr72Wrk56tSMszFHjQ4oM=;
 b=pztfraTzx5u5ApnsU/ZnAoP5hAlt0KbKP6dkGHyCkdlMayZbORt50jgsatV+V7ipXdT8/doVs47ohZaLtOV8dRpgtGDNJ9uhJwFaRaX2L8TEYd5S8+5c2vZid+KY7v2OUR6ixWcpF4DrXdxIi9HcJe8I8QDzVZySP9I/TL5nuag=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2814.eurprd04.prod.outlook.com (10.172.255.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Thu, 25 Oct 2018 14:05:32 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%5]) with mapi id 15.20.1250.032; Thu, 25 Oct 2018
 14:05:32 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roy Pledge <roy.pledge@nxp.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi - simplify CGR allocation, freeing
Thread-Topic: [PATCH] crypto: caam/qi - simplify CGR allocation, freeing
Thread-Index: AQHUXveO6/v0K5+wP0WgERS6BivyOw==
Date:   Thu, 25 Oct 2018 14:05:32 +0000
Message-ID: <VI1PR0402MB3485A342A184BEBB004E74F998F70@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20181005125443.dfhd2asqktm22ney@linutronix.de>
 <20181008110937.29198-1-horia.geanta@nxp.com>
 <20181009171101.jk6lgdx4g5rnq7cm@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2814;6:+BTvHva1bWot5/I8rh0PU3dvp20utD0JEwthvZEfqqFw1hrqgpVOKmJUnVKK7CVWB4namBwQA7jG8cwgYiDQjqBQlxgozyNKVVaJz7sQ8SzCXjouB09m8t75+nCOTlb0atiBu57GI6RNt5K6xqVhulwIw3EOctVNV3acK7n13QM5kGl+M0jPH+XXJWcftFAvXCXlpz5KkMMAU6jffv9fTviDSf03FHfAKIjxLHoaNQTa4nkdoMzRQBgzeEKGX6+5MqaIb5fu+U+bjjm5hmRuhFVI5GeRDjt71Ud6AAoSjB0x/11aTvxDUGDAjguouesZq6rYSvl7k8gk/dcfh4PXhnZBk9M8OfTqZm8SOyv2CponY4v/eqZ53jCp98yuj7GPuMJUk2GnkaQWjMwW+kH+rBS2JEtvdbBM84pIpZNMSdAtUcfGW1LdkEvKU4lQ16Y1mm9keKAn9PcP99IbyiEXWQ==;5:jlFlqK2oGBkyQuBqK7s+SjR7F7K3tVFe3E7fm2SR4vyDpelhpY8kSzhsfJxrmBkDVFWpqWWZxpoB9qY6bIHdFXyVExmuZ1/SoJoRNOpvcz9Ny6xcwXYudIby91GUGJCWo2S3P3Dwsz57Pg6gHBPzof+CdqRoEQGygfIP/pNwqgQ=;7:+mdv5MRRtlcqOxxu61T5f0lhVfjCCNovnPkg180pxMNDobY/hndUkrrnlFKzdL22Y7tG1ilH/LJvCwOyRF5xy6ejfso83AILQ4foU5f1RyDCR/kDJzIqCoxr0CxdEmWN4BwJS0rA7wj/u2WmvwaJiQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 66181e26-b5a3-440a-a5c1-08d63a82ed76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2814;
x-ms-traffictypediagnostic: VI1PR0402MB2814:
x-microsoft-antispam-prvs: <VI1PR0402MB2814E1E2BA848E3692C3D1CD98F70@VI1PR0402MB2814.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2814;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2814;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(3846002)(6116002)(55016002)(2900100001)(256004)(14444005)(9686003)(106356001)(6436002)(186003)(486006)(71200400001)(5250100002)(66066001)(105586002)(476003)(71190400001)(44832011)(229853002)(446003)(26005)(6306002)(33656002)(53936002)(99286004)(5660300001)(25786009)(110136005)(54906003)(102836004)(97736004)(478600001)(53546011)(6506007)(316002)(81166006)(81156014)(76176011)(7696005)(4326008)(8676002)(6246003)(68736007)(86362001)(6636002)(966005)(305945005)(7736002)(74316002)(14454004)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2814;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W+eFhxbzCli3afDjd8j0wlOZtclzZu+5e9x6NfmG4azjIwVyAAPhGdp9troL9ON5VkK1tzsP99sUs/PDLTGINUkxl+3K2pzhI4wF0sNmUTdelmaOcsw6U9oqwN9BDTSsEbmXC/GgpeOzh0BYNGxfb5dZYoNxrOWdBrkAYTV8fcJZHAiLTNlfgk03g18/Rz1RtyKaEfMwkbUclh7n4Qg6BzMfr+/k9txMGf1hdSwnPlRIKgkPIahqw2v/Uyqc0shqPuvbfe/nq9u3BQT2L483UE4dvZrE3u3Fz89mDo3idJF+M8e5C4AgNswuv0eQvLaizGybUPbz02RX4bX6swI9M9N6vglqdhyv6m0lbqg/KFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66181e26-b5a3-440a-a5c1-08d63a82ed76
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 14:05:32.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/2018 8:11 PM, Sebastian Andrzej Siewior wrote:=0A=
> On 2018-10-08 14:09:37 [+0300], Horia Geant=E3 wrote:=0A=
>> CGRs (Congestion Groups) have to be freed by the same CPU that=0A=
>> initialized them.=0A=
>> This is why currently the driver takes special measures; however, using=
=0A=
>> set_cpus_allowed_ptr() is incorrect - as reported by Sebastian.=0A=
>>=0A=
>> Instead of the generic solution of replacing set_cpus_allowed_ptr() with=
=0A=
>> work_on_cpu_safe(), we use the qman_delete_cgr_safe() QBMan API instead=
=0A=
>> of qman_delete_cgr() - which internally takes care of proper CGR=0A=
>> deletion.=0A=
>>=0A=
>> Link: https://lkml.kernel.org/r/20181005125443.dfhd2asqktm22ney@linutron=
ix.de=0A=
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
>> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> =0A=
> Oh. No more usage of set_cpus_allowed_ptr(). Wonderful. Thank you.=0A=
>  Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
> for that.=0A=
> =0A=
> Now that you shifted my attention to qman_delete_cgr_safe().=0A=
> Could you please use work_on_cpu_safe() here instead=0A=
> smp_call_function_single() with preempt_disable() around it?=0A=
> =0A=
> Now, what is the problem with the CPU limitation? Is this a HW=0A=
> limitation that you can access the registers from a certain CPU?=0A=
> =0A=
Roy confirmed the CPU limitation should actually be removed, there is nothi=
ng in=0A=
HW requiring it.=0A=
A clean-up patch will follow.=0A=
=0A=
Thanks,=0A=
Horia=0A=
