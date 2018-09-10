Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7468920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ig//qMjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeIJR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:29:20 -0400
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:46816
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeIJR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEz0GQzegwSFnDkU6Lp89jyGVn33/JMRZvIOa7vZIqQ=;
 b=ig//qMjSMcO2lpeE5pahjNwPVgkENYD/OQUVOy6URhwfQ7iS6aiWgPIbHA+vOmywBlWfB8wtUYdZ27R0NLUBjtU4ydU97KZcOw3hjtPghuAMOXSWdT0CWF1HgHSPnZirWgRyVZTx16W6vTeDOisGNHMul4wMKiuSwtP5YqV7G3I=
Received: from CY4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:903:117::15)
 by SN6PR02MB4942.namprd02.prod.outlook.com (2603:10b6:805:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Mon, 10 Sep
 2018 12:35:24 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0029.outlook.office365.com
 (2603:10b6:903:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15 via Frontend
 Transport; Mon, 10 Sep 2018 12:35:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ettus.com; dkim=none (message not signed)
 header.d=none;ettus.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Mon, 10 Sep 2018 12:35:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzLPW-0003h1-Jx; Mon, 10 Sep 2018 05:35:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzLPR-000580-GE; Mon, 10 Sep 2018 05:35:17 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8ACZ9h1016011;
        Mon, 10 Sep 2018 05:35:09 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fzLPJ-00052i-9C; Mon, 10 Sep 2018 05:35:09 -0700
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Moritz Fischer <moritz.fischer@ettus.com>,
        Olof Johansson <olof@lixom.net>
CC:     Jolly Shah <jolly.shah@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <matt@codeblueprint.co.uk>, Sudeep Holla <sudeep.holla@arm.com>,
        <hkallweit1@gmail.com>, Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, <rajanv@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CAAtXAHfwpKagBUQSFLJ1bBsxvbvyg=+nCuQv11eD+nhuxD=1_A@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0bc8f69a-2d44-7ee2-133b-29f6dd4c0929@xilinx.com>
Date:   Mon, 10 Sep 2018 14:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAtXAHfwpKagBUQSFLJ1bBsxvbvyg=+nCuQv11eD+nhuxD=1_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(438002)(189003)(199004)(106002)(305945005)(336012)(8936002)(65956001)(65806001)(8676002)(81166006)(81156014)(316002)(23676004)(2486003)(110136005)(58126008)(54906003)(36756003)(47776003)(77096007)(65826007)(5660300001)(76176011)(26005)(2906002)(6666003)(426003)(229853002)(186003)(478600001)(53546011)(217873002)(50466002)(230700001)(44832011)(356003)(4326008)(7416002)(107886003)(446003)(6246003)(39060400002)(64126003)(106466001)(486006)(31696002)(63266004)(93886005)(9786002)(14444005)(11346002)(2616005)(126002)(476003)(31686004)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4942;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT016;1:9SFJ5HSPoWfbwCinFWHjGzPhUxojRbmwh13Fgui11ugBfuRq1N/NqmNRq4y5/AQVbF1sbpch3Ya82jWCGzlGAsyUbDqjbMnkR8OykdLfxZCXe8dxH1lEsMR/1Fb/kWRc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9ddaf7f-7e2d-414f-6474-08d61719e127
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;3:OqJKhrr8KJVXBTmzgPap7Dny7YJBolWXXUKj84pfRSbaVmDJmAbDxCe++8hcnc+jvRzIHDtqZIUmln40xe6Lf4n91oJqIj0gWOBYTRQlmmhBMmsp12q+7F/2D2hG4pUrTcXrYuitTpCzRnv0l536MLQ3TIT9EkQKuXqG4Evfpn3zDvJUxqU2TzbKuQox1rCj87oGIAhzholoj187JJfyzNROzZgxY4r9XiVK2FzBR7y4QSJ776I/jR6AVW9r02TkquVepeQ8rO07RxXnIM7FqckMATRPJTP3eT56BpKih1Y9Y6iNMQ+DUq6dATCHl3WYEVPp7y13tndmwlL2cPtmgueEa0MlsfK+/d9hHc+dSn0=;25:EBAfXFtzDLBUvluQ4RDZgOAtHddy1LzvDLK9gre9ktkkiy7lnlECaOqh8NZTjByPF+eKZ+p/ap7UZoVRXRMNfy7/ip45/eSANYcwhBqdV3OXjtrp+pU71dNftRgDO4bE5eVOsc/p/IO4d9RTTMs6kUA7CQPwnsvmc0pI0edrj00jTPFl+gJcVp0Vl/pA/ciK1eDkmipHoCkEMHPhWAeM0HxH0/m+VW3S794gMckXfl5StFR19Dapuj/uFq38hDrpeJbJcUprrszuTGypQ8xMxifU+zcqTrVY0FjSTvRyhgRyhoFQd/O+EE9rsjzXaVMlHXUQYCswRdowISpu1rcrWw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;31:aA9kMRPMnucWlsmcnmpbcsxNnlYT/zVH3orQbz0IdV0idg7uOBgM3lcLDg7cLktDA6LVBC13gat2GGWoyjWjstGi2HAciw1pLQ7tBXpNGH5GIySxx+j78QVx8BAfXWkCb9N/+2uWPpfbVmYQnn/q3he4Ip5GGGbJct+LBO8WfbhyGWdBs4r9CWK3JS/JWWLXcz8F7TNapTYl5FlwsWd/j23fuPu/6BzHUlOnG65KoJs=;20:s9vnlik9wv8UQLY/votJ6JR3OKUiRFSz60709QN1N6logZM4EsZpLANtuu2BHlYG+pr/Si3xmwY634XtlX8Avp/6Wk6JgpsFxj29Ttplqm++jPy3bpNzthDxb9jMaUAxuEnEFegL6LKESFcfUaRr+cLZfdHVXYpoL8f8GqvtfPmO2UAbbAGVu/hiQSG8gcCr4S2YzUCaUiKXpZubvVgDYyHlgSkLniXZfPFWAJ4dd+SofjBPLjYUplKM3YxHo4/RSGAmlhsCIs0ASbdWJf2jS3AC+4aYThEZT+w2g9BjUhLpwveS2L44DFH53BIlgwqWscS6cv8kbR+2fdZsCK90QiUhpFD4ZUOko1gCMUIFl4EgTbXAJn8pih9D+HGfYKsoKFhcA5kdaTOTY6ntZMWepGjYInQ9GnS/zVHYNv/EBY3znkvjesHdynPc6VPO+MgUiYXre5HiXMil4WEbclffcI4Tvjcc1NbTamgj+9Q0WayZqOJh0RFgzrgIdeMLjrC5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4942BA2DE24BCF14FB184506C6050@SN6PR02MB4942.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;4:5qM64FuUYXGWT8CqRzSoh3ugG13TB06E7C3zNRMOSXhWita/7J0SI/MY1aAM6Z4OVT9UKqe3+61mQU/E5fAA8Pq6bSeU8QU6NcyET6Sh4ef7DBX78ojdP/wEIVrAMP6RKJRA9+n2DG/ZVq9G1OzRfOLX1abm8/VvXyikYiZ2+pItwMuStATyTC1+mRB7vPHwYcbNu2HmFpzZ0KtfDuVPDIqNDCwx759qAbxeS8w/opp/xKhBEiY/lBdt456uUEbqdww2cAtnndGecwYuvXXch26pPVcs7QdxIfrQOC4SLBFtvmpuNq5MzzKdIMMzJpZFL1x0AHauhTLrc7Nt1d9bOOyVUK+y9FlLLdTlCN1x5UY=
X-Forefront-PRVS: 07915F544A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0OTQyOzIzOjljMXhSM1l6UVQ4ajZYeTRaYjRGQm5SdHlO?=
 =?utf-8?B?UDd4eFRmZTN3bjNvQXlUOVYyTjVwN0NwelRsYU40Nk54K0F2MGdFNjJtR3RM?=
 =?utf-8?B?LzNqTnUyNmpRUldpOTNKM1RyQ1poR1J0TWJ2VDRxcmFWU09Za2JVZE9nNURq?=
 =?utf-8?B?QkIwZSs5RysyVDVxOERiSHFYOHRSRTcyenBZTjl4TStEVWVBT3lkWFYwRk0r?=
 =?utf-8?B?UU9TVEpQa1pXZGpPQk9JZXF6MDlKa2tmZFozdzVnc05JKzd3Q01MSzBkcXdC?=
 =?utf-8?B?emd5YXJQMGF0WngwRjgyMlgySklvWjRNVWhWTCs3ZmJOR0YvMklWSWcyV0Z6?=
 =?utf-8?B?NkRvQUZjVStYOFJ3WDNtZXFBVWpqOFJ3aDJkWk1vcmQrMm5ZazQvUURrTkE0?=
 =?utf-8?B?SU5ROXhCVHNkUnNrYVNWYnpMeFNBSGFlNFRCZFdxUEdaTGNSWW9xNzZ3Mk4z?=
 =?utf-8?B?eUw0YWRpQThXZDBZWEcyNG1MeWZQOU4xdW1VSGxpbE1WYU5TK083cjIwSng4?=
 =?utf-8?B?NEtYQVRlb1NXZVNoYjJ3WWhQVWNUSTBWbE1nVmtucmo5R1k0bU9aTW5IWlNp?=
 =?utf-8?B?eHZjQ0t6cVdESWwyaFBiTkhTbUsrUjBTNXBCUTlKZ0ZGcmNuK0hZVXNqYXZD?=
 =?utf-8?B?aDU4a09qc2M2UWt0di9GTTJMQ3JQTnM2SHRxc1lvY3JGTFRrNUxQdm93WDZN?=
 =?utf-8?B?SjVYdE96b1pzQUNuWmZnbm1uRXlkMWxlOWJteTFSMzF6eUJRWFN3enBUcVgr?=
 =?utf-8?B?L2dwZXpKWXRVZnAzNU10WFFtVmQ5cURkZ0ZKT3FCTFQ3UFFGamxXdExvL1g0?=
 =?utf-8?B?N01WdE0vR1ErMzVraE5ETnlkT1Q5YWlVaGlpZEtIN0ZWbUE1QzhRRXlWMzVV?=
 =?utf-8?B?Y1JqNGY2SGE2N2dDWTg3VDlvZnlIcFAzem1FeS84MDE2SUpKTG1mMUlsQlBy?=
 =?utf-8?B?Z0l6RHRlOGhuRGVsaDVpbVc4bkxJSjBWOVhiZVBJSWYvMjRZSHp1a1NNd21D?=
 =?utf-8?B?QTNrNmpDTStuN3N3Szg5ZFBnd0w0d1l3aGlXNTV3VS9FZnNCZzJtTHh4ckVV?=
 =?utf-8?B?QVNqOURrV2t3WVNLU3d2dFk4R3ZzMVFycTJEN1R1NDdIQTZUVkdWOXF0RW1O?=
 =?utf-8?B?endCdTVSclpwUkRyU2o2MTFiTVUyMEtrVTJ4K1RIS3J6TUgyOUNSZzNQNjhG?=
 =?utf-8?B?TjBPcGpaQVB1Rm5hZXprejYyOE1oQ2pTS24zU002bkZXKzdXbVlHNlVuQUFP?=
 =?utf-8?B?SUVibUF4eDlSTm94RjJwVEQ5dHBmSDF1K05veW9vcHNoQjFLblB1cWROV05E?=
 =?utf-8?B?Z1EwcU5TQm5aYnRZR0RpRmprZURoNXRsRy8zZkFpeXN0b0UwL2NxY0d5T2xq?=
 =?utf-8?B?TTNzR3kxdWNHNldJUC9jeTZrazc0QWh4NTROS3pMR1FSOHFYT2lDL1VrZkYw?=
 =?utf-8?B?cWRxdXU4dVNTMm50MnM2eS9mZ2JnSm9XbjVrTkxUTmhsQVdXNnc1by91OGlK?=
 =?utf-8?B?bFp1QmJjSldxb2Uwb0ZVWDdDUXArUmMvdHRMeXpsU3BLWW5aaXJpUGxtd2pB?=
 =?utf-8?B?bVFmZ0RrUzJsb0ZEV2IvQVU4Y3JiaWpxZG1WM041UEJOWUFQRHhETjhSTWxR?=
 =?utf-8?B?cDdWbEJmSlV6ZWQvcGdiRHp4bmRTMFVBYTdST2hKMXdWV0MzRFE5VGtTSjZL?=
 =?utf-8?B?a1NiOFRpOVBYd2ppWkllMVVyM1JHUDJRWWVHUGE1YUtkWVJ4REltZVhwZmhh?=
 =?utf-8?B?WGlaVkJMUWRtVlNqL2hNa0gwS25xMDBJczFQSjZnWkplRFRyQXp1cjZwWHJa?=
 =?utf-8?B?Mklabm1zNGJmOG13Skx4M3A4SzdaWnJKYU92QWx2aWlJakdsVXpNaUM0Z3kz?=
 =?utf-8?Q?vvRPABMlqP0jSFgysS8OsabD7oj94ADh?=
X-Microsoft-Antispam-Message-Info: J9Z3JRTV5DqeieXx9Ixt4sb5C3oIFu6w3xNMCMCsKl39jN46nASZU4G6Y6j6QjkdYDvLQur3W9ZGzucleN/T/uDiqFKV07t/dVcSz93cHd8N6OUUqyiSMnLlV0KE+vGqNbjFq97mOoZW/mz+jA3RzaPaGq/LmLk7AUCsuOAklPH+Pcux+PMzbdEyUsWNZieY8H+hMrEQLouZtk5uXi4s8A/VyS6Zya+Ab/obSxywbpsaMSNsitNgMKtOqtivUxxkAvUcFAY8V4sQokim6esNT5r+utNkTYfeJ1FbmdlQhTLLO2d1y7FobxBZttsgVHGC368IKJHftCJqaaHbDgSeIxKzjc4GiSaqRSN24PWbMEs=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;6:u8U89VrV3TPO9hffl8P4bYTeQlu7f9QkEIV1UtcKdocIpNewaJjGd4Ff4uAH8JtLiGN9HLEvroBNXftnTxazvbfaelJ8et2M62TzReWLQPeOsJnboruqrA4CSJ/n4bUu9OjRPoB8eNcs4LI1csW1usbjxK05MowwF12lrNqFSmqgRCqq5PiAnd4WtdbK+JS7weXpQhagLGT9pgOWN2SI84h+ruXqtCbyNC3pUg3quWw9lpfSBntG/iNDDWf/68qHN/GPO5QhtViZ/Ho+oDMYa0LhwLmtW1W2mWJn1mfs1hLt5Y6g+WyzxDNzK9g2WMF2OoT8vwg63HiImEtNR0f2bUrmKNkVGXcWShq3DeCqHg7A/wTbxg8yPoEQyUJDsLuvge5R8Ut84yUCM/h1Vo84sJZHcQEK0l19yWrtWUaWcYMv2aSepIDNynX8GvSjMkY3yiA4miG8WKRfYUBt90Ue5A==;5:0AyOr0IJqr3lQoo8/BLJi9jrdRv+0bAAIfMDHnc50FaKsbONfbb7fIVGaCF9WUV3s1RMbp6mDm93KuilK1/a8a1Qn+JkhVs9h9JQ2NMlwr9KWAmsE8vx0ndecW6b8T7MXgSLJWhIOa88hZjdrCxD2XgkO3m29+zvyuN9/NrxM9k=;7:iBu+OBA+Q4tP7ivDutaFIH+YwevuIAo8iUJMKjuJ5x3qMXJoYEiDNGPRLUp0GnCjLTb51tJSvA+b9jOoM6XXy5ylaJlgydu/6oFFMz6jyy+OdxYHFR/JMkfSiez3cQTzR5sYqJ740paxZTA09aGGalErWf1/MKKUp54QhmrJ4+dBjAhL6XOMhxJVjff5ogVWOL9n2h7WcBO0Xnf5pZcVRT6XijJUkkFqI9jzlHFMfuDIuixlxDJEUXwfov7GhaSk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 12:35:23.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ddaf7f-7e2d-414f-6474-08d61719e127
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.9.2018 21:20, Moritz Fischer wrote:
> Hi Olof,
> 
> On Sat, Sep 8, 2018 at 6:18 PM, Olof Johansson <olof@lixom.net> wrote:
>> Hi,
>>
>> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>>> From: Rajan Vaja <rajanv@xilinx.com>
>>>
>>> Add ZynqMP firmware IOCTL API to control and configure
>>> devices like PLLs, SD, Gem, etc.
>>>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>>
>> This patch worries me somewhat. It's a transparent pass-through ioctl
>> driver. Is there a spec available for what the implemented IOCTLs are?
>>
>> Should some of them be proper drivers instead of an opaque
>> pass-through like this? Could some of them have stability impact on
>> the platform such that there are security concerns and the list of
>> arguments should somehow be sanitized?
> 
> I tend to agree with this, good catch.
> 
>> What's the intended usecase anyway? Just a debug tool during
>> development, or something that you expect heavy use of by some
>> userspace middleware?
> 
> I suspect it is another attempt to make userspace clocks/plls work? Scary.

none is trying to do that as far as I know.

Thanks,
Michal

