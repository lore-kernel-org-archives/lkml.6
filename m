Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C3221B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UpKdWy7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C3221B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeHIJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:36:34 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com ([40.107.71.59]:56083
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0vJlSvgvwnVpjnHvJqs0Z81lMLDC2TcuiA5WVxcV88=;
 b=UpKdWy7u2eJeGZH0Y41swAvFH+bu0gTVken6vvuusoU0DjfAyRaNIyne9rb1KZweBxGl8U5QmYaDi58ptboZAEvI1Xlv87ai12bMqcCA4CcgzUluRIAZwZCxkNUPvcdxFHgkinJajewdYRcSft7cbEERY47DkEmTBukAL/cNdcI=
Received: from CY4PR02CA0037.namprd02.prod.outlook.com (2603:10b6:903:117::23)
 by DM6PR02MB4329.namprd02.prod.outlook.com (2603:10b6:5:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.20; Thu, 9 Aug
 2018 07:12:47 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR02CA0037.outlook.office365.com
 (2603:10b6:903:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.20 via Frontend
 Transport; Thu, 9 Aug 2018 07:12:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 9 Aug 2018 07:12:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnf7h-00005V-81; Thu, 09 Aug 2018 00:12:41 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnf7c-0001pu-4U; Thu, 09 Aug 2018 00:12:36 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w797CZ6A003527;
        Thu, 9 Aug 2018 00:12:35 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fnf7a-0001pU-PF; Thu, 09 Aug 2018 00:12:35 -0700
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <y2038@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <arnd@arndb.de>,
        <deepa.kernel@gmail.com>, <marcin.juszkiewicz@linaro.org>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
Date:   Thu, 9 Aug 2018 09:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533792466-4227-4-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(6666003)(2870700001)(9786002)(31696002)(53546011)(44832011)(50466002)(356003)(305945005)(106466001)(31686004)(63266004)(2486003)(23676004)(76176011)(2906002)(336012)(64126003)(229853002)(316002)(8936002)(426003)(58126008)(39060400002)(6246003)(126002)(2616005)(106002)(186003)(476003)(486006)(478600001)(446003)(110136005)(54906003)(4326008)(36756003)(11346002)(8676002)(77096007)(81166006)(81156014)(47776003)(65826007)(7416002)(26005)(65806001)(5660300001)(65956001)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4329;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT053;1:gL6tqN6TngCYZo6vuiZV6YYW5townOknGfY0xvd6PlUy2fEqII4GYW1Mwfi3Mx5RvesZ9eFlHeoyzE9NgUGOIsiC1zeW1CFruBQ2PbtaLswqPybtooLQ2zwdy5htFgMl
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afad124-8eca-45c2-0d31-08d5fdc781f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;3:cRG74rpv+Hb8M6Bb3aAFspvnSJ/DEV6nQr6DzKoIn5/YD7Uvgmozoxh8+8Q4fK4TmtoXc7GqE7F9d9pjITlxMhYfQ8SAyimKorszH4TITUthxiDrejTyvdH1fKPtP/OrGZLZpLExEHGxMzPQDAPomG0+TMFELaOCskMd8KeRmerwr7jJqiQ2LNa3aaz6dFuBwAlzUDE6WEKoXlL20A/Pd0/AoO1qGsACse9TUO7vzhdWhqWmCZWEA0j1Xve+F/BKHy68xyvPK/8M9cdmy4NCEKdiWMqekL7mq4mTJwDbmV+7VNxBj53C9Fgazxihetg+bnaKFkrDwVoDNfToImoqiGLE6ia2/AxT7IVjAKidjU8=;25:8jouGUZv20doWC0qIa0uiU055bc+DhvTSAugRSbCpKQTl3YxCtnDbQmQYlSmBQFFv/skeEtJrSG5k2udKHHnlCx40qdCDAURGQWJ9dbeLwsGKGlpLblr0NK7H3MFVaYGcx+Y++nOFGdGyALeqYz5tpU9HSLdrEeeigmVt6CPKk2o8nalUAcjqUsJkUSRzlUqF8O6OMNIeg/rsn+MCZyoMCCq99HV2FdBqhdEpqszdudOwcXK4wPmVr05cmzo3SuSpqRaloPYFSJFE/G7ODTJ0bH6cJIRrs55nYDiE+yszaHEnGVwdFmpJfzUx6wq8IwsF3lOdY4ixzZpXl8j9EO82A==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4329:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;31:O9jfD1rqpIfzrUXQPpItr+XENE1GUj9OlgIuWnkRCthQKL973aNS42S0Phi20j7DPnhi4HxNA0ErtTUpOnPLa66Pi7FCS06L+RZfpokEATgQOJtM1x8BaDbWaI8aqaLowuSZ74v6AA/dL9HVuI0vIltLzlSb26VgybN9XnyAu8LOwE6kE5yaNtLnT0DdMgp5neCkwhSputpxWzK1OcP+AUN8kS4Wet4N+aQdGdmMbrw=;20:D3zsZ2oZ7mqHKeD4nXFtUVYmu7yUzZxFNy4zUT7uANHmNfdsLV0RsuRtTAGpTLhqJKL+DsZYIRh1KGzoCC6z/EagSdYW2KzNdUcPXE6v7kI7mdIIhWY96uvs+tOKMVpS4c1OjvfX1WSNNDz8lP/6KZc7czShJjjlYsEPctvLTUTe2bYzgDX+R/h9bwWMkaCcHvy9d+kcayEqT8ox+Dt56X15RvyXw3Lb8ujQ5P+JWtrDeOJ3i1kWLYsaPecoz/+VnhKhQIwI1LFWav6+MeNYginI0nE0xnl+mch74i29moWTtH9al24nNFk4aK9u9lXOeX6Xq0cT3nH5+wOZQ9Y6WhSSaZSnqPU/dx0L02uxg0ONZp2nEpQVxmxm8zMOGBFagIRtcUvqN4d5hmiUBPI+D3TnNUkT0IwqARgxKNucmbpeCHi2GpOSXNStwHDuvnBtFDbNgVgbnHjSHYx06U4umfGZ8Rji3M3WIx9LQt/q8QKdObbjhX70c78Zn1MXM5Dm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43298647A3F8CA4AE5FA76EBC6250@DM6PR02MB4329.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4329;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;4:UWYlmZe6qja0xRCCedYzwq4U1plNsCQ+5RAfxbRBU8QMNHCPWfVPSpxIoCpICjIE014WJdJRyfI1pslazsLO9SEJL8s+7erUJ++bQTCUOvRILP0dPp52idfUlC6fdpmSQepkeCZSR5Esult6/FY94t7IRb80dg5tiIoJf5xv9Os5bA7/P7Qc0p6AXu3mJPF7fi/7HFSnfdmA4fVpf5DQG2Tdzl6Z18YBGybMuw49N0r7Xn50ftfW1rWWMdQxsLdiDvWW9Re2pNNSXijYgvo7qg==
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0MzI5OzIzOkdVSVdaMDdYd2s4S1E3NGNyM1NKTGVUa0tR?=
 =?utf-8?B?K3VaeVE3bmd6NnM5b0FKM3h5ZmRzVHlJYXdWaXYrSHZ5NGtCUmtmeFpOOXcx?=
 =?utf-8?B?bmF5T1owaGVYM1U1Sy9pOUVIUFQrSDlVQ1Z0amlUTExyMnpyd2xOclJoZzly?=
 =?utf-8?B?ZWV6TjgxNnhIK2ZZYTA2aHJaMWpWNno1YVh1SWc4TTdhQUJrR29xQ2l1NmlP?=
 =?utf-8?B?ZDc0YTNDZHgrNmpHcHAva0s5dndJb2ZEUGkzRjRUYTVIVlhoSEFkZmNnanNl?=
 =?utf-8?B?endjSnNnL0R3K0NOL2dxdDB2QnZ2L3ltUnFuZERvSStpVXVlSUlhQnpQM3la?=
 =?utf-8?B?UlNsUmZRWDVxVFZYVHFmTVoxc0hRZm1TTTBiV1EzdG54ei9iSDcydGRhcmpM?=
 =?utf-8?B?MnN4ZkphKzVjOEFXd2t2eSs0T2RoTEMrQ0RFdjhwcDh5dmdHYVgvQm5VYlVL?=
 =?utf-8?B?M1Bpck8xVzdydGo3VzJuZU5yVE9nQU14NzJLaGJUdERTRTFTWUhSZWZ0Nmlu?=
 =?utf-8?B?eG1KRHRabmFNQjVNeUJBMVNKM21oRStUT2ZLV3BxQWRhYkJWK1V2WkRkeWNv?=
 =?utf-8?B?UzRwL204YTBpOE1YalI4U3FJMEhGMkJPQkhOV2tTNlpTcWk4YWpCaDJYS0dk?=
 =?utf-8?B?OUs5eWovVjN1RUJKdWl5SEdmbG1YZ0pYOVA4b01oZTNVQ1Y5ZlFRWnl3Z2d6?=
 =?utf-8?B?a24wSld5OFBxUng2MXFSSjJ0WW1DQnFYODJ1MFF1ME8xZURGTGNrVCtDaWwx?=
 =?utf-8?B?ZWVScjRsUWJ5OWdEWmN5eUVkVWc1ZUZ0VnFJYTFPWEJhRko5VkVsOStCK1NQ?=
 =?utf-8?B?cjhsV3czM1hpejBMSFhtdWZnMDZLUVhEODJJa3dtVUtKZVZubHhLLzNvUldH?=
 =?utf-8?B?U0hpZEtSdHc2ZW5Tc3NaWG1WdHpGNjVNSXJ0Y0lDbG4zbXZJTHZqazJETkg4?=
 =?utf-8?B?d0JNOVFlYW5ZODlTZVlBL2JlaHJFU0s5U1FpeG0zM3BGYWxzZXY2VGFYbStZ?=
 =?utf-8?B?NlRtaVB6SkMrTGhCWnNwdVZSa3NRaUxDN3ZTcngyQm9ZQmxweWZaV2Q0VHB1?=
 =?utf-8?B?dENHekVRL3oxSTJxdzBNeXlnVlZyREpqYXZOMmtMS1p0N1RkVThublNRUGQ5?=
 =?utf-8?B?YnZhWDNoc0pDUWRlQTA2WUdYVXYzdjRtakNPMzVjRGZRbjRaYloyN0RXNEdi?=
 =?utf-8?B?N1ZpbHdVbk5vVTNPc1IxYVJzZThiWGF0alBLMDUwTVFIUE1YZ2ZIN2c1RG9Y?=
 =?utf-8?B?QVB0RzRVSXY4REJSbTRuTDBHSjJERGNNT2FyZExkN2F3ck10U0gxcVVXN1Iw?=
 =?utf-8?B?ZE5vOTVvSFZFdWd4R0l4NWtMUlhnMk9GQnlFQTBDRXdaR0lVNDFsTnlNSXNk?=
 =?utf-8?B?clZsdEFjUE9KWHNQeURVRWdQamNsNk55Rmc2QjZaN2hqdWNTZkJnZVRmVi9o?=
 =?utf-8?B?SFV3YnhqbHdaQ0EyVThZYUZGTnJXdEtYZGVUL0w5eFVBVHNHaG1wdFNoMi83?=
 =?utf-8?B?blgzWmtqRHo5c0VZMTdjdUdhaDdkWWM1MWhTZXBCOXJNakxTQUhuSXJHNEVK?=
 =?utf-8?B?ekd4UnBBL1BvKzZqL2NlaGJieGNIaG9IenV1b3JPaXZtU1hnVzIvUnVOREpP?=
 =?utf-8?B?UU44elVqUnNJcFZGMlJnVEpXNG1GdzhPTmdQenZQdDF0bUgvREt6NXZVOWRh?=
 =?utf-8?B?TmRMc0RHV25aeEl5QSsySG5odHhDRGE5SlIyMDFzbzNEekdkc1JRczU0QllG?=
 =?utf-8?B?VUFpZ1c4YnJWSVF6c3pxWUlzQ0Zpbk1tdDNJL0Y2QVFyM0UzSU5ZQ0pCcHIx?=
 =?utf-8?B?djg0bXRlTVV6akZkVlYvQUtQcGdqb0hwMkVlNGhEZ2Vvb1c3VENRSFN2MXRN?=
 =?utf-8?Q?/phmQZ45hgVcCwjDkBq0w71GCpqBNIcK?=
X-Microsoft-Antispam-Message-Info: 4O9+P7+zmGxSIGjuCbuH1TLC6SvFq1Yk5HHyvHOPruXbWstUyRg9VhQ0+QNX31exUA93w2AApECex8LWVQmJqlrbrVbh+z3ReX01RmlBwXDY4KhSyfhD85r8BcD/AGgqnihyLIdAmp/zSF5xGGYI8KqNVZHj5yvlmtuIEvIcVpXHTZ/Ehp2VCcdZQD3AazN368jE03LYEpJoAiOTKnR/CkRk7RNfi66EJ0R2xrYdU4xtG1jQlnhYtGUt7LBwMJ/eFwMH7MIAlpg0cKHmBfA46wGR2VheNy1YbtimtlOmH+o4/eS/qcAfwMn1mQufou1D+RWaQz0BaV9vDUmzFn+pj9lhocQKtX8PqhCspuq0v4M=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;6:AMQFbJJqSZixZ448UQrAtmQC7IL+Bs3caPdwqClW7/nwEs4NjB2tdYEq4PqcNKE2nf02Lg8CKQHahSg6Sqfmipe9slLkBauJmz4c3MPYEiJC20ePK8MFyhznJ3l4x0hWzvCJYu0fGpvBNCy4G/7F9EPXz/qjP2z4K+Ops78oqVtmAUHHG4sdDbuqVNM9OIRpBObkC7DWkXvaIkMwFpwt7WnOae+LDmni/Ze2GSEV5R1I1PMBhQa09n7DLvB150MRg83PtbEX9eRYq3ippwUyBI2Ovnx9eZ/AxykSHGGL6p5/26o7S5rXcSWxh6IRDC7D0ynGZKntzxvuB/z9eEA+Iv7961wEVJ0gHvTC8k7uWYFXqylJGNKI+OO10+PrUX3Zgr+5q10r4t0QASEPMxeUYIUgG2YTIGyAHohW5Q78ahiuo7xYQWdBTiMmeYpI1co6B4lEve3NX4PpTzH2cM0bdw==;5:GWCWzVSIkaBaDrUs/mRy9RzoCTVs7eTR5BhjZWft3iV62sCQkamh7Sm7y0R9WsmDl6hG5zslD0NwuwfW8sx6rsqzOGtjRUYLmWN40baHCZ/u5BSE9N/OSgEg1DRc940/JpZiHj6NDfcbjsZ2CfilKAgfW/BNbAr5wGIE8FO0mE4=;7:y2DGg7uH+4bebX1Set3MIqcf0nF06vfJva+Ytbc8pLM2MsOWpYdDwmfHYRXxTsSpu7kTwESXE5TNTpSfEdyiXO1HeVctIjAd7ASKXuE8+jXH3EpmvRi3J7to7MRYjf3UXPgl/l7eERYvIK1+J4A4Oc6ZGcBqkLxF/M5tCJWa87z3sHPSt/4lrce287qnpCSitd6Vup7Iq9T8D5BnQ0pBjRNLlZfzxPoLd8+RIGYMOmeY6fgsA8L0SC6+Y3gREyjw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 07:12:42.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afad124-8eca-45c2-0d31-08d5fdc781f9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.8.2018 07:27, Firoz Khan wrote:
> System call table generation script must be run to generate
> unistd_32.h and syscall_table.h files. This patch will have
> changes which will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> arch/microblaze/Makefile and the generated files against the
> removed files will be identical.
> 
> The generated uapi header file will be included in
> uapi/asm/unistd.h and generated system call table support
> file will be included by microblaze/kernel/syscall.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/Makefile                  |   3 +
>  arch/microblaze/include/asm/Kbuild        |   2 +
>  arch/microblaze/include/uapi/asm/Kbuild   |   2 +
>  arch/microblaze/include/uapi/asm/unistd.h | 409 +-----------------------------
>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>  5 files changed, 12 insertions(+), 810 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..6121a2b 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -81,6 +81,9 @@ all: linux.bin
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
>  
> +archheaders:
> +	$(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> +
>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  
> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> index fe6a6c6..99225ab 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
>  generic-y += vga.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +
> +generated-y += syscall_table.h
> \ No newline at end of file

This doesn't look right.


> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> index 2c6a6bf..8fe26a3 100644
> --- a/arch/microblaze/include/uapi/asm/Kbuild
> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> @@ -28,3 +28,5 @@ generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
>  generic-y += ucontext.h
> +
> +generated-y += unistd_32.h
> \ No newline at end of file

ditto.

Thanks,
Michal

