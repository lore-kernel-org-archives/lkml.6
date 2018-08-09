Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD281C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D1321C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OvBUuVYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D1321C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeHIJMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:12:14 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:11904
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeHIJMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl1CWq3VJqy0KZF+tJrlAz6BaV2RJmzQn8rIIu2QrTM=;
 b=OvBUuVYmHAC5OcVhKwMWveOKPQstL3Mx8Bm1vO0OrFdG/zFYnl73PYYRwza1NB2DYN8QL+RDI2tvPvWEe2xjc4L8CNzUhZV4mUDBRaE8ejQCPBexwUEUTbTq+bx57HAnGtd73EnAal84jdJXeSISZQOW6kZmOOUCHQ5jgwivQus=
Received: from BL0PR02CA0079.namprd02.prod.outlook.com (2603:10b6:208:51::20)
 by MWHPR0201MB3516.namprd02.prod.outlook.com (2603:10b6:301:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Thu, 9 Aug
 2018 06:48:46 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0079.outlook.office365.com
 (2603:10b6:208:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.19 via Frontend
 Transport; Thu, 9 Aug 2018 06:48:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 9 Aug 2018 06:48:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnekS-0008Ms-4l; Wed, 08 Aug 2018 23:48:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnekM-0001h8-Tq; Wed, 08 Aug 2018 23:48:35 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w796mXet027381;
        Wed, 8 Aug 2018 23:48:34 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fnekL-0001gu-Je; Wed, 08 Aug 2018 23:48:33 -0700
Subject: Re: [PATCH 1/3] microblaze: Replace NR_syscalls macro from
 asm/unistd.h
To:     Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <y2038@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <arnd@arndb.de>,
        <deepa.kernel@gmail.com>, <marcin.juszkiewicz@linaro.org>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-2-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f1e95c4d-4f02-263d-7f35-cc87bc657fbb@xilinx.com>
Date:   Thu, 9 Aug 2018 08:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533792466-4227-2-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(305945005)(230700001)(356003)(14444005)(478600001)(76176011)(50466002)(31686004)(8676002)(81166006)(63266004)(81156014)(2906002)(39060400002)(4326008)(2486003)(106466001)(44832011)(229853002)(7416002)(23676004)(6246003)(47776003)(65826007)(65956001)(186003)(65806001)(336012)(36756003)(31696002)(26005)(53546011)(77096007)(316002)(8936002)(126002)(486006)(110136005)(58126008)(64126003)(54906003)(426003)(5660300001)(11346002)(106002)(476003)(9786002)(2616005)(446003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3516;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:BT5aRllge/rEvJQe1iKjU49fzHsnSKvjMyigCcQIZCFtrmXeVnFrIuIALGAETcXovL5czLd9a91d4iCsaaikINjQtotHARwKgEPSJC7x3UtGsi5Or4fplRhI2S54kVbq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4993fe0-c5e8-4c4d-27dc-08d5fdc42703
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;3:AT9mBWx8jRimEaDHKTmTnvfusKgc5UK3tdJm73Hor+wuyyNCc6Vt0uTBUwl+23UoJh+Wz/iSZT+mWJfXftbOFh6dzNcapVRfe7smQusXVPbb1Yuz/SMWv1NlOIOUhMX9WnPIZ57AoQttmDNVS4TF8dYmzzx806xuyhOOIDF/lW+/axGDsLXmX0s8QdbNRnkUj+yKhXYiTGiGP2kDIC78qXyhS9BTQeTKB3Oni4mWZpxKGWugQ/b3Y+BlucxZzHkc8lNffWc3WwAAvGQtMaKGrHTyMSZL5l14BtpJgSAuowzOVHpCMCGCfzMoZasb6zFIcdJU86pRY/ydSjD6S1V6b9ToNy+fuqLw+BG9hws+HiA=;25:BSAhELBrjzPcSrabcBnaPGNDV3Fz6/IkIe75tONOdSyq6q1GdWzE4xeRQgUgOJrR+dhJ1YNw6QTrqUtVqh3Y6Ug3sl6v5MvmIiU+9PTcQpgmnBRXge6mxWgiu5HEbZJsb8eHCi5qrDXkkOh29w9Fza4vw4XKdsyMyFkjhS7WWtm1pRWw+2htGHBiRxE+k2umgnqlK9ed7RZOhhDlsSQDG98BVk3DF6SMQi9XDs0nRXBy78VpdgSHM9L4M8ZSB75NICcQiw8WEegqMghYUqY7Ho/88fkyXZSTjpcJA/GIiB5ETWvrdFdecY0hiGN12LHHIliCdVn9wmtLgc8z+F4g+Q==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;31:YiaD8+usXcQkX+XtJQVkBwbphMeuZqfqoefaRkCXIcy6TxhQDrnPl8QZnyf2v3w/96u9tzS0IBQV+Scm/oGEl+etfHfFtLYmo6aPp4e0O2W/JqgFq6/HFFR+Kd4xrUmlrdGfEAHEidfiHV1oRj0T6RULRjtHW+xSNNUwEDLAUzZ1DbanDupDXy76NcEoLj9t3jF/RGVJuewi6vOFkMZ16Fb8321ZfbTO26LnRcCT650=;20:n4DWcyWWDcgN9PNcqFPmXGc3CeTrknLy8nfGy0jz9YKQNwpbHd65Wdpxk5/HWmwnMfIl/r5eN4SCq4zKbWzAhcLfLPXmguHuv1LkiCXYixjOWpFvtLlIFUX8qM7rAWgFkZnYNAA+I8iVXaBeJsXqWH7x9Wcf5QzsKiA4Ds2MgYCyWo7JTAfB5q8F1DuUQaqPK3yQc8EqyCIa4AJ62gotV2vI7HHX4wv2vyUru+ly8cVCaMtpW/qkHJ+Mjq5n+LPT5gDCV0WqQprwF6d5FPWJmkMM5LKFZ3HPAwp9cZ4RUurfmWioIL2rcOFgqvTY6i94igKEqx/vDcOpNMon49uzH+pPgA8jF/jvE+qWXAXXdTxnlno1B0sFJSGt/wt1gD1AmHuzMKWfy/Y6ZYn/LXi1LCxwR4gIPc8QbE5rsb+d7VxQxO0X91QxBiIERtd5XEBR+bnTtCNXWe1tBaX8TNZxrUVO8liuIzcTmPR7KhfO6qFGA3PABuE7ky8dXeZTrPg0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3516B21AA8D6BB648B8B4796C6250@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3516;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;4:abXoctUF1a4nID+5TRh9aqzJwfOB4nAmZoVPx/Erf54Iu/Ke797oen/WAvzvqhvuC4ewAOlxAsFYt6/dgeLI5EAJkX+vBB4Y5atD22WvS8uoWosXSuPMaHtSLJ71bakk8kuLx138O0coTvFBlS/W0FWlTV2rjB4O1itvi2NgSgOIQvZCs45xzZ5nwkby512ZiY52DwzgfPc9Ke3AtCSQMlb7yMPT/9LiYixVn4jOE4RTwl2DJ5MWaiFnBfuLk+scZzmp8x3zvZ/3dsvu0pJObUqpi4+mSnqgSMTTM/QYRMFOBlUwU2McDbEPUMPQdTU9pjYhv0c7YGsd5wWmaSQbl2lMoNNw7wpI9hIuud2pGx0=
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyMDFNQjM1MTY7MjM6aXNhaklSSDB3alYxaFAwU3l0UGFVRFlX?=
 =?utf-8?B?MS9OMDRTOWlZeDQwdzVvR1NvYUpsdGdyNDFhYnNISlBjMEkyTlVTNWh5bVpz?=
 =?utf-8?B?TXVqblkzaDAzam9NZFV6a2thUDM0c01pSnI4UHlET0tmcmpONlJyK3VpL2ZK?=
 =?utf-8?B?U2tVV0tQVmEwdks3Y08vREt2S1Eyclo2bnEyN0w5TGpPRHBUT0p4dFpzckFs?=
 =?utf-8?B?Tk9mU3RaOTkxTmMzOWFtbkdPY2xCd3prVmQ5MHRXZE9vR1YrUTh5alVBZDB6?=
 =?utf-8?B?MzNBZDBoTVRGVDBLWjN1N2ZqVkJ6cUZWOXdYVnRza28yRElVY2k4ZnUyR3JI?=
 =?utf-8?B?L2xhUmZpYkNVcDRaUGRia2thSXVTL2JqN1ZGekRVcVhocXU1RmM5RndldGFH?=
 =?utf-8?B?WDl1dThpYTJMWGFrbXZycis4cmZuY3dJQ095VlExeG1oZ2UwOUljNFI0NWpB?=
 =?utf-8?B?V0E2bmN1Z29GV3JjN0JwTGVoQnVjWnpiZlRhSk9Vd243TE4rUHBScFpsMndQ?=
 =?utf-8?B?RC96eFkvMFdpem1obXM0Rm5SSFFBVzFyd2xDTFduN1ZQcWpMQ1VLK0VWay83?=
 =?utf-8?B?b2F0NlFQSWZCYmJOSEI2bTFqaUozOEpTb0NLZlVhU0VIT1pIdHJtWXQ1L3A1?=
 =?utf-8?B?QWVORHdiT0xZVW9WcE5JT0U1b2JxbU8yN29Uc25QOTRvTTZRdzRlZUE5eTVy?=
 =?utf-8?B?TVhXZ3I1Mkx2SlhpSFBIU1Y2YzZQaEszSXZlS0d2TUcxekVlanpMOG9rTWY0?=
 =?utf-8?B?T05TdnpoMmoxYitLRWZDeTZJM29jL1BKYnRRcjlCaHg5M215TDNndEpJdXUr?=
 =?utf-8?B?Z2FPbnZzcnlXbElESE5Na0NoMTF5YS9VYVNOWGo0dzBTb3JWMGpOY0pVZ2xm?=
 =?utf-8?B?V0NacnlYOENNdFlXQWFPbi8rK1ZXZUJmVmVkbG8wS3kzWE1lMGJuY1kybnRj?=
 =?utf-8?B?WXUrUUY5Vk9tc3A1UjkweXlCM0tCSjc2UUhuckttRG1SVG1xbkU5L1hrbnNO?=
 =?utf-8?B?WEhWNVp0clNXakMySFdOSkVXbDFPVW5UK0dzZlRwNFQwQmhxZFVGUFdCNEdH?=
 =?utf-8?B?SmthTTYrS2gxWTdUQ0JYN3JsTzdKMjkyWDhoVGNVSUswT0Z6RjBvVnB3U2FZ?=
 =?utf-8?B?WUJDa0kvL1UvOXd4WUpCdHpRV0lwYng4YUJGcUI2SDllbWljTUlNQTAvTlNC?=
 =?utf-8?B?VXRvVFZRZnVDWk9raDdWT0JhbHo1bW5NUFV4Y1NjbWlaSys5blVlRXRIVmQ4?=
 =?utf-8?B?Wk9IZEQ0emVuaHpVRzVocVlKSTB5dFVYUUpDVk4zQjdOdlBkOEN3LzIwV3VJ?=
 =?utf-8?B?aTFRcmRyejBjSHRDUVU5T1RORGY3QUVJcEdaWW5PVGw5T2RqWVZ4ZG8vcmJ2?=
 =?utf-8?B?WEpFUG9wczZiLzhBUnFNdmlXMDFTNmI4RVpnSHR5N0RmVUFPWkY4bUx5QXJ1?=
 =?utf-8?B?eGJCVFFHZXVRNnZpS0FxT28xTjFDZS81VnY3bXR6L1E3VjBQWWlZN25Pdmdk?=
 =?utf-8?B?UVRXRWdIZFptcEJKWHhDVUtqRFFMYkl1YzNCK0haNHZYTUZqcUxlc2NRUmcw?=
 =?utf-8?B?RVpiMXJ1VDRNTjdOWWdwZm85aWxUQUZJV0oxMVlCY0RFeWJKcDNjT05jOURn?=
 =?utf-8?B?NXVIVDZweUFteFUxdXdaLzdWTnUzKzduN3dranlpWFNtVjllUjE2czhMeUpv?=
 =?utf-8?B?b2w1OGUydy9DWTNXUEdGWkVFZXIvTTNROW55VzhTNkVVZzJUaWFiN2UxbmlX?=
 =?utf-8?B?SGprdHJxZG1hSkw3Rmo3K0RRPT0=?=
X-Microsoft-Antispam-Message-Info: i/QbtLUOy9dnmVNykMf6D4O1A7eGjEiZ21mryOE8D+rfY+ft6SDSeA/nFkOWPDA3FFs1Pn3DgyNlvRJbHWYGa1Uj7PfV5whjenc+9W7eBkKuMrs53nngcVMQVVGGcE372ND2WlTJNEOZAPcwj2yZVKp5MbkkaUiSXe5+YKj6oggV7llyuAkTcYnDF/ZT0V5xgMK7i0e2kapYr/SRP5ph7hLIolRj+8MQ1gcf2Yy6McU8pBoYFkp+fDQZUoj6BHsXwa7MyYaAm/2MW506fiD+vovCoOkC/FszIsCswhdJW49g2iqsIxcuphHQ6CA1djpI6gxGPCOkg0wT0IyqKVvGLdOUrdqetSF65+kigbSNJVM=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;6:lgW7WUPcgEvyr0R+hgJNPRk1Xk4fqO/nnfjhhRA1Fyz9l/+qp8Y3Hw44QkyE++EWvoDasmY7l7oR2Hw4/5ZhW2SKKipezRt2hzV2DWo7JoJAUVQwv288cpnOlIYudqhRBhrI+88BIdZj2Ij/fSjZVQQaC465FuHAjQEBV/4zxIufV5ChKhZlvR9l73ZTxwf3IEovxvlC8xfGoQyS8rkvtutolUFHcX31xAv7g1JDei/UzRJXx/qGO8A20kxtKeSNe/hLOVgUjwhkXs6nqwBytHxq+PHq9OK6W+3QxqJldVvOICAowYQHudCdDnX4rVp/ua+8hKdC+pp3pyruI5299VjxJCk+56uRe02tSrwx/UOj8LF5GfkaAxn0TAGZMdtgDL0Z+7BjyaQ1CX4mE7M65bWIJAzyHT2M03Fti7/v+iKXQSPvyMRSpndK04Uql3YOipKKYA35/Z2XqzdEYyZ1Qg==;5:W4ouoqMewYPW3uIB7oVqV5FChUYoL3qC0X2xrQFLwNxZyIhI6T2WfBj2u8qdVZrdMdERGTrLH7umb49pf+NIkvN2p9ym7sPRNtGJ4doXDrh6441gun8xqePhmj392s8Xf9V6pAPo92kDk7KDK4HTYEFMm3GZz835Gt5e8y+D6kY=;7:00FL/zqRKjN5iviGwAlv4K9V3USDiLG4/TykEL324PsRo7Ogonw5ONODF4T+604k9TfDP5ysZYsDD+Lt1okylTcQDkUizomTemUzMKvFW3/+D2j8DnNtsALZqj+u4022BtQVmgaB3AnjVnDF5kbjzU7ZzyhKZLU69OIghw9BosZA3MKnP0+pPihnJxKS8JkRm8/DS5ubjm9prWu/+z383o3QGU9QKiF5aklwmlCbuMJfU/aDH/FEWPU0yc6Hinj0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 06:48:41.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4993fe0-c5e8-4c4d-27dc-08d5fdc42703
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.8.2018 07:27, Firoz Khan wrote:
> __NR_syscalls macro holds the number of system call exist in this
> architecture. This macro is currently the part of asm/unistd.h file.
> We have change the value of __NR_syscalls, if we add or delete a
> system call.
> 
> One of the patch in this patch series has a script which will
> generate a uapi header based on syscall.tbl file. The syscall.tbl
> file contains the number of system call information. So we have
> two option to update __NR_syscalls value.
> 
> 1. Update __NR_syscalls in asm/unistd.h manually by counting the
>    no.of system calls. No need to update __NR_syscalls untill
>    we either add a new system call or delete an existing system
>    call.
> 
> 2. We can keep this feature it above mentioned script, that'll
>    count the number of syscalls and keep it in a generated file.
>    In this case we don't need to explicitly update __NR_syscalls
>    in asm/unistd.h file.
> 
> The 2nd option will be the recommended one. For that, I moved the
> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
> name also changed form NR_syscalls to __NR_syscalls for making the
> name convention same across all architecture. While __NR_syscalls
> isn't strictly part of the uapi, having it as part of the generated
> header to simplifies the implementation.

This macro was in unistd.h in past but it was moved out because it was
causing problem with strace.

commit 40c2702a02b755e0183b702778331b351f3be20c
Author:     Michal Simek <michal.simek@xilinx.com>
AuthorDate: Mon Jul 8 09:50:24 2013 +0200
Commit:     Michal Simek <michal.simek@xilinx.com>
CommitDate: Wed Jul 10 07:32:09 2013 +0200

    microblaze: Move __NR_syscalls from uapi


That's why I don't think this is the right thing to do.
I have grepped strace and glibc and none is using this macro that's why
I think it shouldn't be exported via uapi.

Thanks,
Michal
