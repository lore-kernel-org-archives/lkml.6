Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KEwFwCUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLKKeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:34:22 -0500
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:44096
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbeLKKeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1YAhvXMAZmyf9sihBBjRgD00gsPDSdXeyVlcuGSpfk=;
 b=KEwFwCUvKkiD5ZPg3FLRcvQRfGa2waqrBI3He5ftcewkNaFPB1IY83w9mwBleBDKWcB5cfnwyvaSrlQT6VPSQ0Io3mew5zyTQn3StmdNiIZf5Ju+fFw36+ZtK+Nei4J4oL86kUiEaDuDqgkQDnqd+w6XNIR7j2xtTKjwapijv8E=
Received: from CY1PR03CA0037.namprd03.prod.outlook.com (2603:10b6:600::47) by
 CO2PR03MB2263.namprd03.prod.outlook.com (2603:10b6:102:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 10:31:25 +0000
Received: from BY2FFO11FD016.protection.gbl (2a01:111:f400:7c0c::141) by
 CY1PR03CA0037.outlook.office365.com (2603:10b6:600::47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.20 via Frontend Transport; Tue, 11 Dec 2018 10:31:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BY2FFO11FD016.mail.protection.outlook.com (10.1.14.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Tue, 11 Dec 2018 10:31:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBBAVOOU025253
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 11 Dec 2018 02:31:24 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Tue, 11 Dec 2018 05:31:23 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH 0/3] Add devicetree support for ad5933
Thread-Topic: [PATCH 0/3] Add devicetree support for ad5933
Thread-Index: AQHUjyJskZe5JhiSgUq7sufyPIATSaV1hRSAgAAlboCAAyl5AIAA2t2A
Date:   Tue, 11 Dec 2018 10:31:23 +0000
Message-ID: <3ba95fa0946962b113760e157a91b81e43f468c1.camel@analog.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
         <CAAX=9sVrbu2U9go_d1G5=rGRa9AYT+betx9gyKWNXXU4adg4Bg@mail.gmail.com>
         <20181208211043.GA25188@kroah.com> <20181210212756.7e444b4f@archlinux>
In-Reply-To: <20181210212756.7e444b4f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15EAF2C1297802439F08EB74D959B5FD@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(106002)(102836004)(23676004)(54906003)(2486003)(93886005)(118296001)(246002)(7696005)(316002)(8936002)(3846002)(36756003)(8676002)(106466001)(110136005)(2501003)(6116002)(5660300001)(39060400002)(14454004)(229853002)(7416002)(7636002)(7736002)(4001150100001)(126002)(2906002)(305945005)(486006)(446003)(86362001)(426003)(6246003)(2616005)(50466002)(356004)(47776003)(11346002)(76176011)(436003)(26005)(336012)(476003)(186003)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2263;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD016;1:Nau7KiRriQfyxnJcm4Nv0kmK77xjdoUQUQKIb7uE/WBiUgq8mX1U+UluIJ0ybn7w57XglGthZoDM9Ave+jo/Do1ZF9ywoxnqL9opVKFIESG7gvWmySJeuZ4AFDapy0YJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b16fe41-97f2-47fa-66f6-08d65f53cd8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:CO2PR03MB2263;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2263;3:L20ub0XQDTzpQu7MozbXd988eSokLEic3OMUc3VVPVDj4frqAsqwBU7ucNPVldIKcy9YSAk+fyvAhdg5yck0Q6OCtb1kafK14MCR4vuNkVNTWgMZBQBujQ61L31FtP66YStNzdGpl8uZj4aNpo1YopwMZpRiJzSquO2eQijHA+nnRQ5YxOzSk7UNR9J8mglNmBoqGy486xRWkwhoKKiDTzH+YBCxlvorfe3WpOSwp7OiebWYXbR0UHbgqNDd+gwYY/z68m8D5xWpIvVAYSXvGog/LB7+62l1ySz0rAv5a5sCOOJ/rkUVjAdUzNnVeF7iMUYt3z0aPBkfjetdM4uHkAbw15fKEwOuT0yZmvanY0w=;25:2NrmN9ql9pMWPJd4YziiC1Ci2yAE301CmhO75A7nPBdVqBzVpyzNWcETvqxRQ8iCzFk0cbb2nF1EpM4vIobetX3Tvr2ZRyXJv78Ee7gobAij0zW2dU3zosV8G2niY9m27N7utsYVrEXo1O/usrAsQPm8miKNnt1E5c66b/gJlrphrkP3HhXBDbhOxddMoRraI8E5+pzwQKQXrGQ9wQE6Nry0VoI8w0Ja4qkgBfphl9VUGL2ulUasw5InkTfGUKqYycKHMMRo/LsfpAuxfAXaic+0/E54axp7VLs5FqEcffOzgZMuLI881RDQKYJq4H0q/i/3VRfX0hl1WmT0reKenkgWxzLawwKPRhN7Wqvib/I=
X-MS-TrafficTypeDiagnostic: CO2PR03MB2263:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2263;31:x66NZT8aeY2t2aCVYUbusfXweVLX+SJyZik3BzMa1YXVGuYoXoOmRR29kpZnIgLnzI+1+YgQJRa27f+27r1u9TypCKKcJjjFlxs3LSw43Uos/A/d+FVhzy0RZ8NTCjls43pa+059XpPcT9kbmjPEhWA2N0JAibBPlK5mFd59Q1I033kWfFwKD2Sibc9Jdh684RU2s/fkaNdCOdC9DE6zkzT3koglLeahXUelXcEQzHA=;20:ljw6dg8glIyTYkydPSM3UjB38ToChYOa0dXyg6lzpq2symd50P3lOOUaBS9u8o51+bItcet3zIavoLA5KBi3OkXx8TeuYcy8PYumAZJA5CTWtsw6Rt/3yxWerDYpKZZ7BUPMg56Gd0d/O5QmpnbxJ0Nq9U7Sho/YoC4RGh04nUL0nAAFzrBpS4c3KyDKLBpMl/HIMJeUN8ZJAMaYldhAhHosIyDgQZM2JVoogDqHL716j9TakeFJS0mx747t6aTWNdqyJ/U5SNbBnmJ/kXNc63SpgQFf89XbEqqm7ALEthZ7qJs6CznMYAp5wPri9WCwLIwv4pLiI4VPMiF1/1Y7GDsCPLn4Udp+lM+DgqcxMgde87Bwi3WQ5LojtMI7PbsM/MTYp5dOlPq0LksKDOms3snHZTDUPJBeA8qe9RfKqqtEHiwHObUdRJDAeNmPoy7bv1xctTg8jtx5oOWxyRTXlxyuLekqoAkhEEPUlKXXtkifjVPWQO+3g2ZJo7iGcyD5
X-Microsoft-Antispam-PRVS: <CO2PR03MB226355D2369CFC6A48D720DAF9A60@CO2PR03MB2263.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CO2PR03MB2263;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2263;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2263;4:0iUb4Y8IQZxPpIlJNWK9dzZVsplnh78x2A19bTD2H/AsAtqpimDFbSi+YFzcmnz/HATMBMvtWvhA2IAFLDZcgE/hwFto4TxqlYOmPXIyu/3hwHqSg51IIQZeE5o18MCkPGddQlbVBf65P57lVGZyVL1IAhQUZCjTBR1cWX7g2+t13cTkMCj0KfBks1Mbhcnf4BxGHTqy2ASL0GmJ5MHLMV/+xzGTFH20iXFBBJGoQE3ri/CLqKrIX9d5uwy+JNR+ibqkVTZhL2sDm+drxGnb4g==
X-Forefront-PRVS: 08831F51DC
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjAzTUIyMjYzOzIzOjgyUVAwRFFoRU9SZXY1RVgxajVnK2ZxaHNt?=
 =?utf-8?B?L2RoQkpmbElBdW1EVlRGRXR5NVRlaytVcXNUSXhSR0Qzc29JQVZWUmtRNktN?=
 =?utf-8?B?dFF1OWxKelRKQmVubmdnNG81QlZWRUJQWTUrM0NUN3BzYjhMY3k1ODVQb20x?=
 =?utf-8?B?anZ4Rm9pWlVIdFJzTXVXdkQwbHo5NkpKa2ZTMG14ZGVybi9uUmFzcGhlUWF6?=
 =?utf-8?B?dlN4ZytEbExZcGl3elZkYjVUdk5lKzlIR1ArTXNpeWlzc3U0TWd0Qmh4eXd2?=
 =?utf-8?B?OS9nUXRoYVRDT1BKN21WVzl3VC9od2pqTmFzdVJtd3FnWXNTRFNvSnBPZ1Vw?=
 =?utf-8?B?NnF2K0ZDRlpoT24rMXoxU0hOYnR6L2NBTmZ1c2VQN3VzeENyQUVGbWx5dUZw?=
 =?utf-8?B?eWR2R1pTOFIxdkgwNFl6VWtoUTdQOE9DUFk2MzRqbTdkZGNPVlk4YjBQdjFx?=
 =?utf-8?B?THJZdUpLRW9PK0lXVWVBVWVrTkc2Ym9ZbGlXY2hOVFRKZ1JtbW5TSGNvZ1Nm?=
 =?utf-8?B?SXI4S21sYThwK3ZPNFZOVjh5ZC9vRUk5S0ErSHB0MGFRSUtNbzhUSGFjSUZy?=
 =?utf-8?B?c3dXU0ZQckZSZFNtTzJwdXp6WkRKWjdVT09kM29EVUdJQXo1eFVOMWp0dFU0?=
 =?utf-8?B?RytpWlRwbzI2SDlJVjFVZ1EzRGtXbEpqT3hVVWs4akN2TjZlUnpic2p4ckZU?=
 =?utf-8?B?NDkyQWprakJaSm4vVXlmUVZmQ0xqUmU2ZUFNY0dBTE5LdzRIZEFzRDdYdjJH?=
 =?utf-8?B?dUpXYk1sQ3dEeTg0VXFHUDRKemFPNU9PR2tSZHBnbmhuUGVETDdCZTdrZmF3?=
 =?utf-8?B?MmRkMmhIVlk0T1NRWkhrOERRbjZKVUlMYjd2a0xqVUFWREY2RUN5c0J2M25p?=
 =?utf-8?B?Ti9kLzhzM1Y2RDM4azdIZ2puWUdpTXViUFgrcGJFdHVJRzM2czR2djk5L3Ju?=
 =?utf-8?B?cG1ZdHVSek1ZdXVCa0U2REQydjZEMWd5ci9EcGxNenF4VXBWeUE5eW5tNHQv?=
 =?utf-8?B?Q1RMLzMzUzczNTBUTnZ0Y2tVdXpOckFYeHRNMU5uTHZBcmpBSEk2bC95Skdy?=
 =?utf-8?B?d1BXaDFuWEdGQ2NYSldDR0JsZGIzbEhreXVnTWEveHN4TnpIenV1MjU3VlZU?=
 =?utf-8?B?N0hRa0djejFuOGNVUUxsYXhiRzNPVmFaSCs3UVpUdkV2amNGM2lrT1dMbVZ2?=
 =?utf-8?B?YllNeUlRK0xDUVlJeVo3anpYRW9EWDJ4ZHJ2QzNnWGhuak1ScStid1ZaYkx5?=
 =?utf-8?B?ZWtjWW84UkdYczQrZWxTM1hqL0c0NjJHYU9KdmtRSzFmUFZMMEZKamQ1c2JO?=
 =?utf-8?B?L1poYjM4T3B0NFM0Uk5KMzFjQlFDL0ljQm4ybDlRektIVXh3UkwxTEJXUjVF?=
 =?utf-8?B?QVlzMUROWEJOSVk4QkkvY1ZmSW04YmdLQVRHbnRwRjBkTnRvTlhIVVhUMUVX?=
 =?utf-8?B?SytXTGl4WkUrdWN0cDJJR0JXd3dpYkVSNWtQNC9LbEVVZkx1THMzYTkrR2Nm?=
 =?utf-8?B?WXRRQy9xaVBoOHdVSGk5UmNZSmJwdFlVNksxSjhzMW9OSW16OWxYZ3oxemcz?=
 =?utf-8?B?b0JRSy9obVlOekRFbDBIb0traU5xaXZZV0krSi8vNmFxWHNNbVREKzJBSWE2?=
 =?utf-8?Q?JDcvIIMDc+dqd12wZQpK?=
X-Microsoft-Antispam-Message-Info: xc+/FIyM4rA1Y86N6H2yg64MI6gzHOLy65bPyRNUVzmKXKyPYG47TzhzVLcM3UUh3k44bsMJLM4j0U5QvfAOWIuGtAbC46USaN8BWvD/KfeEcvK6OJdWFjkcaov1AqCVtcsXsydh7nCjW4tH61OmkVDh0rrMR+6DRWwe93/GgKH4W+EaWuXXTZ2SUrg6QE9CF2TXLQhtycPDvqdOJj/4pW4CSkaWbhke0pf6/IvMNUzG/9oCZXRiSjHbVJDFeW8IyaGrfGxsypIn6DflClAy1k2f7+mXwa5/dDuMUAM01E/VgksvsL+4/o9387EgPdVb
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2263;6:dvaOddC17j+oXzPSdj9N08nHf8by2D7hiERr7IfIA4wPfDk/TNCQnl7xGwnrvA3i6M/CqXzuYELl9rCm1kYfawtxuKto7kQ78TS4YVzJi4JpnnOKZDhWG9pz3rTZhvDgqC38szhkGyhyymKvidWtWEXD821c1G3NhxAeaX26lXaEcD5VwdzjW9oeDPkbLxeZLt2csjJCz/PSjjYennQlhdFTuyc66E8iGmPpZMulAJaDif8Ccpqk++JgLbwwsT4S9DuvC300ewkPzjhuEqA0il8E20X6MHr8CXXmwi+SbeE3i8lPteIyW6ZIhx4VZk2+1YcOuAcki75kjpKpLwuO8PuiSZnjkXvcyvmPQzVJCv9buDdKQiGqo4+/pF4LkqB4Hr4keKD742KVAxyHGD2IIpbb5moqhJ6aP+6QxCdiYpXl66Z2hHpvNmxrfsKlGkyywYDRlrBqsvW7VyGSXS//hA==;5:TJ9SRZuNEOIFNEgVP9ZjgR2FpjgkoJD5H3EHSVvlrTthVBGD0qfuPmlSvDzGR9JCFCvwAYH3ANk8uYTQTYnmlp+VsNThkyt9Fl4567pD7vDBPqj67cmrP0hpEJqCvFKNf36COqer/Engngpu5Dtbo71trsDkjO42e5pDQpnAhgc=;7:5Pzy+5kaYTTPKJ7hlDB298I9KYwCgE3AAnaUkLmu7STaSk8IhLYMZAp5hO7QKpT3FcOxzEPIO56NpczyCpUTaJkSaP7AsvN5cdUh/noCZZ6BkjVtD54iI+IBwpS14P58E2OzMfFZywAfjQVLRZylAQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2018 10:31:25.2276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b16fe41-97f2-47fa-66f6-08d65f53cd8e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTEwIGF0IDIxOjI3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTYXQsIDggRGVjIDIwMTggMjI6MTA6NDMgKzAxMDANCj4gR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gPiBPbiBTYXQsIERlYyAwOCwgMjAx
OCBhdCAwNDo1Njo0NVBNIC0wMjAwLCBNYXJjZWxvIFNjaG1pdHQgd3JvdGU6DQo+ID4gPiBQYXJ0
cyBvZiB0aGlzIHdvcmsgY2FtZSBmcm9tIGNvbnRyaWJ1dGlvbnMgb2YgQWxleGFuZHJ1IEFyZGVs
ZWFuIGFuZA0KPiA+ID4gRHJhZ29zIEJvZ2RhbiwgSSBhbmQgR2FicmllbCB3b3VsZCBsaWtlIHRv
IHRoYW5rIGZvciB0aGUgaW5zaWdodHMNCj4gPiA+IHByb3ZpZGVkIGJ5IHRoZWlyIHByZXZpb3Vz
IHBhdGNoZXMuIE1heWJlIGl0IHdvdWxkIGJlIHRoZSBjYXNlIHRvIGFkZA0KPiA+ID4gdGhlbSBh
cyBjby1hdXRob3JzIG9mIHRoaXMgcGF0Y2ggc2V0LiAgDQo+ID4gDQo+ID4gVGhhdCdzIHdoYXQg
dGhlIENvLWRldmVsb3BlZC1ieTogdGFnIGlzIGZvciwgcGxlYXNlIHVzZSBpdCA6KQ0KPiA+IA0K
PiANCj4gQWxleGFuZHJ1LCBEcmFnb3MuICBObyBpZGVhIGhvdyBpbnZvbHZlZCB5b3Ugd2VyZSBp
biB0aGUgYWN0dWFsDQo+IHBhdGNoLi4uDQo+IA0KPiBXb3JrIGFtb25nc3QgYW1vbmdzdCB0aGUg
NCBvZiB5b3Ugd2hhdCB5b3Ugd291bGQgbGlrZSB0byBkbyBhbmQNCj4gbGV0IHVzIGtub3chDQo+
IA0KDQpIZXksDQoNClRvIGdpdmUgYSBiaXQgb2YgY29udGV4dCwgSSBzZW50IHNvbWUgcGF0Y2hl
cyBzb21lIHRpbWUgYWdvIHRoYXQgZGVhbCB3aXRoDQp0aGlzLCBidXQgaGF2ZW4ndCBoYWQgdGlt
ZSB0byByZS1zcGluIHRoZW0gW2Jhc2VkIG9uIEpvbmF0aGFuJ3MgY29tbWVudHNdLg0KDQpJJ3Zl
IGRpc2N1c3NlZCB3aXRoIERyYWdvcy4NCkZyb20gb3VyIHNpZGUsIGFueSB2ZXJzaW9uIHRoYXQg
aXMgZGVjaWRlZCB3aXRoIHJlc3BlY3QgdG8gdGhlIGBDby0NCmRldmVsb3BlZC1ieTpgIHRhZyBp
cyBmaW5lLiBpLmUuIHdlIGRvbid0IG5lZWQgdG8gYmUgbWVudGlvbmVkIGluIHRoZQ0KY29tbWl0
cy4NCg0KSSBob3BlIHRoaXMgaXMgYSBzdWZmaWNpZW50bHkgZ29vZCBhbnN3ZXIgW2ZvciB0aGUg
d2hvbGUgbGVnYWwgc3R1ZmZdLg0KDQo+IFBhdGNoZXMgbG9vayBmaW5lLCB0aG91Z2ggd2UgbmVl
ZCB0byBsZXQgdGhlIERUIG1haW50YWluZXJzIGhhdmUgYSBmZXcNCj4gZGF5cyBhdCBsZWFzdCB0
byBnZXQgYXJvdW5kIHRvIGxvb2tpbmcgaWYgdGhleSB3YW50IHRvICh0aGV5IGRvbid0IGFsd2F5
cw0KPiBvbiBzaW1wbGUgYmluZGluZ3MgbGlrZSB0aGVzZSkuDQo+IA0KDQpUaGFua3MNCkFsZXgN
Cg0KPiBKb25hdGhhbg0KPiAgDQo=
