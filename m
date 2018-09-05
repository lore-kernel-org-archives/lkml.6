Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81CBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161E2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mayAGhVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIER6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:58:08 -0400
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:37472
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeIER6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhT89BPDW3x5IcioUND9s5ACpf4ggzv7MBDK2/na9+g=;
 b=mayAGhVQJ0dSvUtR5zw3q4IAxwiB0tx+WJp7na3rAcm7TGJArgNJF7fgksL7/c3cYORetYj/K7K5WgBq4GKetqaAiIOXK4cGY3PD+tS6bNSvOhrSRA9yn2rWwBROXL7YQwM77JqsKob33sexmHA6EyR4dRRj8bLeWMe/vt4aVfw=
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by BLUPR02MB504.namprd02.prod.outlook.com (2a01:111:e400:88c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Wed, 5 Sep
 2018 13:27:44 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.16 via Frontend
 Transport; Wed, 5 Sep 2018 13:27:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 13:27:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fxXqR-000470-4J; Wed, 05 Sep 2018 06:27:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fxXqM-00063T-0b; Wed, 05 Sep 2018 06:27:38 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w85DRVbo018879;
        Wed, 5 Sep 2018 06:27:31 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fxXqF-000637-31; Wed, 05 Sep 2018 06:27:31 -0700
Subject: Re: [PATCH] ARM: zynq: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-3-robh@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <147b3be7-805f-a0af-8da5-04f257d2b919@xilinx.com>
Date:   Wed, 5 Sep 2018 15:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-3-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39850400004)(2980300002)(438002)(199004)(189003)(77096007)(5660300001)(230700001)(64126003)(65826007)(81156014)(47776003)(9786002)(8936002)(6246003)(81166006)(4326008)(36386004)(36756003)(31696002)(8676002)(50466002)(2906002)(54906003)(229853002)(106466001)(44832011)(14444005)(58126008)(110136005)(356003)(63266004)(305945005)(316002)(106002)(426003)(446003)(336012)(478600001)(476003)(65956001)(65806001)(53546011)(26005)(186003)(31686004)(486006)(2616005)(126002)(76176011)(2486003)(23676004)(11346002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB504;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:EWdzA6i5ccNvYrsvgBKYC6UmcREFjyUt1/+uOeh3cYUETsGLz4JA0UzelhuU8uuSngY075A6ecM4XNVnNhP7W1679JE11yUHknmMz0OCEa3Lpg7XmzKSKat7tHNyZPdj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8639b3b-d4ea-4896-48e0-08d613335c98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB504;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB504;3:rQN3A3mAkbLXpITrFovSDVyRsGcu/qroT2VoEKnAprWLDtkSXvCoDd/KPclUvDzgDF4rT7mEwltgf80qfD+fx0NyCDXGo+7XCSMVZc8vm/nYBSxbn+OW0lRb3/+poTAMe17UcynA/pqwkm1qCI4zFS7IXL/T1IIc8dM3XQBKH5UAXzDZLSAZAbkzHKGLYM+MDHqT18kYWVj5rm8AOcCVXPV8ekgIDS3SHwkfa1Z+2457iuLD9dnPs/8gbRE46AnIR6djYPB4Ke8vaRTUJbT41XooHiO/rhEDRP8GWe6L+OCQLD/i+5CfLlDOLFk5ynejH8c//UIR+Oy0cwxITmMfwOm1H2ICRRd3iTJOSyU5Gbk=;25:YYYiBfzZWTg8saSXwXxk/uQLHE/CEHKmI0k3MTQflVhr42TvQJw5h+CD15DUk49iIdW5jTxrVYGM8JOdjWqJyZzeIdXsxzGzyr4Rx8Ar6f4TC1i4o5PG+uQVPJQI2f6LHdDRh0AfY2R7F4BiIpyliUMqSXMddLWh2tEvm0qq5Lm6dJWHCNnGqcH9MfwvA1w2CFjQyqOoe1/KBTvlxf0SRf62p35aXDEdnAD5eztkosguu6xm6jvnKd5qHrfZ9j/WvEYpE9bHUEYkqu3ArEuDDGsaqiJxi7vbAWU7aVXk61p0nqIOaxyWKaJZa12cJFmXDwEZic0ERc+/k3CgUhOrDA==
X-MS-TrafficTypeDiagnostic: BLUPR02MB504:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB504;31:SHF3sseuYgs2fbdsnTrz4EWkAc7EG9VJGwbbAHZ+oTjG8RndgIYock9D20KxzEXUXZBKD4EuyzeunullaEl0ZQmev4fyOIBi4jCsbqkGwjQqTIPrQWyPqEq8rK2VuwZS2I19cX9qnZn90P/Y2qS4np6xiuWDX04VkBwuyeuclPeQq9cyKHpA8DlfOEGUI1X5PmZ1A2t5/EYQiNWNKhCfkAhuF2VzRw1yKWI9y6vL6NY=;20:Mfc2vLvNQusyGEhd+5JquhtNVH/xxu6KSHr5FsqGi+U+hBeck+kEvafhMbFQ6mKcXNbCmhzdb+5kwW7CVfL74Y12V5b7rIcLZVtwEv69gIPv0vPaPYXqFHXM6anGR7yG/eUx5e+/N+7/iGuzBGa2NhJ8NOwlbJin6rNOubz3WH2/IrErdZe11+EnxH23mpghaRtvLcBAqN7VVyab/feuR8zJntwPvY9veZFenLHZAajRsdmu9tADQdecqfnO73NBnBaLQi+aIWv1YQZIuri6IkXYJ+jBdSnhSQVd3sVM+PRueLTPostA0vwS5zoxLTbFZrvc9vwB2qBm5q6Sq42cf/A+vGNRjqLQqt2pGZF8mxI51AWmuE7tgJayXazbTux6vvffbf9FfdxVMF8WAJWhr83gZZw3ppEjrd6z+kzxhjf7oW6DAVRKqMlzke/ngpjIPFDKl/QQpYiSC9Zddmfik0VEtdoMQFLW2jpyi0Zcb0h2kzKlmyUELq2rK63SxDX8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB504E8BDABAB9E6732C543D7C6020@BLUPR02MB504.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR02MB504;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB504;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB504;4:hK3Ztqz+qu0p4kEfs+6jgYKwtSWsLCsk8kJIiosDz8yZT+5MAg1BOEvTQTrI+N7t4KqD8hX0WvuZDJy+vzOidVpdvIwYBaDFRQlxc2Ou0ri3uOI17lO1qItoUx9oxp05gqhUB/sDKqH7EGX4jkvhI4kVV3v2S3+sGHv3975qJ9O5KfKv56p1QXA1LFkxXBQcXI8SeBruRdvJiN3wMXN+iO46tVgTnl9eLgR0ZvUSizBZLTrbyAFHRdZwwzULnNcME0qIh7KQjQtcE2lh+C+VR32eb5k8xymC9neQQoBfnRU3UI1ZOdQrvNhOYBIS0mxDW6jqh/JM99xLYPkSJjR+VqpTzJIOajqm/DNLNpp4Uu0=
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAyTUI1MDQ7MjM6L2s5TUxOZE1RZ0hReHZmbHVYZm11S21WdnYv?=
 =?utf-8?B?dXdyMTVKMkx0OVI5bGMrRGJHN3hrU1NNbWtCcVRxaGJ3dkhQQzJVUE15QW5H?=
 =?utf-8?B?M3RpTVQrZHRoVnlVd1VKa1RRVVhPc29TUzNsbHN1MzlQYTFnL29XdmtMYU93?=
 =?utf-8?B?dWU2eW5BbzZaKzVGMVV0RmZScXA5dW03dkZoZkdjaVBPYU40SjdJditBUmxy?=
 =?utf-8?B?WWI4NDBZN0ZBZjdRMFVDKzNFMGJJc0NIdEJvQW1Wa3U3dGlxVnUveDh4TVNz?=
 =?utf-8?B?QVdBSWFIWm9hdnpHOVgvMDV0U0kxa2V2Zk9ha2VIZHhIQ29ZQ2hyNTZDRWxv?=
 =?utf-8?B?R2djdS9nb2E4TGltWWIweHd4eUpkVCtVVHkwbkg1U0RTUzJRaWlXaExWaHFn?=
 =?utf-8?B?bTc0N2NmaFNKdjYwNFBnVW9yRDZHK3c2STBaaTZHRnMzSEk3SHVOaXJ2dkxk?=
 =?utf-8?B?Q21ZSzNKamhWTkMwNm5HSEdFNnM5TDFXYlRFMm4vTkVBWVZRZGFURUhoU0Va?=
 =?utf-8?B?U3Y0Z2FKckxHWGdjWGl4RVNIdXZTRGlhaGlvci92MDQ1SzlYMnd4R3MrL0ZU?=
 =?utf-8?B?dE13dS84WXF2RlZqM2NNM01QcnB6SEtBbWVsZW41OGVTMnU1RXZybUIxdjFt?=
 =?utf-8?B?blk2dyt0RFYvK0htdFFvN0RzbEtzRVhtbnRQdTVuOXJ6WVRsNUJiOGFRZnIx?=
 =?utf-8?B?bDRMbXdyT2ZLQzRyWHRGYVFQaDlDVXhrRVNxbWdTR0h1OE5TWit1SFVobEN5?=
 =?utf-8?B?ZEs5Tld2TW5BZFk2dkpZbXBLcmQyakljS21TbnRLSEhGTDhWQ2xaaDNZaS9r?=
 =?utf-8?B?b3JxeGFyOHhIZVY1QW1oc2dKRUJZRGtxUkR3aVFhWXVkZ2VtUEw3NjZaSUlx?=
 =?utf-8?B?bXRQbGlKMzNQTGE0MUFNbDg1MHZQb3YyWkRySG42YnQ2WjZFU0NodDB6RzM2?=
 =?utf-8?B?MlJLdHY0SlF6YVNUaWxtWm0wMjNTTE1WRVgzZHk3Snoyem5CZTRERWxrMW1s?=
 =?utf-8?B?S3FqRGR4SUswakIvUTQzekdiVy9TUUdiZ3JKcDBrODg4WkhWT2hhV05kTDJx?=
 =?utf-8?B?WHJ1a1BpaGZNRmxSelRsc1dzZEpTODEvMm8wS3NiNlRpM21NT2cvc2VPRHRo?=
 =?utf-8?B?NjRvaDZXalJlbnIxM2o2R2ZmbmxEM2lFR3pyMTdFaloySldTZWk1UDd3Wldr?=
 =?utf-8?B?Rm91YTlPQ2FDR2s3TTdEc1ZOVnV5bEZYTU5DRjhBZHUrRE0wOCtHWCs5K25N?=
 =?utf-8?B?RlBNWWZmbFV0QXI2QldwaGZNdVB2Y2czN2haNVBqSGdlZ1ZzSDVrY3FrMHdD?=
 =?utf-8?B?T1JyL25TdGwrNjZrdklQc0lnZjNkTXBOaEFtYWJvVmJKdjVCeWt5VEJwZ2s4?=
 =?utf-8?B?b1k3SmNpUUw0eFc2a1B5RWRhSUhiZkZBY2RWSnBKL0oxZHpxbDUvUEo0cE9Q?=
 =?utf-8?B?Uk9wYmtFMkdjTEd0U0RtMWxVemtJSEFKdlBCaWFPeC9XWkd2bzg3MzlObVpw?=
 =?utf-8?B?U0s1QU5VenFWZDVsVi9mOER6TnI4QUFoQ1VzcGVpQzRUMVpVNjh2NEJjSXBi?=
 =?utf-8?B?MUZVelJTNEZXSDM3WTBid2FLeTRXYzZCbWgzeEFJTldBTUs1T25RVEhlM3ky?=
 =?utf-8?B?Vlp3NUJnbHpMUDUxNGhaWlJydjlFQ1UvMUJCM241bzI0ZHZ5alFDUXJIK2xx?=
 =?utf-8?Q?uycV+7ecMGZnF5t8onHNIbLqJ8J8tIA0wLhMSi?=
X-Microsoft-Antispam-Message-Info: mfYvGpZri2U3PVOUQiup4aTVOGmV9WX3xH7WEvYV715sF+THjfzj8aZIrXKPrGjbrn6qzSaM3vVOm5/KOhwMhQx9rxN/DoVwfHmSxRma5acPgMkQ84eU9+2JI2d3UwZMHXmo8GPBg6yC9dqNlwIalfgZsBY3ZJpNciPuZLF3T0iMHM8SFoMVwT9GWtfocVvYvepY5HMjZGbIDuwPiJsrgtjPQ5+Lxf4z84MQUAEzKnxPs+tF2U/IVkIGT7QUcLa0dGD35Gp/xfaBx1GaanzAFn+Bl3z/CMtJ8v2OntES9OAIF/tdMzx23vjd9lQOpTg1Yv+gRFbOKX18CrshUt3dDYhjoSV+hfa8E2fOQi3oeSc=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB504;6:jffjs3NkFemQG1ogW0gf4pWp8R8kweL4cutVrED4Nj7p3iIenKKtRbT9A64THt9dZtmlx9M5vFUnwFksdKRx35YQmAjGrlcSloeARe4ClyW+7d8GzmnOQi8KQLpMPTUY6lmbgGHn+vma+2G0cO2712zZiKfx/nPSXr0M8pLa8A4c3JSUBXFtmlPbhQO89/lxjvZ+I65W8q/ICs2YjYeXJLoQL/7/5SbFtenFmso1f+chVhueguKq93Cm/8aB//x+QEcFsjkJRPPxqHokC2CwuFktM80Xdq4C2AxDOJ1ENus226ltOmpQEpZXsN9I45EjGevtiwm5shWKIyFBp+VBwkFN+uAfxKgZ2tacM9SCdDAiZFZkTCzdoFcUso7cc3ZktPvNasn0y12Y2UKMaRHlRUFmPE1L85zvXCmF+uX9T1zObGmgxaiablByoRdamxIHI+ZrMpgIn3UgtDUac0CRZg==;5:YslafmP3zo42Ti04F8fHSRSgravBFUpwMRXMRvoikIsHt6MnfZxLeQEnE/uQ5rsuBDYI0zZ5F2ltTfQdPYZMMhyRcU3n73+mE4W1zWYCfZurjBY8Bky5b601eFYnEmK3vbY/Dy/8jCnifCidb6a+IysRXoaP5CE6mO7D9Jf3ews=;7:6R1eT0fKUA/p5vJUuRFqS6q2rg97PgkiQs3Ms+085+hppbZHoguq1Z3zTd2ig5wsPLdbrNYNVz5gNLdA53GGEvIT2qWLJGuR63aNrGvmFmfGdCQeVsMDb2iSW2fFoj02U+fMGi/EHXnK2OL3y3dVxJYAKSLXxC/PkGRRJQ5VgNhOJGAtClB2/Yl/mQmrh+zxz6j5CLoySH65AdTiovrxXMw/Zch45+GTO9xc8afcDP30vmyO4V3s+UCMxo44bYlf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 13:27:43.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8639b3b-d4ea-4896-48e0-08d613335c98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.8.2018 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-zynq/slcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index f0292a30e6f6..10ef99ce1d90 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -233,7 +233,7 @@ int __init zynq_early_slcr_init(void)
>  
>  	register_restart_handler(&zynq_slcr_restart_nb);
>  
> -	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
> +	pr_info("%pOFn mapped to %p\n", np, zynq_slcr_base);
>  
>  	of_node_put(np);
>  
> 

Applied.
M
