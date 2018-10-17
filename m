Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78437ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155B220869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Aka8DPRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155B220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJRBtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:49:19 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:24928
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeJRBtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkDEfvGvsdqCZf6CDZu+8+GtXoHQUqEVFBK4jqRwg6E=;
 b=Aka8DPRQtn+cZ1edhckXIQnBRYLXQ664vamTrsIrS4BapUuCsp9eP5AYYvYUV/QSX4FOpvcet6qMaAjZiFqZXaPfTPaYu2LLm7JI00ucLIHJ0Y0YzHL1YxNpVfspRpbFCiL0aUGuxU0qsrquJUJZFQUc+q0d7wW8o+G0BQienJU=
Received: from CY4PR13CA0087.namprd13.prod.outlook.com (2603:10b6:903:152::25)
 by DM5PR13MB1417.namprd13.prod.outlook.com (2603:10b6:3:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.12; Wed, 17 Oct
 2018 17:52:13 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY4PR13CA0087.outlook.office365.com
 (2603:10b6:903:152::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.12 via Frontend
 Transport; Wed, 17 Oct 2018 17:52:13 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1250.11 via Frontend Transport; Wed, 17 Oct 2018 17:52:11 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HHqAeh001517;
        Wed, 17 Oct 2018 17:52:10 GMT
Received: from USCULXHUB07V.am.sony.com (usculxhub07v.am.sony.com [146.215.231.168])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HHq8Hs024446;
        Wed, 17 Oct 2018 17:52:09 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0408.000;
 Wed, 17 Oct 2018 13:52:08 -0400
From:   <Tim.Bird@sony.com>
To:     <kieran.bingham@ideasonboard.com>, <brendanhiggins@google.com>,
        <gregkh@linuxfoundation.org>, <keescook@google.com>,
        <mcgrof@kernel.org>, <shuah@kernel.org>
CC:     <joel@jms.id.au>, <mpe@ellerman.id.au>, <joe@perches.com>,
        <brakmo@fb.com>, <rostedt@goodmis.org>, <khilman@baylibre.com>,
        <julia.lawall@lip6.fr>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <jdike@addtoit.com>, <richard@nod.at>,
        <linux-um@lists.infradead.org>
Subject: RE: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
Thread-Topic: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
Thread-Index: AQHUZaubKrs7lN8yQ0OXjbB6TpE4ZKUj1CUA///kU0A=
Date:   Wed, 17 Oct 2018 17:52:08 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
In-Reply-To: <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(448002)(13464003)(189003)(199004)(6346003)(7416002)(85326001)(2900100001)(7736002)(246002)(102836004)(47776003)(110136005)(66066001)(54906003)(305945005)(26005)(186003)(2920100001)(316002)(106466001)(478600001)(33656002)(5660300001)(72206003)(50466002)(7696005)(336012)(126002)(446003)(2906002)(76176011)(229853002)(23676004)(2486003)(476003)(3846002)(55846006)(6116002)(55016002)(486006)(11346002)(86362001)(86152003)(426003)(8936002)(53546011)(2876002)(4326008)(8676002)(356004)(436003)(6246003)(2201001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1417;H:usculsndmail04v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT012;1:01gjcLcu2Vi11FmEv1gMe50iTE4I3TbzQ0vzI0rqtSqHjuW5bMbWmAYL+188O8lguQ7QFO2ghxAk5jOaw1NWkqlf6GtkOxpGh55kJ4qKEFQSKDBDX/UB0RcXLDA1kSht
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99262bc2-014a-493a-fea2-08d6345944b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1417;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;3:mLWM9C4sDxoBl0g8Fd08L4mss3pr4e0GhsB5VJ1spxg3HyJKzS5bmqL/DAB+9B1bRiCUaGNbvbOn0fEuAkFIUZ61XZKvEV+/Vxe/qUzno5KoA2C4pUCcLYajew/ks5wQHCnf4YvwHg/YmbmhYGTXOFdAEErvLBZstid2qIpv1/1ao+YLTdJ+EK+Tt+UvLY7tO1ecrxWBoZ6XeCmgoF30GfJp5BB4j4LhJPm2R28BTFUBNcyhWi3XK9HMzEn66I6lnZaGLJ2lrlNF2UY60+zH4acQPcUQ8+aJRCfEUO3M2zLZaB4KvxBanx4ktFE0xGmu8FzsRR5a8TDt6PPl4krKYLBVKxbyW6OwSuZAEjNiVEw=;25:pOafX9/1I6ZE/8Bwg7QNU4+HFDdZxjdDtKDHdU3bZOorU7x8DkJ4+Nz8fJKiPO0rgM7L8k5Tcf7xCmOvGVF7xBI301VH5ePQYmcTwzx3S94UITqBsXKCWntsKM8TZb/Xh+gXCtQvvU26qiL0UbegmHOKcK/fpfSmpVU/4E4WGbvDQszm+WGMWK+hkPi3VjGHpMyGeP2gWm4Y/yhs0LxEvMAUrFKNOlnl3lxL+89DYeM+aDe6fXGsCZhFvOgjtggODCHNpby7ee8bhu/sHRGGKwh91AkkDRfyB2/wBAdzYouwmHHOhrsXqwkL5Jm7lFAEISbQx9dQHlyt7xn6e413XA==
X-MS-TrafficTypeDiagnostic: DM5PR13MB1417:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;31:nXPptCHlNzHh8pVPxIGvM1A83XOjGbrLCBcnffz2bEaTbOSbxw/kVdwCKmXsqo7e8ZeNuVLWygtm+DuhYiMSRlo+r/XZnvnDx2u3o0lTg/aytReKsPjEEMW8UzTLwq8qAUOaMQt6kTp9UmM0QTws5al8eSCGpKoO2JwQyPMETrHaPENprRExq34QMIWsjbUmZjbcYS9agidDbDjBLbNYa4O+TkeCe6DH+geZLamYH+k=;20:3RaUXs36bffddCHJPTJVU381eqnn3JDrSAqAKKn1F1gOccso9mZpIN5esUKi9Wrt7Bo2bWjP07/q35UlZkZZs6n3Wv2g1fC7NNuJIdSNZKFIJS3b0fvHHoZ89Vo/zsRRj2zt+BKVhrc+VvVP2zpQZvqfSee/uXxjYIVEagSs4Qjggj2Zz3WoxSOgPkbGRzF665ilBAk5iD0OwezlVBtni4s5XDEm0Ed17Tk2PujZEJwj5h98580Hz+y2/fKuU8OUoUOpdJGKS8JykbOFYQrSH/lbaeOG1YvtCXyXi8iSoiPRCSRAyOksmmOYjyGIwbakqkITJnEkc9IwOU6kSiU0hm1l3O3DghzvFSd8jRM+ZkGxEAfmrONa7vdIUYwl0KL8jfILoqsZgQAfCdOEBP2FDQL1CD1lcY99gECjXvJ055hF3gXhj5+n4L5WQZXUGE+14ia3PYucr7ND2G6ZmwMFUAAjucavMBL2IpRopM2vyIp+3ZSvl00V3plA5O9LywaZ
X-Microsoft-Antispam-PRVS: <DM5PR13MB141734999FABE6155B19C296FDFF0@DM5PR13MB1417.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR13MB1417;BCL:0;PCL:0;RULEID:;SRVR:DM5PR13MB1417;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;4:7uIX1LGgfcdRJsC9NXaZMXbF2DrIj9zUFSj72969T4Otr+4cMp2DhVrBVgtOaKDOMr+wPEgpJnYWvyZqK6wt9rrPocrBK4No6JSbmU6KBZfy2y+tEx2ADVDwHPOA1Oj15hRcFX2mwaALk0/+sxHGxQoS8THjPZrS5xjlKZHE6DjJX5EpCkQMn0FMGtdlKvHFs2huX/yZIDcCTqUfhncinNwO0FxDmQrUI5KTQg1ZwrQ/kashKRCvY/keDDMmd57YLmciVGda4vEGJj5V8pQBTFuAvyd1Z4C/q2/ls0tMdE3ExvFV2JEnnBhsWQ/rWMXdsucSnEF6ewI5PzWrbK4Z+zUJvJ/Oaon2MQjIrmgOJVU=
X-Forefront-PRVS: 08286A0BE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEzTUIxNDE3OzIzOktaa3RGd1dDM29HOXE1dTl1YzZYN0ZKd0JE?=
 =?utf-8?B?ejZPd1BDMXFXUVNvSGJJdFlJV0w2WXBBbGFUMjVYTWk5U0xTUTY1NnlqNHhF?=
 =?utf-8?B?NS9qZ0hKczREVzJISFMvRk1JMWZpd0FMNkd1TUt6ZnQrL0R5MWN4ZUlqSTN5?=
 =?utf-8?B?UmlCbDJJaHZnbTR4aFNqRmRQdStKOXJuTmd4TFc0VGd5OElrTGkvSnAxUGpk?=
 =?utf-8?B?VFpVTkZEZ21vcnNaNWgwSy9wcW1RVkFXMmVlcGVaVS9BemlvS1lUcUU0R3Z4?=
 =?utf-8?B?cXNHT1dScnRuV2tNUGlRY1R4VnIwVHFNNElhS2t6TVZBMG5ZbDFKM2hkQStM?=
 =?utf-8?B?cWNKVmRZMFc5bEJIVGZ0RzhleUZ5bGxYQkk4RExxM2RxdFdpdU1kSnN4SnhU?=
 =?utf-8?B?R2MraGdkOHB4VjdKMkxtV3RtWWxmZlJaTXhMTk9tR1ZFb295YWQ0R1pZRHZB?=
 =?utf-8?B?Q1lJanA4RitPRWtLTFBRTjNDczExM2psTGxkNGdzWDlKRDVzNVdQUWRtMkc0?=
 =?utf-8?B?eUZ4RG9YaFFiUVdvQUNnb2pHQkRTek0zMGJaUDJma25NdHI0WDFmY3pUeHhz?=
 =?utf-8?B?SjBnNVNFc0JOcVN5MVdCZWxhNVRUT3E3RXVkeVZEdVFHNUhmeTRzUGFCVmI4?=
 =?utf-8?B?MmU3cEZ4azUweUthdkVLdEg5SmV0QWVJT1lBZERMaXJDVmo2UFkrY2NiZTVo?=
 =?utf-8?B?SExyRUJpN1k1aVUvTkdNRWRZcHc1S0N5UGlWb1lodjcrNzVUcHVobjZIR2ZP?=
 =?utf-8?B?SXFlNnI1aDNkUUJDU3NoRW51SWNqVU5USmhaemRPQzVQTGpvSTkwWkxJNGpS?=
 =?utf-8?B?SmtKNnptUTAyTitXdk9pem1TWWJUYVNoQ0V1eWQ4N3prSFpaZzREdXpWc1Zx?=
 =?utf-8?B?WDJwUTVKdnJ3TkZTcVY5V2ZrWi8xWSt4Qkd4ZVlFUlZkUXVBdDNBWlpwSms3?=
 =?utf-8?B?QlZxajFsbEd0UFYzaW03S1gwYWJnc0JyL3FOMzNaYTF6ekFQekhGZlhUMDRR?=
 =?utf-8?B?bG1aNmhSTDJBaUJyU1o4UC84QUVka3NHa3Z2d2diZElzVW9LYzg1c3hySTRD?=
 =?utf-8?B?QlRpdWprVGVyQ1pUNnhaRXVFWGNNQ1NLRUJaYjlpMjI5NkorNVQ2L0N2RnRw?=
 =?utf-8?B?L0ZwOEFDT1pheFdhaDVmV09tVXplMWo0LzVQVk9TNEtqUGtFcHkxK1EyOG5j?=
 =?utf-8?B?elZwU0hwUzVZU0FDK05rSW1pV2xlVjJkekgrYzZ1cnJmRFV0TU13d0dtenBx?=
 =?utf-8?B?WkJXdVFLREFkTkx5REVDVDdHNzR0azJ1T3B0R002V01mSzNyTGljaGhtVEN3?=
 =?utf-8?B?VUtGWDhMNVMvVFZkbEtaa3pnL1dzVjNlclNyS1lMWk9lNFFuT0lMbms0Rmh4?=
 =?utf-8?B?V0dBZXR1TjNwN3d5cEwybXljajVjbUkyK0doRzh2TCs2WHF2amQzR3Z4M1A2?=
 =?utf-8?B?bEI1VUZUYkxOeEEzV1FQUzkxbS9sWXUvV2lSWnpmQ1hnbFJraTNCOGdHS25N?=
 =?utf-8?B?dFI3elQvdzNxci9GN3RqTnUwSFZmRTVJSVlYR0UxeXVjRy9aWXRaS25SajBS?=
 =?utf-8?B?RjUzbWRlUTNLdkx4N0NtRFZDZXEvcExpUTQzd1FjZU9LclU1eW1SRm5jR2Nq?=
 =?utf-8?B?c1lZdmp1NHBzMEV4UGt4Ly9ER2xsS3hFM1pKNlFKZjFodUtXOFNEYk1IVFdk?=
 =?utf-8?B?QTN1Zmt1S2xySE5hZUUvNHIwbFRoUXRRM1BocUlOaS9rVmRERHNzd2FDSkR5?=
 =?utf-8?B?KzdiYlRMZWRMckR2cXNIUlJUUzB4YzFrN1FBcngrNS9WL0N4OW43eFBPbHg3?=
 =?utf-8?Q?Zf/L7c7p9xqJN?=
X-Microsoft-Antispam-Message-Info: RxzrLI2jHBADuahSEAK5sjCHuITHyugd1KMqR0txWKcjzOA51BuInyeR1JZuXhHcDUSmkNjjIGTnuZbWJYdo3hB5miYgG628P6mtKbwpKtj+GyWvOMKEf6l3Ad69zk/HJS3+/zTWgJPRPpPF7CqJixb0+f28kxB6DKgjdK74THChwOx/CSNIg/SY+z7BRevkAde8Wiq9oGWNywdngvHpkSty25UU0WZMRknAQpn4G8IFLW10XKGF6UQcVPeMHbDcTvZUmNtqcraCuAXiFkkm7+cN9WmdIPnOJ+1YwiKpUaOWSWuCHlTMbop7UYPU3gpGLTHzGHc0+aiWwQeN5Fm90Nr77WfvVSwU5QF6SbatdvM=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;6:JMmAZ/7riJtphAQQIp3RUYtfXFfNXdp7C/CWagJNzY5IigEZ5hgthkYkLzeV2tBycHs0fTJe0VgPGtLriBrKiy9m+pfbwZc8ZJyDoCQSa7E7gaVbuSJJf+Hg+gnROOjfDYv8NJ5MyZcwXSg16r4mEnFSSRFwOcmqlRftQuqEoFQ0fdCsfDIdNOGYDvPLNQmLwwQqhaY4abVkqN486ht2iuG2MfGKBs+P+/NVY23VDmSr0WYq8o0LdCRdzG1O6NJzaQgrnkDRxaCIde6xpUs02f9/KiMmPT7ZfMVU+bfjT9S4j51OOY/dG6HRmJvdheEme/GumIHR3a6nrSNZLoP8BxWsiosTZu5j6oY6Sg+VNjeU+I0wGVBH9XSpHCA85QMyGt9gL724K/13SPBV6mQE+zgqTLP7PMGYSbbRuWgDtCkMD+HFkSs8hl5FEQbyHgVIWUFGsOkw71wG5S9Q6WkgdQ==;5:aKewHeJnAnoEnhGRG3X8CVq1yI57IMi0EsSI7RH7MC21f5Kv1uvYPIpLFaLrSzYeUcG/6xcji4W5AMRXzBv27pVB+XukGuTUg+TM9GH/ZKm1JdyIrFhZeJAQyVvwVhBIRTYoVgrH4llrP8C1lIYaMkUvY1wxoZenXoTt+c7KlQ8=;7:Dmux+uOQKCcDOk6S2HoH/kKqCdQJ7twTwhomwRqqGbAEvnyRahogiT/JOZf/T7VauWvIUIB9n1m+VkFphrphTRVYddoH6uvw1diBll/W9a76QMkuo3NgH+a4p8Ebv9b6EXYq6SwB9fQRKcxH471NfAWzKh5z3K6zYZZ07fEqj109XzHRy7Fx9J7ZOMqaduMmdlzXxEn2czhmuejPBPFLmnwxPO1XJrs1TAt7lNpl8IVoXI3BZaHLPHPunFNQv8hc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 17:52:11.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99262bc2-014a-493a-fea2-08d6345944b2
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2llcmFuIEJpbmdoYW0g
DQo+IA0KPiBIaSBCcmVuZGFuLA0KPiANCj4gSSB2ZXJ5IGV4Y2l0ZWRseSBqdW1wZWQgb24gdGhl
c2UgcGF0Y2hlcyB0byB0cnkgdGhlbSBvdXQsIGFzIHRoaXMgaXMNCj4gZXNzZW50aWFsbHkgc29t
ZXRoaW5nIEkgd2FzIHRyeWluZyB0byBkbyBhIGZldyB3ZWVrcyBiYWNrLg0KPiANCj4gT24gMTcv
MTAvMTggMDA6NTAsIEJyZW5kYW4gSGlnZ2lucyB3cm90ZToNCj4gPiBNYWtlcyBtaW5pbXVtIG51
bWJlciBvZiBjaGFuZ2VzIG91dHNpZGUgb2YgdGhlIEtVbml0IGRpcmVjdG9yaWVzIGZvcg0KPiA+
IEtVbml0IHRvIGJ1aWxkIGFuZCBydW4gdXNpbmcgVU1MLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQnJlbmRhbiBIaWdnaW5zIDxicmVuZGFuaGlnZ2luc0Bnb29nbGUuY29tPg0KPiA+IC0tLQ0K
PiA+ICBNYWtlZmlsZSAgICAgICAgICAgICB8IDIgKy0NCj4gPiAgYXJjaC91bS9LY29uZmlnLnJl
c3QgfCAzICsrKw0KPiANCj4gQnV0IHRoaXMgZmlsZSBpc24ndCBwcmVzZW50IG9uIHY0LjE5LXJj
OA0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgZmlsZSBpcyByZW1vdmVkIGF0IGYxNjM5NzdkMjFh
MiAoInVtOiBjbGVhbnVwIEtjb25maWcNCj4gZmlsZXMiKQ0KPiANCj4gV2hhdCB2ZXJzaW9uIGhh
dmUgeW91IGN1cnJlbnRseSBiYXNlZCB0aGVzZSBwYXRjaGVzIG9uPw0KPiBEbyB5b3UgZXhwZWN0
IHRvIGtlZXAgYSBicmFuY2ggc29tZXdoZXJlIHRoYXQncyBlYXN5IHRvIHB1bGwgaW4/DQo+IA0K
PiBQbGVhc2UgYWRkIG1lIHRvIHRoZSBDQyBsaXN0IGFzIGFuIGludGVyZXN0ZWQgcGFydHkgb24g
bGF0ZXIgdmVyc2lvbnMgOi0pDQo+IA0KPiBJdCBtaWdodCBiZSBvZiBpbnRlcmVzdCB0byB0aGUg
YXV0b21hdGVkIHRlc3RpbmcgbWFpbGluZyBsaXN0IHRvbyA/IChUaW0/KQ0KDQogSSB0aGluayB0
aGlzIGlzIGludGVyZXN0aW5nIHRvIGdyb3VwcyBkb2luZyBhdXRvbWF0ZWQgdGVzdGluZyBvZiB0
aGUga2VybmVsDQooaW5jbHVkaW5nIG15c2VsZikgYXMgYW5vdGhlciBzZXQgb2YgdGVzdHMgdG8g
cnVuLiAgUmlnaHQgbm93IEkgZG9uJ3Qgc2VlIGl0DQphcyBoYXZpbmcgYW55IHNwZWNpYWwgYXR0
cmlidXRlcyByZWxhdGVkIHRvIGF1dG9tYXRpb24uICBCdXQgSSBjb3VsZCBiZSB3cm9uZy4NCiAt
LSBUaW0NCg0K
