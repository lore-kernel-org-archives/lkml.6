Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C2320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BAj5nPs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C2320893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeG3Kdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:33:37 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:37376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeG3Kdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB4yZgwx5gH69JWKzOGaYp/FnG7HahJ90TuMGJ8jHK4=;
 b=BAj5nPs6tiMFZw6pBTT6qUfDfkvXBF5Ld1p5OHFczzdIsk0whxN/ItPoHUzvCRD4cQUAaiLJ/+1ROAdgHPuoKj2oDJ3htr+KWU2F44kWPo6Ra0KrZ6BSGYimZYY0biOsepN9k7Zi/9U83vUgkVaOyJxbo3Rm7QV9KoIdlhcrFBQ=
Received: from SN6PR02CA0032.namprd02.prod.outlook.com (2603:10b6:805:a2::45)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.20; Mon, 30 Jul
 2018 08:59:34 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN6PR02CA0032.outlook.office365.com
 (2603:10b6:805:a2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Mon, 30 Jul 2018 08:59:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Mon, 30 Jul 2018 08:59:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fk41a-0001hU-Fu; Mon, 30 Jul 2018 01:59:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fk41V-0000rU-Cz; Mon, 30 Jul 2018 01:59:25 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6U8xOF3014446;
        Mon, 30 Jul 2018 01:59:24 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fk41U-0000qs-2r; Mon, 30 Jul 2018 01:59:24 -0700
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
 <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
 <0fce3ee6-873e-154f-b61e-546d9da338df@xilinx.com>
 <8b08583c-121f-347a-700a-17b5d7784309@arm.com>
 <d2eaaf6d-01f9-2daa-ea1f-3396e3b93104@xilinx.com>
 <74f80458-2d04-c161-c82d-55739e46e661@arm.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d73d3580-4ec1-a281-4585-5c776fc08c79@xilinx.com>
Date:   Mon, 30 Jul 2018 10:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <74f80458-2d04-c161-c82d-55739e46e661@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(3190300001)(199004)(189003)(81166006)(8676002)(81156014)(305945005)(64126003)(11346002)(8936002)(23676004)(76176011)(2486003)(36386004)(50466002)(356003)(486006)(6666003)(54906003)(44832011)(126002)(476003)(478600001)(106002)(2616005)(36756003)(336012)(186003)(5660300001)(58126008)(65826007)(93886005)(316002)(4326008)(63266004)(9786002)(2906002)(229853002)(31686004)(39060400002)(6246003)(106466001)(31696002)(446003)(426003)(26005)(77096007)(110136005)(47776003)(65956001)(65806001)(53546011)(230700001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT057;1:TpULjiEl1QRvPV5hecv9cdO4zuv9Fo7hUVvw5YbS1CC773bwucwSFcYxHlUbf+EJ4ZdHjdsHHUSgwOIH0xYQrUEP5XbsD3nFHWo0S3D7TroENyOfXmcI30LahIGhc2iK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af86a2fc-494b-4ac7-08be-08d5f5fac45f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:oXwTQYz6NpOHk1Yv5KgD64RAxJ+ZTeKG5gcRWrHDuolW/lITQyrIQYseCHrtZ5r4yWyUPfjdHhXEVl/8GjkMq7F/RzBtE7kE2p7baF6TyX3zPcY8hb6OPkDUNZhgyiJfJA+Jg8ooSIz+SfVU21p/CBHs2vUQ0NHXCdGwE02yWV8uucRQVXHQb6NWWRNV466okSPPiSlO4NemlpzE8HnSoPrBQ0oHVhWTndaDR3BHsTOXTYvb/wJ+xNmtK0SuQeRGVjSeIpEZc9Hc6p5c9xuqDpsBlux/5ZRMX/5W2KCv5TmndaDghn+bareaxrQbFrn5pk2pPBenNVTEo4OAQ00fMZJ1TVxWpU+39A6zGvdJFw0=;25:FgUp/9ghZVU6gA2GKcvJAaf27VX6mf2ysA/rJnkhBp0EF9no4o6vBaH2/IljiSLsy2Rr++J31oj9IKt352PIZWYhfpMogRwYVjIPMc2XSNLT247d/5P3QBDB2pyThP8A54lb+3D7fycvgHhWMgTjeIItsDTAzujUb1Gj7fgcTdZYuEbaAhAp2jqxWUtXrco2eiuSYRU/y0e+7AcJ9pi/yoXjwLBRtxRHYBGp0SUDikerLZx6J0CNTNPpUoq3wnOJriPaYnw2erCpj6FrgihIA8zG3H5ucb7PNp6Sb4QeEiNKtgxADK+J6XzmDRjziBGVSpjq+QL0Ut0WauEAiBjgKw==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:nsWpzduHtrJ7q0/ViOclb5MsZI43MdFZF2DZMBWn4G6mmv7VFQeJb31cTKrEKdya5J4iuZhgkrzbkSOrxE52ONpUgqhxcJeDHZOdWw9TwzKtsjHb0R6vujKCO2A5+tN+tHHH+sipEO9NMzonNjQ2w11g6ea28aWtVFB7AFPIYhbAeQJQpZIZ2tN81IsQ3dCoft4lgHeONfrirUeOjH8RVZri0xGsFKM/nltF/pTs4mQ=;20:lG4iVVXcIdZux6JurGViXW2kN7V/8zLhY0W4oNrx0xG/pmkxxm6xsuRhba7Y11AY4Kd+UNdc/tVrAy6ICw2MEClCoLyH0+r01k9kMKxb02gU72XcMq2x/NzrRliK8MetWqlrfkLxuzhtj4J7lTG1+zx6e5dSMNko6OqBff+08ddMidWBVUc3hiBVj9vhvAtjZlDuD9XyUwJCWZHsUw3VnREQF9g0CaZoCLxeLo5HnOXo5MAAzgferQBevQm2q10ECdO3F+3TR7aMLsJl9tFhLc3KE/gBxwyEheVPcoM9soMxFmJi8RRmlNJdvXC7vVNpca779UmWz+J2oqAM8Vt+OmzQlpKUr35YOyqduLtJNfEBn4DS6B+TadQEgrhe41hqangRSFtMnvUY2rNJfv1ViWrftncbcAGSLsrbLIJgjtEMHX8UtcjZ9+kAVzudTQ8zDHD+LlyzUAjstlPI6Lh8IrZUyN+9+SJSQ2offmVzlIx0jawa4iLelMQgZoyVsHvG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3511328179D60B78732A6C7CC62F0@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:Ns/t78pT/tnxOdFt7ZQ/QLpv+u1lzBKs4rV40zRsf9f3+37i+gqYgQZVfygeYDUoX5zfwyDaXF+aeI79RvplQeHtpRkKe9tbxxqVro1DiSvpj2Du8+viJaJCcYX2xWhYTesnjFpim6NpKqNWtubysX1DuE92wUQUVcQWR6iZN6s/55cqFB7KJ0Il5cglGCGQH4cUg4O7HwDJM79x6F4avBqp/ccQKZef1BV05+BUvqjdUtasWBpV8HINES1IH0Y/h4CyccnPcwYF+bNnuiuTsQ==
X-Forefront-PRVS: 0749DC2CE6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyMDFNQjM1MTE7MjM6ZzYrTnl5RGdTM3hkdlFabHdRd0lkT3gw?=
 =?utf-8?B?N2NlWGdRMklrdnFKL2N6VjR3NHFQMUNyN05xSURhVDN1ODZtTGdycGVBS2Yr?=
 =?utf-8?B?VHhZd25FT3ZpMzEzRnN0WHQwaWJvK3JTb1VwWmlIVk1EdE1ZM1BNaUt2eTE3?=
 =?utf-8?B?Qk1GcGJFR25CSFBMUFViY3M3TlRPSStJZHBEb0JUN0VVOXU3aTUyalhMM0xm?=
 =?utf-8?B?VnFBUGZYcmhodEROWDkzNERrNEpoVlFLRDBGTmVSYm9IWFJhWTJuTVhKVUM5?=
 =?utf-8?B?UjFTUi9PaG5rZURqaDU4bTMzNndibkVVU3NyTHRPNzdEY1NsNkhtRDVHTHNC?=
 =?utf-8?B?czlLTUc4a3NqUFpqeXJydmFLUGFVYW5Ja1MybFRDOGx2ZHhrTStKRWtsL2lY?=
 =?utf-8?B?L1JIRkxrRzQzM2kxbVR5SGthMHhneERldzE5azFldFhOeUhLMHN1bk9BUkJy?=
 =?utf-8?B?cFBoWXgzTHFNOXZSdHZacWo3R1VlWmdoUFN6bDR1c1h0eStqWTdZWUtiNGJp?=
 =?utf-8?B?em5BR2VHRVZ5ak1yR1BKUXJ6ZTBPanNYVkJZS2dvSHppWWVwUHRMTUd1dFdU?=
 =?utf-8?B?OTdEUFFSSzR5SG4vRUwrZ2d1Y3dWRWpKYXk1N1BSYUdjM0xHNXhjdXBBZ3Yy?=
 =?utf-8?B?K1hyVnR6UjVLYmc2cDFmUUs1TkF1WkIrZmdXWFJHNUNtQUk1TUJSMFUvNEE2?=
 =?utf-8?B?ajlQOWFHUTkweWFIVURBKytvTXNMQnZOWjkrdzR3ZHpRMkllaE1nSjhDQS9C?=
 =?utf-8?B?VEc1TGJJNnQreUdJSE4yanFXOVBNSUlqSTZGa0pCcTBRb3VMVlhmeWhoTmVO?=
 =?utf-8?B?bkFHdDlrV00vbisxM1JDQkVXeGsxdng0dGRuWDNnZDRsbzRKN0R1dE8rWjRz?=
 =?utf-8?B?SFpHbGk5bW91eTV1c0czdjJFaEpGaks0NmMzWk8xaGxnQWRCOVF5OHgzb2lX?=
 =?utf-8?B?OW1Jb2EwRFJTVkxYT01Fd00xZWRUWCtyem9qaG9ubWFtbzBQSzRrYVhDL2Vk?=
 =?utf-8?B?ckRtblhGQzhMNGlmM21SMHhtV3dOZitUV1FqVDJKSGZtME9uUE1MWVRGalJD?=
 =?utf-8?B?TXZ2ZDBPWkVBM3d6bEVSZWpxTU15cnU3NEN5bXBBY25rN2I3cmlXcDEwNjk2?=
 =?utf-8?B?cnJUSlJxTWtmSWVmTGwyUWlPUHN2SXBSSDdvTk5uTjI1ak0xS0xFSmNzVkph?=
 =?utf-8?B?dmozMDQ0enlpajRZUVNxOXJ6UEEyT0REQ1B6Njk3dzlvaXdxUWtDTVQxUUM1?=
 =?utf-8?B?eXhpMDE5c0k4MGVLakVRR1JxNzRZTmRReDRYRUwxUFBPd3dZK0hzeFpZa2hD?=
 =?utf-8?B?L2IzSEN4M2RnWlpoNzVVTDgrLzI1Zkl4WFZuV2lqVmhwVFdIUEt0NVdmbWg2?=
 =?utf-8?B?L0FFYnhuNFlWRlJQU1BsdHpiSC9EZHlVY1JoUS9IYSsxSlV4UmY5ZHZTYmZx?=
 =?utf-8?B?a29QcHJKVXNqV0VITFZ0SXVDRlBmbXVpNlo3SlB3WXFTdUR5aGkyc1NmcDRF?=
 =?utf-8?B?OVIrQWdwTDlsNkVoV2Jad1BTU2taL2VFd3hqVWN2YWlrYW9oQllXZWQ0YlN4?=
 =?utf-8?B?NHVOVHBMZmhaUGhyQW1FWXhjTG4vRmZPZ2pVaSt4Uk9RUG80eVJlejZxRVhV?=
 =?utf-8?B?VDI3anZhRkdDV0Q3cW5kejl3eGRKM3g5c0RteVlWMW9jRUdRV2g4K21BVGoy?=
 =?utf-8?B?NkhoNGVtNEwzUi9YNCtmbUFybUpFOFNmYmJ0OE03WnUwcEJpeEV5ODYvNi9a?=
 =?utf-8?B?aHBmK2xwMjR2VnQ5RGs3M3MrTU8ydHdQWi9Fb0xSTkp2MFpZR2FEY1NWYWVD?=
 =?utf-8?B?UVR3bVRuZ2F3RGNVQStpSjlwVTBHeXVGZXFrcjJSY25RYzk5Zz09?=
X-Microsoft-Antispam-Message-Info: S+7SjJWBgJJWHM4Um9B9oqzWRiSmxFHpWpmCb2R0GOpuwBSxgdr4WbedK0OgcITRBPRfe4NK1TpkkTSPCFqON4Aae8lFcn9p4YtYqiazbenBPQ4o4husD9ixEwH17mgmf2ntvhMXVZ/1mDMjUMAtA3ACWTvdbnaQ44e1GulvpbymhbrPTK16GkD333QJzVG4JCCk8cZEge8GZ1rJL4a4Q0xOy+Vzz0ujOFrrWniQ3w/Dj31SYm4mCPE+KpbYfGr/VBWO3S5xNC+NEKnEpqQLxoxu87XbvfFVLGIAnZKhv0vkga8Z7wQd+5kpSN/aS112UKJ08tJGUi7Wx5eNGLioEuSVAg+DjHoLMO3q6c1fCK8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:bdgkQJ4osxPUAlicH6iU91ag3BnW8BS+i3OuSuaBOus8Q0j6a8ai9DkOUjdEPSq/vqNCIvplYTY4dx574HuVq55vo6lP02Jqd+2CIvVd58gjcoVI4YuVEbY91XnnJlQSTsk8PtNUbyvQeAiQnOQTq5xWpkv6t8450bMpkfrKoIZBexphJNuHw6muTojKke3DN+aRCmnf4RjicBAq1G8hd/5FK6LB51kWixRB0T4HMt/7d4m98TKfXIgDG/uvTZdDAYeiwumnPUo/MEUoAPWxXQOQ6QEyWzRa6QCRWV13i8trHkmFbCieDHiVN0o83s4Vp46DuPTjNvf1pk/sR0xJSBCHQkH3T2xDCSHAqlYTGpMuO6LS48s55HTGWMjr+m+IYN5ZLKoUO+Sn92rTVXIG059YO0jIc3jiHGu6ECOQ0xjpKVhicak/ywzD+f9hB8jUULUebB5QPcyvzL4TkoHmlA==;5:uYm5batdeX56Tg2pOE8cuD6IzAJSMdr6Y6P04Yvyc7muZuZ0iJcHQ1Dioxmr+tsoHZMiBYXKdFU4ZF7KyhYVhcleEjipTGAWZ3a+MFl/OsDDALk7f4RPb2vZyIN1LmIW6sOr9lkL3CSnD2nvM3mAiSs/UKjpEwZxYbsCfA3Jt14=;7:u7hSZEHyGoSICoYfuTTDD1o5ZKBTr9+w8C9BMAAufXYfOS34i0vdXtbwSJqFxLVMMZEfIASzG8eCrq6iRGaI+0IYITRU55d7YLFIvHeLFkUrloh/d++/LOEkadx6obGMTxOrKZFbkuHCOKAYj89wlO4IwgGNyQ3ebu7+eQkUXZt4d2ww2ecbtS+eSAE+nm5K34lG4P5el36hsWHv6JES+LMcCvcwXpyLEpuZy5VPRtfa8rwPDVavJHwFY5qQtXNH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 08:59:30.5016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af86a2fc-494b-4ac7-08be-08d5f5fac45f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 26.7.2018 15:29, Sudeep Holla wrote:
> Hi Michal,
> 
> Sorry somehow missed this email.
> 
> On 19/07/18 11:47, Michal Simek wrote:
>> On 9.7.2018 15:21, Sudeep Holla wrote:
> 
> [...]
> 
>>>
>>> I think with efi_reboot, if user execute the command "reboot warm", it
>>> will set REBOOT_WARM. I was thinking something similar for psci too. I
>>> can drop REBOOT_SOFT if that's not correct.
>>
>> Have you found more details about efi_reboot and passing information in
>> case of reboot warm?
>>
> 
> I was just referring to drivers/firmware/efi/reboot.c- function efi_reboot.
> 
> Anyways the function reboot_setup in kernel/reboot.c sets the reboot
> mode parsing the string passed by the user(e.g.: warm, cold, hard, gpio,
> soft,..etc it just scans the first character TBH)

ok. I see. It is just reusing that reboot=X passed via kernel command line.

Thanks,
Michal





