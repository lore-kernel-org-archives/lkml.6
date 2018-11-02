Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E6C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86472081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EqlKrEsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86472081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeKCCpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:45:42 -0400
Received: from mail-eopbgr710111.outbound.protection.outlook.com ([40.107.71.111]:6115
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeKCCpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDYsm0jC3SgvY1q+gRqkzA8nonB4fNpPk41OOPaz/Gs=;
 b=EqlKrEsdk6XhWzpEMZjW9I5FAVGvXqh88WZeETpQmM5pPBl48jiLoHBHqxvxIYuvDRXOqXdcxVvNIlvqojMixeykjdEBx2UdBgx0okpoE2nBj8muRXrnv0Vk/Vj7L/8GL0vNziY5s+oE5QHWXq0hGfbP502oBnIrKG2A3Cr6tt8=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.5; Fri, 2 Nov 2018 17:37:44 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::8168:9429:a646:f916%20]) with mapi id 15.20.1294.014; Fri, 2 Nov 2018
 17:37:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] genirq/affinity: Spread IRQs to all available NUMA nodes
Thread-Topic: [PATCH] genirq/affinity: Spread IRQs to all available NUMA nodes
Thread-Index: AQHUcj4SU8usCMPo6UiL6oTCebWfC6U8vJQA
Date:   Fri, 2 Nov 2018 17:37:43 +0000
Message-ID: <CY4PR21MB077387C5E70FD9D96D00FE62D7CF0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181101235157.27607-1-longli@linuxonhyperv.com>
In-Reply-To: <20181101235157.27607-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-02T17:37:42.1735689Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:F4S2XjQaTWkM7uMtohtggdygYKFOmTRFBEu7XuGuv4bS6pmRzK/WRiJCOFux3lbLVPsSAh1IfXofFhL8gDFl28nt9TsKQGQRPN9+P/9m8X5EtB3NXB/AmaJMJp6FZMvjUjMBTTqRu7PsHAKukTx0L4jRUL1i0GSlZHKEU6Yrx3b3q8sab2xmFiA3aWW56emQ64LY+enY9Ja99xxLs2nKNIlwZB+j6DT5hyUyg2FiLtBSub7Aby53g8g7LiYWpOGu2ufBU26Ev3eAjdU9LGfN5Nzl3d9zX7GOuL60A14cz0L3Fx/tDpBAb4AhbX1b0oKrkVwiVy8tXdW6qcdDAL0xv6SGYdGgVfXlrWeT0Y7rC4XcnVQGDtAiu7AoK1c0itO+/1ukt9xXjriuH1cSedOcqOIMW4v/W+Zptnr2sUNk15t5Gv3sqW87clWw/g/OLQEvJdLyJFzK0cjb8C3bmQYIfg==;5:mVQOaTJeB+lIkZSqcNUoiI/Ir2otwrJwQRyFESn+2Z9Kf4OPu+HcrscRUVnKl4di/QSIWYOwZJsQe4mmD0znfqrJfKDH9Cj6Vj9l7qtZbo3DFxvSWK68pEqkZG6B3CrhMsKD8b7HQYbRpEz16g6dRCYzdKHGmLsXXIgzLSlmYmc=;7:YNIz/vkrJwU/cEUjt7BgzVph68OOGjMlOrg3HjMPa7MDaMfSbp0NF+jZghbsLtFI4WYDvjEMJHBH6Mwx4sNr9oDnLraMf10NExqdj+9ZzSuttcS/8EV9DV67HdWMAriSP7qxOV6tVdjeUIAMzJkZMQ==
x-ms-office365-filtering-correlation-id: 7784abe0-93e8-4c53-d7d5-08d640e9e572
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06959F0F8614FEC65C3C9EDCD7CF0@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(7736002)(316002)(86612001)(6246003)(86362001)(6506007)(3846002)(6116002)(14454004)(74316002)(102836004)(2900100001)(6436002)(7696005)(76176011)(99286004)(97736004)(55016002)(2906002)(508600001)(10090500001)(10290500003)(5660300001)(110136005)(9686003)(256004)(22452003)(68736007)(66066001)(25786009)(105586002)(106356001)(33656002)(486006)(476003)(1511001)(186003)(71200400001)(71190400001)(26005)(305945005)(53936002)(81166006)(8990500004)(81156014)(2501003)(229853002)(8936002)(446003)(8676002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zfnXXJNEpBKmyQ4nFWoFgKYTgqVwp23KRUkImq5QS1PzKCngq5g/MZfaRLD5tybU49j51DXIUwYKrs23SyOuv5dzxkWcujaSw6SA5qdntO11bQuu8nSH0E+2Fla/UvYdZiND2Agynw+LUs7MArzFIfDAJ+n3W7UbtXTrSgczaxNOZhTk9ZD4THamJogaZBIVl2Pq930P7eGxvq1UjjcxVbSDtIg9hO1RzxtA6iw3maRb4j+kfBf30H+uFb6V1fDQYpEMNpzvpA8RfEOUxRQkog70gfBDkLN5v8TvPmcbU5vm4885b9rXUQlFtHlCdkvtfnFTgCQPFVQ1ETN88IbxrAsyzAobIf4IW3F2NCPfzNY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784abe0-93e8-4c53-d7d5-08d640e9e572
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 17:37:43.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>  Sent: Thursday, November 1, 2018 4:52=
 PM
>=20
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -117,12 +117,13 @@ static int irq_build_affinity_masks(const struct ir=
q_affinity *affd,
>  	 */
>  	if (numvecs <=3D nodes) {
>  		for_each_node_mask(n, nodemsk) {
> -			cpumask_copy(masks + curvec, node_to_cpumask[n]);
> -			if (++done =3D=3D numvecs)
> -				break;
> +			cpumask_or(masks + curvec, masks + curvec, node_to_cpumask[n]);
> +			done++;
>  			if (++curvec =3D=3D last_affv)
>  				curvec =3D affd->pre_vectors;
>  		}

When the above for loop is exited, 'done' will always be equal to 'nodes' s=
ince
there are no early exits from the loop.  Hence there's no need to be
incrementing 'done' in the loop.=20

> +		if (done > numvecs)
> +			done =3D numvecs;

And if 'done' would always be equal to 'nodes', there is no need for the te=
st.
Just always set 'done' to 'numvecs'.

>  		goto out;
>  	}
>=20
> --
> 2.14.1
