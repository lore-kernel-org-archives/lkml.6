Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CC2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="D279Ayss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfBDPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:55:42 -0500
Received: from mail-eopbgr790100.outbound.protection.outlook.com ([40.107.79.100]:60633
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbfBDPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqkTnNGBDuNHq/TOkeQ0RYvchwmwpm4ywLV5Af091fU=;
 b=D279AyssZVDPq9s2S1ogS4cXgx5q6plrbSX/0vs4+Zpnk0YWT8W0/Aus2s/OtzcXYr5viC4EwJzzNDkY1/ZpEQbuxBX6hP+wuzRFRC7972qfR3ZaDbSdoBGDidbCuKBFvDs13ASnBckHuYr8jRxO9Gi2UC3pJfat+psg7kdhj0U=
Received: from SN6PR0102CA0005.prod.exchangelabs.com (2603:10b6:805:1::18) by
 DM5PR01MB3210.prod.exchangelabs.com (2603:10b6:3:fa::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.23; Mon, 4 Feb 2019 15:55:39 +0000
Received: from BY2NAM03FT027.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::205) by SN6PR0102CA0005.outlook.office365.com
 (2603:10b6:805:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Mon, 4 Feb 2019 15:55:38 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT027.mail.protection.outlook.com (10.152.84.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 4 Feb 2019 15:55:38 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x14FtZTs026356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Feb 2019 10:55:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 09F7B7A4B1C; Mon,  4 Feb 2019 10:55:35 -0500 (EST)
Date:   Mon, 4 Feb 2019 10:55:35 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v2] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
Message-ID: <20190204155535.GC9802@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20190201180831.19839-1-prarit@redhat.com>
 <20190202030240.GA9802@mit.edu>
 <4adb711f-f81e-31ef-c581-4d5ecc739bd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4adb711f-f81e-31ef-c581-4d5ecc739bd1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(189003)(199004)(58126008)(1076003)(186003)(229853002)(26005)(103686004)(54906003)(75432002)(36756003)(90966002)(42186006)(316002)(6916009)(476003)(126002)(11346002)(7416002)(446003)(2616005)(336012)(52956003)(486006)(36906005)(86362001)(786003)(16586007)(47776003)(46406003)(4744005)(50466002)(14444005)(246002)(6266002)(478600001)(8676002)(76176011)(6246003)(305945005)(26826003)(23726003)(8936002)(88552002)(97756001)(106002)(106466001)(356004)(2906002)(33656002)(4326008)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB3210;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT027;1:uQxPzIOU1jeC4FOBjAqspmgY1nKzseHJbE0zykcHebZG5hL8HPRt3hSqNZOgDKZuyPpFLmGX+HJcQXwsz1GWcpo4IrTELoNpNo1r8CYoZCEAEFzxOG83nTYaV8p+ec9URiaxPMcyvK6eTQRLM4my4SP7uiCFzx5SydYOzIgHGEA=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6dc7839-ea71-422f-4192-08d68ab93536
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR01MB3210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3210;3:vjNj0Bwc8sDQ0f1CKompjeyOUTXVmdRz5Jx30fdLADGxwq6bVIfQe+QdRvna0PUv4SHYjTiN5RAIXoWcZ5hR+uSEXwlo2FpLKGo5BZNYejqudMiWcLMOhihGdiN3JSURpWwVjRt/M63m+hdum2ZBi335RQ5tPMV66+DW9k8gQ+qIPvSvljsWJ0MXlzkdhN2+LirTTRM0D9S3gO/r6QCKq/5NJN7/UYMa5pUN/bWIzEP9m7mNxBM5RqMRbP99ptC8tuEpB2RPpJNJqfB/n5HV5NT691RBjjXK+b8e56Vhr7u0Y30ehED3mPD0kjZSdJxAhQ1PRe9+p3PffyoXTOCjpu5inDspUUbTLLrbgSRXenYuqLZbEyajttgcGxU5Sx00;25:roY86LIOqn/OSvp5yVVhprJq54YIV1ngJAO+cSFU9MAqBmDP+ofeln09t5QqWt96wdAVMSmIlE0RLxWGOfIykgtqVDdZ5mSAg2e2w/TWsvZ2cqoCsWGQF8CtpVny5xm92WHaHFAVmyopMQy/CbWNIK5/48jgJOwIsa60wP2j+sWrNjSblbvckZpxyL2Hr59AjpMSFSbSbKWwh6E783vLRhrq+zG208RWq9GdzmAMU19CSbs0nuPxDPs1TrBgwczMAGY0r5nByw5FH1qEQfHybQ88CjrKVQG9S+XW/4yNzWqi21CL6YD/vR2WReopbknMSIXKQwpaR7We2TYL83OCiw==
X-MS-TrafficTypeDiagnostic: DM5PR01MB3210:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3210;31:wc7AE99Egsur8JzI6xkDi/dx5L1CrFN7mYhpS6v2LYSrUSYRq+aWRthfXN5yj3gagrUXsEafknj3Iz8IlgJ2PpGG+iOChphw50qH/1HnmGMacJP48hPg+b7W7wuO2fy3R4OGz0JBWb/HRdvqqwzAVX5YzQbc3Ud9XawiZgPV9pq5/f2DQkjumOUJSpUt1ZFBXudgOfw/mT+Eqt/hx6PLMPY71TlT155uXfvzxsh80EM=;20:JJ3RinedLHG9CpeEPQ2WiGCMdE33HhMytSKx6ZxbfFiYUpVJ+SY60UcKxMCMph0QGT6D0zOB4ZJNsUB8cwssAhudB3azoY3Fuu6upg2eJ2X+xL6oDQRgcYVNYxE4/8D4liS1o6g8smE/aGc7naXUyf0jTjdW3fzn7Ry/wnunW/3u5Lq0rZ/4g9Eb22zRfvRouaQpx8cZkNkIjuwz6BCbbNMNAOj60NOfKZpJLb6dUFx5GN+lsmClyxsc2PLoXBSlvViJtnS0Mw0T2cTqiJ92iciNH4iGkCZFNPTTSd5eOgXy9L2UlAObx9/NvJiZmXbZnJpTJN0OSIiQq8LT8uqNQo29GzjtLecs9uEXXoYAYK4lH6SyfeNMyj/+hyAVjmE4c1WtxcztIjSQPCTOrentgTys1ymKxEX2CT/BftBYQGs7qZqN7EZD3b0KLHGZwqcrsZOacFzhu3JWvs1CmCTWUSi6xe75389hISqMZqCjf2u4dukPjZjH/tymXDEQmJstUnFItowpXmqPOM0x/cS9E3WbC2yWlNrKP78iuIEUUMG6LuooQIhocH7p0petFv4ZUWmTpK4UBS15GGmUdYgrqb66wNbv7SPL0Dnl/ZNtb3k=
X-Microsoft-Antispam-PRVS: <DM5PR01MB3210544BB418C7D078D623CAB56D0@DM5PR01MB3210.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3210;4:zxb4th8fiVpiOyVxphF95AytCZGSCSqk/WLrXKM31AhmsEESDvrY/fD1J/1543w+gzP45JfEdQ74eki0RWxUnl6KRB2K+mfDCMbNm/DLPcwpLDmeDlasPrZDWKUqDTCpuDT+Bqw6UsV4X0f0DDo1BXloOH0nKCgZV0p7Bv4RM56A0OEGKxj8eHr+mTb7NSNEKHUVBeKsDPKr2dWFk/wbcKRHlITmCTGDI4ZRHxDC6xJXxKM1IywT0hHP2VE+24PI98hwBZ6zWMsl1NsCrClXoOhD3NW95xI8nYPp+FP+yfc=
X-Forefront-PRVS: 0938781D02
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR01MB3210;23:g1UPPJqgeMqiYV029Fz3fcGFq22aoNUQf8iZREuIP?=
 =?us-ascii?Q?D3f+yk2EmDEVzLd3AruLKLuMl827p0XNo9ZArFQndHa4joG+DihmwvUDaGJu?=
 =?us-ascii?Q?5/pl3TTZlD97bKCktinizmwN4Sz3ghYHwzoaLfRui9cOHMZ9zQqijTu8yrEw?=
 =?us-ascii?Q?ARtrapVjtgw4S2JIjuUtgLm+3Koi8Cyt4k0xAQPJPsjm6YgSYTxxz6i/6aSB?=
 =?us-ascii?Q?sUVJdY8k/M5gfPQLe8YNROs6qilUKEljWBT2oaR/dmoIxYWJ2rojElqtcCpr?=
 =?us-ascii?Q?+GksNsup051375dSfBWCaz6Z8vFN4t7iXTEobptSsf79egrNsBQP5oSKFTRx?=
 =?us-ascii?Q?FStVjyONypatdnTMKaFrxxZcmmTm8EQ8KTrEIwf0PArAbEhrfaHQlUfzL0jP?=
 =?us-ascii?Q?0fy06ty+zz8LB6OFiEqvM/sftBIbA1XaO5Uvmgcr5fhVjLIomjQy6QTP6LZa?=
 =?us-ascii?Q?KeirxI+UBoksZm/udQ1ui4d1RRdE94Hrqa9mfrr59tG+WM6Vn6cZ6tMfFRI0?=
 =?us-ascii?Q?+sJmUUpaZksB4lK4nJ0gcmOoJVyc57k1ul39YrfPALW1K0T3wQlh0rbux/CR?=
 =?us-ascii?Q?cLsEGNYx2eD+4B/7GndxIGY6C9YbXZWKxeYdZXosw0P6oP4UuxQYILErlsx+?=
 =?us-ascii?Q?1ayFPLrT80gtveaftQOwwtORPncwJssZA3t4PdrtaZGrsgSeu7mVxlJOWbxI?=
 =?us-ascii?Q?8+VPZTmDF/wj7NcsFFRLYm5mjpCe9PGAyGvQp+GQF2ViOZBqagMkKiDi6xWC?=
 =?us-ascii?Q?hiTdGcIN8GFuErIAvkpkwutxtVax1oU8gpt9amQ5BX7PhL2g/QkyNNkOrnEn?=
 =?us-ascii?Q?a+oQCCgzSHk9NPetf8Ie45D8WC4f7wkvUSQBsbWyeRzs332WNfyMjEag5rdd?=
 =?us-ascii?Q?uDGQ1uHsbEokDdHqwFI3Weat3n7PeE71AtzQiFwq3XtYakr115sBY9LZNQf/?=
 =?us-ascii?Q?B0FlcRU2uWXbGLIPMWEtQHiBqy4aYm1plwMML1HDgLPUiji7fgAAzanwZt4C?=
 =?us-ascii?Q?EedoYZTw3UrYIYiVLq7gOsMQ374L1ve797D98/hZfT/Ov/APN6tkWJRx9OdZ?=
 =?us-ascii?Q?NUwyTvgEhuY9TSdIJj7EzwuapKYb4zoCvIHwNy31FY/P4hoykrtdUuKVM2s4?=
 =?us-ascii?Q?Xs2e5MVKYFPgXE0b9tILfCYqkLTBq3yf6n6AvJQXtiqH1GDoGnt76hmlKimJ?=
 =?us-ascii?Q?81c4E56P3AC2A3jW5sai1GgzQ+Yq4KzU92H0RNbMk3u+K2UJyT4pUq4n6fC0?=
 =?us-ascii?Q?zmXy+1rZ+LYpvLsWbDv/t3wUfatoiZfr96PedNUPSWmqmFMsFTHvKw3LEFn/?=
 =?us-ascii?B?UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5WX1CQoep95evCAdt9AtelvRmeKX/3r4Dh078FY62x44nUV1z/wBmELryqWDROZB98egOPawyhwYSzOzx25vgdlz/Zb0zTAQBdBo0cj1uD8AabkDxZMGoE3emjTSByi+HCEWWVndLvcKLBBYMMNR3PxCgrEnOd0Vgp5+T7Ac8yDyDY4aS3a8V9pBhaPGD1QpBESJ8moCR86S2Co7gY+ebXbZh5UBaC317NsK6K3CK2XS5v7jFSVRObsXx/LesZcla+9JuLWL7d9eOX3DmQ896fnS2A73hdyh9RkqJm2af3BbL6qP+vR/q5LBbwnetlqS7Nib4XTEbjebXL+RhbFIklLa7Vttu3glUWqB6kIjlLufo0pIZHy1qaS9JHMZVIEWoC2kWF9fjbIohqQyQLVJ78RBsO07XrqQHoBcoe7Oz+8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3210;6:hr2Z4FXWimKkIIX5lG3xiuDPi/4x9RXOqMPrQ1/n6YTTSJQkRtoHeMUXb5pTr9kFgTV0tk7HbxLBA7lGeHMLbzT68Q6rxSmVDO8yUcHvgh1l7WvtZC9xc6oKi+4iWKera5c08mUctf1t7Levqf8eq1e9gbpWXoDV94ZAwLz9vQ6DBqGS5cOr+Q9fgYxxdDmo3Ft0VL4O8vzURd4fugYbgbXb6BcvvNLe49i4IIvveBdLfX311wjYC6ekWymqR5iUOIHxIJ7+iqYIv/DU0H8V8vkYm3A4jx3WdhxxIxC5XEL6gsH8t/a6CW1PAZcl7ChmGeOVxkVAisicaxFOFv9dGpIzMa3HMyc00rX+XplwRLwi1yYoAEzUeWyn/KAJK/F/y2IL8oz9Ue4OYrQBIp9PyCOS30Rz22sBv1gY3NLI52ZgUb9jm8aOsmM3TzWT0EnychZq7gqCpsc2bwZSU9Jk8A==;5:+tH03Epleeg+DYTF047htPN4WK1jak//SX/1O9ikjNUWZq4eiTTaG09CO8dOw1sao/sAilpu6eWPmL+6BeSOz5N0tiQcwL5KMEU8uoRbNfum47B+TNr+Spb6DhMhDlcL+nBdQwll1zPcnyyl5ssT06u4tSogBMPoOMHRfBUIyap1WL5aEaQOT1gyBZBmpPbmVGd3fwVJ2+i2Oy1m8r60cg==;7:RTjOvBVG8/2syZxczfQnpvGQ81QHQjFTN+XaKO7O+Zvvfith6LfY+/r0C4DD0iGTkCnvZQBhFxHMHMoKk6RVmOAPijA8equ9bVEbaFfUD80iSwN2lHS4PdTSmw5JTIDbTJWsC2JPb7V97fczSW89Mw==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2019 15:55:38.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dc7839-ea71-422f-4192-08d68ab93536
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB3210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 08:09:37AM -0500, Prarit Bhargava wrote:
> Ted, the bug I'm trying to fix is the warning:
> 
> random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0
> 
> during early boot.  Even with the kernel parameter the warning appears.

Sometimes the warnings are real, and shouldn't be suppressed.  A
Debian maintainer once tried to suppress a compile-time warning, and
it was disastrous for security.  :-)

What line number is that corresponding to?  It sounds like something
is trying to use get_random_bytes() before the random driver was
initialized, and so the first question is does it really need to call
get_random_bytes() then or can it be moved?

> > Also, relying on the TSC for entropy is not something we should be
> > recommending.
> 
> The current code uses the TSC.  It is not something new I'm introducing.

But we don't *rely* on it.  That's a big difference.

       	     	       	    	     - Ted
