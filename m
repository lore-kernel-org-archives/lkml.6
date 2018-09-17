Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A50ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34BF214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D0yF/xot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34BF214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIQPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:52:44 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:53120
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjo4beLcUkSCdXv1sZsvoTlJ7uDi81FrjcgH4iDE6vU=;
 b=D0yF/xot5FHiWpV/ugksBfybXs2KY7NVcXCL3Q4OqnH2nTjVrhWfcOKz/aRpS6/v+AmEeG19LGb0ezsykrwr1/tJZdslmaWEd9JMY/HdfhSRJckt9Myf7V/lwniM2TFvr5qc1RF29I4wZGegvsiyFRcDonqQDRHDW4mq3yvFY3I=
Received: from MWHPR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:301:73::21) by BYAPR02MB5110.namprd02.prod.outlook.com
 (2603:10b6:a03:70::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 10:23:48 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR0201CA0044.outlook.office365.com
 (2603:10b6:301:73::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.17 via Frontend
 Transport; Mon, 17 Sep 2018 10:23:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 10:23:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g1qh0-0002p9-Pr; Mon, 17 Sep 2018 03:23:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g1qgv-0004yF-MI; Mon, 17 Sep 2018 03:23:41 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HANZiD031468;
        Mon, 17 Sep 2018 03:23:35 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g1qgp-0004xR-6J; Mon, 17 Sep 2018 03:23:35 -0700
Subject: Re: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <sgoud@xilinx.com>,
        <anirudh@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
 <20180916111242.73af71ed@archlinux>
 <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
 <20180917110215.00002846@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <469597c5-724f-08c9-ccbc-f076673e1744@xilinx.com>
Date:   Mon, 17 Sep 2018 12:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917110215.00002846@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(6246003)(65826007)(39060400002)(5660300001)(229853002)(2906002)(186003)(4326008)(81156014)(64126003)(9786002)(478600001)(6666003)(36756003)(81166006)(8936002)(50466002)(8676002)(36386004)(23676004)(476003)(11346002)(305945005)(7416002)(63266004)(446003)(2616005)(44832011)(106466001)(76176011)(2486003)(126002)(65806001)(356003)(77096007)(26005)(93886005)(58126008)(336012)(54906003)(47776003)(65956001)(110136005)(106002)(486006)(426003)(31696002)(316002)(230700001)(53546011)(31686004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5110;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT011;1:m0r4/TO58MZFmfufhbhIG3yAJMP/5MxtOimnFL/oyUGGeRk4x8DFoNte5fq/w2EqKgGup5Gb26slyscmdwoFmu65VVXFHiaAEEnq2IwsjQDWth47uxKFnxpMU0sK/vIu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926fc6e3-5eb6-448b-cb12-08d61c87a78c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5110;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5110;3:h6kcmlqlZdJ0YSTCrxVFN+zGEB00ISl0z4XBZwunksLZAliIWjLI1QfiMyGLmzyRBiEyYtU+dQCcoQ1/Q4d6j/SlsnL3I743OZaSEtyvvq4NH29ubIZjb2CHc/YkdZVdvZT3Cq2yojTMANwUkQNpp1qQzsLfQ1PZVB3bHyEh9HopcWUtINy2vwU6qiKBQ8jcTn/toQ4iso+8Kvc33c8vWrRPCD9Ro9LKePycrReqID/jr4W3P7K0GAM8uZarAqh9HP7nTD1YGKvXg1wmMIkwN2fr0T5IaNjWGRGDLVW2yBmonEi15nlxlnMHU/mUiI8yve/11QfZ7PomPXsM+j6XDrdLrPpNGJ4wjBPAS5ZlD5M=;25:SlS3elpmbsY1u26H8Wrs0MoKjHszRAUdwvSc/vOXPjML3nqeT4K0rKntoE1StgaTp6MEdawDzbZvjSItJCwwrZNNMbrYcoLPVKr9191d3jdtH9evB/1Lv+QDJIKjD6zq8teS+U3PoMyVk4SApiOjZco6Iwctk/7ufssvzEbqdD3voh9jOiv+lcylb7gSZljq4lqbYUp0+izcq/nyNcv4wKxl2LDxopCfMohBn04lad6iD5iiKC5jSzdvdu7wNHO8+GUnKgiex4uZHLU3VCbsdNCNlVUZpsJ2Jp/mT25qkFDay++XKoLs9Oiip9mXYeNlSvNrSc0NG4uU1TWpe16FFA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5110:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5110;31:mwgalRqnuahO/QQhBByQyVdovTWWQ4Gj0Kd670PIlp6pWYQxgqcqCDwKldJHonz89VBsMJjTeYf7gFpdOWkSyrPZH6isxqj1dURZtqzK9rRawg9FNYygClGKNsCRBeuUof9RRM4k4qY2eY36zywrbedGuZTxz5OR9y0DrYUddGHiZlDi6v8K6JP0BBLBqBUjancKCUpu4Dcb4GG0Zs6uSPdpHApM/v7DHVv4L8dyoUM=;20:vjCctsy/+Hc1NPEp4QijoPiLCeDEedd0jdhAUtz0BSMSePU8jdqrS7q2rObJslU/Jxmm0vvs/vTypGzr/ZCydJGroMNsI502fYWtaiZs57lukQKiR8k3NGZK64NpeXJqEZWIhRmOpsYMlI8/O28lPo7WtJtSRd2QFqwP6e+6og4V/C9KOSC5W0SSGNF5ub4RcvTMAEScMliFKAFQuhCNDi1hfaO2hWgOAE1DTSCV6u7Bqe4jTDKq+TGIR/GJln7Rduk5QLVvMdqOkDEO3u3jZs+1mO2iNR8abGWXgSvV7BWDnxS1io98bJBQMz6HG4cJbwaR8/6X6ska4PExKs8ynX87wJYg/0AWcLTMnOspXLIxMJ+kRIkvQHSfoemaBvkv1H46Ae0nOHt+G93eX5c6KC5OydgorBxZOt2ndgtvOMzAwJatqeH193NEUzrP2gV3jIT+eZ2ZjTeswsjXFdr5pkTX5jlKlqtwaPAwa/KYe4hdpjAa0lOr9nodMFmr2hlm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5110DE5DB7593C1118B3C9A6C61E0@BYAPR02MB5110.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB5110;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5110;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5110;4:/w1hU5AMr4yVZACNrHxnoscPjXEcZ4iXQGK6mmiZuePXKkLyuvI+TMPrxpswl92eyr2wKaghEGNyzCi4ig5UjNu5/eGuVpMHH7aDX14vdwBTNt/Uatdz+wUIdYrslCbS2WbcF8M216vk1LKlpF6o9gFAfuwbU0Pb6BKRyZkwqlvIuONIuh3SOMi1MJ3xRtSa5w+SPUN3gXFu30UwJRyvR1paVKZqikHrlliRT5ak4hV8uF5BhtyTczsBOQEw7IOpR6itrPlHDFvCR1pf6Rh7bRU7aJ6mQhIDBdz1QDszFabEa81F4dkMP5NUCWqF5g0HOy6lhu72MaS6JTl6IZf76o0PfoEP364AvCOeXP3XDgU=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI1MTEwOzIzOkI1cDBTdzFaTk0zSFdQMWlvTEdxcEloeXIx?=
 =?utf-8?B?Y21mR24ya0FzL0xNWjU2QUJnZEZBREwyV0lDT3pkM044ZXZtMkN3TkhxRFRY?=
 =?utf-8?B?Yzlid2lMUG85Rm15bG1SQVJILzljTVhMR1lUSFNvZXVUd0J6ZW1YL1REL1JB?=
 =?utf-8?B?Tjc1NGJMN2pnQWZkbGtqKzl0ZUV2dTNWYVdrbE1yTUpiWjJLYVBUMWFHV3Nm?=
 =?utf-8?B?bnZBZmxBQ05FTDB2ZTJzeE04Ymt5S2xoSWRUVGF3ZkJxQ2phcm1yOW81R2lu?=
 =?utf-8?B?WDkzTjBXZzkyci9UamJVUC9zbDc4NUVMck5EZEI3Z3JjNmhzMFdxSVM5UXVN?=
 =?utf-8?B?azdkMmNGcmgyQkI0MDQ4NnEwcGtvRTZqbVNCRG5DSWo2SWptS2t6ZkZWRXpq?=
 =?utf-8?B?WU40cU9POE5qemxZWFhjWlZRRXgyaTVWNGhCWHRjYWNHbU4wRDBORXZNTVFC?=
 =?utf-8?B?TDVBa1VFcnVEVUlDT2NGMTZ3N0craWx1Q09tYWxLazBwU1ErRG5MSW1ZcVdj?=
 =?utf-8?B?TW9BMkM2bG9lYm56WEU4QkNlZDYrYTdpUys1YmZka2NiZDI3Nm5sQ2dCck0w?=
 =?utf-8?B?UDZRckFzbmpzMlloZW13ZDlkL3hKa2ZWZk1uOGdqMDJqekVMUjk1UmN0Yk90?=
 =?utf-8?B?TUYyWmpPdlJMaHQ3ekhJRml6TEd4L09qTFJYeUgzNmt1anNvVWZ1S0hrejFv?=
 =?utf-8?B?bEtNcjc2Tk1xcnU5aEhhRzlLVStHRVJXd1Y4TUJhdkpoMXc4aFlQaEt4WVlS?=
 =?utf-8?B?T3AxNzBlZ3Ywb0t2TUR1NXRlU1dBRndnL0M5MXlpVTJPZlhweXcxalJTaXF3?=
 =?utf-8?B?UEVucFRDL3hHS3VpbDRXeU5PWmdXamxHdDNqMHJJd0dVaGl5ZnhDRWs1bEZs?=
 =?utf-8?B?TmVNYTFmbnhPMkFPbDlUc2xzVGFrVGZ1MlZaQ2Ftd1BYY0N6RTJWUUIvT2Vp?=
 =?utf-8?B?UFdsWFd2ZnpudUQwVFZJY2R0TEpqMDNXQWZkZEZqNlNQNkRyTjZJV2tnZ2U5?=
 =?utf-8?B?akxhNjRCZ1NIZ0Y1L203bmIySVY2RTdWU2FmSXJNdkgxR2JNcGp1NG5xVC9m?=
 =?utf-8?B?WXBoQTZJc2tscVVpRnNlL0RGYngwN2dNVHdaeVI0bW5aRzV5Q1FuN0pmb0tv?=
 =?utf-8?B?c2thTmRwenFVOGtmWXd0bzNkSUx4R1A0R0wzZk9xVllwMVhrRWNlLzhqeEEy?=
 =?utf-8?B?M3pZVGFQbFY2S2FyeHNLR2JpcWc2OTBMV2JRWVRBWlhHS2dJMEhiOGhweXV1?=
 =?utf-8?B?QmNBemlQMDhCbEVFeWRLNG5Xa1RublpzRnlWNlBWd2pKU1V0ckVBUE4yR0Jn?=
 =?utf-8?B?ODdXVTFmNHN1Z3NCOHBUdDFxemJvOWR0ZTl6Z2E3VC8yV0VMcGF4anlIZWRD?=
 =?utf-8?B?by8wOXFsMWprb1hhWDBqU016dnMwWExvUnk3bElTT1JSWitZY1lpUVA1azUw?=
 =?utf-8?B?NW8vb1MrN2tKc1JoVkdJbWxFekQ0UTZleEt3SjdRRjlFY0o2bENJSVMybHBZ?=
 =?utf-8?B?MzY3Znh2N3JKSngwUzNjcFlpV0JTZXEva1FMV1N0elcrbjQvZGJvS1orZ1dN?=
 =?utf-8?B?aDNTM0xQT1JqWTFYNXZZczU4QU5zWm1Sd1JYUGg1SUlMUWNjeS9kRmZyVDEx?=
 =?utf-8?B?RlBmYnZ2Z3BYMU5JdlMzcXgveUJqUi9mdk5leHA2TjB4RExJQVorMjBYR2Z1?=
 =?utf-8?B?VllRR3RHUk9McExhV2pBTjEwaHdkL3B2SGpIUDQxVzd6K2JlY1hPSTIxNFpz?=
 =?utf-8?B?dXFiejU3aXFnWWRTTXpJZnFISjB6UEhmeEVjNEwwOHMveVd3dnVpM29CQlA3?=
 =?utf-8?B?YWpjbHlLZ29PRElyVFhuVi9zYXU5bEFzZWFZVlU4VUJqK0E9PQ==?=
X-Microsoft-Antispam-Message-Info: ukQDMGUtt9axRQyW8xcA+aq5LexPeLHeebYMgbC5uqi+1T2K7nD90zLxeS0v7A8zF05XKadFnq8thpWazTVdB/d/nEqDwc3bpO3sul4LW/K+Y+q8iQGir2Nyod6WKyzYG8tAd7hArnco8m240Y8rKl9lRe61m9f0977p0ma9KghS9xhlvNgXwyBTzp4GEu2coxgEvuw+K3veP+FANta09zqZnM3kNUuRrurb8nx/MY4CvDAJUx+HlhG2BFILvsg6PeJ+tdYzHlwO5e41tG5JE6HVmbXlDmRmvwEzXTXvkXMs7DL1TZ3YEX/Lf26iAPyNxq2zpP1BNcrfBEVN+B9tAc5ed5oSpfsSJXj1Z4IdhZM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5110;6:ZjIato9hOwSHr54zDP+OPYR6KwNS4tkdCmv6BJJb0c4jJz+kqJD5f2gRAvBMi3MKrlgPCPHgm2KSfnGKCRk1BD2KuqxFQMbf0wboGmAMjUKzNifxzZUG6eoLQiIL+tv1yFMVnv2RJcj+UDzSGYleYC4nHfn0gp1y6vV+fnkMtbCsWr/MicsFdn4LsYUFgRckNq4W4gj75bNX3GZgwg3Y3o+LDu37wL+2NSQnmw6vtu86SxKMTp4qYijuUpSgUoaC1rInuX1BIWwlWbBtwG5UT6hQSFu4dE+DwnyWOXZpQNmLVYHF7dZuJNUUg8a7Yt8wrAwoUez/dy/uYm+3PQrgz3BehPtmkBlWxIcRJmyyCOo7HqJwZFVQ1biqzYmhsMAIH3tM8IjY/UgfaHrt7X+NTyIvp8HLw53ozeHPuVKP5aiBWpBy31rr42A1UozsOf6fg1+fdsj8qEQWBdEe6ksAFA==;5:DKbKpnfbUVigiQBT4VOEUd5pAx7nmVinbxDKVrL7RhqQpVUKskXmpqmHpdq8GNkZfrvBpQ+PZdrJU8d2S4eJ546zICKWRxFsZ1ujmq69fxpg9xAtpR8C9vJ5k3VcadNKxtH8bqUjt1MXefnMjOvSO0qbRzdPzUDq/ZfEQXgRcWw=;7:FYTeH1GBa7bCFs3D/kdSIdMRJzP820UwSe/JMwmpBXCK+i1DeyS9HG0ulVKJhtt4dc51Ibrd8OrCkWEnaoqpYO0aoBR+5EgfB1Nn6JPPPlbDRckCqqqIEhzXEvD6gwyH7dl5J3+LxqXvv8TO5SthNs0LzPlyClkCEpgu3PAPHW+e5ciOXAtxujhfEUu51fCJ1OYQ1f046DO6+kmRZRl+oQ/vf7pfQK7TphwWM3IESADUjP8TKSt2hnZ4T8IbA3vm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 10:23:47.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926fc6e3-5eb6-448b-cb12-08d61c87a78c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.9.2018 12:06, Jonathan Cameron wrote:
> On Mon, 17 Sep 2018 11:56:08 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> On 16.9.2018 12:12, Jonathan Cameron wrote:
>>> On Fri, 14 Sep 2018 12:48:28 +0530
>>> Manish Narani <manish.narani@xilinx.com> wrote:
>>>   
>>>> Add documentation for xilinx-ams driver. This contains information about
>>>> various voltages and temperatures on PS (Processing System), PL
>>>> (Programmable Logic) and AMS Control Block.
>>>>
>>>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>  
>>> The more I look at this device the more I'm convinced it is very much a dedicated
>>> hardware monitoring function, not a generic ADC sensing unit at all.
>>>
>>> Hmm.  It is still fine to have it in IIO but you need to think in detail
>>> about how you are going to interface this to hwmon via the iio-hwmon bridge.
>>>
>>> Some of the interface complexity should only really be apparent when we hit
>>> hwmon perhaps rather than having so many different custom interfaces in IIO.
>>>
>>> Please also loop in the maintainers and lists for hwmon in the next
>>> version so we can get their input.  
>>
>> Isn't there iio-hwmon driver for this?
>>
>> Thanks,
>> Michal
> 
> Absolutely.  The interesting bit is that if we are planning to actually expose
> the many monitoring channels via iio-hwmon IIRC it won't use the extended names
> at all (I may have missremembered this thogh).  As such we may want to reduced
> the amount of custom ABI in IIO in favour of a level of opaqueness with the
> 'real' interface provided by the iio-hwmon bridge driver.  A quick glance
> suggested we may need to increase the information exposed by the iio-hwmon
> driver to make this work.

ok.


> When we have run into cases like this (a very much hardware monitoring oriented
> device with a few general purpose channels) in the past we have always gotten
> agreement from the hwmon maintainers that they are happy with using an IIO provider
> and the iio-hwmon driver route. It is just nice to keep everyone in agreement
> and have no surprises!

Definitely I agree with this.

Thanks,
Michal


