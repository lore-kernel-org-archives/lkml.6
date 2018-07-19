Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0FD2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wx8IYMuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0FD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbeGSL2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:28:25 -0400
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:23296
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbeGSL2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WcpBg+fzFTkuPr3yzA+HkxE2Lo4UdfLh7oz6CTd4MI=;
 b=wx8IYMuqdLViYLTUkmqvF4PKoZYfGB0DbVd/+ZSHuAucIttopcYvfw2VXyJThNokOqCK+iVVv+RESTji2MboXP9VlopeYUqt8ZKO+pUHvYF5ujqb6NciA0VLhkA9swxV4Vly0KMopUcd+pBsZsLU0xvCidfhp5PDpUit2b14Z2w=
Received: from BL0PR02CA0076.namprd02.prod.outlook.com (2603:10b6:208:51::17)
 by CY1PR0201MB1913.namprd02.prod.outlook.com (2a01:111:e400:527e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 10:30:46 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0076.outlook.office365.com
 (2603:10b6:208:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:30:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:30:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57609 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Cq-0000Cc-JT; Thu, 19 Jul 2018 03:30:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Cl-0003hZ-GR; Thu, 19 Jul 2018 03:30:39 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JAUaVJ026972;
        Thu, 19 Jul 2018 03:30:36 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fg6Ch-0003em-Qq; Thu, 19 Jul 2018 03:30:36 -0700
Subject: Re: [PATCH v10 10/10] drivers: clk: Add ZynqMP clock driver
To:     Jolly Shah <jolly.shah@xilinx.com>, <ard.biesheuvel@linaro.org>,
        <mingo@kernel.org>, <gregkh@linuxfoundation.org>,
        <matt@codeblueprint.co.uk>, <sudeep.holla@arm.com>,
        <hkallweit1@gmail.com>, <keescook@chromium.org>,
        <dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <1531857547-16652-11-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6dadc5a6-7bc1-0e37-4df6-0278d9046c96@xilinx.com>
Date:   Thu, 19 Jul 2018 12:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531857547-16652-11-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(438002)(199004)(189003)(336012)(2201001)(126002)(476003)(31696002)(2906002)(186003)(47776003)(36386004)(7416002)(77096007)(36756003)(53546011)(26005)(426003)(486006)(446003)(11346002)(2616005)(44832011)(31686004)(9786002)(6246003)(305945005)(81166006)(110136005)(106466001)(54906003)(23676004)(76176011)(2486003)(8936002)(58126008)(5660300001)(316002)(356003)(65826007)(81156014)(8676002)(50466002)(39060400002)(230700001)(4326008)(63266004)(6666003)(107886003)(64126003)(106002)(65806001)(65956001)(229853002)(478600001)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1913;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:rdMo6std8r4UaZqa1vqGwtYVyaeryknEjlhM3pfPALHsyLt0LCzdOzRN0Z8D30vZ0ZNFKnlKm+MDifCJ8yoVuq8hsdjlHITGspK3CJ2ryfnNFt7mNX4HulgJcJBwCM+1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b28cf2-2f71-4516-001d-08d5ed62afba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;3:sNpVPPqrAmsxGfKRXOGeE8l2wZdBUdoMxzMqoZg2WnhSCr2aPXSFK6esw/XD/wcHJhafC3L9PgD0A0dy4kv6ZDhZUNdQdfOZIY1KM8hXILJa+El+kwgJofwAL3mReAXXNdB+w74IRL1sDH+vMoyAk4xn3C8gYksf6QTmZ3OdAI+GaT4VWq2IXKzkcSfENDUdoyEFeqlIRH/s7i59hgLr7bDp56/+PG/ygstc4Tr5Jgv5qw5YWdCnBh7hST9zxfVgkVjf5MFi4kFLpYhBuJiheBENM+BLC9lD5t8zHXDHZf7bnHg4WsSkKK+r5DEZYo8ImSKZzPdIcEwkY72l3WwduhUui8rrNE+Yw0plJWnQhII=;25:yVu+u9aGe+05ogkpiXEkwXuPh+6g5TfwruLk4EoEhXpKp9Bixonm4ehSrpZvrGVeeJmn59Jo+WvyWS4dtqYe+vjWNHI6xfpcLraQt0UNQhaz2HGrxGEXeF/VSyqKG8gfJlWXOE5wzrPTl8NfHTlpqAeEdbm5B0pW0VjeWIyKO4sZxpWb+1bG+AZEkOgprTptuHrDX3opA0Fe0FLHiNlQ2NwkRe2x7FKtcj7n9AcT44BQRakY7vjCp0pu26tvY5ZzPpbSOoo0lLngsTY0uh5TDX6Mab1o/AdaDcZ5jxWePnCz8mOhx/RYH4s7YftGTphy13TOvf1hDnWvNUUdLQS2/Q==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1913:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;31:6SugIGeSyZ8CLaAywaPMqZIs1hMVz7p7RhbakH/uW7KUHs1/qb3sKsIrCAMcssuF0ehiyKp1zcBb7oLhjvWhgj7Lpy6bytcH/OUrHS4SvvE49k7I2cZ/4d7hcJ/b5IyPpjlSYwZZO12+d2DyLXsV7mySO/RUZ9GMfWVypwwc2Yj9nvcVOONPstx3tvfexX28I/B1X2KSFVNXKXlk6EUDFXv8iQRklTOdYDG6ZcxrbTE=;20:vl+43KQBZEModPx9RD9Bk4+ao6jfGxDTeAfYiANN/ezO9V8gwuoKdYbve+BPMBrJIz8HenwQDmWzkuaa1N/b71lD64dRqIQ9Jby8JyDaVbl2gOJd5FG1CfNug8DasGmBxOI4qvk+QWNgm7OhBy9GryTMrOzGZQLyFiSFtn57qPDkyDBHJTq6/14wM3rUsqmJ+chxkwIB1UlHwJ8nlfmG4DikqCiR/OpDOktR+ANt5uaxM5EZuPxCkbTxFLTlVjptJoYP6MnzU7v7IViMPERHhat0//M2hsPYa8uSujaGDbcpO/pM1Kg0AbujWaoaoxNCY0h9K5rbQ6FRVjJaQh9RRPYcb8emdDM4IW+1k8QEoaLPjtpdqxq8D4lyC78UzkAKzi8xvG89mGexTqPLX9sdiOR/NzSLgEuPpjl3JpmBItPR8jbPFtFemuh+uhSpjsy1YUBOS1NlkrohhGwqD7jP6/xPr1BPMrvhhXuPI9MrBKlTFcOpZp7r3zxKMG3tT57C
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1913DDAC1CAA83118C8A4238C6520@CY1PR0201MB1913.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1913;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;4:U45mrOqbRi7LrPr2pTvROBUQNn+rJEmG6OytR48vbFuZjgEtgmuSMbygSBYadrSOUXdNUuekWfXENMpDO1cPB+a9NGS1JSj73rna6uJ0iyIrx6LiY30JGIknzXfWeQocMM/GuOqC1Q83bTKF14VQTA8W78wwkqV+1QEkEx89ZEWmOKssYBl9KMq/1azHmUhm4LmwSYXOQRxauzcVOJtAM2Nkp+rr6Tzum4Z0yIHHk1i7w/QFhGKvB/6azVi3WVyoRh+eKPxn/oBQcWy1OzY5fShEiwT+GwZ6Ukf3O035wcpjphwrG5VNKD4lmYtRzLJ6
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjE5MTM7MjM6WVVyRWVkN094aDQxdDhSVTFodVpJRVhG?=
 =?utf-8?B?eXVwT2grMmxSTHhodkh3NjMyWE5CVU9ybDVESlZpeTBDUzAzZ2FBbHQrRnZ2?=
 =?utf-8?B?ZE5kRldTaTBqK1FUWDhpeFFORDBRSVJXQ1N4QXQwTmhzaHc2VlZrYnFjdThG?=
 =?utf-8?B?cnlEdTVRREJqYnBPNEc4SkNpK1BVNlJiTTZXMXlSZDlJeGpqcStreUVxUHhJ?=
 =?utf-8?B?bnpqYnE1bngvYkMvUm5pczdCWkRyRTFnUlhxMVZkNWpuTFVRVit3Qk1pRjhm?=
 =?utf-8?B?MjR4elJ0QStEY004bDFCd2FOZjgvWFFETkpZMnFVQkltTDduMGlkT25uelAz?=
 =?utf-8?B?bmJLc0dtbWhCRDhSbkNud2JNLzRwZmJSVVlmUEEzRGc0bWF5RFRwczdISkd0?=
 =?utf-8?B?K3BBcjRkQzhZTWEzVG1Qd2lCb0hUTHEyMVBLUUtja0M3UWxnY3VwWlBLeHU2?=
 =?utf-8?B?VlFqQmxCMVhaelFJV0luRnlGbnBoRzA5emQ0UE84TFo5WTdleHpJaGNwWmtY?=
 =?utf-8?B?TG1PUisvVVFNSkVNeFJHMXFnTHNzbG5PQmRSY253VW0vYTJVOGFWZHZyUXJz?=
 =?utf-8?B?bEMwWFV5R2NweDFRMFVJMzNFNmx2SGwrMWVDT1k4NnhUOVl4WVl0OHFXRTBU?=
 =?utf-8?B?cFYrZFFuY29rRzhZcGp4VEpzT2FNWVNlVkpZVncyZmZ4SVptdVVqT2lzZDgy?=
 =?utf-8?B?QXErcDJwY0plZjAxYUM4YmFrNE94aTYyTzdXaUVnSzkzTENOQjRPRUFmYU94?=
 =?utf-8?B?ZzAyUmdUMWJXcncxZFp2QlNFeXI5c2NzZjg0NTZaUXBqclJFS2F4ZTNGVnNh?=
 =?utf-8?B?UzdtY3RXUXNsdmRjbjRmVUdOZlBJQVhtQnNobXZqNlhoNGN6UlREVDJCdjRX?=
 =?utf-8?B?TnVXckl2WUZONWx0WUF1bjRGQnV4OXN6M0hENDBHUVRNenYwaFBDVVIxVXgw?=
 =?utf-8?B?VGVNSFdKR1g1OU1qcnJhemlUQ0JDNXdKdUNScThmRlI3NSsvZWVVVzlrUG1V?=
 =?utf-8?B?VS9uN3FQUFk5VUpkNThmV0Mrem1SdjBIdXk4cU9yRVRCWkhJUTVsMER6THZr?=
 =?utf-8?B?MFFSelN0emxkRFZpYkt5eU5RY0FVVEZtTVNKeEFod296WHdscWVnNUJVV2x3?=
 =?utf-8?B?MkxHd2ZUZDhHbDZvdlp5eEgwWFhjRHZtRWdGZkZhbi9wV1dGQ0hlOU84OUNN?=
 =?utf-8?B?Qlk1U2U4a2sybWcveVcyQXFWVFlUZmNnQnJUbWh5bFBNMldGZTU0VFcwNlBS?=
 =?utf-8?B?UVhKRWEyQVZMMEpzazl5QS9rYUQwWGczamhMOElPYjBlakJGL25nS001Q3dm?=
 =?utf-8?B?NGtGSWtZOWtwUzVUdk93UWRXTEE4T1lZRXhMQTFvb0xGWXVrSXJMdnJ1V2pj?=
 =?utf-8?B?elFobmFMbXRzS3VXTWdPVE1lOGJIRXc4V29DOGcwQURwZmZPeE9sMzFLYkpG?=
 =?utf-8?B?ZWxucVluVFN5L0tSTklMb08rTkt6VWorcm9sZUdiNjljbjliWjhTSFh4eS9a?=
 =?utf-8?B?VW5VYTRQZGxrOS92WTcrMHUwOVhrRGF6Uk5qbGpSZzl1SFlqQVJrVHN4Qzlw?=
 =?utf-8?B?U0xvcjRaM2RBSENua3dDRVRrWTQ3REp2QytlZXp5K0xQMTVKejhsRTJpOWJR?=
 =?utf-8?B?RHZzUGNiUDZZbG9XRjE0WTJMSlJxcmZsbytESlUwclphQTJxVDQ5dm0xSnpK?=
 =?utf-8?B?c3dBRmZhTUI2MHFFQ0pmZjFONmxQMXU5YW84VmdkM2Q3VGNIcXpoVHkyUDdq?=
 =?utf-8?B?QndEbHdHRVdob3Btd1BjSE9rTkJIR3dDVGJNdUdWeUJReUpKSTBvOERuKy94?=
 =?utf-8?B?bHRjaWJvaW55YlhpbnRNYUpGSWk3dDgwWjg4ZnRDdU1EcFFZeVpuUDE1b21L?=
 =?utf-8?B?bUpCcDhpbHJFNDY3RjlPV2NPWnN3eWE3b1RIYWhmZm1ZcDVTaEYvVVFCSGhy?=
 =?utf-8?B?aTJET3FldGt2ekE9PQ==?=
X-Microsoft-Antispam-Message-Info: qYMVU03yCHBGbYEZAkEcIRjBJsV/5m+AfM9N/H5TC194ofxiIUx2JDrw8ACGeZPav0oiXifVKQHYbF+1ZCpZnOhzfphWpfEBGPr+FsUw/Jf8HfMSkBbv1+kXtSVL2w40zmLgsu4RbsrQt13NQS723vYO40c5WI/2cZHI+TPRbqdsxkwyviKVs9PMw00TDqF/EACtuijR40Ro70/pIhDqb+sZQ9iI9bU51FXLQFBJi93ZOq0AZg9UnNtC3iSzynqUl6Y9Ps7XNRjf2sC3I4b9XKAa5p64HYOCT50TtSXAS+yNtPeoqvNJj6gTkYNFfrkoQedvRwRZExDs8tF+Kf+IUtMa3nJcHP68TbEvBDWObDM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;6:VuvA6/VdCSGQyyhn9fT8JDMkk4LLaSIxGqMBgWIiMzneBzk01ozZhytzqmS8raIiHMY3h1DKXnwYUa3O7vSRWkC8O9WDylpA5E9wrIjzDBmMIbx2GlOytuwR8yVwmwPSc9NIFCj61pgaqKEKTt6hkO18Sf5IaI4mYGXaq2wGuUwpLT3LBanIpvuMhDgw41EUC2V489wioXC4pQs+91QXFgWRGDp+i6NPDLCIBfdDpUxfFpHQ8K2eS/waBHbYSKQmf0iWmrzEjzu6UBakopGGqaVmFbhSfmIjeCOWNoFPdPohNT0mJVj1PH1pEd+J4BTr4G0M9v27N97zX1u6xGYXKUBsVqMQGgKVuqPgZgpke8nZs7ibtH7fmaSunlukqhITIr1JokAO/pq1Et5xm/b87HC7vwv6z7YzfTAZB3MM62CymBwBhMM0W/gryeZG+kQw24ayMNTba0GpTt6OjPgcTA==;5:DbxT2bcN4s2fbxb+w4BqPkq3+yZLIGEsHdv2987IIhYO49zQ5BSQqkpARG6yXrBSI32aglvYwuLsn/StBVttf+JiVunsirZKOmMu5Ae00DaMUgKkhgdYqxt0Wvb9woL6WLGTRRBuvhSsfO+1deyqCfzPTvPEtBtuXgppOzktEP0=;24:245Txo6Fj+cgKaupIIWvonXC2VwOdPGtIerBVZ15iX1veCWnHdnCWAlF2Vi8QQfeVxvwp9alp9sKBednQXXNsFCuok29PndicbICuE3pfzM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;7:FzFRF1mgLxbV5XjlTz6P2Aq4lgQd+mU06HNjHPiImpJgP9gGOg+fEvq2zDErwapmVqSzOQUj0Z7K/OUDPp6TToCos5ERi/wj09UcBtolMgA2Gm8c2qEvrlo8X/3cjVoaaZwncx+ZT5bhOadYKHEofouI/LpvZpHsdluWvk6MtXUULfLjvNFYHm8Q+13GbqFH979RS9hvdAvZKXmMQ8FV5TAySSTc+MncMyfLSVclKQHKFez+V3sZaB0TWGxbzpRk
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:30:45.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b28cf2-2f71-4516-001d-08d5ed62afba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Mike,

On 17.7.2018 21:59, Jolly Shah wrote:
> From: Jolly Shah <jolly.shah@xilinx.com>
> 
> This patch adds CCF compliant clock driver for ZynqMP.
> Clock driver queries supported clock information from
> firmware and regiters pll and output clocks with CCF.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/clk/Kconfig                  |   1 +
>  drivers/clk/Makefile                 |   1 +
>  drivers/clk/zynqmp/Kconfig           |  10 +
>  drivers/clk/zynqmp/Makefile          |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c | 144 +++++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c  | 141 +++++++
>  drivers/clk/zynqmp/clk-zynqmp.h      |  68 ++++
>  drivers/clk/zynqmp/clkc.c            | 719 +++++++++++++++++++++++++++++++++++
>  drivers/clk/zynqmp/divider.c         | 217 +++++++++++
>  drivers/clk/zynqmp/pll.c             | 335 ++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |   1 +
>  11 files changed, 1641 insertions(+)
>  create mode 100644 drivers/clk/zynqmp/Kconfig
>  create mode 100644 drivers/clk/zynqmp/Makefile
>  create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
>  create mode 100644 drivers/clk/zynqmp/clkc.c
>  create mode 100644 drivers/clk/zynqmp/divider.c
>  create mode 100644 drivers/clk/zynqmp/pll.c

DT binding was reviewed by Stephen but I can't see any review for the
driver itself. Should I wait for your review or do you want to take
binding doc 09/10 and 10/10 separately or this can go via arm-soc tree?

Thanks,
Michal
