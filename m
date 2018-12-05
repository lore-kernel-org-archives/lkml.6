Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OYrk2RLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeLEMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:54:20 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:35488
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbeLEMyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJIQ/75H10luMoRWDUN6xkNmaTqaVbuV5bo3KdUGE1k=;
 b=OYrk2RLgwnZYrZhgK2h22mq7UXMrKLX/hxvys7gdoU8+WST7vhHsuIhHQyxqClX6azy/C1j4Z7A7qOo6/zoQJ9Oef6huRBl48+gcLB6kNo1mNoxaZJAsoThSNMz2jZYVqitynziuODHaIGMHzT5p9rgJiDCOBUUL6S+ZMewg8ls=
Received: from SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) by CY4PR0201MB3507.namprd02.prod.outlook.com
 (2603:10b6:910:95::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.18; Wed, 5 Dec
 2018 12:54:12 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN4PR0201CA0044.outlook.office365.com
 (2603:10b6:803:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.19 via Frontend
 Transport; Wed, 5 Dec 2018 12:54:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Wed, 5 Dec 2018 12:54:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUWgr-0007AJ-6N; Wed, 05 Dec 2018 04:54:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUWgm-0001p3-32; Wed, 05 Dec 2018 04:54:04 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB5Crxvc010196;
        Wed, 5 Dec 2018 04:54:00 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gUWgh-0001n0-LV; Wed, 05 Dec 2018 04:53:59 -0800
Subject: Re: [PATCH] tty: xilinx_uartps: Correct return value in probe
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <jollys@xilinx.com>,
        <anirudh@xilinx.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3245866d-d70b-5118-43c8-91811b1d3bbb@xilinx.com>
Date:   Wed, 5 Dec 2018 13:53:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(31686004)(2906002)(356004)(106466001)(63266004)(31696002)(65826007)(126002)(486006)(44832011)(336012)(476003)(2616005)(5660300001)(230700001)(50466002)(64126003)(6246003)(305945005)(426003)(11346002)(446003)(2201001)(36386004)(8936002)(8676002)(81156014)(81166006)(65956001)(478600001)(186003)(65806001)(229853002)(58126008)(47776003)(4326008)(106002)(54906003)(110136005)(14444005)(23676004)(2486003)(76176011)(9786002)(316002)(77096007)(26005)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3507;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT061;1:5Si8DixDa3Z26ldNAG8mcB1Cp7JUvCJh/9GYiPkcfNEbSWkVU3b1RWGUQAFWzLfrOdcrShCbPOSzBEGpYrB05ItAGoII+cETCe0VA4wFjrwF3ANlXoSk4iyT46OFQjhZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457406d4-fb9f-4738-cf19-08d65ab0c0fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;3:ST33CHqY5tIZmzQ16kizY3kLfIetYbFevN078P46gi8E9V/2/Kr5yUKsAB5Jx7CebQg9e4VYTBzwspmOYQUpvU8xg9lxApI1u+bNJclGmcbjUxaDIsZmso+m7KsGQ7MvWcG40PyMvgdZsFnP2FXmnx2szQT4fL8+iDJKl0K7xW9f5WKqf7Aiq3qwEJB/Fj0rweGwp+UkFmylw/TupDayvCn4i6z0v91KBRCtN/2OVsC5IPYNcIs8BqUAGczyloNYuTMLwx7VwNkUm8h+0UgjEueB6o4ZHIC5KyMtbSeOaFk4qPipUWorZO1vFyrPhsXjDDMtPfbs6V2WMrXpG9N+4kvjn8QNgPsou7Jihf9UIEQ=;25:4nVr6noJ06HDdTWNKaPKIzMBDde2k3DYmG1E/Ec5R6Qinalkuf1bvLYish3QV+5mtK7xgYWeGyb9OBCYcP6yrOxBN8StgQhS5tXqMV2bwGw2es+PhmjzQ3vz3W8WBM5UuX2bKLxNbE65by/KJNnjAEyxMMvssvC5oOiFGTTbNsPZ9DRKKoUi1103b/TqK9H0MRH2P1tOGhDStU71BY8r9vooR4OIXdKUC/V3r8pdPUr2NCHFAVe9fkrSpkTipXwAPzzeimMiSqgeA81mSrECC3mCxArHc8vwTJsbEhlm4ARUebwe0WNzrGgKb5xlC7qMFxK1rvabpBcpV8IiQ+w0wg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3507:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;31:wn7+C2xSrXzCXTN3U0cxvIzuS0Di6BwWDWd4to6/ccdQMz7vKD3W34yytiP5on1+gKNvGZsosdl4mhz6YhWl8QLCUSohmvV7sWrUcz5uPxeaYNPm/YoW7rlmg61Oi/Yu4Xd2tCeKLmVyUbU4Wdrg7MY7hGRKLFffbiHPSJqR3CQWTPDRJc6iS+2JcfBjE5wmLxILrEz8IQy9MuqxnUghkx02D/VVSUBMHnoeCnlPjPA=;20:9qup4+UcJ3ClnNpyAa+DhEX5ccN/HkebZjhNbYcmNDzZmLPAAebk/kySHagP9XVoiy2LXdRyDdTK324jJX+yTTfra7Df65/ylStbsiuaNmTTs1b4O/vzkX7sRirusMAw/PfmtthxwEFi14I/S8UHyLoDlEfBS08rywUiRwgYMVl4G4S5sXtT2dBMHu0Y7bjBuZ9w0McVNtsHHBihh4vAXMOLr1BrW0/+YuW9Je8bUY9skd+tLOAyI+y4VESW1E9UBwuI52A8pF5p9z/xsAYwyDHvSueLL3e2/qvD0KeWPPDoZbVfpr0HKihnsp425FLCEDpZO7G/qsWFj57jf35a1NcxUn/Jn3kW90XgMKJlidbAFtuVqbrY/dgPVEnLyDn/P0ABJsQFwPZnoRQS+QJAN7lQuHCVSW7a/aBsYVGvGi+0aOrzktybfhAYXDqHjatjW88gKxP8wVCkDRWeuY29nHR1adAi88VbmfTO7jOUleOfEN0hYQ6fOvEU5rxRU9bp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB350791CC466CB50B4F5B3B73C6A80@CY4PR0201MB3507.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3507;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;4:YcYLAjmz75SIi5T1570sQqF+x3m7+mNUdY1vWBs5dcRpOylRd0jwRhUTaIwWAejqQOyo0fHHmr1tmJ5Gl4Ou5P8n/PdzNEJlNl83D/BOWMe1G889HSfnvG2ovqCw42NRrv1Ku1W+lmqs6l1rAuROre7C6MY8KE4cdjx05c9U1mJ1BgOADcOyLg0Hm0RTjclEL9bo4TfmfvQV759ZSxX/k1L9GThftUpVvHArD5v0g5ORTVy1FiIBqQLhpuUSBeGWov7Y+QlX337mG9lGxtyjtQ==
X-Forefront-PRVS: 08770259B4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyMDFNQjM1MDc7MjM6UVhhNUthYzdqV2lLZzZKRjY3bElNL2Uy?=
 =?utf-8?B?SVVueHUxM1ZaU2NPeUJ1SU5IMTQvdi9RUTNqV0ZxZ2lDQlBIc3lxVkR0ZEFD?=
 =?utf-8?B?aXMzeHpuaHd6YytqcFE4NnNXVzc1Q2JRbSs2U3dudmlJOGsraW9LaXkxRVFE?=
 =?utf-8?B?OEhmV0J2cDBOTm95NUZRWENVL3FGc3BYM1o0Wk4yOTJITUJYVmpCeFdQQjc4?=
 =?utf-8?B?MXo0bVFvdEMzT2FXb3RvMDNvSjdYUHVFNUtKZjl6QS9zb1JOcklOZXBzeEhM?=
 =?utf-8?B?dFl3SjZ3dTFmTFBxU21oTG5Wd0lGNit3eGxSQmRNNVU4T0U5Y08xMWhmY3h5?=
 =?utf-8?B?WDhvYXJVRERuSXdpMzgzRjQzdlBGQlpuZWh6dUg2L2M4TUNkb29mT2lWN1dI?=
 =?utf-8?B?bk1EN0NZa1ROdmoySXU3K0JpYXNScnFKaW5Sb21OQzhQc1BkK3FuYkhTM1hr?=
 =?utf-8?B?UVF2N1ZXZVJqZGN5VHg5dUZkMWdXWjR4di9pSjFiT3VUMVVmVVpTQmc2aW5K?=
 =?utf-8?B?bUtOTWgrdWwrVzI3N0xVM2o2TlU5L29FLy9KeFBvV1h1ck5BSFdkTXJCS0Zt?=
 =?utf-8?B?TlBjbWs3dXFaYm9Kd0JNeUNKYW1LM2dkaExNbnUyWGo1MzdhaFBEUFNvbkZz?=
 =?utf-8?B?cVE2Mm50dXhmN2RyNlFFZmtvYUVoNkQ3Ym9YR1FWNmF0VitoZUZMNjVqRGdh?=
 =?utf-8?B?bnRiL3F0bGNvcndXSmFFZCtmUGxMd3J2YXovNlJqeEJ1d3hXU1VXU3FSOFJo?=
 =?utf-8?B?OFZkdnFrYVZPLzZYRjlkSWpvRklQekZDWUZQdk4zY2pPZGtiQ096RUxrcEZZ?=
 =?utf-8?B?YjdBdXZYRUVsdkozYy9qS1RoK0hKQlliOUUvNlc0YjFxa1NZNnlCNmxHTGZi?=
 =?utf-8?B?TmRqN3RKVjQ3VFUrZS9TZDlhc1hRdDVQbVYyVE5NNTVndSthRGhlc281bTNl?=
 =?utf-8?B?OFNWcjk5QWRVRzd2UndwOXBiOG1SZHhmbEJENEo2cThQc1BFOVlrVmMvOHBi?=
 =?utf-8?B?NUxSeFMvOE9ha3dQaTJVVTE1eGUyTzFWWlVYYm84KzNuaDc1VTBNenJWTzU5?=
 =?utf-8?B?RTJKYy9sTGdONkhCS3dRbklCbzRmNHFITkM0SkxDdUZhLzc2Y2FHczlTR2d1?=
 =?utf-8?B?MDh0OVBMZGJ0dE1rUzhTVzBTbGRCNythZUFEWVdtN3BxcjNuSE1NNnBPZHI4?=
 =?utf-8?B?OXd4cFdCcFJseXdTUGVEa1QzSlNuOVpabVJBZEFXR1ZqNlFxSkxpblFORFFJ?=
 =?utf-8?B?REFmWC8xeXZsRWJmNVl4MXdLTnI1aUwxbmxWYUJZZnlxNmdrS253Y0NjeWIx?=
 =?utf-8?B?Q0N5U3VGdGtJSGlrbTBQUTNNN214NmNRMWhucm5nZFhIUVJQM0VWTVZ0NUl2?=
 =?utf-8?B?TkpMYks5SExISXNpWW5Sd1VZSWE5MTBFMmJXUXo4cXFVUnM1Z1VZMllLbS9D?=
 =?utf-8?B?Vmg3UytjcW5Wa2twaVpNU25OV25QMWlyR1VsRm1qeHljT2FRUEJtUHhrYWt2?=
 =?utf-8?B?WktZSncxNXR1b2k4enBjSnpXeHQ3WXNpaTZraGt1N1htam9ZWmJnL2duKy8w?=
 =?utf-8?B?VDN4RUJxUzR3aWFqVjkyZHZIdENSVFJFeDB4ZzFNQnYvYjFkS0pRZWlxT1lw?=
 =?utf-8?B?VDBKNGFJek44a081VitkYXluQTdUMFdGN29TN3BZSmh5YWNvN3Nya29UWmow?=
 =?utf-8?Q?QWitpLhZ86oFSj4Er424=3D?=
X-Microsoft-Antispam-Message-Info: 9/xTqm4goOaeKqk7uisQIuyz+soXqbbJ7wnKgQWhQpHJsSW/wT2U3qIoJtFpEr2fsU/v0pTixDmHgqNZISO9J5hZ8lxvBmIUY8R0/nYoiOcjTnxa0GgXGDTjm98h1yfAW60gd2zjPwdS+f8tMmTVcMmN2H4z/3nMMrath6WlIvwcSCmTrLcPK1QLkbCv+5gUZv8jmU9P0SLFjvfYMgCGPdrVcHPonhMKPpkt4e6D70UKc85gwryxymwhabysIEwRgfOZIO9Q3SN0bKRzDnbdV9F9PFin3iubIdyPA/KG2LTi/kNKnzvGMQiL3lWAYZJKQgKo9pFgnz9d4Fm7z3cq2zShC3SKjAiUCeG8ZtUNR2s=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;6:sr8IsCAqJG2gwW1ak+XIrC3zBe1BHhSK/pTXDEbWNcA91M99n6WVYBiPw+BBjBpMai0Dg/waGZLTPrcCId9XK7KX2kIfUXsh+6XN5Am0XY4r9wX6q9ZxX/zymqcRQehHaWCIReRSRFeR3PaJG9OoX9pM5avNn8HtehWPiio4VL2PP74d4nEKH5J8exUfnPdTjGWrCoIUd/aKIDrHojO8YNu8pU+t4Yyc6JMvnc1XWPZEJzIJpkVPfJd1g6BnN3cJfC1yvUhQokQQXkWnMZkJTweBXemWiCD4tYyTWM659sCFvYi8urK+EKz/FoShi/ChxwG7I7ctJSCIfuzteNyxLPrrOukb/MY6BbvXNgV1LsMYjICLw1LFqfT29ezFgaOtKktpnElGIbLIKhujg4Byrsuc7Bz+s/TCxVC28zcon7pfTUO0XHe8fi+i8nJ9jNgSBtSH84TiEeCVBs+0w2TuEA==;5:JbpT29Ibnqnzw8kXB2qaD1M0vWZVLHy8qsXhzhJBndgsHfvY3FCMfmm3R0Ol/S3QMPbIuWPnIPmA1wJ1pOdfAsyiKfeOZfgZlZDG9sKJqrnLSab58goXGYnKKb31nO9qgiXh9L9c6dgIXvVeyUzi01qbzhEWBs8b73Rm8eAZYkE=;7:R9bpK1SgQtEGqJezgK5vfaaLAVDwD1Zh0br7Y7osLjmlzVyim+LMr1Bm/s2jfDZtUbZkM+4dCl7keo/xNsTYRspRkHM1GAmMlw7qWyfJZUcwbXYnz5RTsByEX94aqxhWmsk8hgruvlbyTu3VeGP5Wg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2018 12:54:09.8912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457406d4-fb9f-4738-cf19-08d65ab0c0fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 12. 18 13:51, Rajan Vaja wrote:
> Existing driver checks for alternate clock if devm_clk_get() fails
> and returns error code for last clock failure. If xilinx_uartps is
> called before clock driver, devm_clk_get() returns -EPROBE_DEFER.
> In this case, probe should not check for alternate clock as main
> clock is already present in DTS and return -EPROBE_DEFER only.
> 
> This patch fixes it by not checking for alternate clock when main
> clock get returns -EPROBE_DEFER.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 57c66d2..a23baa4 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1545,27 +1545,25 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	}
>  
>  	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER)
> +		return PTR_ERR(cdns_uart_data->pclk);
> +
>  	if (IS_ERR(cdns_uart_data->pclk)) {
>  		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
> -		if (!IS_ERR(cdns_uart_data->pclk))
> -			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
> -	}
> -	if (IS_ERR(cdns_uart_data->pclk)) {
> -		dev_err(&pdev->dev, "pclk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->pclk);
> -		goto err_out_unregister_driver;
> +		if (IS_ERR(cdns_uart_data->pclk))
> +			return PTR_ERR(cdns_uart_data->pclk);
> +		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
>  	}
>  
>  	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
> +	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER)
> +		return PTR_ERR(cdns_uart_data->uartclk);
> +
>  	if (IS_ERR(cdns_uart_data->uartclk)) {
>  		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
> -		if (!IS_ERR(cdns_uart_data->uartclk))
> -			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
> -	}
> -	if (IS_ERR(cdns_uart_data->uartclk)) {
> -		dev_err(&pdev->dev, "uart_clk clock not found.\n");
> -		rc = PTR_ERR(cdns_uart_data->uartclk);
> -		goto err_out_unregister_driver;
> +		if (IS_ERR(cdns_uart_data->uartclk))
> +			return PTR_ERR(cdns_uart_data->uartclk);
> +		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
>  	}
>  
>  	rc = clk_prepare_enable(cdns_uart_data->pclk);
> 

Nack. This is the origin version before dynamic port allocation.
Please look at Xilinx version which has this feature already and it is
resolved there properly.

Thanks,
Michal

