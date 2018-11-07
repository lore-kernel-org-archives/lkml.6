Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EC52086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MIHsQB54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EC52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeKGSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:31:52 -0500
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:36672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbeKGSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycaL8dY5Amu3gViOqDQrB398BR6j1xqB5QRKPwbMgZo=;
 b=MIHsQB54dCvkcygibCLtFRNrr7Z+s9aKPNQgtUD6z+gjYQ+DPQVM3afl94ytKVe+CvdWCakdHV9eaxe5z4nWeu1c/TXPN3JnAQ1wRkOsLvuK5Z5fpbx2mgERIv8Zl8c+FqtVoM45Djt+EVkuagzX2LckFSYI6+nMIdtnPWoXr4E=
Received: from MWHPR0201CA0021.namprd02.prod.outlook.com
 (2603:10b6:301:74::34) by BYAPR02MB4455.namprd02.prod.outlook.com
 (2603:10b6:a03:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Wed, 7 Nov
 2018 09:02:18 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0021.outlook.office365.com
 (2603:10b6:301:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.25 via Frontend
 Transport; Wed, 7 Nov 2018 09:02:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 7 Nov 2018 09:02:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJj6-0008Rr-Oc; Wed, 07 Nov 2018 01:02:16 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJj1-0002w7-Kf; Wed, 07 Nov 2018 01:02:11 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA7927Ml000808;
        Wed, 7 Nov 2018 01:02:07 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gKJix-0002tm-DC; Wed, 07 Nov 2018 01:02:07 -0800
Subject: Re: [PATCH v2] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <20181107085639.32366-1-natechancellor@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <79a33561-6980-2fa4-182a-c2def95d49cb@xilinx.com>
Date:   Wed, 7 Nov 2018 10:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107085639.32366-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(36386004)(50466002)(65806001)(65956001)(31686004)(64126003)(47776003)(230700001)(26005)(8676002)(81166006)(81156014)(186003)(39060400002)(229853002)(8936002)(2616005)(31696002)(426003)(14444005)(336012)(486006)(575784001)(6246003)(446003)(476003)(126002)(44832011)(63266004)(23676004)(106002)(316002)(2486003)(65826007)(54906003)(58126008)(110136005)(36756003)(356004)(9786002)(11346002)(76176011)(5660300001)(2906002)(305945005)(77096007)(478600001)(106466001)(4326008)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:G6BD9riYcXng/hFYqFa8YISiR4J8g/tnfyThSvHz98gc9uPbkeYxx/isoHvfv9u6EKawQJL7VnZq3e9xTNCtXXRcMJPhgdhLd13nNqytvnAB2O9XjZtuF19jZNwijukn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b823923-98ed-4fdb-36b5-08d6448fb7e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:Hhtd6YMntpDhkLCZfbDLwmcpyjHbgn87opbn40OYUZr9yDv1X7pw/dfhaj9rc+F6x1TMW5LHpums3Gn9hO8+/qrJH0f4Tz4L3ryY9FDX0qXvBMcD3Tsngxb6dKyK3/x5YpuZRUOc0Z9L5Xhwca3zit/a7FEtWdAEMB34HA1vegIZ+JQSC7raDJEm7I0zptbArSnRxEr3Owq0Vrd9kaLnuk9wuXpXsM0iB8L3+GK9Yn13cLGaM29I5Un5srktEx5Bds58vAEy1q0lnjtyN3880nNmPQgpgANfCxOs58b4ZzcroDL2MkiHOmXT+R2napxHBVhmO+2sNOL0fe0vfQxHxxTMwPf0I/FOxuEENQzDQXM=;25:i4ZSNS1mzx7OvZbYMAid84l5G2sqnDHeozMKyAUeCm/2SNgLVtsGcE5axwWi1+jufofUMf8MIUCCie9RpPwyLraFbFp4eQFw3hDDGnwxhQq62dDaE3y+HCHYKCaJ7NlI5tbKn9s7jSPEPBPWGaoA36p980V+G4ny8n78YvjBW+7D7E3SzEF2bdllW9pkv3yVayJw3gBHsgFn6Akm3K6sx19le1zkiHW8vq/nQ/ghQeKkTUBCissnZO8bIdns5QBQz1WqY7/s2WbwbXt2BqBBEx8dsyW98vCgitEiP+hW7srzy1Yxt2SSXhko/P+AVxKQUgcKBuOOM6UaCeH9fHBF1g==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:vu8fR3olfg2FuFW/3ZbfHVdiZLWbj2oQhR/Qps3fU4f9cdvccLj2JdsVuQTqAmFqkBtNSFdA5JMDDn5lS1MbC/f1JedqREdGpiDwmX1gNFyR4vJHQayqqHg6YO7HQgKpExr0PyBQEZRQIHrLa5WYVCLTmG9luqJfZtMTw8a/esCJDehkeJjEFHWHAEcyCsWlU9bqE6iT7QgcUyk5UeCiHBsHCw10mtuKD6DnwT+sO1g=;20:nsWeZkAAu4/mQu3nse9IGoN43Qx7vAUL1rXo/Xivpkse45O8TULTbKs1pRw5/cdR42n2Qwhgl3BDCxfpZtQCf61KXXk50iBZmqoHoKxT7ESFkP1BdcTCt6+3m+arOqOlQseUhnjLWEnkE5MG0cBq9OYJcwIwxT85vrDqS1gbmj4A4iYmVScCj4piWWUIYsf+n9cqH8lu7gUzlkQ8EkRDvxKCGWMv3XXUjLbDyryx5yFFKzf8Us5nKaB3q3vtRqeNX9Lt34lswoeO9zddXngZaE2ByLAzoViFzGi5618Q0VJMUJIRGwSIAB7ZCeNk38GlUKKYz4Ayset5/tZzMpAI3XrWkx1IBntbboN/HXBEki3U0PKrzoJ0fOiMAD9tGwRB0jO+qXWNcRg1EukuMmNLd9LB+oOhLK4w/JJelwPeIYE16QDcI2KMs1cWgCtPe/9uRN3R0bo3Qn6Xj4hsqldQcQyYsnQfgeP0CGyR1LHNsN89Ds1ggjeg9LNlWfQhkyoj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4455BDA43EAD548666DE4E8DC6C40@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:UqtvPotEAO3gJO2/9k9bfQW18EgSglIP+a3jw+FYhkgDktjHZwNmXdZCWWDVoFngjv3aTNHxhmH/Br3r5uApnBBtA0tE/XSTajxcPU8+wYEcnl7KhIUuTTsqrxdfpHQp3h86pcc+pQR6wOAMOuqW1WGcaGyLi44QfOUXKiFLEGIezdFkVPpOkdVTEcRC6xfitVzYSbbwoUqmqjJDsCnRKimhFQ7YYhJ3kjeB+q/+4neo91/imjFI+swtuK5z1BFoMjQdXuyfysiN9NgezUUQbwD7Rd/r+N0H5DXL9xhSLWSXSkNRpIjFfpQuHNWbMQ4QIWpzmKqhg6W7iurEUGmm/to62VbN7GWIzeWJlILtO9I=
X-Forefront-PRVS: 08497C3D99
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NDU1OzIzOmNBcFdZcVJlY0dOZW5uNkh5NGtaMlhyZ1Bm?=
 =?utf-8?B?NWZPSnNjQm9QWkYzWGgyNmxhcTBkY0ZHRUwxamlKcmVGcnZPQjBZbVdmQWxU?=
 =?utf-8?B?aE5UYldNYi94WnRmcHAzK2djb3IvSDgyb3psamE0MmtYc1VkZkNuSjFRRkZB?=
 =?utf-8?B?eXlKK2lwdWNxVnFQbndUR2x0TjNEY0c1QjJpckpTaGJnaCt0K3dxOE9sUW5P?=
 =?utf-8?B?R3hjekI2cTVoN2hZY1ppbFUzV0RjbXRGSTMxRERqSE1TaVJBaGdtRjRtTXBz?=
 =?utf-8?B?QXc0MFF4ZFovUEN1NW91dHJ5Z25BVys1azNZdmE5dXRlOUlYYlROOUlpUUJj?=
 =?utf-8?B?bmcrMjE1RzZQN1p0RFZwRklmcU1FMjh5US9TQlJvcFdYYzNaUDA3dGZGZDlZ?=
 =?utf-8?B?OUJ2U3VRT294cE1HOURRWWw1L3dmZXR4MnhPVnVmOFV3MU82d1hFUVVSNlBa?=
 =?utf-8?B?ZTB0TEJuQ2hYNE85QThMK1ZDNjlzYnRIUnIxVjFqY0kxRDd2b05nVWYzTDcx?=
 =?utf-8?B?WmNxZkFFcXBnQ2ZQeStJbkt1ekdMZmgvTlprNlhhZHdRRVg4VVlxZkduakVq?=
 =?utf-8?B?THZrT3lrNzViWE1JRUhmL0daSnpBN1h4R1AzV3d4S2xtbE1FcHlFRytWcXB6?=
 =?utf-8?B?N3lmbEZOMS90R2ZZczloTnpLK1cyaExpcDNLdFY1eklpNDVTNjE0TjlzKytw?=
 =?utf-8?B?bytXWHdyNkZ6K0lqc1Q1YmMzUHJzS1cvYUlNRGwxb3FXS0ZGV1A2RVVSYjhL?=
 =?utf-8?B?eWZDWndRTnZKUXUvY1NHM2VkYnh3NHNtS2FZMmlxY2FOenY0ajg2N0lHM0Yz?=
 =?utf-8?B?T2t5V0hVdkpQd3hVUUxrUjNrRFVNNTJGQ1c3TVUyK2xGTDVoTFE1T2ordldG?=
 =?utf-8?B?U1Z1OXd1Sis2cWFFSCtESUloREo4WkVVVHNRVzgvT1pJcjFEMlB0c2lBU09v?=
 =?utf-8?B?SVVVcHlNSXJIWFZNU2hobkdSUmM3WlpScDExeTFtcGp0Y3pRYkp1V1FzUW1K?=
 =?utf-8?B?QkZjZzg1TjRDaVU1Q0tDUU1FcTBtUXMvK20vU0xiTmxHUmdJaEM5R0oxVTNl?=
 =?utf-8?B?V3BibUFZNUhPdEhjRElZS3lWZ2UxcmlJU3g0Qk5uRjdubk1tSkdXUDF4cWpk?=
 =?utf-8?B?TkFMSldMTmo4cWZTQ2NJMEJldFlJZ21ZSVlaczNEQyswZVpaZFRJSmVsTC9R?=
 =?utf-8?B?WW5Ed2pQNHB5eDdFZklIbkVEblRHdXNpSkNGNzUybktrRjc4MXZXaU1PcytU?=
 =?utf-8?B?Uy9nY0pZajAralhicGJvQ1pNNlpXVDN6dkp6RVFjRlJSdnJodHNuWm95Mktx?=
 =?utf-8?B?d1llWTJZSU5pUVBxZXpWcitJaUlIZ2phT0ZlL3oyUG9mWXZzUWdBd1VJZkp6?=
 =?utf-8?B?WkdMVjhZKzhLTHkwSy9QdG9CZTd5ZC96ZGlWZWlRaVAyWEhSaVdkNW96bXNE?=
 =?utf-8?B?UlEwSnAzclArdTdreGRjeTYra2UvZTB3NnZleS9xbll2bklSK05CTVgrSHdR?=
 =?utf-8?B?cmVBWndIRDMvamcrS3hnU1JTMGJHb0dXOUlVcWIva25nWUZkS2tqR0dTMHc2?=
 =?utf-8?B?NXNuNGFuZ2VldC9aSXZRMVo2bVRQTkpuWDk3V1hWZGR1dHpHUThBRmkvV0tB?=
 =?utf-8?B?ZFlaWlhLaE05Y2JWSkhtb2pYM0lvakMzenpBdWhkOUhXVEJSeml6NjFLTlgw?=
 =?utf-8?B?ZURrU0ZvZnJheEt4RitLZEpyS3M4elV5UGowRVNPVTgzc1VGR3JEN2o4ZWZz?=
 =?utf-8?Q?7VCVFIf/Vpux+HCOAitOwU/QXBNnm9dmwXAxQ=3D?=
X-Microsoft-Antispam-Message-Info: dzZsIUHj/2WTw57NPkM6xpcng4YyikM8WKTuIb4ZUoGXn+5zwNk74eqZlNl0y/EAq2GxUbRtqtZ3SSnJQQlMXZytMxik1W9TLUBPd60Y/tZQTxiwwLS2zggArX1/9fMngqSoC4FIox7t/Ejm2TQp2Rwz0q1aia3Uxfk5ZAo0sZH/dUlqJlT/qGbVlyRN6pPt+uoyQ6PGxNLsQ8YiLj9fj65FtVv+9kQh3UqE7mrfBX1VytelfJexnXkKya+wmeO2JVm5a/l/nHZToY5Ak5pepsa1ke46I4ryzda2Q2CRt8eqTbgFj47nTqyN8Ce/z6cJ08BM9V2iEoD8i3zZ+Wb0BOYlpSKWiADs6PWnrc8/bG0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:TFks4rFH+D4JXilyaT7z/YtNkq07BeHyjk14Lk2/faDkcn+pyZc8wNKnJh8j7rKgHBD5EySB26bBbTlx2/bGMLhvpp8EdJ4Xu9PpaQ4pBitODQdXfYhXL3Ikc/3Hgu/6QNOOoVhlCqJHXZ/dvsT7yR8EFU+p8TnL4tqbNF6cGod9k2JiXMHbov7gf5DMl3p0/ytvdx3SBtIX0joaoTNKUsMdeuZ91T0i2MQx2hj14uI1YkRdPxMMvq7aZH8caiV6hm09g7yuLhVcWyBcz5lNjnOO1b2XjUCcvEdlSO3PmhhBF+S/s/Ow/aDCCJdUk4Fo3M1JKxclMjklfvZxMdVJzlU+QgJbN21PqMAAE78TCzRSTotklislHzbisi7xm6Dji4dq4tKOB9D+d7GAJW4mUj/KB+3Ih0eyvQ73GacrzfXvqXS92mxEPAJwLvxf2GH+dy44tvQb8rH5qyCXKSiXIQ==;5:5+4m3qOS4sOwjVhm5IOvMxkIk/4NrhJieioPyLhmXoDm9bR1mbyJ9twU2I55khwStnmAuiTBVPjW9rdH2URCerovBCDuZ0aYVbY/BAvbeMUGgFTXK1EFtXuZMk9VfsGegAXZS2CAkfIiCDlGVudHlooh9ggRYHYvXu7SefFZNH0=;7:Bqze9nN1w4isxrVavbqV5nWgi1cu0mFd5j+32ZyaAtATauYnK3q0tp1iQ26psvisVRjGpOhgpYNvz9HGGfPpZv/AJbVqvdTafvIBvajuSoJYvPwbCIz/8mF53+kpth80TOiSQOfvAqCA5wvL0R+3mA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2018 09:02:17.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b823923-98ed-4fdb-36b5-08d6448fb7e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 11. 18 9:56, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>         ~               ^~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
> 
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Avoid kernel-doc warning
> 
>  drivers/pinctrl/pinctrl-zynq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> index a0daf27042bd..90fd37e8207b 100644
> --- a/drivers/pinctrl/pinctrl-zynq.c
> +++ b/drivers/pinctrl/pinctrl-zynq.c
> @@ -971,15 +971,12 @@ enum zynq_io_standards {
>  	zynq_iostd_max
>  };
>  
> -/**
> - * enum zynq_pin_config_param - possible pin configuration parameters
> - * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
> +/*
> + * PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
>   *	this parameter (on a custom format) tells the driver which alternative
>   *	IO standard to use.
>   */
> -enum zynq_pin_config_param {
> -	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
> -};
> +#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
>  
>  static const struct pinconf_generic_params zynq_dt_params[] = {
>  	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
