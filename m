Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E678D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e0J690lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJYOjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:39:07 -0400
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:32697
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeJYOjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxgXdpaNgAtH53DtPuEZr/rZOAcaWNlw0OvpH0MhTY=;
 b=e0J690lWH0ax0G4ZzFcXzMLS9KDzSouupgXxVLqoyxcvl82WfBdelb+K2ER7xnhglNZkBfmYc1ni4rsN5IDhcGU/7IPy7O7GSiIQppTRQUW0WrN9VWgVqkQ0LpDOdUci2uxCoPGMIMsnJwnF2QRQd+lnxEoQ2myZDH6S65WD0ZE=
Received: from MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:50 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR02CA0018.outlook.office365.com
 (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51722 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYo8-0005qj-LR; Wed, 24 Oct 2018 23:07:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYo3-00086k-HH; Wed, 24 Oct 2018 23:07:43 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67XQk030756;
        Wed, 24 Oct 2018 23:07:33 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYns-000826-Hk; Wed, 24 Oct 2018 23:07:33 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id AA9D41216D2; Thu, 25 Oct 2018 11:37:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Date:   Thu, 25 Oct 2018 11:37:00 +0530
Message-ID: <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(8936002)(50226002)(110136005)(106002)(186003)(575784001)(2906002)(54906003)(316002)(42186006)(16586007)(36756003)(72206003)(305945005)(36386004)(106466001)(336012)(63266004)(44832011)(26005)(47776003)(7416002)(478600001)(356004)(6666004)(2616005)(103686004)(50466002)(6266002)(11346002)(476003)(5660300001)(51416003)(126002)(426003)(486006)(76176011)(52956003)(446003)(90966002)(8676002)(2201001)(81166006)(81156014)(14444005)(48376002)(4326008)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:fF+MxU5mxJI03yXBOHMA5lUPKS42HmyOBxLOsDirHBEl6JXzXGeUiN6O6zHaCF7Fk7oDN4Hj/JZXi6X23wERowF3mMXACi/i/2ZpijpgoHvUpzqLQjKsq6/DT8trwOIS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ef00ea-4cbe-41aa-0996-08d63a403132
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:cBxA6Amg2axrfCboylV51s99Mc2qKxcOevdwLKnqY6U71ieRnyAzdFtBQ3TRHd6pJ8pAQfncfvtJFtCOsky7avfMZpFUn2CVa2BrRijAC4XM1vDXVtcefi2AwmumIOzEu9GCnLbaZzEbptmi+7mcittgvInPwWAbtnvuzfr9cPKEEVpdz5YRgo2HMcgb/M/CBNCjQjHFZXB9fvUXpfM8TqXTXUKjSS+cNPPb4nG+Tf0pkPShvogFGrCXWw22BAdPpjEjqI0yX6AW3L/QvVG/GwT+PoyqO0UvncWL7f/Bb7+KqA2OeD/Vab1aNWfAkJTta+UAG0Qf/cDje2R9N9CbfSCZHtiH4aJXAkIGcKwPXVs=;25:GxTQpYHFVURfmAIzROMRCqNf2dHzXd8ZMeZ4APM6EN5zAwruOuOj+dHXPpNr/8Y9OWZIRfojHP8sdoitVm/oAcuZyuHvRPy9jiWzfcytP86kARxPjb+zfv7MBVUgsP0WocWAS2f5Ez+DGOLUHuW6kG8s/IhCTZTZkiuNO/2ldupcZWLTtEWIyTwuZgpaMAnx0u386pxpJD5HBkX6yA+dUDdMzlKipj0PGOtufHKMr7hJbamQ5OEP2OIvD42svwuTEns6pmN5yQXIQ4tygsZ/e74jBeiy6UkPYMgGQ3dEDDc/HnIdPFG8Jk+MxiVoN1FHDxMimxcnd7cQPP3TONsplQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:HfeBLV6ury8BDHtbjckuSaImc33XJMPvEWznv+5rY7M52Nm4MKvWirx5JiKmcCE1bO+3Z7DnleU+gkixgUtauZc7nKuHIxf4QrxWMRY6SeLroHDmY/Wf9zb9PSWgk3km/JKuT25bE4P6GJSnt3OZFreVDV1QeQ39it5zJeB2gOPYiFNiT8+dx5PKEW2E2tQcrx9pcq+8NkGpkICOEaxbM1N6YMV+uWMhcI3kQMMvdBY=;20:/c4e6tiGbPP9iQyqZKtsMAPVfh0ogyHJc+uR+QU3ZfR1H8Hc0rINe4R1BvltNnareTg7xhnTyTyH+i3joBtRY0bjLVV6gDqQCL44SiQwaCDKTutetKPTWyex+YUcy6hezFXUG7jQbQhb1J5wgRYamrD6LLK1GPgIw7CgNLCqPbr9hdxB8+nYJXiJX0YOBy4IqmBkudYm416M7sOwP5hdxTXHpk6HBsu/E984QqoPejtrrfWfAYr1FJG0lDJLvSLFpKghMbPg0e4McL0u9du0OxL1VQXfBrFrbSfR31eZ/Y9k/q4NbO7eMv8vwwqEvGcKsE/LRsbu8voV0lXzMe1uEtfM3xNj0tPQ1pE/WHqKeh8BjwNBQQKBDLbmf98Xvu+8EjpLoEFXDOz0O9FsBQkYyB3W8f6tUY74TA2Mbj66IiIDysZEEKkzBzam30A08kPfoL7m6Yn0evDSTcf2vuIIFmqUSkzJpApD6g2XbO+wuMDKsMVZcooaPbjUeVAZs9rx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330C40BED3AB021BE0EA083C1F70@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:WrJr9F2mIuzbEiWfkBN2/JEdD+fI18a4KOrbznPsthvJmEhOoSEexms3oCdss7dwfi0TqphkxBONRp83V+lutgeavJRILem3vt+TH9nablMA80gq3yw4bKRh9nFtXUdTq30lfaiDR+FdbWcjtk6Anuevu0WCtN1FAB0RQ0HSkne6O7kv0HSY5dTLGpzBEe/fh+GSUS/e38RQRhorzMiOXsE00VkWgut8YMZ6D5L8UjEcF+LFnWJAZfvRhhMdK2yPUEqtDzr9xRC2NdOxU7H5V0C+wJci8aiAVyMQQqPd0A8i36CbFWIsjiK863E/Y6TV
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:TVy2COgk/dkHXU+/DGkJKCFYw4Z81lKRRuGZ9HxPD?=
 =?us-ascii?Q?qeSH9sNCZ0Jds/sSpzM4sNRWs4N+MvXmwwodEpcflaL8KjPnYQjkbmb6t09W?=
 =?us-ascii?Q?rWDKvCLH6eTha6v/FwNsc3R/yw69dSnGTvzH4OZDU8RQNqGuozmAGMLIhQ2l?=
 =?us-ascii?Q?OVWUDJcchEKkiNgXZlypVAtE3Zy6vxkiCPLMTwt+Iat7zFNTNjlYwp68Tc2Y?=
 =?us-ascii?Q?OuoYxd6MHJhAM2EO+/LYT4vHpGsvrrHsSe64cnjqS3UCsHm6/GOKo4OVn5xM?=
 =?us-ascii?Q?x59DGonikrel+fCkpzelAl6Qx+2UCZ7U0TTSW50zqRhVpa6YkwFM2FOTgwzR?=
 =?us-ascii?Q?5G4w73pJKpPfejtyi5znp+pzm9rIdq0gBzAXrrAz/inYX5qLBwTLW2c3fIWV?=
 =?us-ascii?Q?ARvW79j+feeCEIu0Rp0WklMloBImn/5UwPRdzlSynSCEYUi10M2B2rU1hopT?=
 =?us-ascii?Q?rGnasFDNHdrE6w9ry50k6lR8L/Ncg4cwXD+M/dBoS/vxy8p2WRLJAZluujtF?=
 =?us-ascii?Q?prLfmRx/aJjF/vWqJ6uTGl8be2xW4CrEPaYMKNkWbQ6bFitpyBGgbEEz+QS5?=
 =?us-ascii?Q?2ztGt8ZTIqYuu+7mmG0eIyRsiqrssjJVMChrqv8IgrQn/am/0anIovFdOxpt?=
 =?us-ascii?Q?q1+1eJ+sdCrqaRcpGHkhmL8KgfPgr65K33ixLYoMiSapEkra8kKunriTe/XR?=
 =?us-ascii?Q?jT8achk89/kTLtn7xW3Lm4vSMdXoUditSYikd+uq7ILr1Ndf57uplDFRYODg?=
 =?us-ascii?Q?4+8uQcdJny68NZKlDv39yaWO4p15XvanMpB/4JKreKf+R2nYgAvhycoWe5xx?=
 =?us-ascii?Q?nEVdcpZAoOQT8cNaMuN7jEmXUcs6DhisaiHpsPwGGgict2tmTQifaXVQJ0eK?=
 =?us-ascii?Q?hO3CHl8FesRbQS+ME4hbN/zlF2b/C+rIwTFfS2ZNC6GPJiAA6yT7iwvAMhLS?=
 =?us-ascii?Q?Bf9HQ09cHfB8gteNKOHnGEzJ+EPbdlf64dJLI1aiEVqRh5to888MSstRwGRf?=
 =?us-ascii?Q?MsdW/ZBRrEjVOa5c7N8cwi90vUQaJ4u7FuwPhID9mCq4rWjWEFsT/DpDC9lS?=
 =?us-ascii?Q?MHepPumEeu5oUoYVLn+6JyLek21mQmFbvm7j1uTqKCVcpvQmnEwt3YaoH26h?=
 =?us-ascii?Q?/dNI12AJe1AgMMepQbBNcH+48B2J7CucONmBM/Mq6lSWcn0gw3gWEg6AkA3K?=
 =?us-ascii?Q?ckVn2A8smfC0AfMsah7YvmrGdn+QP+DJsWB8ANxEL5qfS1Je1A4mqEe/Thy6?=
 =?us-ascii?Q?sndVPDUNeUJMAA6i+7Z5wy1jK5IR20PU8NMXiPt5JKq74Iviuzl8SxfLFdLX?=
 =?us-ascii?Q?QeabCl+qC1ltWFYOYopHZs=3D?=
X-Microsoft-Antispam-Message-Info: xkLoIqrbvadtckI9u+IVp5HbcCDJNNt97DzVm8OLMnNcqDBEoJLViibImV4L1UbP8pu8Eg/083OJTIjfHQZk7+nQtBewfM9MUXf88FwyzI21+NCDKlDvIZGCAnnadmoby3M3F1XtBtTwfr6XVDxGcKGdz4UFLfCnUWU8fJPXb8b+0YZSpQnFVlzoCtDMQuqtmMPed5JZWohROZFaLBN+xhbbVrLflHoByDZOEoCwBrm1QLRYZZfh3lLwOON8P2gIpJ32Y5kLqkimLq1HJzlVhxH7feSUOKADgmpbhp7b8SyGLxZBx+4BfavYQoGo5kr4icBfK4AJM29FNZIqs/Vp4+q8u0suTKl3rcHkJ856XBA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:YyieMyfgHSdGGM4z9h+ueS30BzMPwqEhLozq22qmcR2j5S7DPXe3UL5+053cY44UnUG84Kz1kL1GkgcJFMxyLDXilWZY7ONCuZ4I+l7QGJStaVvf6nx9mzjiUTDP+TU3sRFX+YxqzKwlPuRfwnShyOUgDSO9Q8gbLAv1Ocep9PXmb8VpKwn9Afkqtzxqx6jZJTQajzYuw6G1MmnUvMQxTV5MdmsbeA1Iwm61WpenoQl845D40wUKXmi/7gQfl6aOFn/NF36CRQlonKUouceFEHDdTTkMz84N4SPSB71X435XVVyWhs0YasT17D8+s1USEUGz+e6GHMH30J6d2r0Ii/ntyNQaLD9SJHBRk959qt22/n5oPt0rTdY5ffdiIJLlRckvuZyjgU5LZ9Kz4eCiCqWn4GLT1DfKm0Lag+LEa67lprizLjZ6fzd7y7ris2jl5/6PhaCw5gce1JplZ/zqSw==;5:vsT/y+y3wZljlclbSPrknlFLJVvmdNOt4va8LhSObVB9zKD5WqpD2ddDENasCE8kbMJWxy65Vnp6wnzoLgwwMSlp3nDkzlPEWezxxbM0MWZ49hDInTCRxgfFn0iOmjbu4X1s57Sw2Zxx3vnDU3UfL/qNj9gKLt7TVmMo9gH9Kh4=;7:sCgvWWPcduipddTJ+jviza0PdRG0YvNwWdN1LD6PoSmR3cdrQEBZ6ksdl6D13K6x836zcAZmcWHd+6BlGRsQlHDQ9VsHMvdRfc1j92cBrPU3+Q99Zdz5TvtYpTI+lYhP5rVuCrcZdQqvq818TXu6CpsgCLu4A49RmTvb9lBKfAbiDgs8dS7Erk/MbjXByQqwZx++MDAXTyIctLnJAaOco3bl2s8ybcVKkMWv/260JnqBGemrv2JlGCDf3/DMg4AF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:49.2809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ef00ea-4cbe-41aa-0996-08d63a403132
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ddrc memory controller node in dts. The size mentioned in dts is
0x30000, because we need to access DDR_QOS INTR registers located at
0xFD090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..a81d3b16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

