Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Jbde2/Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682E820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJHVDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:03:48 -0400
Received: from mail-co1nam03on0095.outbound.protection.outlook.com ([104.47.40.95]:18700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHVDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1nonu8DDPyQ07NIYhK+AY1EoJxgiLaQoiPiUcPPIQw=;
 b=Jbde2/GeZIVIlWHK9z2QicwsNofX8Ec4/UWje2tLmCfyTJPGVMc4bPf52oO+YBnMQiW1uTe2hKfaTAZDwZ9WYDBokDp6Fr6ea9WQIpiPAX3WwrM3nxK2EiCgbfpojQhOYO9VnyjuPTL0Od3fmA/bU8ImM7sDIrd/BTNBmsMOvCo=
Received: from MWHPR1301CA0009.namprd13.prod.outlook.com
 (2603:10b6:301:29::22) by CY4PR13MB1415.namprd13.prod.outlook.com
 (2603:10b6:903:137::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.19; Mon, 8 Oct
 2018 13:51:16 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR1301CA0009.outlook.office365.com
 (2603:10b6:301:29::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.8 via Frontend
 Transport; Mon, 8 Oct 2018 13:51:16 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1228.17 via Frontend Transport; Mon, 8 Oct 2018 13:51:15 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98DpED0009633;
        Mon, 8 Oct 2018 13:51:14 GMT
Received: from USCULXHUB05V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.43])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98DpEkn028388;
        Mon, 8 Oct 2018 13:51:14 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0408.000; Mon,
 8 Oct 2018 09:51:13 -0400
From:   <Tim.Bird@sony.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Topic: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Index: AQHUXbzsST+hQw7zT0eB3iy5jbswn6USvpZwgACmBYCAAfY7MA==
Date:   Mon, 8 Oct 2018 13:51:12 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1538861851.4088.7.camel@HansenPartnership.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
 <1538883209.4088.14.camel@HansenPartnership.com>
In-Reply-To: <1538883209.4088.14.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(448002)(189003)(199004)(13464003)(76176011)(26005)(6246003)(186003)(2906002)(4326008)(336012)(7696005)(55846006)(486006)(316002)(11346002)(106466001)(66066001)(50466002)(93886005)(229853002)(126002)(47776003)(426003)(446003)(436003)(2486003)(23676004)(476003)(8936002)(86362001)(478600001)(110136005)(6116002)(3846002)(72206003)(246002)(356003)(85326001)(102836004)(33656002)(7736002)(305945005)(55016002)(86152003)(2900100001)(5660300001)(2876002)(2920100001)(14444005)(8676002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1415;H:usculsndmail01v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT040;1:5VVdbBjCTsmQdJsH1hn/Zij7v1/UeHg/Sb1EZwFmZaM6iyrLNBF+r6W24ZKOWRfaDf7bVqf6I8d/E1L+GHNj0H0cucmQaHPlWOZZ8CG6ND94uP47GH0xJIovsd3swdx2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7881e20-50aa-4aec-19c4-08d62d251dd2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR13MB1415;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1415;3:VmCc3bnRdOq3GIpMQY0KFbR9wE+3QTDfX1FuhOsIqk8wtNQi0ys2Cbl1EavMoVPaeZJ/n+/bPc+CmdGr9aupEJRWx1emAnWYaDb1OZptNdf6tn1qMWyhy7X44Bj3JlFd0DihzXNyjowxmkR9Gh851T1z9JGXYsxyyMQQujiay7HeyMpcf5RkL2S8f400kZl9AJpPl3Ah2G5TTLhG8akt/v0cUPdi/rkvX2hVxq7cWcieWPzEMAV5y0m4oQf69U5JkukqO+ZF4+OpxHRZ20aRsyVC7qXg0/T2aaXoFhpZqguXGtRoaoP1v2Nix7o2OJaVHa6+6l2xrYZ7tm/pFChHPAHu7CklNwzkDnC6Wl/SjV4=;25:xs5Alu4pAzsFY8ENp5VT3YAeUuUg1kXkx+0RiSqo3nKpsTP1tin9WkRciE1MCwu4P2pwIS9NbF7IRC2KvZeKlp1e/VpoUWjT8z4hCo111v6G+twVeRlp1FIeZbtjTl0emt06+M09Eeu7oGg+0tHKi/BUoRFiBa1dF7+JAAmDVch2/FEWCwktxfe5pBvWnG3uguCL1ppOaSDtGTwp4ul7HHBlpzFoAoNZlB3finbELTqdZnlDbm0ibboHs+/GdMBDdcOxMQOwnMyHSt/pm+h3QZNwUSAacM+lfHghobFIuPf0gEHB83IzcEq79UR2YpdI7ORc9kq02fqjgfEo+icICw==
X-MS-TrafficTypeDiagnostic: CY4PR13MB1415:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1415;31:K+liniRoRO2UuuwFXiTEXxha7Pg41nC3jZGjj8LyOMctpEK5VCKH2zztgVGqP/9RDu9zZ/0ic+q9xzFiDKLG2HDAOrq0muczSScovqnqjh++wUk6QI6i1xrgYvHI5zj96rSUsdrrSIDRt1UcOw1ct0yqaLSMSqj0C8fNwk59u8afuBnWXY2QIUXsuwC99gCyqr7wb84WKBmPC1IaC977QMYKCcU9aw1x6z1o6/blhp0=;20:kWm1MWShSGMY9+JATRUHodfT40GOBf2AJEw003pc324UidXeMm4LWLz5vjgYq2U6MJgwqqLbwd3AT4cBbUW+DJSr/mX4m2t/Yvwp6DkBiFlLlzajBhyZy8c6dNcrzk3SGha9Z2czfth+uv01kHJyGDPJGkPPFntnnvZzxcawMOpWBUDzl90+BxM8WROJyxcErbMIVWJANL5EmkdjUAjWWVIYFUnQ4fXLaAYMi4+1gLcH1ZY6h0opIqxn+t1cqnBMuyF5sxpbGPCmI895jg9j9OFD0cnQnSglz7JBXCgLTywnvY/c2/GVgGzxEST5hlV1NOUuQL7XFbX1KkTSEAhiZwI/Wr8vBCF3VhNue9ShL/NgWKmtQSeyGOFDHgkXC3E+i7JSXldsLumsFrEZfu0iARF3w5JnQ/4LBPOZa0MkewqyG1A4SWuEA9S87FXA3NPwcvFvP+rz51y5k2zL8qv8ID0TJ3kdEkdeChQbESwTQn1Bq4TvJ/lsT+Enpr14756W
X-Microsoft-Antispam-PRVS: <CY4PR13MB1415FDFF1787A96B4AB44385FDE60@CY4PR13MB1415.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656)(209352067349851)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:CY4PR13MB1415;BCL:0;PCL:0;RULEID:;SRVR:CY4PR13MB1415;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1415;4:Tqc/zH5wReNUrIs+9/sTPId8v1jJjjbpRhQ3pHEM9T2aynDwzwbVUHFZrklfRwodjyQXELNuphQpT59LKoZpaOje4DEmXXGtQ9pXtuLNyXZHCh9et2gEVQQtfuZUmBUMgIfVdgwqusDohNKqt1PX0xP8w00049Ow8ZN0uEhODyu4MOP5sUBUSghXt7EMrth9Cw8KlZ0c6N0Y16ELuQ3FzABUyw4d8REBouumP1WhAkd7NaPbZmz8bgFEhwxyZgw/xTxnV5FWaYQyhggowbdlxHBG32xot5KTCFMq5SiUGhvNFsZ3/wwMTT5mmYbWCTRKqFzGn8O/Ku+ntjKUuSzUe/8s3duHvkbGBIwAfRoOFE5vJ04si2SL3uPQ4z9sbyz6
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEzTUIxNDE1OzIzOmEyRUdSUlJoR0ZHTDcxV1RtUXVDOEoyR29a?=
 =?utf-8?B?anB0dXhvZS9VQ29iN05GYnFFZzZ3cHljTFl4WERnd2M3Y0NkMm5sMVo5am03?=
 =?utf-8?B?MFRxMUtuSTRYbTFJeWVGMlNyZ1piR3IrdnNadDZpMXFXTDhaTmtNa1NLSDJV?=
 =?utf-8?B?RTlOV0s3NWRMTE5MTW0wVGtpRHBuR3NxcW9YWEpZVDNEL09PZGtjVWlOS3E2?=
 =?utf-8?B?OUNvN3RWc3Q3ZkJQSnZyMmNpRzhteTFqOGMxRmpFT0xFSFBSbFluQS9iZzNY?=
 =?utf-8?B?M3lnUVcrS0Mycjk2VEx2NUVib3VQYXhaVG9NUytUTlFtSnh1N2RrbFdGbmJG?=
 =?utf-8?B?dWRCeEx1YnVoRThhMTBtQjREOWdMUm1oQXFtNkxBdzNvVW52OW5JWlhscDlx?=
 =?utf-8?B?ZW02RVNWWTZIVytRMFl3VXFGSFZFMEFoOERwOGVPblVvSVk1Y0x1SE5VeXZW?=
 =?utf-8?B?ZmtjOUt0UGM5K0V1Nm9iZHNaRTdKSVEwUyt4L0JiSFQ0a2NEaFgwNWRJcVJS?=
 =?utf-8?B?cSsvV3FkRlNGYzJIdnFDSW80TVBqdTZvSExBQ3IybCtMdTNIb21yRm1LY08w?=
 =?utf-8?B?akZtUCtWQUJnL1lOVkZmVE5YSURtZ3VsYklyT1ZucDJoaVRFaUNIVnI4cFNR?=
 =?utf-8?B?c09NV1gxcEFrRzJHN2ZWbmNrN3g4ZzkwWkthcExHRk1qdUdQOWNlM0hTVlZX?=
 =?utf-8?B?azE2VFMzYjJKWkk3dC9aQ25oZlV3WXA0aHhyUldKdVdkQ1pDK2JtNm9KYXVq?=
 =?utf-8?B?S0gvVUpDSEozdE1CZ2xrM3gySjZ2a2UwcE40OXh4TWNQcFV1OXpXd1NsaWhu?=
 =?utf-8?B?a3Y3Q1c1S2twNWxNQ1ZuUE5rM0FYZEVMcE9XTlh6dktxVUUrOEMvaE10bGZW?=
 =?utf-8?B?VFJkNlNZNzErK1c4bE9iekRYMGo3cG8xZ0MyZitWVlo0T1psOXRpOEJRRzZq?=
 =?utf-8?B?NkVDR1pIYllBZEpOQjBPbGpEQysxa2NqNFpHTm9LWjl1UnpYVFBUcGxGYlBQ?=
 =?utf-8?B?dHdRMGg5Mmh0dEdOcFBqMnJCTGpyUGpzVjRTYXNZd0JUbnpoUGxhZjU5VkMv?=
 =?utf-8?B?SEROczdzbEhhSmdwY2EwV0t3bUFta2hFdUZtVTdYUHQ4S1AvSW96Q0NGa0k0?=
 =?utf-8?B?Y2tlaFNzMHRFd0NhYmhmMXc1WUpIUG9QNXFaKzBXdU5QNjVMcUdDZ1lrWmtT?=
 =?utf-8?B?TGFlb3dqblJpOW01Qm1ad2s4NjRjc3NZa3ExWEI3UERLRjVvT1BYdWtsZTlB?=
 =?utf-8?B?by9Bam96YXBkTlB2S3hUVHJRWVVWWFZLTHd5Kzc0VHFDZEIvQlYzL1lpbUlK?=
 =?utf-8?B?ZmFNajlXN0c0d2tUbjBpMTZGWlgyTUFXZE1TaGJiY2dNc0RabERGSzl3ZXpp?=
 =?utf-8?B?b2pNRzl0bnhBZk9oVHQ2R3NERitoM09qSkI3ZWRkaW1uVXNpd1BQS2dpa2tM?=
 =?utf-8?B?YWxHOUR4aWIxdFlWdS9NWWgzQlgrb2dHN0xhakVjQWsrdHIyTXltdTNDTk43?=
 =?utf-8?B?TTlQYVlnSzN4N3JCTERrVjdFb3VTMGlQd3VvMUJ4M0pocGJtbjZhcGlnaUJT?=
 =?utf-8?B?YnBSRnRjSEFoMkFEWUJkZWlnQVp3YU9sbHVPek9oM2FWdTYvNG4wVTZkeDEz?=
 =?utf-8?B?R3o5OFZkQzJaQmFIUXdnN29ha1Buc0IwZy96a2pCNHF0d0J2SlFla0piL0Yx?=
 =?utf-8?Q?Gimp+oFUZ2UHtAcFuZSMH6HZeBM2cd/QIUVop6E?=
X-Microsoft-Antispam-Message-Info: 6hghQ7N1XAMEHMYTEktPdqCNrXDs+9fkzJ1gjxgQLBFMPapvIX/OgI0fHAqSGsAd1XPKH/NDmANFUSmI91sPd5vxCjWT/LRU2CU4OTF0I4M4Jlvl83NZ2Kw8/wiURoybYJAoKxwhBMBpsHYZbdyWYP35sRzVacRF9hemZqieMUQGcZ/Eo+RNg/EW2U7fFRP67lk7WtO8xp1izLVSp2rWUP19pFJvOVMYVseRAeoSWQheVYbTvnZSDJd2mUcgddkID+nk2B9lQuqLNKwHoYqEfbZHxQlGASIhtHvv+EgXBtGyCI7JOZ5qX/W3ttZokRg81NN43wdpkJNhgwBPQiZpuwAedkLc+FAtHKt8A2lEjfo=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1415;6:KJP2czffseIKbulnUrMlHbfx0E1s7n2hLcDM9znPXszpe4NNTfvsN8xN962Oc9frvOzHORWaym86Icda5/L3J0vg+UNw2HxBf+KI3eNblb28Ofq25ZGg5yPECosLjewm3C2Tg6/R6KJq6cs0sfX50w7bxLlOAy4RBQ3JvkMK5Jn4b0JCYxr1DZPendLrt6l83zmL9luwsR+bi1QoA+HaGILM70ZF7UU4bXX9kSTPprSvPOkxMHWc8pXq6kwUPsp1wzGVUqhh8ByCiB+jC+JoTjbKJTCJMBx3s90twS9kYIOo5I/cGdORvZrB2nFV2mmV7WLN4o6ImYM1FgD7+RcTZrh8aJiVxrB+7QgpYtGwvLfHSb2M9FA6xmcoSjmufmRm4GT3kwwOC9yoQM7yX9HtcuIdVJTfm58AHsZfxGm4tphXdO8D9gDFPL7b1gqDCJ09ef1HUxvMdR4Jh9pymBAknA==;5:7lEfxSiHoRUAQovaaRz9mPkYxBThWj+0EOkdfB+8mKPZyz+3VE4mjS9birTdIfbeqs8gDFWxbxTA1069osND3bOlKnHkDnS/jCIbhuq8ZlsvZ4a9HHhzcpZe48DvKIjTdhP4xYhTUmpaOSNA3Hti2LXODLu5SsdhJwcDM9PnSDc=;7:vR8x4JreYV9nUC//FaXdPASWaMo6Yxuaqzu+xF3bRPLZ3aTh/+WGxIZ4zP8o9L1iT3FO1wrOHek79XfcQLGne2LUIS/yViaLBTIKmiiA6z/QRC5GNe/5GDkh6OyPUmK5haBjxZSzKrHl8fF8hqchpRzsosGqbBB1Jv+h2Fe+Gwncf21RC2ubp61oH9+Vfvd/T4x6jYXHlnXOnOC5PPfcHs0KHfncaW27ywvyBgavPK/CA3AAt+6+eTW3SixZZ9Qn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 13:51:15.3570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7881e20-50aa-4aec-19c4-08d62d251dd2
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5
IA0KPiBPbiBTYXQsIDIwMTgtMTAtMDYgYXQgMjE6NDMgKzAwMDAsIFRpbS5CaXJkQHNvbnkuY29t
IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEph
bWVzIEJvdHRvbWxleQ0KPiA+ID4NCj4gPiA+IFNpZ25pZmljYW50IGNvbmNlcm4gaGFzIGJlZW4g
ZXhwcmVzc2VkIGFib3V0IHRoZSByZXNwb25zaWJpbGl0aWVzDQo+ID4gPiBvdXRsaW5lZCBpbiB0
aGUgZW5mb3JjZW1lbnQgY2xhdXNlIG9mIHRoZSBuZXcgY29kZSBvZg0KPiA+ID4gY29uZHVjdC7C
oMKgU2luY2UgdGhlcmUgaXMgY29uY2VybiB0aGF0IHRoaXMgYmVjb21lcyBiaW5kaW5nIG9uIHRo
ZQ0KPiA+ID4gcmVsZWFzZSBvZiB0aGUgNC4xOSBrZXJuZWwsIHN0cmlwIHRoZSBlbmZvcmNlbWVu
dCBjbGF1c2VzIHRvIGdpdmUNCj4gPiA+IHRoZSBjb21tdW5pdHkgdGltZSB0byBjb25zaWRlciBh
bmQgZGViYXRlIGhvdyB0aGlzIHNob3VsZCBiZQ0KPiA+ID4gaGFuZGxlZC4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBCb3R0b21sZXkNCj4gPiA+IDxKYW1lcy5Cb3R0b21sZXlA
SGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoERvY3VtZW50YXRpb24v
cHJvY2Vzcy9jb2RlLW9mLWNvbmR1Y3QucnN0IHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxNSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gPiA+IGIvRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gPiA+IGluZGV4IGFhNDBl
MzRlNzc4NS4uNGRkOTA5ODczMDViIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9w
cm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vcHJv
Y2Vzcy9jb2RlLW9mLWNvbmR1Y3QucnN0DQo+ID4gPiBAQCAtNTksMjEgKzU5LDYgQEAgYWRkcmVz
cywgcG9zdGluZyB2aWEgYW4gb2ZmaWNpYWwgc29jaWFsIG1lZGlhDQo+ID4gPiBhY2NvdW50LCBv
cg0KPiA+ID4gYWN0aW5nIGFzIGFuIGFwcG9pbnRlZA0KPiA+ID4gwqByZXByZXNlbnRhdGl2ZSBh
dCBhbiBvbmxpbmUgb3Igb2ZmbGluZSBldmVudC4gUmVwcmVzZW50YXRpb24gb2YgYQ0KPiA+ID4g
cHJvamVjdCBtYXkNCj4gPiA+IGJlDQo+ID4gPiDCoGZ1cnRoZXIgZGVmaW5lZCBhbmQgY2xhcmlm
aWVkIGJ5IHByb2plY3QgbWFpbnRhaW5lcnMuDQo+ID4gPg0KPiA+ID4gLUVuZm9yY2VtZW50DQo+
ID4gPiAtPT09PT09PT09PT0NCj4gPiA+IC0NCj4gPiA+IC1JbnN0YW5jZXMgb2YgYWJ1c2l2ZSwg
aGFyYXNzaW5nLCBvciBvdGhlcndpc2UgdW5hY2NlcHRhYmxlDQo+ID4gPiBiZWhhdmlvciBtYXkg
YmUNCj4gPiA+IC1yZXBvcnRlZCBieSBjb250YWN0aW5nIHRoZSBUZWNobmljYWwgQWR2aXNvcnkg
Qm9hcmQgKFRBQikgYXQNCj4gPiA+IC08dGFiQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPi4g
QWxsIGNvbXBsYWludHMgd2lsbCBiZSByZXZpZXdlZA0KPiA+ID4gYW5kDQo+ID4gPiAtaW52ZXN0
aWdhdGVkIGFuZCB3aWxsIHJlc3VsdCBpbiBhIHJlc3BvbnNlIHRoYXQgaXMgZGVlbWVkDQo+ID4g
PiBuZWNlc3NhcnkgYW5kDQo+ID4gPiAtYXBwcm9wcmlhdGUgdG8gdGhlIGNpcmN1bXN0YW5jZXMu
IFRoZSBUQUIgaXMgb2JsaWdhdGVkIHRvIG1haW50YWluDQo+ID4gPiAtY29uZmlkZW50aWFsaXR5
IHdpdGggcmVnYXJkIHRvIHRoZSByZXBvcnRlciBvZiBhbg0KPiA+ID4gaW5jaWRlbnQuwqDCoEZ1
cnRoZXIgZGV0YWlscyBvZg0KPiA+ID4gLXNwZWNpZmljIGVuZm9yY2VtZW50IHBvbGljaWVzIG1h
eSBiZSBwb3N0ZWQgc2VwYXJhdGVseS4NCj4gPg0KPiA+IEkgdGhpbmsgaXQncyBPSyB0byBsZWF2
ZSB0aGUgYWJvdmUgc2VjdGlvbiwgYXMgaXQgZG9lc24ndCBzcGVhayB0bw0KPiA+IGVuZm9yY2Vt
ZW50LCBidXQgcmF0aGVyIGlzIGp1c3QgYSBzZXQgb2YgcmVwb3J0aW5nIGluc3RydWN0aW9ucywN
Cj4gPiB3aXRoIGFuIGFzc3VyYW5jZSBvZiBjb25maWRlbnRpYWxpdHkuwqDCoFRoaXMgc2VlbXMg
dG8gbWUgbm90IHRvIGJlDQo+ID4gdGhlIG9iamVjdGlvbmFibGUgcGFydCBvZiB0aGlzIHNlY3Rp
b24uDQo+ID4gKElPVywgSSB3b3VsZCBvbWl0IHRoaXMgcmVtb3ZhbCBmcm9tIHRoZSBwYXRjaCku
DQo+IA0KPiBTbyBJIGRpZCB0aGluayBhYm91dCB0aGF0LCBidXQgaXQgc3RydWNrIG1lIHRoYXQg
d2l0aCBib3RoIHBhcmFncmFwaHMNCj4gcmVtb3ZlZCwgdGhlIGN1cnJlbnQgQ29DIGlzIHZlcnkg
c2ltaWxhciB0byB0aGUgc3RhdHVzIHF1bzogbmFtZWx5DQo+IGV2ZXJ5IHN1YnN5c3RlbSBoYW5k
bGVzIHRoZWlyIG93biBpc3N1ZXMgYW5kIHRoYXQncyBmb3JtYWxpc2VkIGJ5IHRoZQ0KPiAiT3Vy
IFJlc3BvbnNpYmlsaXRpZXMiIHNlY3Rpb24uICBUaGF0IGFsc28gbWFrZXMgbWUgdGhpbmsgdGhh
dCB3aGV0aGVyDQo+IHdlIHdhbnQgYSBjZW50cmFsaXNlZCBjaGFubmVsIG9mIHJlcG9ydGluZyBv
ciBlbmZvcmNlbWVudCBhbmQgd2hhdCBpdA0KPiBzaG91bGQgYmUgYWxzbyBvdWdodCB0byBiZSBw
YXJ0IG9mIHRoZSBkZWJhdGUuICBUaGUgVEFCIHdhcyBjcmVhdGVkIHRvDQo+IGNoYW5uZWwgY29t
bXVuaXR5IHRlY2huaWNhbCBpbnB1dCBpbnRvIHRoZSBMaW51eCBGb3VuZGF0aW9uLiAgVGhhdCdz
DQo+IG5vdCB0byBzYXkgaXQgY2FuJ3QgcHJvdmlkZSB0aGUgcmVwb3J0aW5nIGFuZCBhcmJpdHJh
dGlvbiBzdHJ1Y3R1cmUsDQo+IGJ1dCBpZiB3ZSdyZSBnb2luZyB0byBkbyBpdCByaWdodCB3ZSBz
aG91bGQgZGViYXRlIHRoZSBleHBhbnNpb24gb2YgaXRzDQo+IGR1dGllcyAoYW5kIHBvd2Vycyku
DQoNCldoZW4gdGhlIENvZGUgb2YgQ29uZmxpY3Qgd2FzIGFkb3B0ZWQgMyB5ZWFycyBhZ28sIHdl
IGFscmVhZHkgY3JlYXRlZA0KdGhlIGNlbnRyYWwgcmVwb3J0aW5nIG1lY2hhbmlzbSwgc28gSSBh
Y3R1YWxseSB0aGluayBsZWF2aW5nIChpZSBpbmNsdWRpbmcpIHRoZSBhYm92ZQ0KcGFyYWdyYXBo
IGlzIGNsb3NlciB0byB0aGUgc3RhdHVzIHF1by4gIEkgdGhpbmsgaXQncyB0aGUgZXhwYW5kZWQg
cG93ZXJzIGFuZA0KZHV0aWVzIChvciBwZXJjZXB0aW9uIHRoZXJlb2YpIHRoYXQgYXJlIGNhdXNp
bmcgY29uY2VybiBhbmQgSSB0aGluayBkZWJhdGluZw0KdGhvc2UgdG8gY2xhcmlmeSBpbnRlbnQs
IGFuZCBhZG9wdGluZyBjaGFuZ2VzIGFzIG5lZWRlZCAgdG8gYW1lbGlvcmF0ZSBjb25jZXJucw0K
aXMgd29ydGh3aGlsZS4NCg0KSSBiZWxpZXZlIHRoYXQgaW4gdGhlIHZhc3QgbWFqb3JpdHkgb2Yg
Y2FzZXMsIHRoZSBUQUIgd2lsbCBlbmQgdXANCnBlcmZvcm1pbmcgYSBtZWRpYXRvciByb2xlIHRv
IHNtb290aCBodXJ0IGZlZWxpbmdzIGFuZCByZW1pbmQgYW5kIGVuY291cmFnZQ0KaW1wcm92ZWQg
Y29tbXVuaWNhdGlvbiAtIHZlcnkgc2ltaWxhciB0byB3aGF0IHdlJ3ZlIGRvbmUgaW4gdGhlIHBh
c3QuICBJIHJlYWxseQ0KYmVsaWV2ZSB0aGF0IGJhbnMgd2lsbCBjb250aW51ZSB0byBiZSB2ZXJ5
IGZldyBhbmQgZmFyIGJldHdlZW4sIGFzIHRoZXkgaGF2ZQ0KYmVlbiBoaXN0b3JpY2FsbHkgKEkg
Y2FuIG9ubHkgdGhpbmsgb2YgMyBpbiB0aGUgcGFzdCBkZWNhZGUuKQ0KIC0tIFRpbQ0KDQo=
