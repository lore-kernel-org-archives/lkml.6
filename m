Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD08C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2239213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C9uuOmxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2239213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeJCSOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:14:39 -0400
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:29888
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeJCSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4Pult4Y/CX0leSjEmHiKw5sL+MuPxH4DheUotyv2YQ=;
 b=C9uuOmxjciKh5NMFSWGnoU0zB30VA3513UiG4ZBMQur6ebI4RfffIzQA2r0yqRuMkPdEWOaKDyK4mnWiaUL3D+UGHRneIkyh4XRKt9TS/xnj3cS/wcp+DfX6abZmaYQbOmKP8d6TYcdakSudijFGxSsVMsap1GABvymAQLKSGU4=
Received: from SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) by SN6PR02MB4768.namprd02.prod.outlook.com
 (2603:10b6:805:90::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Wed, 3 Oct
 2018 11:26:35 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0026.outlook.office365.com
 (2603:10b6:803:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Wed, 3 Oct 2018 11:26:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 3 Oct 2018 11:26:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7fIY-0006dK-6Z; Wed, 03 Oct 2018 04:26:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7fIS-0004hA-Vc; Wed, 03 Oct 2018 04:26:29 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w93BQJrU016667;
        Wed, 3 Oct 2018 04:26:19 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g7fIJ-0004gA-98; Wed, 03 Oct 2018 04:26:19 -0700
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
 <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
 <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <440fc4a0-cd4e-c8fc-9278-928cf5b7cd92@xilinx.com>
Date:   Wed, 3 Oct 2018 13:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(438002)(501624003)(189003)(199004)(64126003)(8676002)(106002)(93886005)(65826007)(39060400002)(6666003)(5660300001)(54906003)(63266004)(7416002)(305945005)(478600001)(76176011)(58126008)(110136005)(356003)(47776003)(6246003)(23676004)(2486003)(53546011)(31686004)(486006)(229853002)(476003)(4326008)(106466001)(8936002)(2616005)(65956001)(77096007)(26005)(65806001)(81156014)(446003)(230700001)(44832011)(9786002)(81166006)(126002)(336012)(316002)(31696002)(50466002)(36386004)(36756003)(11346002)(186003)(2906002)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4768;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:KV0c2j+vCMhVvH1av/vRFsPZgn9aBADLJTJqXTCMvvx7BwIh75io5xIMZm35lICUtHlVwPCZfIawqRx0ONw9rrX8Dr+XFs5N7tdjeO7h1/I4oJnTSe4PlbciWkfiMlZg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70efe26f-bb79-41e1-c6e2-08d6292313b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;3:DhD8pLf4bFvO6Xg4rMElQ+5Rb5OsRXDqw76TMpXG7UZ2FC6YfwLHgMe2dcgItfSRv+BHArp2MKltE3b6exEWl/qvw3GYq88EwqYlU7uOiIHww81BWer6uBNOiOa6KSiwVZynnju5NCoVPPORZKvbH4IcX/WaniwWDlwslhPiaNK2TUATwvH56dwPOyVRQ62Foxe++CSNhCpgjHuBkiYpp/RsitREit11j+qgpOdBlOUtCyj4qKT6urCQVWk3cXggOcrzlu0OYoUgX9JTMLhd5/BVvDITDLtTyNDWkiCM/yKX8bb7SMYoMN1PP4ImnEw9Wsqv4bLMf9Tm1rMXqwQL4OBImWMeN41CO8/AIWwIFjE=;25:oErzan2+NlrqykwdPGhLRDsMXnN/2YIjogm04yP1HQ7f8LYjvczyKWz7P91txrjbJo7pldkg1rviF8vDH3/XBin0f4UKcxq3ANq6miJJfxkbV5M8Qhg6cH7+QVLIyk/oge04dTbw44TkFPk9Th3b6q1kdCxNfXqVfNsYtiiJ8rQIasAZPZdRyCiocPAoDXBGr4mWFkXG3VMpM/xu2f/K+AXsoYIi+E+/U4M4/jARQFCjNEQP6qeKJfgQq1t5PFgdR8+xQ9Kclin7OnMJDCbSro9Xpn269UicvA1Xg/LCCdSyEQE1YrV3XpBAQgOLPUOhJgU/4b6vniMDVi8jVT+z0A==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4768:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;31:7qNtoXVrJuuI17kJ47jviQEhZauR6fR6Ut1v4eyEzpUJv09vPAdSQUsSlg+e9jWX1DDq+J5eBBJT9LeAcXGqkaJ6h5PyXQnLf1cTqCm5LtrgZlt5XibKbzePnH8F9O22Jec3b4zv1DYXJy29B4ojSsPy4IEFMqMZrSPdqTwTqz6Qpyt9LvgGEi8CoUS1Wi2ultxsA+7mzW63XihZ5YAgeXVeSQqvl3cOa5F2v4SUA+w=;20:+8pluQntfbUIIfofx23N4e7tEhDPfTPtOl2vVbBo8c619J9e+kRqbTuxRt+PTIaKUkPdyA9rzZLHtZmKeU1ZLxN5v7CoTAygSFoxaoZ2CXeJlAZZtTlviJrprpIPniR7fgBjKFeWaWYaCy8s1Tc0fdyvzDx3/SB53NYisg78q+IB+yLbyoq3arY64neLeuyrbz9ZYB+EOGDOZFKNLeRes/Ml6UgwpOoTS0ZWcwQYz3xNhZrCttU7q0NnyDuoxY5HJTsvp6KUqSz3hgwmdX9zk/L3gtd15bz61RRE5bLMsjXwQnu7FG2uUxcthIsalamH6de0bRgCmHuGx+QZPVdUTw5q8C8NYnTDLWE1urk6xCMBe2rM0rycmuRu5oqMPs6+SLfT70iAyJo9b1qaCJGTzsbGZ76bZQQC3qP/VqJqU5GA4RR59gymQVOZ2u4+zirmb2TTI4a0JMJ8kldDvimyr9ama5lVW8ouVMTUviqygBTfJQU6QuQ2RtLKPbEj9s/w
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4768F05B056DB1DE57A64543C6E90@SN6PR02MB4768.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:SN6PR02MB4768;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;4:cskLeDPzZ+DYaRyHEj3s/1ewF7km5xb3Z44KPRzBtd4zfarhzcxO5mrowZaYFXarbAefpEHp+R01VLZ4zkga3tUZxMGbNm98I1YrPAeOw2iWeG3wau+omEepF28RgNKYyEBoKZRDSsL4WLFb1rnAzQhlqQcUQeGkQ5FWuxvoJ/hAVC64qz8Ozpd5ljzoRSX/EThZzV/eZlrqNHcfeBRHUS4ZPGIwWzJP/LYF3/Kb/fzVhiSN/3J7cDKiLz9fhA86RjS2TWzYEgC52Ad9TviEr5Gpr80xMvjhHunyO2kuaY2ck0BChFcWvI19CMrTQRH2
X-Forefront-PRVS: 0814A2C7A3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0NzY4OzIzOjRyall6VlZLeUhKeVV6K3FuNVpUZTZwK0lS?=
 =?utf-8?B?V2lIVzh0N1NWNHUybExNMjlKNGhCR3B4RWpocExNdE4vaEdhV1dZY3hhUzhi?=
 =?utf-8?B?VFNTMXMzLzZyaHNUK2h4L0I3Z25NYzlIRnV6R2RtKzdFYkkrMlJrSGNWeWlw?=
 =?utf-8?B?U3dGVDlSdEFYeUNtelRBcDBOWk93ZVVCS0JnbkRFS1Jab1JaVjZFdTVTVEt1?=
 =?utf-8?B?YWtaNHZVR0YvU1grQVBLeTRnamw1RS9NV3B4VHBZa2lvVVduVkZjaVpiMVpt?=
 =?utf-8?B?QzdPMnViOExpblprdzhWYi9XRmFyRlRDaDhQT3ZDQmtnZFZWNXREd1lvL0VJ?=
 =?utf-8?B?aGhkZGZPd1IxVmtjWDZUS0VLMmJPK04rTyswS2NMV0dqV0k1SFloOFlFWE96?=
 =?utf-8?B?SXN3ZlYvRXNMRTdBVEJ0bWZrM0F3c1o3MHQwTFEyYVNpQVJTREtsVVNlZ1pN?=
 =?utf-8?B?YmhlYVp6WUorMy9jcnNIcndpQnlEWGx1ZUFXNlFUanFlQnJldjJXOUFqVlVo?=
 =?utf-8?B?bUUwNlRKaDNQdXdLNHBTaitWUUlHU3FkeDVVRUI0c0Z0aGhNbHVCUEtOaGFD?=
 =?utf-8?B?OWI4ZzVqbkY0N3F5cCt5Ry90elNLcms1dlE4NldFNUsvWlUzamhsb3FQTzln?=
 =?utf-8?B?WDNIUTFxS3hrb1dzQi9vZW9DMkRSdjM0YlVva2QrRGJlVFEwbCsvbFlyL1Q1?=
 =?utf-8?B?VzlLL0h3ZkJWZ1F0SVdZVzVJaHdHSmRHSFFBazg3YkxCaS9CSEk3cytmTFM3?=
 =?utf-8?B?TFhyL3lhUUFtUTNDbUFVK1lER1ZSN3B5QXQyUkNtcExsd2JOdVZESS9ncEtH?=
 =?utf-8?B?a25QMHR2RVhOMGlEclVUbEJBaGZuZW51SnlQMmUvNm1FQ0V2UmVmYmFZU1Ev?=
 =?utf-8?B?eFg2TmcrRElrMGlhWDZqN213d1lMWTB6ZVJ3V0RBa2o2T2c0WjBjU0Y0a2dK?=
 =?utf-8?B?WFlJSzlqSXMyZHh4Qmxpa3V5Q09Fb3J1bWcrN2c4Vi9rNDZzVGZNajhJTFo1?=
 =?utf-8?B?clZ1b25ybENaOHNOaStKVzR0dTZDUUVveHA4cUx6VzJqazZ0S1NycWpVOUdC?=
 =?utf-8?B?WWRLQVdxdStJam9tTDNQbE5mbDBLUFpudlppODJsakxnTUdCWThib3VUQlpB?=
 =?utf-8?B?MXRsWGlreVZRMXhmeGNOMnFRbDdOVW5IUHVGaExoTi9jS1llbEQ5QzhxNkRv?=
 =?utf-8?B?QkthdFlYREZaQ01tREZkUTNZRWprOGUwMG5xK09CZ3ZDRkNoeTI5dkw2OVI4?=
 =?utf-8?B?dW5QUTY5TUxSMWxmaFBTb0N5alltSTVtSDJIbW12ek1KMk5nV08vRm5KczFv?=
 =?utf-8?B?MjlGN3hyNTU2ZXA4WnQyYmNMaURzQlpwaWxPOTc4YXpQaE9HeWtqTVBJZTl6?=
 =?utf-8?B?NGNPRW9pU28weVpURC9UUS9WVWdTZW5vOU5uWTAySmVNQmhLYXNkaHV2OUdW?=
 =?utf-8?B?cmFEUjZ3Z25UM1grZ3VOVHVvYmdhcFVaYWp6Qmo4b09QbmF4WmdIOVpSRGVP?=
 =?utf-8?B?UmJTdmg5TjA0cmpRdnphL1o1c2Z4eHNwM0d5dm5INnFKYkorSWV1R3FaZy90?=
 =?utf-8?B?MklON1BqL0x6eUU3Q3pKWGowdzRKWTl4dUxNMXhZL3o4WThYQzlIVHZuR3RF?=
 =?utf-8?B?RXQ3R0QxQXRqWHc1aDdwY0hjaWVEMVZ1ZFd0UVpIOEd4ZGgvT0VKU0RZL3BW?=
 =?utf-8?B?ckdZOTNqUGU3L1pDaG9ON2c0RG93MDlaUFY0cXgxa2EyYmdaLzhIb255bDlU?=
 =?utf-8?B?RjBlMmE2aG1ZY09QNGFvamlReUszcUtPSGtpczgxU0dvaFRPVXRwRGZPWTZG?=
 =?utf-8?B?RDZScVdGeVA0bGVJcXdxdGRJSUxtVWFyYy9MOElxTE9kMEd3Y3dGdTJzODk1?=
 =?utf-8?Q?vTxpzontXLQ=3D?=
X-Microsoft-Antispam-Message-Info: xpOjsiON5pq1/Sm/3qHe4cIaHLoSutIZHR1KJXGV+Rnm0zhljzCvJkETJUmFNHjd+dKoeqOKRTnZd1pWj0LRzcpRTglKiyvB1IzW4TnrO/bnafSVXJ24QJ0oQB+6ctoq63fdtsBOjvET4cf5+LW4B2wUXh8T9q2T40UUzdiqV9ouvdGNEJHhVDNWdssJJqNti+IEmr/pvrZTcNkVRgNlZqGRL9ECKOmJgyADqdd3Rs2k9k447nZE6ALZfIMaNREE3o+8gk7zRPaKLczTFeESHpTM1rkiUu5OFzITmbhBTW5HsotMUIgNjNO4fQBY83Ox4vLNcjMNnSVvXgZqEM8jJhM+VVQ22Dlg5PDN6BVJcuI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;6:F5PsPnReKrf+EDYCjRTcfbvh2euO25oFpNjtDM3TQUgcKWA1q+rLjwT5JAsSIcHUgG45Ik6O5/WRFplnBnpaBZQyDrZ+Skrq9bgACKkrND7QezoLdKKyrk9sq0I6lxRZKiXEQAOnMNbkllyw5oJm06IKupjUptrMbIoVaVtrWk9M6AP6/2WCMuFQDGSOcyvuLrQLjQ28fEyPyX64XytPrHPf796HzOA65zDUm4SEwMAOP1RFEGwudefhBlbcyvFOmYsRJfmBh6LLFcpgNDNBD9geBcemGXeQs43/HXp6CVXWw21GXR0nYxa8cwGXNxxapBtqWjjKQzx/gjK/ZcJcbQgzdd03K9zLFzT6OOhawSa5ANG4UHJqSzjlGTqfsA+i+xR6QwWj8DTY07wmu4K/i1gNdJGg6579mbBxcq7qmqJtEQmvEkC0BSCQCQKM/Nf91PuWenWhaPgzMwdAuMNLug==;5:hUJKJuOuCmZ3qOoRnhLUt/W0OVt5WvKYCmgjZ7CgkbpiRpVRT14D5zkZS/07e/MhQgiooTVJfQyl9phzh54GsUCXr9Sn97wSI5k8x3ztMdxk4bmrv3myEIcTPgqyr21lCQDlQZgn0GIlceXb5Y4uYQmyopcrXE4xAHT3girU5TI=;7:GtTkalL8M8iPyKp5GZHC/SqD05ywexJQTTNRqoC5HLKQi/kezs9pHrcIBpG7uvOK9wGioskaYHct/tgfDX5meIxnX3jTjgvtV2KIzPAf3IsuRDiHI0+8dv3TWeRK6Q5UW9Nf3VytCL673KHVJKRGnLoOtb1LkI1vKfkAbyVfMPvzlcNmjpDcVFg37Ph8im8rUon35bAeLOlzuhCNf51IrXs5VNd9iw4AT0SFFneDU/0xKONk1rA2l3bDzfEzxh2p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2018 11:26:34.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70efe26f-bb79-41e1-c6e2-08d6292313b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.10.2018 07:08, Firoz Khan wrote:
> Hi Michal,
> 
> On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 1.10.2018 14:43, Firoz Khan wrote:
>>> System call table generation script must be run to generate
>>> unistd_32.h and syscall_table.h files. This patch will have
>>> changes which will invokes the script.
>>>
>>> This patch will generate unistd_32.h and syscall_table.h
>>> files by the syscall table generation script invoked by
>>> arch/microblaze/Makefile and the generated files against the
>>> removed files will be identical.
>>>
>>> The generated uapi header file will be included in
>>> uapi/asm/unistd.h and generated system call table support
>>> file will be included by kernel/syscall_table.S file.
>>>
>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>> ---
>>>  arch/microblaze/Makefile                  |   3 +
>>>  arch/microblaze/include/asm/Kbuild        |   1 +
>>>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
>>>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
>>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>>>  5 files changed, 10 insertions(+), 812 deletions(-)
>>>
>>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>>> index 4f3ab57..cda5e03 100644
>>> --- a/arch/microblaze/Makefile
>>> +++ b/arch/microblaze/Makefile
>>> @@ -81,6 +81,9 @@ all: linux.bin
>>>  archclean:
>>>       $(Q)$(MAKE) $(clean)=$(boot)
>>>
>>> +archheaders:
>>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
>>> +
>>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>>>
>>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
>>> index 569ba9e..d64f5e7 100644
>>> --- a/arch/microblaze/include/asm/Kbuild
>>> +++ b/arch/microblaze/include/asm/Kbuild
>>> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
>>>  generic-y += vga.h
>>>  generic-y += word-at-a-time.h
>>>  generic-y += xor.h
>>> +generic-y += syscall_table.h
>>> \ No newline at end of file
>>
>> Still the problem with "No newline at end of file"
>>
>>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
>>> index 2c6a6bf..3a40659 100644
>>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>>> @@ -28,3 +28,4 @@ generic-y += termbits.h
>>>  generic-y += termios.h
>>>  generic-y += types.h
>>>  generic-y += ucontext.h
>>> +generic-y += unistd_32.h
>>> \ No newline at end of file
>>
>> and here too.
> 
> Thanks for your comment. checkpatch script didn't warn this one:(
> Hopefully, I can fix this one in the next version.
> 
> I would appreciate if you can perform the boot test on the actual
> platform and share the result with me.

I see one issue there.
Run
make mrproper
make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/1/

And then

make mrproper
make archheaders V=1
make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/2/

And compare output.
What I see is that in the first part asm/unistd_32.h pointing to
asm-generic/unistd_32.h

But when archheaders is run before there is expected content.

That means there is incorrect/missing dependency in Makefiles.


Time to time I am able to see compilation warnings
but I didn't find exact steps to replicate this but it also looks like
on missing dependency somewhere.

[linux](next)$ make mmu_defconfig
#
# configuration written to .config
#
[linux](next)$ make -j8 simpleImage.system
  WRAP    arch/microblaze/include/generated/asm/barrier.h
  WRAP    arch/microblaze/include/generated/asm/bitops.h
  WRAP    arch/microblaze/include/generated/asm/bug.h
  WRAP    arch/microblaze/include/generated/asm/bugs.h
  WRAP    arch/microblaze/include/generated/asm/device.h
  WRAP    arch/microblaze/include/generated/asm/compat.h
  WRAP    arch/microblaze/include/generated/asm/div64.h
  WRAP    arch/microblaze/include/generated/asm/dma-mapping.h
  WRAP    arch/microblaze/include/generated/asm/emergency-restart.h
  WRAP    arch/microblaze/include/generated/asm/exec.h
  WRAP    arch/microblaze/include/generated/asm/extable.h
  WRAP    arch/microblaze/include/generated/asm/fb.h
  WRAP    arch/microblaze/include/generated/asm/hardirq.h
  WRAP    arch/microblaze/include/generated/asm/irq_regs.h
  WRAP    arch/microblaze/include/generated/asm/kdebug.h
  WRAP    arch/microblaze/include/generated/asm/kmap_types.h
  WRAP    arch/microblaze/include/generated/asm/irq_work.h
  WRAP    arch/microblaze/include/generated/asm/kprobes.h
  WRAP    arch/microblaze/include/generated/asm/linkage.h
  WRAP    arch/microblaze/include/generated/asm/local.h
  WRAP    arch/microblaze/include/generated/asm/local64.h
  WRAP    arch/microblaze/include/generated/asm/mcs_spinlock.h
  WRAP    arch/microblaze/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/microblaze/include/generated/asm/parport.h
  WRAP    arch/microblaze/include/generated/asm/percpu.h
  WRAP    arch/microblaze/include/generated/asm/preempt.h
  WRAP    arch/microblaze/include/generated/asm/topology.h
  WRAP    arch/microblaze/include/generated/asm/syscalls.h
  WRAP    arch/microblaze/include/generated/asm/trace_clock.h
  WRAP    arch/microblaze/include/generated/asm/vga.h
  WRAP    arch/microblaze/include/generated/asm/serial.h
  WRAP    arch/microblaze/include/generated/asm/word-at-a-time.h
  WRAP    arch/microblaze/include/generated/asm/xor.h
  HOSTCC  scripts/bin2c
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/mod/mk_elfconfig
  HOSTCC  scripts/sortextable
  CC      scripts/mod/empty.o
  HOSTCC  scripts/dtc/flattree.o
  UPD     include/config/kernel.release
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  MKELF   scripts/mod/elfconfig.h
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  HOSTCC  scripts/mod/sumversion.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  YACC    scripts/dtc/dtc-parser.tab.c
  UPD     include/generated/utsrelease.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  CC      kernel/bounds.s
  UPD     include/generated/timeconst.h
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  UPD     include/generated/bounds.h
  CC      arch/microblaze/kernel/asm-offsets.s
In file included from ./arch/microblaze/include/uapi/asm/unistd.h:14:0,
                 from ./arch/microblaze/include/asm/unistd.h:12,
                 from ./include/uapi/linux/unistd.h:8,
                 from ./arch/microblaze/include/asm/seccomp.h:5,
                 from ./include/linux/seccomp.h:14,
                 from ./include/linux/sched.h:21,
                 from arch/microblaze/kernel/asm-offsets.c:13:
./arch/microblaze/include/generated/uapi/asm/unistd_32.h:1:35: fatal
error: asm-generic/unistd_32.h: No such file or directory
 #include <asm-generic/unistd_32.h>
                                   ^
compilation terminated.
make[1]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
make: *** Waiting for unfinished jobs....
  HOSTLD  scripts/dtc/dtc
  HOSTLD  scripts/mod/modpost



When build is fine system is booting fine (v4.19-rc6 + your patches).

Thanks,
Michal


