Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC9C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD2D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GkB71CFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2D20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeKBAF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:05:57 -0400
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:6616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728627AbeKBAF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVw5dqd2CkXglC2e2gULjRipV7Ozaguaxu/YBpJhjWQ=;
 b=GkB71CFZ2b3DlvtgFLhKMtnWI+uoNbbsbiVa7gWHTq8Qbmm2Gat92mZmWg2yb6eGE7mWm0xmeHoPG2+aeeBNvJL62u0mWR/yRaoDrddQAOp5HDDVZGVdhoMskVgJO3HIQewLK9SHvOY7W5LzChUGyGhDFawrPi1AJ+GOm5jgTDw=
Received: from CY1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:600::21) by
 BN6PR03MB3124.namprd03.prod.outlook.com (2603:10b6:405:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Thu, 1 Nov 2018 15:02:34 +0000
Received: from BL2FFO11FD017.protection.gbl (2a01:111:f400:7c09::113) by
 CY1PR03CA0011.outlook.office365.com (2603:10b6:600::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.20 via Frontend Transport; Thu, 1 Nov 2018 15:02:34 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD017.mail.protection.outlook.com (10.173.161.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 1 Nov 2018 15:02:33 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA1F2XYM007569
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Nov 2018 08:02:33 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Thu, 1 Nov 2018 11:02:32 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Thread-Topic: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Thread-Index: AQHUcfE3UjGtgCDbSEilTo1Hx55CraU7Rv6A
Date:   Thu, 1 Nov 2018 15:02:32 +0000
Message-ID: <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
         <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
In-Reply-To: <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9E5B9DE058A1947A8F59728F9B9D67D@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(118296001)(2486003)(14444005)(76176011)(5250100002)(7696005)(2501003)(3846002)(6116002)(50466002)(39060400002)(23676004)(47776003)(106002)(6246003)(2906002)(14454004)(229853002)(4326008)(8936002)(486006)(476003)(126002)(102836004)(8676002)(246002)(186003)(86362001)(426003)(7416002)(336012)(7736002)(446003)(436003)(7636002)(11346002)(2616005)(2201001)(54906003)(110136005)(316002)(106466001)(2900100001)(5660300001)(356004)(478600001)(36756003)(26005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3124;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:P70/hmpphpJ7eolHCLIjPtxs+jCEQZaDnTqtR+HWnayog0HrsTv2FM4E0djLjKm+U8+uUC4n0gJYWMbzzf6oiedTjfBW7vNJAXvjiTWqc2C+Uh4EdqN756QdwWHlJyua
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f9d307a-6bf9-4bed-4118-08d6400b0db5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;3:8erUIJGQvdcvC8hzOcHzwc2xBNM/pRNukOTQ6S8SXICxgXLUvp68RgUqv39hwNLD5qjbR9ehenfJvuoAWUQeo3l09f8s2T5a6MBYeTPbPqGRDvInl/hHMjWJMF3WTDyCM7wmr3FPeJoCyUO5WyWXQQ0ULXvdAXaaAymjds7qXq2+5EsDwjlIUIDE4iMcSZBBDvcc3x2Vr2P8UFVDtxLc1pgnTXj645xmYw14WqMvivWh7dbrAGtOdaBFomICzbpyElQAjke29o8GWP14FQh13mEAo9ZuvYrR90cPCGrXvYHQxf0kjzz8UEm2N670bb78ECro0MoauiN9K8K7Nf0o8ZM8v1zQOHZCJ3X0ysJ3Zwc=;25:QNpbDhxQ1jmvQmJLwb7Np3jW0DqoTzQ0JQF4ecFEJBa/f44T3rK/ox2JG4N6xTcJQ7NxbmxNdLx6IShN6lnn5xfjtap17+hB4YNkND+6jNdFdftTRr6fEbxY+qsvazg+pG/Sop1hznhIGMOnLf8gPhMa46VtcAr7REMEFzx/SGYLdgEJ7LeoBFp3qxdH2iWZkcnLlLsAPx5VMbWFWRJmm5oFMNbPR9HPReaeozZEsD6i0tXiutObR6FYlPt5jzwrBtyEHUFCx4xq96fxz3NuwDhiLWe4drMijzlt82+CWoAXIJU14oJXNZbqResmCUUv2098KZLepfCj1Me7uiE2/A==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3124:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;31:cL7ajjo1kRJhjzfYQBO/j3kgBvvVTtf1W9jWDUPCRQOb2Q1+58qj7aLYhoCe/A29WAxeKu+m7X8vCCv2Y/P6l3oeMh5+BJH89I7G6pS1EGWpxhNwxG3Qovwp04lzwpeW9s20aAaUKVQMksj98riYBrZBK2WpGRLQ8MB7gD4IVHsczfSDaWvN2w6SvOTWw8yMA5p0vCO7qs01UHo7qvL1f+VhBoZ8b9iexhI9ZU+xKsY=;20:Fw0S25wTALaqUrYuUFI4ykyEo7q1vsWd8+VpRaLv/RmwBFBXeeJ15ssPlrQxE9H1nH/mNUm5qnNgqo2q5kqYES9NKBIgODTkcw8mEFoqyTAJWFGr0+g+hkYIfMUqx3+hXfxQVMLsx6x9TtZGqYY/83f4z8Rd8TKGrIdJNlkaTNBO4JVgqkaIBGDdVVdR1C7Mrz9itQqhkkpTYeBC8zA8QQYOtmO0zh0ngi1OIIWpSkVGb6icvViq+fNQFd3chebpkyy1xD5ay8IzgSEkEc4Mr/FiMzDhvX7BE1oNoFBuNNVM/YinSDIBOqWDzefFxmDm/GRn/pvcH5dSSTXyHhGeaYsQCzQw9/KYuOzhJH40qoIzK47gJr3GQV+iAeoApS244AmlB8yYdPvrJ72IJ6a/k6i2Ju2yoLCzLLJENrgrJq5KD6gA/I73j3DGHWgaCy9Jc0iwUgf0fd2IzNr1CRjYdjVK27SwzG1WpIm/QziAoQzdLKFpRghYrOzMN9+ZKWZl
X-Microsoft-Antispam-PRVS: <BN6PR03MB3124E1DE15107D777E937CBEF9CE0@BN6PR03MB3124.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR03MB3124;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;4:WFpTeOOhptVVw8nSQ46nEbkbZK8wJta695bQtNSST8VV4arnFdgIpHwz2jYSCpip1iiIZah8RsucvvLUYi5lJrSmIU9Vj7PX0MR69SyZ5sKQWBbDV05lGkDZX6q7PX+QyXoG2tEYuC1QsmJttk982HluON0GerKYTbJL4l59+LBtTzEjWzWiHrIz1yBEIXrp5y/7RcMgVq0+jRWTwthiylm8edwrFsPdZH1bSbfmYod61ebzlhK/BkJ6Blz1dBdmntapNpbYOMnJ7hu/pyF1P0TDUEZXddKD3MSkEKuRZjk1L0r3sUys6VdnXrANUfokGdNwNzHYfIu1fMYw3wJEptxPkNpr3TjOsi6aQTEGmY8=
X-Forefront-PRVS: 0843C17679
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMTI0OzIzOkg1YUJFbUE2Yk52aDJZODdITUdKbmo3VFRX?=
 =?utf-8?B?dnhuMlFCTG5CbjF3eUlxay9RcEpFOGxzNkRtcWNXRFdvWUl6NVMvbll2RXZ4?=
 =?utf-8?B?RzlkeUU3YVNJbEI0Y0JjcFh5ZUZpdlJpNUFrazk3QVNJQ0c5ajdXam9XM2xi?=
 =?utf-8?B?MjhwTDVkRXNJK1AwNDJuUnBBMEx0QmtNVUhYTVgvdnJZaUNFYk53Zk9LZ0Zy?=
 =?utf-8?B?QzFtUitlK29lUnpiK3hmUkVaeHhwVXhURzN6eDNkblYvTlVMNTd1TnRJMi9Z?=
 =?utf-8?B?Ui9CMlJ0eXZWbDBUZnNkdUdMZXc3RmtQZjJtVERNdzVqeDNlcDJoeTNiQUh0?=
 =?utf-8?B?UnpPUjhtWjJpZy8yY1FGYTM2REtEZGRLbjZ3TkhmakdVZTVWWU9NUEkzOW1N?=
 =?utf-8?B?R05ONEFkcEV0ZW1aY1V5UkpORm1ERkNRaTlzVHlDTHR0cDBSMEtuQnBVQ3lG?=
 =?utf-8?B?clpFbGU2cFQvbWE1SVVoT1RBLzFyTHZaaTFyWFhqTVZpenVjZEZvV29vR3I0?=
 =?utf-8?B?c1VxaTZzdVZzQm52dTZNZnlscHJ5bGEyNzlETU0rTTNMLzA3WHpPbjlqSDdx?=
 =?utf-8?B?SUNtMlpLdFVETEVNUlYzdjVFTURkQUtKMlRLd21ibkFCWTA4OEdSVElSY05w?=
 =?utf-8?B?ckRualNnaWcxTVRONDVLMmtJN2FNamRNamhGQ2R1Zmx6SFRuVUd0TEljTmhx?=
 =?utf-8?B?L2taQmRJOWRZV213U0I0L1lFQkFFZlFFT0JWWjUzUjVrNDZrcW1vdVdFNW50?=
 =?utf-8?B?S3VmNzRTNnB0bDJXN1owMWhFcmdDQjMvOEh6aS9vRkhiV2JReERmMklPR0Ji?=
 =?utf-8?B?djg3d29LQ2daT0h6ekVGeDg1THJkZTk1RnBsamVHVVJtS0ZRdnJNeDA0aDVj?=
 =?utf-8?B?aERNd1l1ZFFIQlNmL2VXWW5JdzE1cWYxSlhnTmN6RlNjWW4wUnB6OFFJY2U5?=
 =?utf-8?B?STVUR3pRUllTY0lUd1dzeWhnTzhCTURGbml4aEZYRUR2ZXBKQWZvQkZuajFF?=
 =?utf-8?B?UEtIU3NITmltRTFFdkNHdzJTVEZlOFRDN0FUSmlQQktzbXNCSk9GQ0R5Uk9r?=
 =?utf-8?B?VlJoSXFCZ0tlVkgvaGgvV2tvZ0U5ZFY0Q2VDZXpkK3BsZncvQ2JsSWE3S2d3?=
 =?utf-8?B?SkcxMWpmWTFZR1lLRnI2bVo5SVpTT2xreWdpakRiN1h2ZTM2VGhSdGU1cm1Y?=
 =?utf-8?B?M25oZkx3QVk2eXM4U3JETnhhU0k4Q1p1eXA4YlZEajhGSzEzNHZpaGU0ZE9G?=
 =?utf-8?B?SG9nZHA1VnRyK0wranpHZ2VoSTRBTjcraFVWK1FhdWVSSnVZMzNBMDRQRE55?=
 =?utf-8?B?d0gzUUlFOXpXYzhxZ2xadFErN1NBeGpjUmZLdXRqUkQrY0EvUkZZcWUxR3Ni?=
 =?utf-8?B?S2RyajhkTDU3LzZ5S1l3emFiWEVidTRKVmFySHlVYktMV2E3WVRMSEI1dW45?=
 =?utf-8?B?WmpFVGRRWE01bEh1ckUzd1FGZ3o4eUxvYXFmUldZMHlMUDFZOWVPeHBoZ2cw?=
 =?utf-8?B?V2hxWlVqZ0tPL2JWUStnQWVEQmxFWmwzZzFqaEZVWE1JVDBlMStMNGxQaTk5?=
 =?utf-8?B?UDBFelpOK2JWOHlXaFJDWUp4VXpieUpCUU5TTUNoQUhwRVlzQTRCSE9LWWtB?=
 =?utf-8?B?M2IrWXg4d2pUZWlkVnZ2VmpDeE9ldUwvSVVFWExMNmZaMTMzZlo4VDV5aG5z?=
 =?utf-8?Q?UXPYpcAwd+QrW171C0=3D?=
X-Microsoft-Antispam-Message-Info: LHCHC3v8JpWFYiVul5ygdkOOLcoow9eSmqH4EnyYVuuwknbN6sappgq7qupW9TqKSC72mQ1KmmLHJrhiM+5LC2oAX84W3XRaj6OHoQt8l6iYHuF10woFcBI5beNSFN6sKkfE+K0Nx32+gwger5J5Ms5vhgBU85n+glCFMP9FAjCMCLtaLyHf9NUHzU8+n3PwIGxPbZl8DXcPps6QTMXjCub+uxZGF/CpyGIwDo5Dm5ahN34BItzdC/HOIWFQWS8F07dlkuWvXPgwdxWApV5BFwk478a6z762YEmJ7WYIkRDF8U3Yh0tVcVIZH3nvRvNBCPmCKMZepwi3EzI2ujqM0qVFW+LmCyKorpLNzvjCZ0M=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;6:bnbj0syjOGBypJKkBkuCVRl8xQ/snMlPuL4Lh6aiwPDR6fY5YKi7le+Hc0YIXtmNlkhnFGrO8G7prUrbrCi1CLXBy2oFu7/GwotqlWJBkFVmyKxjE5Pkry3MrDCe8NhzJkfIBftn1/yVgWAKMp9FMxDK7Gse/KqAauIO+vBLnaiSAnzOf6Z2n2/hCrwpAmLmlXNAl74nvjzF2sfYqAdkfsELy08h3OEYnwMbfNUDs4Ey+8fP91ghe2M/8VUvz3ELq9BXEZ+rmCNtPFjRMFnWv5rKfPU6OhPxoy7LoKxVRi7ZT4JKLI/JaBuIyh0t+NOr5NSVdlD4m69uKUHg4OumzdzK1clSVnzQAHjIOxGdbF4/SpzTgBl12Qf2BEio59LdDKOqmRm7O5XnwGLBgozOrefBSynWaVNAyYkTv1kYENIcEl+UDdI/BRnOPc1V5meH1uXebXuHbxn/XRumBRz+mQ==;5:LEmgYaUZQbPQDd0ozJ9SakB3wh9VaKMwQh5PdP5uQgJpO7s0+pTxRPUjyxvNRWVY6Z7a29y5q9stxcJXDAD2kwQiFQROu0dE4Fo1p7rFPsA3N/1gg9U824K4l5Kt6als7k96X+SP67+vwWNPABLnJQrTrQ4GgxpQ7PTLVFlfz9M=;7:3Lh6LgeovsHErwZ7ggeurNW4+32TMsai0WhryqYr139J3lWce1AwJnM4HA6tZMt6BSowK/ze+dte8mk8Ycb5IWpNRDZRwNL3AOs8eKU1T0Zno0XoBI9j+/9cATEfL/6wvEP4mHl4udtei7VGmIhXhw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2018 15:02:33.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d307a-6bf9-4bed-4118-08d6400b0db5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBjYXRjaC4NCg0KQWNrZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFy
ZGVsZWFuQGFuYWxvZy5jb20+DQoNCk9uIFRodSwgMjAxOC0xMS0wMSBhdCAxMTo0MyAtMDMwMCwg
UmVuYXRvIEx1aSBHZWggd3JvdGU6DQo+IFZhcmlhYmxlIHZhbCBzdWJ0cmFjdGVkIGFuIHVuaW5p
dGlhbGl6ZWQgdmFsdWUgb24gSUlPX0NIQU5fSU5GT19PRkZTRVQuDQo+IFRoaXMgd2FzIGZpeGVk
IGJ5IGFzc2lnbmluZyB0aGUgY29ycmVjdCB2YWx1ZSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2Fk
Nzc4MC5jDQo+IGluZGV4IGI2NzQxMmRiMDMxOC4uOTFlMDE2ZDUzNGVkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdp
bmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBAQCAtOTYsNyArOTYsNyBAQCBzdGF0aWMgaW50IGFkNzc4
MF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQkqdmFsMiA9IGNoYW4t
PnNjYW5fdHlwZS5yZWFsYml0cyAtIDE7DQo+ICAJCXJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUxf
TE9HMjsNCj4gIAljYXNlIElJT19DSEFOX0lORk9fT0ZGU0VUOg0KPiAtCQkqdmFsIC09ICgxIDw8
IChjaGFuLT5zY2FuX3R5cGUucmVhbGJpdHMgLSAxKSk7DQo+ICsJCSp2YWwgPSAtKDEgPDwgKGNo
YW4tPnNjYW5fdHlwZS5yZWFsYml0cyAtIDEpKTsNCj4gIAkJcmV0dXJuIElJT19WQUxfSU5UOw0K
PiAgCX0NCj4gIA0K
