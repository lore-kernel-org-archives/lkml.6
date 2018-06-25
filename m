Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2893921735
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="cTNNminZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2893921735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFYQNr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:13:47 -0400
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:14160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeFYQNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OIcSLy3GfKgKmabw5y6P8Q7GKhHrOq9xGO3eRoA5Mo=;
 b=cTNNminZu6gqDWMO3bEsTcm9SDbdH13SDet5Zd/eAkxdvRTrLRonP+rfr18lxowQu5HGkW3+XwO4aOFwk3AwxZS/DonEgbUQuX9DPf5avd2NqQXpbVfYEyjOs65l5BnIPScio2HcfGmaE83n4aw0WQf6B6MzYUo78MXahsHGJ10=
Received: from DB6PR0601CA0014.eurprd06.prod.outlook.com (2603:10a6:4:7b::24)
 by VI1PR0602MB3375.eurprd06.prod.outlook.com (2603:10a6:803:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.22; Mon, 25 Jun
 2018 16:13:41 +0000
Received: from HE1EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::201) by DB6PR0601CA0014.outlook.office365.com
 (2603:10a6:4:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.20 via Frontend
 Transport; Mon, 25 Jun 2018 16:13:41 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT035.mail.protection.outlook.com (10.152.10.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.906.15 via Frontend Transport; Mon, 25 Jun 2018 16:13:40 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 25 Jun
 2018 18:13:16 +0200
Received: from pcbe13614.cern.ch (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Mon, 25 Jun 2018 18:13:17 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Peter Korsgaard" <jacmet@sunsite.dk>
CC:     <federico.vaga@cern.ch>
Subject: i2c:ocores: fixes and polling mechanism
Date:   Mon, 25 Jun 2018 18:13:00 +0200
Message-ID: <20180625161303.7991-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(1076002)(106002)(26005)(786003)(44832011)(486006)(16586007)(110136005)(316002)(36756003)(8936002)(50226002)(7696005)(51416003)(2616005)(126002)(426003)(476003)(2906002)(16526019)(336012)(186003)(6116002)(478600001)(14444005)(48376002)(107886003)(86362001)(106466001)(4326008)(53416004)(50466002)(7636002)(7736002)(305945005)(8676002)(356003)(246002)(74482002)(5660300001)(6666003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3375;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dad990a-7e48-493a-9dd4-08d5dab69dd1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3375;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3375:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3375;20:8QNj7Nedq98pL7SUhlCW0jGfwo9Yg/abCjHaIvg1Md8OooI/lMAKUHuGlaOI9auGOhIr23TNqrxixBRfm22Tg6vBmaGrmPspnzN0S9U9KxbUxvfBDD0XmDJnLgYHPFyLffi6Pq3AkePlEKE4Q6dqH87n//p9LVa1G0szCP2fcVTcJZYPSRg2SSoQQTpr8j6IE7fNK6smRE3TpsvzVVevFUcUY9fscD/zMzQrFTSRlP4EUtOVDrkJkUtIz7MQ9gT7bzIgHnma6W73Ynpxa+qD+f5aqLU7Qyqho+gAiJO7rD48g9ymULksA+EeNVyxoTQ79kR20eVqehcyDzJ3+5BEzhEwX4Z+9TfzSf2cNACo7GQkR+pKg+DAAtO2VIxSek5dv0FtSjJXCuaahTsj7LDMsaV0eb+LmWCCV1xV/4YmJZkEtxtQuWAT/y/vsiISUTZeoQuVgtXzPI5CmnzJFU1lJ7Vi5Mx658inzBMAuBuKMMzWK9aU4f8FtTwNeOI8PROL;4:PHHjldh90LfB2YEwJRcrVtIaJuTfOnyRltZmYKveWhnupieJEQVW6dLLZpX5vZx4icvxeYf7XTW7cPBsuu1AqFd9/cfcj55tuXehNrYjZ92o7Kzu9cIGOvI2mYmFw1Zrdz8ixqi2CF4Lg5k6FtATAusAuS2saiX5h8s47FmDFFPEa5Mi9Tfb5OgAAxRf/akUAiyked4qpbljBWdmSgheqqRXuAz1fnvLKL9Cn0iOq7Sm9RA0Q0ryuilyaO/1XTg6qa5qCNrYJv+wjPVfZ4kT9Q==
X-Microsoft-Antispam-PRVS: <VI1PR0602MB3375007AA7C2923A5F6C9292EF4A0@VI1PR0602MB3375.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0602MB3375;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3375;
X-Forefront-PRVS: 0714841678
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3375;23:pUX4xj9/OFVwXlDELjApL+svav2u7AUz9gYSKd0?=
 =?us-ascii?Q?K0/2aNoSAgpe9lY0PAZ+/vcPkZoW+8tIl1dpwXOhfY2EaCO4wJlXJfcHzg/0?=
 =?us-ascii?Q?Bm0f7FiZ0fOkbIWLBN8dVnQZDvdJKElDJfZ7THq/T2gp5agvE38f458SqmyX?=
 =?us-ascii?Q?Q+BsQzbvWF0wPes5j9vlfIS7395BLW+DSl5yi7VxsZS5X8mYmbG14OxSKS50?=
 =?us-ascii?Q?IkgHenZiFt/wUa3aK6U3YpOo8XUQaMctCBLU1x3eHy8bixbDtFY6MoCKWjJb?=
 =?us-ascii?Q?SRcjFHk0X9KjTs5iVrK1W/Pfxy9SunU4Z9wzVUOPRB51AC8pcJ7GmRE7sw+8?=
 =?us-ascii?Q?sYpGLVnUn7jZ3zrHejQYoaND0W5Ud2buFf9ybyRpODR3Nzxc1Dn2OC5ywZTE?=
 =?us-ascii?Q?dfx0ImyCVH+GwCwJmpRn4xW//LxozSHhGZ0YOvZChIwabKyz0/3Gy2mSrkii?=
 =?us-ascii?Q?SjdU8W9abMcWWx4QjP4wFRLwPs2W0Jf6L/mFWuh3lPZ4eCrLO69s32PmCdkg?=
 =?us-ascii?Q?TmubP+SSWXSb3n4DDQf//+NXKpjptcjrVT+nsu14ZGkdcwB7ISz4pLDiGIm7?=
 =?us-ascii?Q?Cg1Q6rkYloOQXhTPtFdf8vtKgZkT/qbKCXwJXGq42LVxReuLDEJoMHSBBlDQ?=
 =?us-ascii?Q?yUHtvq/efSURd4cp/O7vT8LaOjkjlqjKxTGE1suVID/THx7StE7cyR+5PcIv?=
 =?us-ascii?Q?NYlQAoLwdybi0WYNEGViC0wtBZ8vT4O0dm4TrLCY0dfBBHxwH97ZYTAOXiGX?=
 =?us-ascii?Q?Z8Y4SOz6+HQyGe4dN4Nao7hxlhTJ84RiTEQ7VV5sczIis3/oM1L0Bl6j9wDv?=
 =?us-ascii?Q?MeZNw4qpJGHR0gUP0/Op399MoJskX8Woyy0h+KuFUblMpf44d9RzLqmCmZDa?=
 =?us-ascii?Q?WtaSK3Fk+hj+EWgdGVMNBWSrvGJ0rhGP4zYnNPDD6BL3EqM7oPR2MzPKgmY8?=
 =?us-ascii?Q?951WDMETQEvElYpuFrK7ildoLS7b1rpZH4L3JDrI4Ml+YNgy273iK41DcWLY?=
 =?us-ascii?Q?skPmTS7nTv61eox+P4zKkjBuhgjHk0HH9Cz9dmPSUrGX3T0VFAeMlEBPkwaF?=
 =?us-ascii?Q?DbUHPUXp7V7eDfIbogIzFEWO2kU8Bh6fp8KuxOxKCFALgozNjr3waqfKcgpC?=
 =?us-ascii?Q?z50jz2O7zqJE=3D?=
X-Microsoft-Antispam-Message-Info: aTBaYvTee0ftdFO9EN6H3IIMZMhUu6ydBWtnUHPnlPLpylNg2A+D5ptOvRKZJWcr2ugw0WZX0if+bQCxqocmw8O7MmkG128qTczVOixLt3e5s9a0skpsbK5w+ryQTPW9tAH1cSLaOJxzGWUbIoEDNhve5QTDTWCOVJvOVg7nP13EWTsw8jU3Y6iKLJqzsfgUMxQdwFln6Q4liWvk39K1xrJpt39a+9RUW4/H2/P7GETZS52bG/liQBU4PWsK2/Wtz0f5fsc3ahYMlvz3NxyHZid1asvo7GqziODO7aF4h5J3Z6pN2wMiAS/RPpwdL7sKhgWlUJ+S3an/RjMhuj1dZ7iuogv+ocPeoH7GgDtj9Q0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3375;6:0sryMGn9ykhlheJmsrEyYcD3BRdPtu7pfZEezv0IP0Mp75UrOZOoNYfArdPIfDkfEy/1cWFoig1j5nQp4hgZpJfG+WfBv6RWc4RDhpqsj2OlvGbuBkcDJ8vc7nMSlrf6LaZA0+eMMCMUuEawg+6vBSfUqJpLCfBssAR88H9KedlqKy6JPwdkw1F0jnt7v1HF3yjmTWG06L81iEMILFwr1eNh10aFlXJTjZqcQmRvsDea4jZuDDClbLXpvA3WzXbxmt2JdEn+eyEvvjgONtm24uouIguEr85KQySLjOV4p5KBxqvKdztGY1upG40qQWsvzOF6bBumqCvXvJU1MiOvVRE8tI2epC79L2mk8GIlxpM3MN1GxCeg/cWu9TLFAue2VqMd7btbBzfDMnM7CuWH8YW/tQ4/NclHzNOPNTuUYnVoXdFjomI52pdFpyQgwzbyFmzdXqzpdjcuTGITXcSOTg==;5:IyM5sJIJE7MZ2MUNDt+NNuoufTSDPTTwyzqmGa86zvYFodJWCbred48ybbt5J4miNScNdT0qIkO3iJbun7P5M9Z9Bixk7qU4ax+gJNnB56+HyGweAitgIoqm4QuOFrtPLie5SeUv6TFGWYe0TW4xH1I6ij8TZgm3JQndpwoqT0A=;24:zwMa1RJqO9UIsJveCTKZvR/hhaMrZQJ+VFtH3Cap76GSaCFYAO4KgTDW+9ChpcTkgwO4/y8m5wBNEw5OVN1c/huTUXWmvbS5fj6CChMjpjY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3375;7:RCoiui+h6/1GcE2wVwJmsjWhTwpCAFy9FZIHtgme6O5Fyk83skeK5FWEfLtZ7f46AQ676zQ1cmy+OpSs0XhJ7c/Xq/iBDG/EikT39BzfwYh69zKJSmQt33ZW3GliPvWhfd1pcpSbLaoLvP3jIxbZ9cBEEOlti4gwctb1uuJg9Cu9bJmEiLbz2TuWIYKKFt0HRwsE1FlV64W70cH4VmEB7vEmiCBwXLn8jzUQjOKoqcX3C/QwUHMS2epoT2CVBsH2
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 16:13:40.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad990a-7e48-493a-9dd4-08d5dab69dd1
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches fix what I believe are bugs.

The third patch add a polling mechanism for those systems where interrupts
are not available.

All these patches have been tested on a system without interrupt, this
means that I used my third patch to validate also the other two.
I would be nice if someone can run verify this also on other system,
perhaps with interrupts. If you consider it a useful information, I'm not
using devicetree for this installation.


